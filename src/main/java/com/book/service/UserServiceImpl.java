package com.book.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.book.domain.FileDTO;
import com.book.domain.AuthVO;
import com.book.domain.UserVO;
import com.book.mapper.BookBoardMapper;
import com.book.mapper.BookReplyMapper;
import com.book.mapper.FileMapper;
import com.book.mapper.UserMapper;

import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class UserServiceImpl implements UserService{
	
	@Setter(onMethod_=@Autowired)
	private UserMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder encoder;
	
	@Setter(onMethod_=@Autowired)
	private BookBoardMapper boardMapper;
	
	@Setter(onMethod_=@Autowired)
	private BookReplyMapper replyMapper;
	
	@Setter(onMethod_=@Autowired)
	private FileMapper fileMapper;
	
	private String bucketName;
	private String profileName;
	private S3Client s3;

	@Autowired
	private JavaMailSender javaMailSender;
	
	public UserServiceImpl() {
		this.bucketName ="ca-myuniq";
		this.profileName ="profileImage";
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}


	@Override
	@Transactional
	public boolean insert(UserVO user) {
		user.setUserpw(encoder.encode(user.getUserpw()));
		int cnt = mapper.insert(user);
		
		AuthVO auth = new AuthVO();
		auth.setUsermail(user.getUsermail());
		auth.setAuth("ROLE_MEMBER");
		mapper.insertAuth(auth);
		
		return cnt == 1;
	}

	@Override
	public UserVO read(String name) {
		
		return mapper.read(name);
	}

	@Override
	public boolean modify(UserVO user) {
		
		user.setUserpw(encoder.encode(user.getUserpw()));

		int cnt = mapper.update(user);
		
		return cnt == 1;
	}

	@Override
	@Transactional
	public boolean delete(UserVO user) {
		
		replyMapper.deleteByUsermail(user);
		
		replyMapper.deleteByBnoUsermail(user);

		fileMapper.deleteByUsermail(user);
		
		boardMapper.deleteByUsermail(user);
		
		mapper.deleteAuth(user);
		
		int cnt = mapper.delete(user);
		
		return cnt == 1;
	}

	@Override
	public UserVO check(String usermail) {
		return mapper.read(usermail);
	}

	@Override
	public UserVO dupNickCheck(String nick) {
		return mapper.dupNickCheck(nick);
	}

	@Override
	public boolean modify(UserVO user, String oldPassword) {
		UserVO ex = mapper.read(user.getUsermail());
		
		if(encoder.matches(oldPassword, ex.getUserpw())) {
			return modify(user);
		}
		return false;
		
	}

	@Override
	public UserVO checkPw(String userpw) {
		return mapper.checkPw(userpw);
	}

	@Override
	public boolean delete(UserVO user, String oldPassword) {
		UserVO ex = mapper.read(user.getUsermail());
		
		if(encoder.matches(oldPassword, ex.getUserpw())) {
			return delete(user);
		}
		return false;
	}

	@Override
	public boolean modifyInfo(UserVO user) {
		
		int cnt = mapper.updateInfo(user);
		
		return cnt == 1;
	}


	@Override
	public boolean upload(String usermail, MultipartFile mfile) {
		// 회원 테이블에 파일명 추가 
		FileDTO file = new FileDTO();
		file.setFileName(mfile.getOriginalFilename());
		file.setUsermail(usermail);
		
		mapper.upload(file);
		
		// s3 upload
		try (InputStream is = mfile.getInputStream()) {
			
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(usermail +"/"+ mfile.getOriginalFilename())
					.contentType(mfile.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, mfile.getSize()));
			
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
		
		return false;
	}


	@Override
	public List<UserVO> list() {
		return mapper.list();
	}


	@Override
	public UserVO info(long bno) {
		return mapper.info(bno);
	}
	
	


	@Override
	public void send(String subject, String text, String from, String to) {
		   // javax.mail.internet.MimeMessage
        MimeMessage message = javaMailSender.createMimeMessage();
        
        String ContentText = text;
 
        try {
            // org.springframework.mail.javamail.MimeMessageHelper
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setSubject("임시 비밀번호 설정");
 //           helper.setText(text, true);
            helper.setText(ContentText);
            helper.setFrom(from);
            helper.setTo(to);
  
 
            javaMailSender.send(message);
       
        } catch (MessagingException e) {
            e.printStackTrace();
        }
	}


	@Override
	public UserVO findmail(String phoneNo) {
		return mapper.findmail(phoneNo);
	}


	@Override
	public UserVO viewInfo(String usermail) {
		return mapper.viewInfo(usermail);
	}



}
