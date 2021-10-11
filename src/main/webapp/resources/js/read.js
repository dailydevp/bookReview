 $(function(){
 
 	var appRoot = window.appRoot ? window.appRoot : '';
    var boardBno = window.boardBno ? window.boardBno : 0;
    
    	$("#listPagenation a").click(function (e) {
		e.preventDefault();
		
		console.log("a요소 클릭됨");
		
	var actionForm = $("#actionForm");
	
	actionForm.find("[name=pageNo]").val($(this).attr("href"));
	
	actionForm.submit();
	});
	
 
	function showModifyModal(rno){
		$.ajax({
			type : "get",
			url : appRoot + "/replies/" + rno,
			success : function (reply) {
				$("#replyRno").val(reply.rno);
				$("#replyer").val(reply.replyer);
      		    $("#replyNick").val(reply.replyerName);
				$("#replyTextModify").text(reply.reply);

        //댓글 작성자와 로그인 유저가 같지 않으면
        //수정/삭제 버튼 삭제
        if (usermail != reply.replyer){
          $("#reply-modifyModal")
            .find("#replyModify-deleteWrapper")
            .hide();

            $("#replyTextModify").attr("readonly", "readonly");
        } else {
          $("#reply-modifyModal")
            .find("replyModify-deleteWrapper")
            .show();

            $("#replyTextModify").removeAttr("readonly");
        }
				$("#reply-modifyModal").modal("show");
			},
			error : function() {
				console.log("댓글 가져오기 실패");
			}
		})
	}
	function showReplyList(list){
		var container = $("#replyList-container").empty();

    for (var reply of list) {
      var replyHTML = `
      <li class = "media" id = "reply${reply.rno}" data-rno="${reply.rno}">
        <div class="media-body">
          <h5 class="my-4">${reply.replyerName}</h5>
          <p>${reply.reply}</p>
          <small>${new Date(reply.replyDate).toISOString().split("T")[0]}</small>
        </div>
      </li>`;
      var replyComponent = $(replyHTML).click(function(){
            showModifyModal($(this).attr("data-rno"));
      });
      container.append(replyComponent);
    }

	}

	/* 댓글 목록 가져오기 */
	function getReplyList(){

		$.ajax({
			type : "get" ,
			url : appRoot + "/replies/pages/" + boardBno,
			success :function(list){
				console.log(list);
				showReplyList(list);
			},
			error : function(){
				console.log("댓글 가져오는 중 에러");
			}
		});
	}
	// 페이지 로딩 후 댓글 목록 가져오는 함수 실행
	getReplyList();

	/* 댓글 입력 버튼 처리 */
	$("#replyInsert").click(function(){
		var bno = $("#replyBno").val();
		var replyer = $("#replyWriter").val();
		var reply = $("#replyText").val();

		var data = {
				bno : bno,
				replyer : replyer,
				reply : reply
		};

		$.ajax({
			type : "post",
			url : appRoot+"/replies/new",
			data : JSON.stringify(data),
			contentType : "application/json",
			success : function(){
				console.log("입력 성공");
				//모달창 닫고
				$("#replyInsert").modal("hide");
				//댓글 리스트 가져오고
				getReplyList();
				// 안내 메세지보여주기
				alert("새 댓글을 입력하였습니다.");
				//$("#alert1").text("새 댓글 입력하였습니다.").addClass("show");
			},
			error : function(){
				console.log("입력 실패");
			}
		});
	});

	/* 수정 submit버튼 클릭시 */
	$("#replyModifyBtn").click(function(){
		var rno = $("#replyRno").val();
		var bno = $("#replyBno").val();
		var reply = $("#replyTextModify").val();
		var replyer = $("#replyer").val();

		var data = {
				rno : rno,
				bno : bno,
				reply : reply,
				replyer : replyer
		}

		$.ajax({
			type : "put",
			url : appRoot + "/replies/" + rno,
			data : JSON.stringify(data),
			contentType : "application/json",
			success : function(){
				console.log("수정 성공");
				//모달창 닫고
				$("#reply-modifyModal").modal("hide");
				//댓글 리스트 가져오고
				getReplyList();
				// 안내 메세지보여주기
				//$("#alert1").text("댓글 수정하였습니다.").addClass("show");
				alert("댓글 수정하였습니다.");
			},
			error : function() {
				console.log("수정 실패");
			}
		})
	});

	/*삭제 버튼 클릭 시*/

		$("#replyDeleteBtn").click(function(){
		var check = confirm ("Do you want to delete?");

		if(check) {
      var rno = $("#replyRno").val();
      var replyNick = $("#replyer").val();

      var data = {
          rno : rno,
          replyer : replyNick
      }

			$.ajax({
				type : "delete",
				url : appRoot + "/replies/" + rno,
        data : JSON.stringify(data),
        contentType : "application/json",
				success : function(){
					//modal 닫고
					$("#reply-modifyModal").modal("hide");
					//댓글 리스트 다시 얻어오고
					getReplyList();
					//alert 띄우고
					alert("삭제에 성공했습니다.");
					
				},
				error : function(){
					console.log("삭제 실패");
				}
			})
		}
	});
	
	/* 글 삭제 */
	
	$(document).ready(function deleteCheck() {
	$("#delete").click(function() {
		var deleteUrl = appRoot + "/board/delete";
		var readUrl = appRoot +"/board/read";
		var msg = confirm("글을 삭제하시겠슴둥...?");
		if(msg == true){
			$("#readForm").attr("action", deleteUrl).submit();
		}else{
			return appRoot + "/board/list";
		}
	})
})
	
	$('.likesBtn').click(function(){
		update(this);
	});
	
	function update(elem){
		// var root = getContextPath(),
		var likeurl = "/booklikes/update";
		// usermail = $('#usermail').val(),
		var bno = $(elem).closest(".tr").find(".list-num").text();
		bno = bno ? bno : window.boardBno;
		var count = $(elem).closest(".item").find('.likesCheck').val();
		var data = {"usermail" : usermail,
				"bno" : bno,
				"count" : count};
		
		console.log("좋아요버튼클릭");
		
	$.ajax({
		url : appRoot + likeurl,
		type : 'post',
		contentType: 'application/json',
		data : JSON.stringify(data),
		success : function(result){
			console.log("수정쓰" + result.result);
			location.reload();
		}, error : function(result){
			console.log(result)
		}
		
		});
	};
	
	function getContextPath() {
	    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	} 
})