<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		// 이름에 한글만
		$j("#name").keyup(function() {
			this.value = this.value.replace( /[A-Za-z0-9]/g, '').substr(0, 5);
		}); 
		// 휴대폰번호에 한글만
		$j("#phone").keyup(function() {
			this.value = this.value.replace( /[^0-9]/g, '').substr(0, 11);
		}); 
		
		$j("#form").submit(function(e){
			e.preventDefault();
			
			var $name = $j("#name");
			var $phone = $j("#phone");
			
			if($name.val() == ""){
				alert("이름을 입력해주세요.");
				$name.focus();
				return;
			}
			
			if($phone.val() == ""){
				alert("휴대폰번호를 입력해주세요.");
				$phone.focus();
				return;
			}
			
			var formData = {
				name: $name.val(),
				phone: $phone.val()
			}
			
			
			this.submit();

		})
		
		
	})
</script>
<body>
<form id="form" action="/rec/loginAction.do" method="post">
	<table id="boardTable" border = "1" align="center">
		<tr>
			<th width="80" align="center">
				이름
			</th>
			<td>
				<input name="name" type="text" id="name" maxlength="5"> 
			</td>
		</tr>
		<tr>
			<th width="40" align="center">
				휴대폰번호
			</th>
			<td>
				<input name="phone" type="text" id="phone" maxlength="11"> 
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input id="submitBtn" type="submit" value="입사지원">
			</td>
		</tr>
	</table>
</form>
</body>
</html>