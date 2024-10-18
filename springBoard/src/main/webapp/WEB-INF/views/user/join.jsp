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
		var idCheck = false;
		var isPwValid = false;
		var pwCheck = false;
		var lastCheckedId = "";

		
				
		// ��ȿ�� ���� �� ���� ȭ
	    function showError(message, $element) {
	        alert(message);
	        $element.focus();
	    }
		
		// �ߺ��˻�
		$j("#duplication").click(function(){
			var $userId = $j("#userId");
	        if ($userId.val() === "") {
	            return showError("���̵� �Է����ּ���.", $userId);
	        }
	        if(/[^A-Za-z0-9]/ig.test($userId.val())){
	        	return showError("���̵�� ����� ���ڸ� �����մϴ�.", $userId);
	        }
	        
	        var data = {userId: $userId.val()};
			
			$j.ajax({
			    url : "/user/duplication.do",
			    dataType: "json",
			    type: "POST",
			    contentType : 'application/json',
			    data : JSON.stringify(data) ,
			    success: function(data, textStatus, jqXHR)
			    {
			    	console.log(data);
					if(data.isDuplicate !== 'true'){
						alert("��� ������ id�Դϴ�.");
						idCheck = true;
						lastCheckedId = $userId.val();
					}else{
						alert("��� �Ұ����� id�Դϴ�.");
						idCheck = false;
					}
					
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("������ ������ �����ϴ�. ����� �õ����ּ���.");
			    	idCheck = false;
			    }
			});
			console.log("�ߺ�Ȯ�� ��û: " + $userId.val());
		});
		

		$j("#userId").keyup(function() {
			this.value = this.value.replace( /[^A-Za-z0-9]/ig, '');
		    
		    idCheck = false;
		}); 
	

		$j("#userPhone2").keyup(function() {
		    this.value = this.value.replace(/[^0-9]/g, '');
	  	});
	   

		$j("#userPhone3").keyup(function() {
	    	this.value = this.value.replace(/[^0-9]/g, '').substr(0,5);
	  	}); 
	

		$j("#userName").keyup(function() {
			this.value = this.value.replace( /[A-Za-z0-9]/g, '').substr(0,5);
		});

		$j("#userAddr1").keyup(function() {
		    var value = this.value.replace(/[^0-9]/g, '');
		    
		    if (value.length > 3) {
		        value = value.substr(0, 3) + '-' + value.substr(3);
		    }
		    
		    value = value.substr(0, 7);
		    this.value = value;
		});
		
		$j("#userAddr2").keyup(function() {
			this.value = this.value.replace( /[A-Za-z]/g, '').substr(0,50);
		});

		$j("#submitBtn").click(function(){
			var $userId = $j("#userId");
			var $userPw = $j("#userPw");
			var $pwCheck = $j("#pwCheck");
			var $userName = $j("#userName");
			var $userPhone1 = $j("#userPhone1");
			var $userPhone2 = $j("#userPhone2");
			var $userPhone3 = $j("#userPhone3");
			var $userAddr1 = $j("#userAddr1");
			var $userAddr2 = $j("#userAddr2");
			var $userCompany = $j("#userCompany");
			
			if($userId.val() === "") {
	            return showError("���̵� �Է����ּ���.", $userId);
	        };
			if(!idCheck){
				return showError("���̵� �ߺ�Ȯ���� �������ּ���.",$userId);
			};
	        if($userId.val() !== lastCheckedId) {
	            return showError("���̵� �ߺ�Ȯ���� �ٽ� �������ּ���.", $userId);
	        };
	        
	        if($userPw.val() === "") {
	            return showError("��й�ȣ�� �Է����ּ���.", $userPw);
	        };
	        if($userPw.val().length < 6 || $userPw.val().length > 12) {
	            return showError("��й�ȣ�� 6�ڸ� ~ 12�ڸ����� �մϴ�.", $userPw);
	        };
	        
	        if($pwCheck.val() === "") {
	            return showError("��й�ȣȮ���� �Է����ּ���.", $pwCheck);
	        };
	        if($userPw.val() !== $pwCheck.val()) {  
	            ispwCheck = false;
	            return showError("��й�ȣ�� ��ġ���� �ʽ��ϴ�.", $pwCheck);
	        } else {
	            ispwCheck = true;
	        };
	        
	        if($userName.val() === "") {
	            return showError("�̸��� �Է����ּ���.", $userName);
	        };        
	        
	        if($userPhone2.val().length !== 4) {
	            return showError("��ȭ��ȣ�� ���� 4�ڸ����� �մϴ�.", $userPhone2);
	        };
	        if($userPhone3.val().length !== 4){
	        	return showError("��ȭ��ȣ�� ���� 4�ڸ����� �մϴ�.", $userPhone3);
	        };
	        if(!/^\d+$/.test($userPhone2.val()) || !/^\d+$/.test($userPhone3.val())) {
	            return showError("��ȭ��ȣ�� ���ڸ� �Է����ּ���.", $userPhone2);
	        };
	        
	        if($userAddr1.val() === ""){
	        	return showError("�����ȣ�� �Է����ּ���", $userAddr1);
	        };
	        
	        if($userAddr1.val() !== "" && !(/^\d{3}-\d{3}$/.test($userAddr1.val()))) {
	            return showError("�����ȣ�� XXX-XXX �����̾�� �մϴ�.", $userAddr1);
	        };  
	        
			
	        var formData = {
	        	userId: $userId.val(),
	        	userPw: $userPw.val(),
	        	userName: $userName.val(),
	        	userPhone1: $userPhone1.val(),
	        	userPhone2: $userPhone2.val(),
	        	userPhone3: $userPhone3.val(),
	        	userAddr1: $userAddr1.val(),
	        	userAddr2: $userAddr2.val(),
	        	userCompany: $userCompany.val()
	        }
	        console.log(formData);

	        $j.ajax({
	            url: "/user/joinAction.do",
	            type: "POST",
				contentType : 'application/json',
				dataType: "json",
				data : JSON.stringify(formData) ,
	            success: function(data, textStatus, jqXHR) {
	                if(data.success === "Y") {
	                	alert("ȸ�����Կ� �����ϼ̽��ϴ�.");
	                    window.location.href = "/user/login.do"; 
	                } else {
	                    alert("ȸ�����Կ� �����߽��ϴ�.");
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("���� ������ �߻��߽��ϴ�. ��� �� �ٽ� �õ����ּ���.");
	                console.error("Error: " + error);
	            }
	        });
			
		})
	});
	

</script>
<body>
<form id="form">
	<table align="center">
		<tr>
			<td align="left">
				<a href="/board/boardList.do">list</a>
			</td>
		</tr>
		<tr>
			<td>
				<table id="boardTable" border = "1">
					<tr>
						<td width="100" align="center">
							id
						</td>
						<td width="300">
							<input style="width: 150px" name="userId" id="userId" type="text" maxlength="15"> 
							<input type="button" id="duplication" value="�ߺ�Ȯ��">
						</td>
					</tr>
					
					<tr>
						<td align="center">
							pw
						</td>
						<td>
							<input name="userPw" id="userPw" type="password" maxlength="12"> 
						</td>
					</tr>
					
					<tr>
						<td align="center">
							pw check
						</td>
						<td>
							<input name="pwCheck" id="pwCheck" type="password" maxlength="12"> 
						</td>
					</tr>
					
					<tr>
						<td  align="center">
							name
						</td>
						<td>
							<input name="userName" id="userName" type="text" maxlength="5"> 
						</td>
					</tr>
					
					<tr>
						<td align="center">
							phone
						</td>
						<td>
							<select name="userPhone1" id="userPhone1">
								<c:forEach var="option" items="${options}">
									<option value="${option.codeId}">${option.codeName}</option>
								</c:forEach>
							</select>
							-
							<input style="width: 35px" name="userPhone2" id="userPhone2" type="text" maxlength="4">
							- 
							<input style="width: 35px" name="userPhone3" id="userPhone3" type="text" maxlength="4"> 
						</td>
					</tr>
					
					<tr>
						<td align="center">
							postNo
						</td>
						<td>
							<input name="userAddr1" id="userAddr1" type="text" maxlength="7"> 
						</td>
					</tr>
					
					<tr>
						<td align="center">
							address
						</td>
						<td>
							<input name="userAddr2" id="userAddr2" type="text" maxlength="50"> 
						</td>
					</tr>
					
					<tr>
						<td align="center">
							company
						</td>
						<td>
							<input name="userCompany" id="userCompany" type="text" maxlength="20"> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="button" id="submitBtn" value="join">
			</td>
		</tr>
	</table>
	
</form>	
</body>
</html>