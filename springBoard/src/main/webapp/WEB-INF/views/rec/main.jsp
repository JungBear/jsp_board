<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>

<style>
	input[type="button"]{
		margin-top : 10px;
		margin-bottom: 10px;
	}
</style>

<script type="text/javascript">
	$j(document).ready(function(){
	   var sido = [
		    "����", "��⵵", "��õ", 
		    "������", 
		    "��û�ϵ�", "��û����",
		    "����ϵ�", "���󳲵�",
		    "���ϵ�", "��󳲵�",
		    "���ֵ�"
	    ];

	    function populateSidoSelect($select) {
    	 	$j.each(sido, function(index, value) {
             	$select.append($j('<option>', {
	                value: value,
	            	text: value
	        	}));
	    	});
		};
		
		function deleteRows(tableId) {
	        $j("#" + tableId + " tbody tr").filter(function() {
	            return $j(this).find('input[type="checkbox"]').is(':checked');
	        }).remove();
	    };
	    
	    function collectFormData() {
        	var formData = {
	            recruit: {
	            	seq: "${sessionScope.user.seq}",
	                name: $j("#name").val(),
	                birth: $j("#birth").val(),
	                gender: $j("#gender").val(),
	                phone: $j("#phone").val(),
	                email: $j("#email").val(),
	                addr: $j("#addr").val(),
	                location: $j("#recLocation").val(),
	                workType: $j("#workType").val()
	            },
	            educations: [],
	            careers: [],
	            certificates: []
	        };

	        $j("#eduTable tbody tr").each(function() {
	            formData.educations.push({
	            	seq: "${sessionScope.user.seq}",
	                startPeriod: $j(this).find("input[name='educations.startPeriod']").val(),
	                endPeriod: $j(this).find("input[name='educations.endPeriod']").val(),
	                division: $j(this).find("select[name='educations.division']").val(),
	                schoolName: $j(this).find("input[name='educations.schoolName']").val(),
	                location: $j(this).find("select[name='educations.location']").val(),
	                major: $j(this).find("input[name='educations.major']").val(),
	                grade: $j(this).find("input[name='educations.grade']").val()
	            });
	        });

	        $j("#carTable tbody tr").each(function() {
	            formData.careers.push({
	            	seq: "${sessionScope.user.seq}",
	                startPeriod: $j(this).find("input[name='careers.startPeriod']").val(),
	                endPeriod: $j(this).find("input[name='careers.endPeriod']").val(),
	                compName: $j(this).find("input[name='careers.compName']").val(),
	                task: $j(this).find("input[name='careers.task']").val(),
	                location: $j(this).find("input[name='careers.location']").val()
	            });
	        });

	        $j("#cerTable tbody tr").each(function() {
	            formData.certificates.push({
	            	seq: "${sessionScope.user.seq}",
	                qualifiName: $j(this).find("input[name='certificates.qualifiName']").val(),
	                acquDate: $j(this).find("input[name='certificates.acquDate']").val(),
	                organizeName: $j(this).find("input[name='certificates.organizeName']").val()
	            });
	        });

	        return formData;
	    }
		
		populateSidoSelect($j("#recLocation"));
		populateSidoSelect($j("select[name='educations.location']"));

	    $j("#addEduBtn").click(function() {
	        var newRow = 
	        	`<tr>
		        	<td>
						<input type="checkbox">
					</td>
					<td style="width: 100px">
						<input name="educations.startPeriod" type="text" style="margin-right: 5px" placeholder="YYYY.MM" maxlength="7">
						 ~
						<input name="educations.endPeriod" type="text" placeholder="YYYY.MM" maxlength="7">
					</td> 
					<td>
						<select name="educations.division">
							<option value="student">����</option>
							<option value="dropOut">����</option>
							<option value="graduate">����</option>
						</select>
					</td>
					<td>
						<input name="educations.schoolName" type="text" style="display: block; box-sizing: border-box;" maxlength="85">
						<select name="educations.location">
						</select>
					</td>
					<td>
						<input name="educations.major" type="text" maxlength="85">
					</td>
					<td>
						<input name="educations.grade" type="text" maxlength="4">
					</td>
		        </tr>`;
	        $j("#eduTable tbody").append(newRow);
	        populateSidoSelect($j("#eduTable tbody tr:last-child select[name='educations.location']"));
	    });
	    
	    $j("#removeEduBtn").click(function() { 
	        var $checkedRows = $j("#eduTable tbody tr").filter(function() {
	            return $j(this).find('input[type="checkbox"]').is(':checked');
	        });

	        if ($j("#eduTable tbody tr").length === 1 || 
	            ($j("#eduTable tbody tr").length === $checkedRows.length)) {
	            alert("�з��� �ּ� 1�� �̻� �Է��ؾ� �մϴ�.");
	            var $firstCheckbox = $j("#eduTable tbody tr:first input[type='checkbox']");
	            $firstCheckbox.prop('checked', false);
	            $j("#eduStartPeriod").focus();
	            return;
	        }
			
	    	deleteRows("eduTable"); 
    	});
	    
	    $j("#addCarBtn").click(function() {
	        var newRow = 
       			`<tr>
		        	<td>
						<input type="checkbox">
					</td>
					<td>
						<input name="careers.startPeriod" type="text" maxlength="7" placeholder="YYYY.MM">~
						<input name="careers.endPeriod" type="text" maxlength="7" placeholder="YYYY.MM">
					</td>
					<td>
						<input name="careers.compName" maxlength="85">
					</td>
					<td>
						<input name="careers.task" maxlength="85">
					</td>
					<td>
						<input name="careers.location" maxlength="85">
					</td>			
		        </tr>
		        `;
	        $j("#carTable tbody").append(newRow);
	    });
	    
	    $j("#removeCarBtn").click(function(){
	    	deleteRows("carTable");
	    });
	    
	    $j("#addCerBtn").click(function(){
	    	var newRow = 
	    		`<tr>
		    		<td>
						<input type="checkbox">
					</td>
					<td>
						<input name="certificates.qualifiName" type="text" maxlength="20">
					</td>
					<td>
						<input name="certificates.acquDate" type="text" maxlength="7" placeholder="YYYY.MM">
					</td>
					<td>
						<input name="certificates.organizeName" type="text" maxlength="20">
					</td>
		    	</tr>`;
	    	$j("#cerTable tbody").append(newRow);
    	});	
	    
	    $j("#removeCerBtn").click(function(){
	    	deleteRows("cerTable");
	    });
	    
		$j("#name").keyup(function() {
		    this.value = this.value.replace(/[a-zA-Z0-9]/g, '');
	  	});
	    
	    $j("#birth").on('keyup', function(){
	    	var value = this.value.replace( /[^0-9]/ig, '');
	        if (value.length > 4) {
		        value = value.substr(0, 4) + '.' + value.substr(4);
		    };
		    
		    if(value.length > 7){
		    	value = value.substr(0, 7) + '.' + value.substr(7);
		    }
		    
		    value = value.substr(0, 10);
		    this.value = value;
	    })

	    $j("#phone").keyup(function(e) {
	    	this.value = this.value.replace(/[^0-9]/g, '');
	    });

	    $j("#email").keyup(function(e) {
	    	this.value = this.value.replace(/[^a-zA-Z0-9@.]/g, '');
	    });
	    
	    $j("#addr").keyup(function(){
	    	this.value = this.value.replace(/[a-zA-Z]/g, '');
	    })
	    
  		$j("input[name='educations.startPeriod'], input[name='educations.endPeriod'], input[name='careers.startPeriod'], input[name='careers.endPeriod'], input[name='certificates.acquDate']").keyup(function() {
  			var value = this.value.replace( /[^0-9]/ig, '');
		    
		    if (value.length > 4) {
		        value = value.substr(0, 4) + '.' + value.substr(4);
		    }
		    
		    value = value.substr(0, 7);
		    this.value = value;
		});
  		
  		$j("input[name='educations.schoolName'], input[name='educations.major'], select[name='educations.location'], input[name='certificates.qualifiName'], input[name='certificates.organizeName']").keyup(function(){
  			this.value = this.value.replace(/[0-9]/g, '');
  		});
  		
  		$j("input[name='educations.grade']").keyup(function(){
  			var value = this.value.replace( /[^0-9]/ig, '');
  			
  		   if (value.length > 1) {
		        value = value.substr(0, 1) + '.' + value.substr(1);
		    }
		    
		    value = value.substr(0, 4);
		    this.value = value;
  		});
	    
	    $j("#saveBtn").click(function(){
			var formData = collectFormData();
	    });
	    
	    $j("#submitBtn").click(function(){
	    	var formData = collectFormData();
	    	var emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
	    	
	    	console.log("����");
	    	
	    	if(formData.recruit.name ==''){
	    		alert("�̸��� �Է����ּ���.");
	    		$j("#name").focus();
	    		return;
	    	};
	    	
	    	if(formData.recruit.name != "${sessionScope.user.name}"){
	    		alert("�α����� �̸��� ���� �̸��� �ٸ��ϴ�. �α����� �̸����� �������ּ���.");
	    		$j("#name").focus();
	    		$j("#name").val("${sessionScope.user.name}");
	    		return;
	    	};
	    	
	    	if(formData.recruit.birth ==''){
	    		alert("������ϸ� �Է����ּ���.");
	    		$j("#birth").focus();
	    		return;
	    	};
	    	
	    	if(formData.recruit.birth.length != 10){
	    		alert("��������� ������ ���缭 �Է����ּ���.");
	    		$j("#birth").focus();
	    		$j("#birth").val('');
	    		return
	    	}
	    	
	    	if(formData.recruit.phone ==''){
	    		alert("����ó�� �Է����ּ���.");
	    		$j("#phone").focus();
	    		return;
	    	};
    	
	    	if(formData.recruit.phone != "${sessionScope.user.phone}"){
	    		alert("�α����� ����ó�� ���� ����ó�� �ٸ��ϴ�. �α����� ����ó�� �������ּ���.");
	    		$j("#phone").focus();
	    		$j("#phone").val("${sessionScope.user.phone}");
	    		return;
	    	};
	    	
	    	if(formData.recruit.email == ''){
	    		alert("�̸����� �Է����ּ���.");
	    		$j("#email").focus();
	    		return;
	    	};
	    	
	    	
		    if (!emailRegex.test(formData.recruit.email)) {
		        alert("�ùٸ� �̸��� �ּҸ� �Է����ּ���.");
	    		$j("#email").val("");
	    		$j("#email").focus();
				return;
		    };
	    	
	    	if(formData.recruit.addr ==''){
	    		alert("�ּҸ� �Է����ּ���.");
	    		$j("#addr").focus();
	    		return;
	    	};
	    	
	    	if (formData.educations.length === 0) {
	    	    alert("�з��� �ּ� 1�� �̻� �Է��ؾ� �մϴ�.");
	    	    $j("input[name='educations.startPeriod']").focus();
	    	    return;
	    	}
	    	
	    	var focusSet = false;

	    	formData.educations.forEach(function(education, index) {
	    	    if (!focusSet) {
    	    	  	if (education.startPeriod === '') {
	    	            alert("���� ���� �Ⱓ�� �Է����ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.startPeriod']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.endPeriod === '') {
	    	        	alert("���� ���� �Ⱓ�� �Է����ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.endPeriod']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.schoolName === '') {
	    	            alert("�б����� �Է����ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.schoolName']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.location === '') {
	    	            alert("�������� �������ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) select[name='educations.location']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.division === '') {
	    	            alert("������ �������ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) select[name='educations.division']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	      
	    	        if (education.major === '') {
	    	            alert("������ �Է����ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.major']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.grade === '') {
	    	            alert("������ �Է����ּ���.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.grade']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
					if (parseFloat(education.grade) > 4.5){
						alert("������ �ְ����� 4.5�Դϴ�. �������ּ���.");
						$j("input[name='educations.grade']").focus();
						$j("input[name='educations.grade']").val('');
					}
	    	    }
	    	});

	    	if (focusSet) {
	    	    return;
	    	}
	    	
	    	
	    	
	    });
	});
</script>

<body>
	<div align="center">
		<h2>�Ի� ������</h2>
	</div>
	<form id="form">
		<table border="1" align="center" style="width: 100%">
			<tr>
				<td>
					<table border="1" align="center">
						<tr>
							<th>�̸�</th>
							<td>
								<input name="recruit.name" id="name" type="text" value="${recruit.name }">
							</td>
							<th>�������</th>
							<td>
								<input name="recruit.birth" id="birth" type="text" value="${recruit.birth }" maxlength="10" placeholder="YYYY.MM.DD">
							</td>
						</tr>
							
						<tr>
							<th>����</th>
							<td>
								<select name=recruit.gender  id="gender">
									<option value="M">����</option>
									<option value="W">����</option>
								</select>
							</td>
							<th>����ó</th>
							<td>
								<input name="recruit.phone" id="phone" type="text" value="${recruit.phone }" maxlength="11">
							</td>
						</tr>
	
						<tr>
							<th>email</th>
							<td>
								<input name="recruit.email" id="email" type="text" 
									value="${recruit.email }" placeholder="example@example.com"
									maxlength="255">
							</td>
							<th>�ּ�</th>
							<td>
								<input name="recruit.addr" id="addr" type="text" value="${recruit.addr }" maxlength="85">
							</td>
						</tr>
	
						<tr>
							<th>����ٹ���</th>
							<td>
								<select name="recruit.location" id="recLocation">
								</select>
							</td>
							<th>�ٹ�����</th>
							<td>
								<select name="recruit.workType" id="workType">
									<option value="M">������</option>
									<option value="W">�����</option>
								</select>
							</td>
						</tr>
					</table>	
				</td>
			</tr>
			<tr>
				<td align="right">
					<h3 align="left">�з�</h3>
					<input type="button" value="�߰�" id="addEduBtn">
					<input type="button" value="����" id="removeEduBtn">
					<table align="center" border="1" width="90%" id="eduTable">
						<thead>
							<tr>
								<th></th>
								<th>���бⰣ</th>
								<th>����</th>
								<th>�б���(������)</th>
								<th>����</th>
								<th>����</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td style="width: 100px">
									<input name="educations.startPeriod" type="text" style="margin-right: 5px" placeholder="YYYY.MM" maxlength="7">
									 ~
									<input name="educations.endPeriod" type="text" placeholder="YYYY.MM" maxlength="7">
								</td> 
								<td>
									<select name="educations.division">
										<option value="student">����</option>
										<option value="dropOut">����</option>
										<option value="graduate">����</option>
									</select>
								</td>
								<td>
									<input name="educations.schoolName" type="text" style="display: block; box-sizing: border-box;" maxlength="85">
									<select name="educations.location">
									</select>
								</td>
								<td>
									<input name="educations.major" type="text" maxlength="85">
								</td>
								<td>
									<input name="educations.grade" type="text" maxlength="4">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<h3 align="left">���</h3>
					<input type="button" value="�߰�" id="addCarBtn">
					<input type="button" value="����" id="removeCarBtn">
					<table align="center" border="1" width="90%" id="carTable">
						<thead>
							<tr>
								<th></th>
								<th>�ٹ��Ⱓ</th>
								<th>ȸ���</th>
								<th>�μ�/����/��å</th>
								<th>����</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									<input name="careers.startPeriod" type="text" maxlength="7" placeholder="YYYY.MM">~
									<input name="careers.endPeriod" type="text" maxlength="7" placeholder="YYYY.MM">
								</td>
								<td>
									<input name="careers.compName" maxlength="85">
								</td>
								<td>
									<input name="careers.task" maxlength="85">
								</td>
								<td>
									<input name="careers.location" maxlength="85">
								</td>			
							</tr>					
						</tbody>								
					</table>
				</td>
			</tr>
			
			<tr>
				<td align="right">
					<h3 align="left">�ڰ���</h3>
					<input type="button" value="�߰�" id="addCerBtn">
					<input type="button" value="����" id="removeCerBtn">
					<table align="center" border="1" width="90%" id="cerTable">
						<thead>
							<tr>
								<th></th>
								<th>�ڰ�����</th>
								<th>�����</th>
								<th>����ó</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									<input name="certificates.qualifiName" type="text" maxlength="20">
								</td>
								<td>
									<input name="certificates.acquDate" type="text" maxlength="7" placeholder="YYYY.MM">
								</td>
								<td>
									<input name="certificates.organizeName" type="text" maxlength="20">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			
		</table>
		<div align="center">
			<input type="button" id="saveBtn" value="����">
			<input type="button" id="submitBtn" value="����">
		</div>
	</form>
</body>
</html>