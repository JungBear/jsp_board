<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>

<script type="text/javascript">
	$j(document).ready(function(){
		
		$j("#updateBtn").click(function(e){
			e.preventDefault();
			
			var href = $j(this).attr('href');
			
			if(!${not empty sessionScope.user}){
				alert("로그인 후 가능한 서비스입니다.");
				return;
			}
			
			location.href = href;
			
		})
		
		var type = "${board.boardType}";
		var num = "${board.boardNum}";
		$j('#submit').on("click", function(){
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			
			let param = {
					boardType: type,
					boardNum: num
			};
			
			$j.ajax({
				url: "/board/boardDeleteAction.do",
				dataType: "json",
				contentType: "application/json",  
				type: "POST",
				data: JSON.stringify(param),
				success: function(data, textStatus, jqXHR){
					alert("삭제완료");
					alert("메세지:" + data.success);
					location.href="/board/boardList.do?pageNo=";
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("실패");
				}
			})
		})
	})
</script>

<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
				    <td width="120" align="center">
				        Type
				    </td>
				    <td width="400">
				        ${board.boardTypeName}
				    </td>
				</tr>
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
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
			<a id="updateBtn" href="/board/${board.boardType}/${board.boardNum}/boardUpdate.do">update</a>
			<c:choose>
		        <c:when test="${sessionScope.user.userId eq board.creator}">
					<td align="right">
						<input id="submit" type="button" value="삭제">
					</td>				
		        </c:when>
			</c:choose>
		</td>
	</tr>
</table>	
</body>
</html>