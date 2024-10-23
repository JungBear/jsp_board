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


		
		function deleteRows(tableId) {
			   const checkedRows = $j("#" + tableId + " tbody tr").filter(function() {
			       return $j(this).find('input[type="checkbox"]').is(':checked');
			   });
			   
			   if(checkedRows.length === 0) {
			       alert("������ �׸��� �������ּ���.");
			       return;
			   }
			   
			   checkedRows.remove();
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
	            const startPeriod = $j(this).find("input[name='careers.startPeriod']").val();
	            const endPeriod = $j(this).find("input[name='careers.endPeriod']").val();
	            const compName = $j(this).find("input[name='careers.compName']").val();
	            const task = $j(this).find("input[name='careers.task']").val();
	            const location = $j(this).find("input[name='careers.location']").val();

	            if (startPeriod || endPeriod || compName || task || location) {
	                formData.careers.push({
	                    seq: "${sessionScope.user.seq}",
	                    startPeriod: startPeriod,
	                    endPeriod: endPeriod,
	                    compName: compName,
	                    task: task,
	                    location: location
	                });
	            }
	        });

	        $j("#cerTable tbody tr").each(function() {
	            const qualifiName = $j(this).find("input[name='certificates.qualifiName']").val();
	            const acquDate = $j(this).find("input[name='certificates.acquDate']").val();
	            const organizeName = $j(this).find("input[name='certificates.organizeName']").val();

	            if (qualifiName || acquDate || organizeName) {
	                formData.certificates.push({
	                    seq: "${sessionScope.user.seq}",
	                    qualifiName: qualifiName,
	                    acquDate: acquDate,
	                    organizeName: organizeName
	                });
	            }
	        });

	        return formData;
	    }
	    
	    function setupInputHandlers() {
	    	
			$j("#name, input[name='careers.location'], input[name='educations.schoolName']").keyup(function() {
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
		    
		    $j("#addr, input[name='careers.task']").keyup(function(){
		    	this.value = this.value.replace(/[a-zA-Z]/g, '');
		    })
	    	
	        $j("input[name='educations.startPeriod'], input[name='educations.endPeriod'], input[name='careers.startPeriod'], input[name='careers.endPeriod'], input[name='certificates.acquDate']").keyup(function() {
	            var value = this.value.replace(/[^0-9]/ig, '');
	            
	            if (value.length > 4) {
	                value = value.substr(0, 4) + '.' + value.substr(4);
	            }
	            
	            value = value.substr(0, 7);
	            this.value = value;
	        });
	        
	        $j("input[name='educations.major'], select[name='educations.location'], input[name='certificates.qualifiName'], input[name='certificates.organizeName']").keyup(function(){
	            this.value = this.value.replace(/[0-9]/g, '');
	        });
	        
	        $j("input[name='educations.grade']").keyup(function(){
	            var value = this.value.replace(/[^0-9]/ig, '');
	            
	            if (value.length > 1) {
	                value = value.substr(0, 1) + '.' + value.substr(1);
	            }
	            
	            value = value.substr(0, 4);
	            this.value = value;
	        });
	        $j("input[name='careers.task']").keyup(function() {
        	 	var value = this.value;
	        	    
        	    var slashCount = (value.match(/\//g) || []).length;
        	    if (slashCount > 2) {
        	        value = value.split('/').slice(0, 3).join('/');
        	    }

        	    this.value = value;
	        });
	    };
	    
	    function validateRecruitInfo() {
	    	const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	        const name = $j("#name").val();
	        const birth = $j("#birth").val();
	        const phone = $j("#phone").val();
	        const email = $j("#email").val();
	        const addr = $j("#addr").val();
	        const [year, month, day] = birth.split('.');

	        if(name == '') {
	            alert("�̸��� �Է����ּ���.");
	            $j("#name").focus();
	            return false;
	        }
	        if(name != "${sessionScope.user.name}") {
	            alert("�α����� �̸��� ���� �̸��� �ٸ��ϴ�.");
	            $j("#name").focus();
	            $j("#name").val("${sessionScope.user.name}");
	            return false;
	        }
	        if(birth == '') {
	            alert("������ϸ� �Է����ּ���.");
	            $j("#birth").focus();
	            return false;
	        }
	        if(birth.length != 10) {
	            alert("��������� ������ ���缭 �Է����ּ���.\n����) 1999.02.12");
	            $j("#birth").focus();
	            return false;
	        }
	        if(month > 12){
	        	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01.23");
	        	$j("#birth").focus();
                return false;
	        }
	        if(day > 31){
	        	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01.23");
	        	$j("#birth").focus();
                return false;
	        }
	        if(phone == '') {
	            alert("����ó�� �Է����ּ���.");
	            $j("#phone").focus();
	            return false;
	        }
	        if(phone != "${sessionScope.user.phone}") {
	            alert("�α����� ����ó�� ���� ����ó�� �ٸ��ϴ�. \n�α����� ����ó�� �������ּ���.");
	            $j("#phone").focus();
	            $j("#phone").val("${sessionScope.user.phone}");
	            return false;
	        }
	        if(email == '') {
	            alert("�̸����� �Է����ּ���.");
	            $j("#email").focus();
	            return false;
	        }
	        if (!emailRegex.test(email)) {
	            alert("�ùٸ� �̸��� �ּҸ� �Է����ּ���.\n����) exaple@example.com");
	            $j("#email").focus();
	            return false;
	        }
	        if(addr == '') {
	            alert("�ּҸ� �Է����ּ���.");
	            $j("#addr").focus();
	            return false;
	        }
	        
	        return true;
	    }

	    function validateEducation() {
	        const eduRows = $j("#eduTable tbody tr");
	        if (eduRows.length === 0) {
	            alert("�з��� �ּ� 1�� �̻� �Է��ؾ� �մϴ�.");
	            $j("input[name='educations.startPeriod']").focus();
	            return false;
	        }

	        for (let i = 0; i < eduRows.length; i++) {
	            const startPeriod = $j(eduRows[i]).find("input[name='educations.startPeriod']").val();
	            const endPeriod = $j(eduRows[i]).find("input[name='educations.endPeriod']").val();
	            const schoolName = $j(eduRows[i]).find("input[name='educations.schoolName']").val();
	            const location = $j(eduRows[i]).find("select[name='educations.location']").val();
	            const division = $j(eduRows[i]).find("select[name='educations.division']").val();
	            const major = $j(eduRows[i]).find("input[name='educations.major']").val();
	            const grade = $j(eduRows[i]).find("input[name='educations.grade']").val();

	            const [startYear, startMonth] = startPeriod.split('.');
	            const [endYear, endMonth] = endPeriod.split('.');
	            
	            if (startPeriod === '') {
	                alert("���� ���� �Ⱓ�� �Է����ּ���.\n����) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.startPeriod']").focus();
	                return false;
	            }
	            if(startPeriod.length != 7){
	                alert("���� ���� �Ⱓ�� YYYY.MM���� �ۼ����ּ���\n����) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.startPeriod']").focus();
	                return false;
	            }
	            if(startMonth > 12){
	            	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.startPeriod']").focus();
	                return false;
	            }
	            if (endPeriod === '') {
	                alert("���� ���� �Ⱓ�� �Է����ּ���.\n����) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();
	                return false;
	            }
	            if(endPeriod.length != 7){
	                alert("���� ���� �Ⱓ�� YYYY.MM���� �ۼ����ּ���.\n����) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();   
	                return false;
	            }
	            if(endMonth > 12){
	            	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();   
	                return false;
	            }
	            

	            const startDate = new Date(startYear, startMonth - 1);
	            const endDate = new Date(endYear, endMonth - 1);

	            if (startDate > endDate) {
	                alert("���� �Ⱓ�� ���� �Ⱓ���� �ռ� �� �����ϴ�.");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();
	                return false;
	            }      
	            if (schoolName === '' || (!schoolName.endsWith('����б�') && !schoolName.endsWith('���б�'))) {
	                alert("�б����� �����ּ���. \n��) ������б�, �������б�");
	                $j(eduRows[i]).find("input[name='educations.schoolName']").focus();
	                return false;
	            }
	            if (location === '') {
	                alert("�������� �������ּ���.");
	                $j(eduRows[i]).find("select[name='educations.location']").focus();
	                return false;
	            }
	            if (division === '') {
	                alert("������ �������ּ���.");
	                $j(eduRows[i]).find("select[name='educations.division']").focus();
	                return false;
	            }
	            if (major === '') {
	                alert("������ �Է����ּ���.");
	                $j(eduRows[i]).find("input[name='educations.major']").focus();
	                return false;
	            }
	            if (grade === '') {
	                alert("������ �Է����ּ���.");
	                $j(eduRows[i]).find("input[name='educations.grade']").focus();
	                return false;
	            }
	            if (parseFloat(grade) > 4.5) {
	            	alert("������ �ùٸ��� �Է����ּ���.\n����) 0.00 ~ 4.50");
	                $j(eduRows[i]).find("input[name='educations.grade']").focus();
	                $j(eduRows[i]).find("input[name='educations.grade']").val('');
	                return false;
	            }

	        }
	        return true;
	    }

	    
	    function validateCareer() {
	        const carRows = $j("#carTable tbody tr");
	        
	        for (let i = 0; i < carRows.length; i++) {
	            const startPeriod = $j(carRows[i]).find("input[name='careers.startPeriod']").val();
	            const endPeriod = $j(carRows[i]).find("input[name='careers.endPeriod']").val();
	            const compName = $j(carRows[i]).find("input[name='careers.compName']").val();
	            const task = $j(carRows[i]).find("input[name='careers.task']").val();
	            const location = $j(carRows[i]).find("input[name='careers.location']").val();
                const [startYear, startMonth] = startPeriod.split('.');
	            const [endYear, endMonth] = endPeriod.split('.');


	            const isEmpty = !startPeriod && !endPeriod && !compName && !task && !location;
	            const isPartiallyFilled = startPeriod || endPeriod || compName || task || location;

	            
	            if (isEmpty) {
	                $j(carRows[i]).remove();
	                continue;
	            }

	            if (isPartiallyFilled) {
	                if (!startPeriod) {
	                    alert("��� ���� �Ⱓ�� �Է����ּ���.\n����) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.startPeriod']").focus();
	                    return false;
	                }
	                if (startPeriod.length != 7){
	                    alert("�ٹ� �Ⱓ�� YYYY.MM �������� �Է����ּ���\n����) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.startPeriod']").focus();
	                    return false;
	                }
	                if(startMonth > 12){
		            	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01");
		                $j(eduRows[i]).find("input[name='careers.startPeriod']").focus();
		                return false;
		            }
	                if (!endPeriod) {
	                    alert("��� ���� �Ⱓ�� �Է����ּ���.\n����) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.endPeriod']").focus();
	                    return false;
	                }
	                if (endPeriod.length != 7){
	                    alert("�ٹ� �Ⱓ�� YYYY.MM �������� �Է����ּ���.\n����) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.endPeriod']").focus();
	                    return false;
	                }
	                if(endMonth > 12){
		            	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01");
		                $j(eduRows[i]).find("input[name='careers.startPeriod']").focus();
		                return false;
	                }
		            const startDate = new Date(startYear, startMonth - 1);
		            const endDate = new Date(endYear, endMonth - 1);

		            if (startDate > endDate) {
		                alert("���� �Ⱓ�� ���� �Ⱓ���� �ռ� �� �����ϴ�.");
		                $j(carRows[i]).find("input[name='careers.endPeriod']").focus();
		                return false;
		            }
	                if (!compName) {
	                    alert("ȸ����� �Է����ּ���.");
	                    $j(carRows[i]).find("input[name='careers.compName']").focus();
	                    return false;
	                }
	                if (!task) {
	                    alert("�μ�/����/��å�� �Է����ּ���.");
	                    $j(carRows[i]).find("input[name='careers.task']").focus();
	                    return false;
	                }
	                const taskParts = task.split('/');
	                if (taskParts.length !== 3) {
	                    alert("�μ�/����/��å �������� �Է����ּ���.\n����: ������/�븮/����");
	                    $j(carRows[i]).find("input[name='careers.task']").focus();
	                    return false;
	                }
	                if (!location) {
	                    alert("������ �Է����ּ���.");
	                    $j(carRows[i]).find("input[name='careers.location']").focus();
	                    return false;
	                }
	            }
	        }
	        return true;
	    }

	    function validateCertificate() {
	        const certRows = $j("#cerTable tbody tr");
	        
	        for (let i = 0; i < certRows.length; i++) {
	            const qualifiName = $j(certRows[i]).find("input[name='certificates.qualifiName']").val();
	            const acquDate = $j(certRows[i]).find("input[name='certificates.acquDate']").val();
	            const organizeName = $j(certRows[i]).find("input[name='certificates.organizeName']").val();
	            const [acquYear, acquMonth] = acquDate.split('.');
	            
	            const isEmpty = !qualifiName && !acquDate && !organizeName;
	            const isPartiallyFilled = qualifiName || acquDate || organizeName;

	            if (isEmpty) {
	                $j(certRows[i]).remove();
	                continue;
	            }

	            if (isPartiallyFilled) {
	                if (!qualifiName) {
	                    alert("�ڰ������� �Է����ּ���.");
	                    $j(certRows[i]).find("input[name='certificates.qualifiName']").focus();
	                    return false;
	                }
	                if (!acquDate) {
	                    alert("������� �Է����ּ���.");
	                    $j(certRows[i]).find("input[name='certificates.acquDate']").focus();
	                    return false;
	                }
	                if (acquDate.length != 7){
	                    alert("������� YYYY.MM �������� �Է����ּ���");
	                    $j(certRows[i]).find("input[name='certificates.acquDate']").focus();
	                    return false;
	                }
	                if(acquMonth > 12){
		            	alert("�ùٸ� ���� �Է����ּ���.\n����) 2024.01");
		                $j(certRows[i]).find("input[name='certificates.acquDate']").focus();
		                return false;
	                }
	                if (!organizeName) {
	                    alert("����ó�� �Է����ּ���.");
	                    $j(certRows[i]).find("input[name='certificates.organizeName']").focus();
	                    return false;
	                }
	            }
	        }
	        return true;
	    }
	    
		setupInputHandlers();

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
						<input name="educations.schoolName" type="text" placeholder="00����б� �Ǵ� 00���б�" style="display: block; box-sizing: border-box;" maxlength="85">
						<select name="educations.location">
							<option value="����">����</option>
						    <option value="��⵵">��⵵</option>
						    <option value="��õ">��õ</option>
						  	<option value="������">������</option>
						    <option value="��û�ϵ�">��û�ϵ�</option>
						    <option value="��û����">��û����</option>
						  	<option value="����ϵ�">����ϵ�</option>
						    <option value="���󳲵�">���󳲵�</option>
						    <option value="���ϵ�">���ϵ�</option>
						    <option value="��󳲵�">��󳲵�</option>
						    <option value="���ֵ�">���ֵ�</option>
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
	        setupInputHandlers();
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
	        setupInputHandlers();
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
	    	setupInputHandlers();
    	});	
	    
	    $j("#removeCerBtn").click(function(){
	    	deleteRows("cerTable");
	    });
	    
	    $j("#saveBtn, #submitBtn").click(function(event) {
	    	const formData = collectFormData();
	    	const url = event.target.id === 'saveBtn' ? '/rec/save.do' : '/rec/submit.do';
    	  	const successMessage = event.target.id === 'saveBtn' ? '������ �Ϸ�Ǿ����ϴ�.' : '������ �Ϸ�Ǿ����ϴ�.';
			const actionType = event.target.id === 'saveBtn' ? '����' : '����';
			
			if(actionType === '����'){
				if(!confirm("�����Ͻø� �� �̻� ������ �� �����ϴ�.\n�����Ͻðڽ��ϱ�?")){
					return;
				}
			}
			
  	  		if (!validateRecruitInfo() || 
   	      		!validateEducation() ||
    	      	!validateCareer() ||
    	      	!validateCertificate()) {
    	    return;
    	  	}

    	  	
    	  	
			$j.ajax({
				url: url,
    	    	dataType: "json",
	    	    contentType: 'application/json',
	    	    type: "POST",
	    	    data: JSON.stringify(formData),
	    	    success: function(response) {
    	      		if (response.success === "Y") {
    	        		alert(successMessage);
    	        		location.href = "/rec/main.do";
    	      		} else {
    	        		if (response.message === 'Rec Empty') {
    	          			alert("������ ������ ��� �Է����ּ���.");
    	        		} else if (response.message === "Edu Empty") {
    	          			alert("�з� ������ ��� �Է����ּ���.");
    	        		} else {
    	          			if(actionType === '����'){
    	          				alert("���忡 �����߽��ϴ�. \n��� �� �ٽ� �õ����ּ���.");
    	          			}else{
    	          				alert("���⿡ �����߽��ϴ�. \n��� �� �ٽ� �õ����ּ���.");
    	          			}
    	        		}
    	      		}
    	    	},
    	    	error: function (jqXHR, textStatus, errorThrown) {
    	    		if(actionType === '����'){
          				alert("���忡 �����߽��ϴ�. \n��� �� �ٽ� �õ����ּ���.");
          			}else{
          				alert("���⿡ �����߽��ϴ�. \n��� �� �ٽ� �õ����ּ���.");
          			}
    	    	}
    	  	});
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
								<input name="recruit.name" id="name" type="text" value="${recruit.name }" 
									${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
							<th>�������</th>
							<td>
								<input name="recruit.birth" id="birth" type="text" value="${recruit.birth }" maxlength="10" 
									placeholder="YYYYMMDD" ${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
						</tr>
							
						<tr>
							<th>����</th>
							<td>
								<select name=recruit.gender  id="gender" ${recruit.submit eq 'T' ? 'disabled' : ''}>
									<option value="M">����</option>
									<option value="W">����</option>
								</select>
							</td>
							<th>����ó</th>
							<td>
								<input name="recruit.phone" id="phone" type="text" value="${recruit.phone }" maxlength="11" ${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
						</tr>
	
						<tr>
							<th>email</th>
							<td>
								<input name="recruit.email" id="email" type="email" 
									value="${recruit.email }" placeholder="example@example.com"
									maxlength="255" ${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
							<th>�ּ�</th>
							<td>
								<input name="recruit.addr" id="addr" type="text" value="${recruit.addr }" maxlength="85" ${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
						</tr>
	
						<tr>
							<th>����ٹ���</th>
							<td>
								<select name="recruit.location" id="recLocation" ${recruit.submit eq 'T' ? 'disabled' : ''}>
								  	<option value="����" ${recruit.location eq '����' ? 'selected' : ''}>����</option>
								    <option value="��⵵" ${recruit.location eq '��⵵' ? 'selected' : ''}>��⵵</option>
								    <option value="��õ" ${recruit.location eq '��õ' ? 'selected' : ''}>��õ</option>
								  	<option value="������" ${recruit.location eq '������' ? 'selected' : ''}>������</option>
								    <option value="��û�ϵ�" ${recruit.location eq '��û�ϵ�' ? 'selected' : ''}>��û�ϵ�</option>
								    <option value="��û����" ${recruit.location eq '��û����' ? 'selected' : ''}>��û����</option>
								  	<option value="����ϵ�" ${recruit.location eq '����ϵ�' ? 'selected' : ''}>����ϵ�</option>
								    <option value="���󳲵�" ${recruit.location eq '���󳲵�' ? 'selected' : ''}>���󳲵�</option>
								    <option value="���ϵ�" ${recruit.location eq '���ϵ�' ? 'selected' : ''}>���ϵ�</option>
								    <option value="��󳲵�" ${recruit.location eq '��󳲵�' ? 'selected' : ''}>��󳲵�</option>
								    <option value="���ֵ�" ${recruit.location eq '���ֵ�' ? 'selected' : ''}>���ֵ�</option>
								</select>
							</td>
							<th>�ٹ�����</th>
							<td>
								<select name="recruit.workType" id="workType" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						       		<c:choose>
				           				<c:when test="${empty recruit.workType}">
						               		<option value="������">������</option>
							               	<option value="�����">�����</option>
					           			</c:when>
					           			<c:otherwise>
					              	 		<option value="������" ${recruit.workType eq '������' ? 'selected' : ''}>������</option>
					               			<option value="�����" ${recruit.workType eq '�����' ? 'selected' : ''}>�����</option>
					           			</c:otherwise>
				       				</c:choose>
								</select>
							</td>
						</tr>
					</table>	
					<c:if test="${recruit.submit ne 'F' }">
						<table border="1" width="90%" align="center">
							<thead>
								<tr>
									<th>�з»���</th>
									<th>��»���</th>
									<th>�������</th>
									<th>����ٹ���/�ٹ�����</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${educationSummary }</td>
									<td>${careerSummary}</td>
									<td>ȸ�系�Կ� ����</td>
									<td>
										${recruit.location }��ü
										<br />
										${recruit.workType }
									</td>
								</tr>
							</tbody>
						</table>
					</c:if>
				</td>
			</tr>
			<tr>
				<td align="right">
					<h3 align="left">�з�</h3>
					<c:if test="${recruit.submit ne 'T'}">
					    <input type="button" value="�߰�" id="addEduBtn">
					    <input type="button" value="����" id="removeEduBtn">
					</c:if>
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
							<c:choose>
						        <c:when test="${not empty educations}">
						            <c:forEach items="${educations}" var="education" varStatus="status">
						                <tr>
											<td>
												<input type="checkbox" ${recruit.submit eq 'T' ? 'disabled' : ''}>
											</td>
											<td style="width: 100px">
												<input name="educations.startPeriod" value="${education.startPeriod}" type="text" style="margin-right: 5px"
												 	placeholder="YYYYMM" maxlength="7" ${recruit.submit eq 'T' ? 'disabled' : ''}>
												 ~
												<input name="educations.endPeriod" value="${education.endPeriod }" type="text" 
													placeholder="YYYYMM" maxlength="7" ${recruit.submit eq 'T' ? 'disabled' : ''}>
											</td> 
											<td>
												<select name="educations.division" ${recruit.submit eq 'T' ? 'disabled' : ''}>
												    <option value="student" ${education.division eq 'student' ? 'selected' : ''}>����</option>
												    <option value="dropOut" ${education.division eq 'dropOut' ? 'selected' : ''}>����</option>
												    <option value="graduate" ${education.division eq 'graduate' ? 'selected' : ''}>����</option>
												</select>
											</td>
											<td>
												<input name="educations.schoolName" value="${education.schoolName }" type="text" 
													placeholder="00����б� �Ǵ� 00���б�" style="display: block; box-sizing: border-box;" maxlength="85"
													${recruit.submit eq 'T' ? 'disabled' : ''}>
												<select name="educations.location" ${recruit.submit eq 'T' ? 'disabled' : ''}>
													<option value="����" ${education.location eq '����' ? 'selected' : ''}>����</option>
												    <option value="��⵵" ${education.location eq '��⵵' ? 'selected' : ''}>��⵵</option>
												    <option value="��õ" ${education.location eq '��õ' ? 'selected' : ''}>��õ</option>
												  	<option value="������" ${education.location eq '������' ? 'selected' : ''}>������</option>
												    <option value="��û�ϵ�" ${education.location eq '��û�ϵ�' ? 'selected' : ''}>��û�ϵ�</option>
												    <option value="��û����" ${education.location eq '��û����' ? 'selected' : ''}>��û����</option>
												  	<option value="����ϵ�" ${education.location eq '����ϵ�' ? 'selected' : ''}>����ϵ�</option>
												    <option value="���󳲵�" ${education.location eq '���󳲵�' ? 'selected' : ''}>���󳲵�</option>
												    <option value="���ϵ�" ${education.location eq '���ϵ�' ? 'selected' : ''}>���ϵ�</option>
												    <option value="��󳲵�" ${education.location eq '��󳲵�' ? 'selected' : ''}>��󳲵�</option>
												    <option value="���ֵ�" ${education.location eq '���ֵ�' ? 'selected' : ''}>���ֵ�</option>
												</select>
											</td>
											<td>
												<input name="educations.major" type="text" maxlength="85" 
													value="${education.major }" ${recruit.submit eq 'T' ? 'disabled' : ''}>
											</td>
											<td>
												<input name="educations.grade" type="text" maxlength="4" value="${education.grade }" 
												placeholder="0.00" ${recruit.submit eq 'T' ? 'disabled' : ''}>
											</td>
										</tr>
						            </c:forEach>
						        </c:when>
						        <c:otherwise>
						            <tr>
										<td>
											<input type="checkbox">
										</td>
										<td style="width: 100px">
											<input name="educations.startPeriod" value="${education.startPeriod}" 
												type="text" style="margin-right: 5px" placeholder="YYYYMM" maxlength="7"
												${recruit.submit eq 'T' ? 'disabled' : ''}>
											 ~
											<input name="educations.endPeriod" value="${education.endPeriod }" type="text" 
												placeholder="YYYYMM" maxlength="7" ${recruit.submit eq 'T' ? 'disabled' : ''}>
										</td> 
										<td>
											<select name="educations.division" ${recruit.submit eq 'T' ? 'disabled' : ''}>
											    <option value="student" ${education.division eq 'student' ? 'selected' : ''}>����</option>
											    <option value="dropOut" ${education.division eq 'dropOut' ? 'selected' : ''}>����</option>
											    <option value="graduate" ${education.division eq 'graduate' ? 'selected' : ''}>����</option>
											</select>
										</td>
										<td>
											<input name="educations.schoolName" value="${education.schoolName }" type="text" 
												placeholder="00����б� �Ǵ� 00���б�" ${recruit.submit eq 'T' ? 'disabled' : ''}
												style="display: block; box-sizing: border-box;" maxlength="85">
											<select name="educations.location" ${recruit.submit eq 'T' ? 'disabled' : ''}>
												<option value="����" >����</option>
											    <option value="��⵵">��⵵</option>
											    <option value="��õ">��õ</option>
											  	<option value="������">������</option>
											    <option value="��û�ϵ�">��û�ϵ�</option>
											    <option value="��û����">��û����</option>
											  	<option value="����ϵ�">����ϵ�</option>
											    <option value="���󳲵�">���󳲵�</option>
											    <option value="���ϵ�">���ϵ�</option>
											    <option value="��󳲵�">��󳲵�</option>
											    <option value="���ֵ�">���ֵ�</option>
											</select>
										</td>
										<td>
											<input name="educations.major" type="text" maxlength="85" 
												value="${education.major }" ${recruit.submit eq 'T' ? 'disabled' : ''}>
										</td>
										<td>
											<input name="educations.grade" type="text" maxlength="4" 
												value="${education.grade }" placeholder="0.00" 
												${recruit.submit eq 'T' ? 'disabled' : ''}>
										</td>
									</tr>
						        </c:otherwise>
						    </c:choose>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<h3 align="left">���</h3>
					<c:if test="${recruit.submit ne 'T'}">
						<input type="button" value="�߰�" id="addCarBtn">
						<input type="button" value="����" id="removeCarBtn">
					</c:if>
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
						    <c:choose>
						        <c:when test="${not empty careers}">
						            <c:forEach items="${careers}" var="career" varStatus="status">
						                <tr>
						                    <td>
						                        <input type="checkbox">
						                    </td>
						                    <td>
						                        <input name="careers.startPeriod" value="${career.startPeriod}" type="text" 
						                        	maxlength="7" placeholder="YYYYMM"
						                        	${recruit.submit eq 'T' ? 'disabled' : ''}>~
						                        <input name="careers.endPeriod" value="${career.endPeriod}" type="text" 
						                        	maxlength="7" placeholder="YYYYMM" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                    <td>
						                        <input name="careers.compName" value="${career.compName}" 
						                        	maxlength="85" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                    <td>
						                        <input name="careers.task" value="${career.task}" 
						                        	maxlength="85" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                    <td>
						                        <input name="careers.location" value="${career.location}" 
						                        	maxlength="85" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>          
						                </tr>
						            </c:forEach>
						        </c:when>
						        <c:otherwise>
						            <tr>
						                <td>
						                    <input type="checkbox" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="careers.startPeriod" type="text" maxlength="7" 
						                    	placeholder="YYYYMM" ${recruit.submit eq 'T' ? 'disabled' : ''}>~
						                    <input name="careers.endPeriod" type="text" maxlength="7" 
						                    	placeholder="YYYYMM" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="careers.compName" maxlength="85" 
						                    	${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="careers.task" maxlength="85"
						                    	${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="careers.location" maxlength="85"
						                    	${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>          
						            </tr>
						        </c:otherwise>
						    </c:choose>
						</tbody>						
					</table>
				</td>
			</tr>
			
			<tr>
				<td align="right">
					<h3 align="left">�ڰ���</h3>
					<c:if test="${recruit.submit ne 'T'}">
						<input type="button" value="�߰�" id="addCerBtn">
						<input type="button" value="����" id="removeCerBtn">
					</c:if>
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
							<c:choose>
						        <c:when test="${not empty certificates}">
						            <c:forEach items="${certificates}" var="certificate" varStatus="status">
						                <tr>
						                    <td>
						                        <input type="checkbox" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                    <td>
						                        <input name="certificates.qualifiName" value="${certificate.qualifiName}" 
						                        	type="text" maxlength="20" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                    <td>
						                        <input name="certificates.acquDate" value="${certificate.acquDate}" type="text" 
						                        	maxlength="7" placeholder="YYYYMM" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                    <td>
						                        <input name="certificates.organizeName" value="${certificate.organizeName}" 
						                        	type="text" maxlength="20" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                    </td>
						                </tr>
						            </c:forEach>
						        </c:when>
						        <c:otherwise>
						            <tr>
						                <td>
						                    <input type="checkbox" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="certificates.qualifiName" type="text" maxlength="20"
						                    	${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="certificates.acquDate" type="text" maxlength="7" 
						                    	placeholder="YYYYMM" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						                <td>
						                    <input name="certificates.organizeName" type="text" maxlength="20"
						                    	${recruit.submit eq 'T' ? 'disabled' : ''}>
						                </td>
						            </tr>
						        </c:otherwise>
						    </c:choose>
						</tbody>
					</table>
				</td>
			</tr>
			
		</table>
		<div align="center">
			<c:if test="${recruit.submit ne 'T'}">
			    <input type="button" id="saveBtn" value="����">
			    <input type="button" id="submitBtn" value="����">
			</c:if>
		</div>
	</form>
</body>
</html>