<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			
			var $boardType = $j("#boardType option:selected");
			var $boardTitle = $j("#boardTitle");
			var $boardComment = $j("#boardComment");
			var $creator = "${sessionScope.user.userId}";
			
			function showError(message, $element) {
			      alert(message);
			      $element.focus();
			  }
			
			if($boardTitle.val() === ''){
				return showError("제목을 입력해주세요", $boardTitle);
			};
			if($boardTitle.val().length == 16 ){
				return showError("제목은 최대 16자입니다.", $boardTitle);
			};
			if($boardComment.val() ===''){
				return showError("내용을 입력해주세요", $boardComment);
			};
			
			
			var formData = {
					boardType: $boardType.val(),
					boardTitle: $boardTitle.val(),
					boardComment: $boardComment.val(),
					creator: $creator
			};
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    contentType : 'application/json',
			    type: "POST",
			    data : JSON.stringify(formData),
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});
	

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td>
							<select name="boardType" id="boardType">
							<c:forEach var="option" items="${menu}">
								<option value="${option.codeId}">${option.codeName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" id="boardTitle" maxlength="16" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment" id="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
							<p id="creator">${sessionScope.user.userName}</p>
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