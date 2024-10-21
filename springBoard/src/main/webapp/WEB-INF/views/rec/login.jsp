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
		
		$j("#submitBtn").click(function(e){
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
			
 	        $j.ajax({
	            url: "/rec/loginAction.do",
	            type: "POST",
				contentType : 'application/json',
				dataType: "json",
				data : JSON.stringify(formData) ,
				success: function(data) {
		            if(data.success) {
						alert("로그인 되셨습니다.");
						switch(data.status) {
				            case "NEW":
				                alert("지원서 작성을 시작합니다.");
				                window.location.href = "/rec/main.do";
				                break;
				            case "SAVED":
				                alert("이전에 작성하던 지원서가 존재합니다.");
				                window.location.href = "/rec/main.do";
				                break;
				            case "SUBMITTED":
				                alert("이미 제출하셨습니다.");
				                break;
						}
		            } else {
		                alert("로그인에 실패했습니다.");
		            }
		        },
	            error: function(xhr, status, error) {
	                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	                console.error("Error: " + error);
	            }
	        }); 

		})
		
		
	})
</script>
<body>
<form id="form" >
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
				<input id="submitBtn" type="button" value="입사지원">
			</td>
		</tr>
	</table>
</form>
</body>
</html>