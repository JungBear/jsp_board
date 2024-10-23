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
			       alert("삭제할 항목을 선택해주세요.");
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
	            alert("이름을 입력해주세요.");
	            $j("#name").focus();
	            return false;
	        }
	        if(name != "${sessionScope.user.name}") {
	            alert("로그인한 이름과 현재 이름이 다릅니다.");
	            $j("#name").focus();
	            $j("#name").val("${sessionScope.user.name}");
	            return false;
	        }
	        if(birth == '') {
	            alert("생년월일를 입력해주세요.");
	            $j("#birth").focus();
	            return false;
	        }
	        if(birth.length != 10) {
	            alert("생년월일의 형식을 맞춰서 입력해주세요.\n예시) 1999.02.12");
	            $j("#birth").focus();
	            return false;
	        }
	        if(month > 12){
	        	alert("올바른 월을 입력해주세요.\n예시) 2024.01.23");
	        	$j("#birth").focus();
                return false;
	        }
	        if(day > 31){
	        	alert("올바른 일을 입력해주세요.\n예시) 2024.01.23");
	        	$j("#birth").focus();
                return false;
	        }
	        if(phone == '') {
	            alert("연락처를 입력해주세요.");
	            $j("#phone").focus();
	            return false;
	        }
	        if(phone != "${sessionScope.user.phone}") {
	            alert("로그인한 연락처와 현재 연락처가 다릅니다. \n로그인한 연락처로 제출해주세요.");
	            $j("#phone").focus();
	            $j("#phone").val("${sessionScope.user.phone}");
	            return false;
	        }
	        if(email == '') {
	            alert("이메일을 입력해주세요.");
	            $j("#email").focus();
	            return false;
	        }
	        if (!emailRegex.test(email)) {
	            alert("올바른 이메일 주소를 입력해주세요.\n예시) exaple@example.com");
	            $j("#email").focus();
	            return false;
	        }
	        if(addr == '') {
	            alert("주소를 입력해주세요.");
	            $j("#addr").focus();
	            return false;
	        }
	        
	        return true;
	    }

	    function validateEducation() {
	        const eduRows = $j("#eduTable tbody tr");
	        if (eduRows.length === 0) {
	            alert("학력을 최소 1개 이상 입력해야 합니다.");
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
	                alert("재학 시작 기간을 입력해주세요.\n예시) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.startPeriod']").focus();
	                return false;
	            }
	            if(startPeriod.length != 7){
	                alert("재학 시작 기간은 YYYY.MM으로 작성해주세요\n예시) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.startPeriod']").focus();
	                return false;
	            }
	            if(startMonth > 12){
	            	alert("올바른 월을 입력해주세요.\n예시) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.startPeriod']").focus();
	                return false;
	            }
	            if (endPeriod === '') {
	                alert("재학 종료 기간을 입력해주세요.\n예시) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();
	                return false;
	            }
	            if(endPeriod.length != 7){
	                alert("재학 종료 기간은 YYYY.MM으로 작성해주세요.\n예시) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();   
	                return false;
	            }
	            if(endMonth > 12){
	            	alert("올바른 월을 입력해주세요.\n예시) 2024.01");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();   
	                return false;
	            }
	            

	            const startDate = new Date(startYear, startMonth - 1);
	            const endDate = new Date(endYear, endMonth - 1);

	            if (startDate > endDate) {
	                alert("종료 기간이 시작 기간보다 앞설 수 없습니다.");
	                $j(eduRows[i]).find("input[name='educations.endPeriod']").focus();
	                return false;
	            }      
	            if (schoolName === '' || (!schoolName.endsWith('고등학교') && !schoolName.endsWith('대학교'))) {
	                alert("학교명을 적어주세요. \n예) 서울대학교, 서울고등학교");
	                $j(eduRows[i]).find("input[name='educations.schoolName']").focus();
	                return false;
	            }
	            if (location === '') {
	                alert("소재지를 선택해주세요.");
	                $j(eduRows[i]).find("select[name='educations.location']").focus();
	                return false;
	            }
	            if (division === '') {
	                alert("구분을 선택해주세요.");
	                $j(eduRows[i]).find("select[name='educations.division']").focus();
	                return false;
	            }
	            if (major === '') {
	                alert("전공을 입력해주세요.");
	                $j(eduRows[i]).find("input[name='educations.major']").focus();
	                return false;
	            }
	            if (grade === '') {
	                alert("학점을 입력해주세요.");
	                $j(eduRows[i]).find("input[name='educations.grade']").focus();
	                return false;
	            }
	            if (parseFloat(grade) > 4.5) {
	            	alert("학점을 올바르게 입력해주세요.\n예시) 0.00 ~ 4.50");
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
	                    alert("경력 시작 기간을 입력해주세요.\n예시) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.startPeriod']").focus();
	                    return false;
	                }
	                if (startPeriod.length != 7){
	                    alert("근무 기간을 YYYY.MM 형식으로 입력해주세요\n예시) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.startPeriod']").focus();
	                    return false;
	                }
	                if(startMonth > 12){
		            	alert("올바른 월을 입력해주세요.\n예시) 2024.01");
		                $j(eduRows[i]).find("input[name='careers.startPeriod']").focus();
		                return false;
		            }
	                if (!endPeriod) {
	                    alert("경력 종료 기간을 입력해주세요.\n예시) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.endPeriod']").focus();
	                    return false;
	                }
	                if (endPeriod.length != 7){
	                    alert("근무 기간을 YYYY.MM 형식으로 입력해주세요.\n예시) 2024.01");
	                    $j(carRows[i]).find("input[name='careers.endPeriod']").focus();
	                    return false;
	                }
	                if(endMonth > 12){
		            	alert("올바른 월을 입력해주세요.\n예시) 2024.01");
		                $j(eduRows[i]).find("input[name='careers.startPeriod']").focus();
		                return false;
	                }
		            const startDate = new Date(startYear, startMonth - 1);
		            const endDate = new Date(endYear, endMonth - 1);

		            if (startDate > endDate) {
		                alert("종료 기간이 시작 기간보다 앞설 수 없습니다.");
		                $j(carRows[i]).find("input[name='careers.endPeriod']").focus();
		                return false;
		            }
	                if (!compName) {
	                    alert("회사명을 입력해주세요.");
	                    $j(carRows[i]).find("input[name='careers.compName']").focus();
	                    return false;
	                }
	                if (!task) {
	                    alert("부서/직급/직책을 입력해주세요.");
	                    $j(carRows[i]).find("input[name='careers.task']").focus();
	                    return false;
	                }
	                const taskParts = task.split('/');
	                if (taskParts.length !== 3) {
	                    alert("부서/직급/직책 형식으로 입력해주세요.\n예시: 개발팀/대리/팀원");
	                    $j(carRows[i]).find("input[name='careers.task']").focus();
	                    return false;
	                }
	                if (!location) {
	                    alert("지역을 입력해주세요.");
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
	                    alert("자격증명을 입력해주세요.");
	                    $j(certRows[i]).find("input[name='certificates.qualifiName']").focus();
	                    return false;
	                }
	                if (!acquDate) {
	                    alert("취득일을 입력해주세요.");
	                    $j(certRows[i]).find("input[name='certificates.acquDate']").focus();
	                    return false;
	                }
	                if (acquDate.length != 7){
	                    alert("취득일을 YYYY.MM 형식으로 입력해주세요");
	                    $j(certRows[i]).find("input[name='certificates.acquDate']").focus();
	                    return false;
	                }
	                if(acquMonth > 12){
		            	alert("올바른 월을 입력해주세요.\n예시) 2024.01");
		                $j(certRows[i]).find("input[name='certificates.acquDate']").focus();
		                return false;
	                }
	                if (!organizeName) {
	                    alert("발행처를 입력해주세요.");
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
							<option value="student">재학</option>
							<option value="dropOut">중퇴</option>
							<option value="graduate">졸업</option>
						</select>
					</td>
					<td>
						<input name="educations.schoolName" type="text" placeholder="00고등학교 또는 00대학교" style="display: block; box-sizing: border-box;" maxlength="85">
						<select name="educations.location">
							<option value="서울">서울</option>
						    <option value="경기도">경기도</option>
						    <option value="인천">인천</option>
						  	<option value="강원도">강원도</option>
						    <option value="충청북도">충청북도</option>
						    <option value="충청남도">충청남도</option>
						  	<option value="전라북도">전라북도</option>
						    <option value="전라남도">전라남도</option>
						    <option value="경상북도">경상북도</option>
						    <option value="경상남도">경상남도</option>
						    <option value="제주도">제주도</option>
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
	            alert("학력은 최소 1개 이상 입력해야 합니다.");
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
    	  	const successMessage = event.target.id === 'saveBtn' ? '저장이 완료되었습니다.' : '제출이 완료되었습니다.';
			const actionType = event.target.id === 'saveBtn' ? '저장' : '제출';
			
			if(actionType === '제출'){
				if(!confirm("제출하시면 더 이상 수정할 수 없습니다.\n제출하시겠습니까?")){
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
    	          			alert("지원자 정보를 모두 입력해주세요.");
    	        		} else if (response.message === "Edu Empty") {
    	          			alert("학력 정보를 모두 입력해주세요.");
    	        		} else {
    	          			if(actionType === '저장'){
    	          				alert("저장에 실패했습니다. \n잠시 후 다시 시도해주세요.");
    	          			}else{
    	          				alert("제출에 실패했습니다. \n잠시 후 다시 시도해주세요.");
    	          			}
    	        		}
    	      		}
    	    	},
    	    	error: function (jqXHR, textStatus, errorThrown) {
    	    		if(actionType === '저장'){
          				alert("저장에 실패했습니다. \n잠시 후 다시 시도해주세요.");
          			}else{
          				alert("제출에 실패했습니다. \n잠시 후 다시 시도해주세요.");
          			}
    	    	}
    	  	});
   		});
	});
</script>

<body>
	<div align="center">
		<h2>입사 지원서</h2>
	</div>
	<form id="form">
		<table border="1" align="center" style="width: 100%">
			<tr>
				<td>
					<table border="1" align="center">
						<tr>
							<th>이름</th>
							<td>
								<input name="recruit.name" id="name" type="text" value="${recruit.name }" 
									${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
							<th>생년월일</th>
							<td>
								<input name="recruit.birth" id="birth" type="text" value="${recruit.birth }" maxlength="10" 
									placeholder="YYYYMMDD" ${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
						</tr>
							
						<tr>
							<th>성별</th>
							<td>
								<select name=recruit.gender  id="gender" ${recruit.submit eq 'T' ? 'disabled' : ''}>
									<option value="M">남자</option>
									<option value="W">여자</option>
								</select>
							</td>
							<th>연락처</th>
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
							<th>주소</th>
							<td>
								<input name="recruit.addr" id="addr" type="text" value="${recruit.addr }" maxlength="85" ${recruit.submit eq 'T' ? 'disabled' : ''}>
							</td>
						</tr>
	
						<tr>
							<th>희망근무지</th>
							<td>
								<select name="recruit.location" id="recLocation" ${recruit.submit eq 'T' ? 'disabled' : ''}>
								  	<option value="서울" ${recruit.location eq '서울' ? 'selected' : ''}>서울</option>
								    <option value="경기도" ${recruit.location eq '경기도' ? 'selected' : ''}>경기도</option>
								    <option value="인천" ${recruit.location eq '인천' ? 'selected' : ''}>인천</option>
								  	<option value="강원도" ${recruit.location eq '강원도' ? 'selected' : ''}>강원도</option>
								    <option value="충청북도" ${recruit.location eq '충청북도' ? 'selected' : ''}>충청북도</option>
								    <option value="충청남도" ${recruit.location eq '충청남도' ? 'selected' : ''}>충청남도</option>
								  	<option value="전라북도" ${recruit.location eq '전라북도' ? 'selected' : ''}>전라북도</option>
								    <option value="전라남도" ${recruit.location eq '전라남도' ? 'selected' : ''}>전라남도</option>
								    <option value="경상북도" ${recruit.location eq '경상북도' ? 'selected' : ''}>경상북도</option>
								    <option value="경상남도" ${recruit.location eq '경상남도' ? 'selected' : ''}>경상남도</option>
								    <option value="제주도" ${recruit.location eq '제주도' ? 'selected' : ''}>제주도</option>
								</select>
							</td>
							<th>근무형태</th>
							<td>
								<select name="recruit.workType" id="workType" ${recruit.submit eq 'T' ? 'disabled' : ''}>
						       		<c:choose>
				           				<c:when test="${empty recruit.workType}">
						               		<option value="정규직">정규직</option>
							               	<option value="계약직">계약직</option>
					           			</c:when>
					           			<c:otherwise>
					              	 		<option value="정규직" ${recruit.workType eq '정규직' ? 'selected' : ''}>정규직</option>
					               			<option value="계약직" ${recruit.workType eq '계약직' ? 'selected' : ''}>계약직</option>
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
									<th>학력사항</th>
									<th>경력사항</th>
									<th>희망연봉</th>
									<th>희망근무지/근무형태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>${educationSummary }</td>
									<td>${careerSummary}</td>
									<td>회사내규에 따름</td>
									<td>
										${recruit.location }전체
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
					<h3 align="left">학력</h3>
					<c:if test="${recruit.submit ne 'T'}">
					    <input type="button" value="추가" id="addEduBtn">
					    <input type="button" value="삭제" id="removeEduBtn">
					</c:if>
					<table align="center" border="1" width="90%" id="eduTable">
						<thead>
							<tr>
								<th></th>
								<th>재학기간</th>
								<th>구분</th>
								<th>학교명(소재지)</th>
								<th>전공</th>
								<th>학점</th>
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
												    <option value="student" ${education.division eq 'student' ? 'selected' : ''}>재학</option>
												    <option value="dropOut" ${education.division eq 'dropOut' ? 'selected' : ''}>중퇴</option>
												    <option value="graduate" ${education.division eq 'graduate' ? 'selected' : ''}>졸업</option>
												</select>
											</td>
											<td>
												<input name="educations.schoolName" value="${education.schoolName }" type="text" 
													placeholder="00고등학교 또는 00대학교" style="display: block; box-sizing: border-box;" maxlength="85"
													${recruit.submit eq 'T' ? 'disabled' : ''}>
												<select name="educations.location" ${recruit.submit eq 'T' ? 'disabled' : ''}>
													<option value="서울" ${education.location eq '서울' ? 'selected' : ''}>서울</option>
												    <option value="경기도" ${education.location eq '경기도' ? 'selected' : ''}>경기도</option>
												    <option value="인천" ${education.location eq '인천' ? 'selected' : ''}>인천</option>
												  	<option value="강원도" ${education.location eq '강원도' ? 'selected' : ''}>강원도</option>
												    <option value="충청북도" ${education.location eq '충청북도' ? 'selected' : ''}>충청북도</option>
												    <option value="충청남도" ${education.location eq '충청남도' ? 'selected' : ''}>충청남도</option>
												  	<option value="전라북도" ${education.location eq '전라북도' ? 'selected' : ''}>전라북도</option>
												    <option value="전라남도" ${education.location eq '전라남도' ? 'selected' : ''}>전라남도</option>
												    <option value="경상북도" ${education.location eq '경상북도' ? 'selected' : ''}>경상북도</option>
												    <option value="경상남도" ${education.location eq '경상남도' ? 'selected' : ''}>경상남도</option>
												    <option value="제주도" ${education.location eq '제주도' ? 'selected' : ''}>제주도</option>
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
											    <option value="student" ${education.division eq 'student' ? 'selected' : ''}>재학</option>
											    <option value="dropOut" ${education.division eq 'dropOut' ? 'selected' : ''}>중퇴</option>
											    <option value="graduate" ${education.division eq 'graduate' ? 'selected' : ''}>졸업</option>
											</select>
										</td>
										<td>
											<input name="educations.schoolName" value="${education.schoolName }" type="text" 
												placeholder="00고등학교 또는 00대학교" ${recruit.submit eq 'T' ? 'disabled' : ''}
												style="display: block; box-sizing: border-box;" maxlength="85">
											<select name="educations.location" ${recruit.submit eq 'T' ? 'disabled' : ''}>
												<option value="서울" >서울</option>
											    <option value="경기도">경기도</option>
											    <option value="인천">인천</option>
											  	<option value="강원도">강원도</option>
											    <option value="충청북도">충청북도</option>
											    <option value="충청남도">충청남도</option>
											  	<option value="전라북도">전라북도</option>
											    <option value="전라남도">전라남도</option>
											    <option value="경상북도">경상북도</option>
											    <option value="경상남도">경상남도</option>
											    <option value="제주도">제주도</option>
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
					<h3 align="left">경력</h3>
					<c:if test="${recruit.submit ne 'T'}">
						<input type="button" value="추가" id="addCarBtn">
						<input type="button" value="삭제" id="removeCarBtn">
					</c:if>
					<table align="center" border="1" width="90%" id="carTable">
						<thead>
							<tr>
								<th></th>
								<th>근무기간</th>
								<th>회사명</th>
								<th>부서/직급/직책</th>
								<th>지역</th>
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
					<h3 align="left">자격증</h3>
					<c:if test="${recruit.submit ne 'T'}">
						<input type="button" value="추가" id="addCerBtn">
						<input type="button" value="삭제" id="removeCerBtn">
					</c:if>
					<table align="center" border="1" width="90%" id="cerTable">
						<thead>
							<tr>
								<th></th>
								<th>자격증명</th>
								<th>취득일</th>
								<th>발행처</th>
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
			    <input type="button" id="saveBtn" value="저장">
			    <input type="button" id="submitBtn" value="제출">
			</c:if>
		</div>
	</form>
</body>
</html>