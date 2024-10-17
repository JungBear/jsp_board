<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	
	$j(document).ready(function(){
		
		$j("#loginBtn").on('click',function(){
			var $userId = $j("#userId");
			var $userPw = $j("#userPw");
			
			if($userId.val() === ""){
				alert("���̵� �Է����ּ���.");
				$userId.focus();
				return;
			}
			if($userPw.val() === ""){
				alert("��й�ȣ�� �Է����ּ���.");
				$userPw.focus();
				return;
			}
			
			var data = {
					userId: $userId.val(),
					userPw: $userPw.val()}
			
			$j.ajax({
				url : "/user/loginAction.do",
				dataType: "json",
				type: "POST",
				contentType : 'application/json',
				data : JSON.stringify(data) ,
				success: function(data, textStatus, jqXHR)
				{
				  	console.log(data);
					if(data.success === 'Y'){
						alert("ȯ���մϴ�.");
						location.href = "/board/boardList.do?pageNo=";
					}else{
						alert("���̵� �Ǵ� ��й�ȣ�� �������� �ʽ��ϴ�.")
						/* if(data.type === 'id'){
							alert("�����ϴ� ���̵� �����ϴ�.");
						}else if(data.type === 'pw'){
						
							alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
						}*/
					}
				},	
				error: function (jqXHR, textStatus, errorThrown)
				{
					alert("������ ������ �����ϴ�. ����� �õ����ּ���.");
					
				}
			});
		});
	});

</script>
<body>
<form id="form">
	<table align="center">
		<tr>
			<td>
				<table id="boardTable" border = "1">
					<tr>
						<td width="80" align="center">
							id
						</td>
						<td>
							<input name="userId" type="text" id="userId"> 
						</td>
					</tr>
					<tr>
						<td width="40" align="center">
							pw
						</td>
						<td>
							<input name="userPw" type="password" id="userPw"> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<span id="loginBtn" style="cursor: pointer;">login</span>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>