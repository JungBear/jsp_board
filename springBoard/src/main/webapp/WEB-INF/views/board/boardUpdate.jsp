<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		if(!${not empty sessionScope.user}){
			console.log(1);
			alert("로그인 후 가능한 서비스입니다.");
			location.href = '/user/login.do';
			return;
		}
		
		function showError(message, $element) {
			alert(message);
			$element.focus();
	  	}
		
		var originalTitle = "${board.boardTitle}";
        var originalComment = "${board.boardComment}";
        var type = "${board.boardType}";
        var num = "${board.boardNum}";
        
		$j('#submit').on("click", function(){
			
			var $currentTitle = $j('input[name="boardTitle"]');
            var $currentComment = $j('textarea[name="boardComment"]');    
            
            
			// 만약 메세지가 같다면 같다는 알림창 출력
			if(originalTitle === $currentTitle.val() && originalComment === $currentComment.val()){
				return showError("변경된 내용이 없습니다. 변경후 다시 시도해 주세요.", $currentTitle);
			}
			if($currentTitle.val() === ''){
				return showError("제목을 입력해주세요", $currentTitle);
			};
			if($currentTitle.val().length == 16 ){
				return showError("제목은 최대 16자입니다.", $currentTitle);
			};
			if($currentComment.val() ===''){
				return showError("내용을 입력해주세요", $currentComment);
			};
				
			let param = {
					boardType: type,
					boardNum: num,
					boardTitle: $currentTitle.val(),
					boardComment: $currentComment.val()
			};
			
			$j.ajax({
				url: "/board/boardUpdateAction.do",
				dataType: "json",
				contentType: "application/json",  
				type: "POST",
				data: JSON.stringify(param),
				success: function(data, textStatus, jqXHR){
					if(data.success === "Y"){						
						alert("수정완료");
						alert("메세지:" + data.success);
						location.href="/board/boardList.do?pageNo=";
					}else {
						if(data.message === "401"){
							alert("로그인 후 다시 시도해주세요.");						
						}
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("실패");
				}
			})
		})
		
		
	})

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="수정">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
							${board.creatorName}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>