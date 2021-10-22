package com.book.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.book.domain.ArtBoardVO;
import com.book.domain.ArtFileVO;
import com.book.domain.Criteria;
import com.book.mapper.ArtBoardMapper;
import com.book.mapper.ArtFileMapper;
import com.book.mapper.ArtReplyMapper;
import com.book.mapper.BookBoardMapper;
import com.book.mapper.BookReplyMapper;
import com.book.mapper.FileMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Log4j
@AllArgsConstructor
public class ArtBoardServiceImpl implements ArtBoardService{
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	@Setter(onMethod_=@Autowired)
	private ArtBoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private ArtReplyMapper replyMapper;
	
	@Setter(onMethod_=@Autowired)
	private ArtFileMapper fileMapper;

	public ArtBoardServiceImpl() {
		this.bucketName = "ca-myuniq";
		this.profileName = "spring1";
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		
		ProfileFile profileFile = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(profileFile)
				.profileName(profileName)
				.build();
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}
	@Override
	public List<ArtBoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public ArtBoardVO read(Long bno) {
		log.info("read" + bno);
		return mapper.read(bno);
	}

	@Override
	public void write(ArtBoardVO board) {
		mapper.insertSelectKey(board);
		
	}

	@Override
	@Transactional
	public void write(ArtBoardVO board, MultipartFile file) {
		write(board);
		
		if(file !=null && file.getSize()>0) {
			ArtFileVO vo = new ArtFileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(board, file);
		}
		
	}

	private void upload(ArtBoardVO board, MultipartFile file) {
	try (InputStream is = file.getInputStream()){
			
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key("art/" + board.getBno()+ "/" + file.getOriginalFilename())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, RequestBody.fromInputStream(is, file.getSize()));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	@Override
	public boolean modify(ArtBoardVO board) {
		log.info("modify proccess" + board);
		
		return mapper.update(board) == 1;
	}

	@Override
	@Transactional
	public boolean modify(ArtBoardVO board, MultipartFile file) {
		
		if (file != null & file.getSize()>0) {
			ArtBoardVO exBoard = mapper.read(board.getBno());
			deleteFile(exBoard);
			upload(board, file);
			
			fileMapper.deleteByBno(board.getBno());
			
			ArtFileVO vo = new ArtFileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			fileMapper.insert(vo);
		}
		return modify(board);
		
	}

	private void deleteFile(ArtBoardVO vo) {
		String key = "art/" + vo.getBno()+"/"+vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
		
	}
	@Override
	public boolean delete(Long bno) {
		log.info("delete process" + bno);
		
		replyMapper.deleteByBno(bno);
		
		ArtBoardVO vo = mapper.read(bno);
		deleteFile(vo);
		
		fileMapper.deleteByBno(bno);
		
		int cnt = mapper.delete(bno);
		
		return cnt == 1;
	}
	@Override
	public int views(Long bno) {
		return mapper.views(bno);
	}
	
	@Override
	public int likes(Long bno) {
		return mapper.likes(bno);
	}

}
