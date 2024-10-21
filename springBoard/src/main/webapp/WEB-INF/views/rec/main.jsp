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
		    "서울", "경기도", "인천", 
		    "강원도", 
		    "충청북도", "충청남도",
		    "전라북도", "전라남도",
		    "경상북도", "경상남도",
		    "제주도"
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
							<option value="student">재학</option>
							<option value="dropOut">중퇴</option>
							<option value="graduate">졸업</option>
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
	    	
	    	console.log("제출");
	    	
	    	if(formData.recruit.name ==''){
	    		alert("이름을 입력해주세요.");
	    		$j("#name").focus();
	    		return;
	    	};
	    	
	    	if(formData.recruit.name != "${sessionScope.user.name}"){
	    		alert("로그인한 이름과 현재 이름이 다릅니다. 로그인한 이름으로 제출해주세요.");
	    		$j("#name").focus();
	    		$j("#name").val("${sessionScope.user.name}");
	    		return;
	    	};
	    	
	    	if(formData.recruit.birth ==''){
	    		alert("생년월일를 입력해주세요.");
	    		$j("#birth").focus();
	    		return;
	    	};
	    	
	    	if(formData.recruit.birth.length != 10){
	    		alert("생년월일의 형식을 맞춰서 입력해주세요.");
	    		$j("#birth").focus();
	    		$j("#birth").val('');
	    		return
	    	}
	    	
	    	if(formData.recruit.phone ==''){
	    		alert("연락처를 입력해주세요.");
	    		$j("#phone").focus();
	    		return;
	    	};
    	
	    	if(formData.recruit.phone != "${sessionScope.user.phone}"){
	    		alert("로그인한 연락처와 현재 연락처가 다릅니다. 로그인한 연락처로 제출해주세요.");
	    		$j("#phone").focus();
	    		$j("#phone").val("${sessionScope.user.phone}");
	    		return;
	    	};
	    	
	    	if(formData.recruit.email == ''){
	    		alert("이메일을 입력해주세요.");
	    		$j("#email").focus();
	    		return;
	    	};
	    	
	    	
		    if (!emailRegex.test(formData.recruit.email)) {
		        alert("올바른 이메일 주소를 입력해주세요.");
	    		$j("#email").val("");
	    		$j("#email").focus();
				return;
		    };
	    	
	    	if(formData.recruit.addr ==''){
	    		alert("주소를 입력해주세요.");
	    		$j("#addr").focus();
	    		return;
	    	};
	    	
	    	if (formData.educations.length === 0) {
	    	    alert("학력을 최소 1개 이상 입력해야 합니다.");
	    	    $j("input[name='educations.startPeriod']").focus();
	    	    return;
	    	}
	    	
	    	var focusSet = false;

	    	formData.educations.forEach(function(education, index) {
	    	    if (!focusSet) {
    	    	  	if (education.startPeriod === '') {
	    	            alert("재학 시작 기간을 입력해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.startPeriod']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.endPeriod === '') {
	    	        	alert("재학 종료 기간을 입력해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.endPeriod']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.schoolName === '') {
	    	            alert("학교명을 입력해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.schoolName']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.location === '') {
	    	            alert("소재지를 선택해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) select[name='educations.location']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.division === '') {
	    	            alert("구분을 선택해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) select[name='educations.division']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	      
	    	        if (education.major === '') {
	    	            alert("전공을 입력해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.major']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
	    	        if (education.grade === '') {
	    	            alert("학점을 입력해주세요.");
	    	            $j(`#eduTable tbody tr:eq(${index}) input[name='educations.grade']`).focus();
	    	            focusSet = true;
	    	            return false;
	    	        }
					if (parseFloat(education.grade) > 4.5){
						alert("학저의 최고점은 4.5입니다. 수정해주세요.");
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
								<input name="recruit.name" id="name" type="text" value="${recruit.name }">
							</td>
							<th>생년월일</th>
							<td>
								<input name="recruit.birth" id="birth" type="text" value="${recruit.birth }" maxlength="10" placeholder="YYYY.MM.DD">
							</td>
						</tr>
							
						<tr>
							<th>성별</th>
							<td>
								<select name=recruit.gender  id="gender">
									<option value="M">남자</option>
									<option value="W">여자</option>
								</select>
							</td>
							<th>연락처</th>
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
							<th>주소</th>
							<td>
								<input name="recruit.addr" id="addr" type="text" value="${recruit.addr }" maxlength="85">
							</td>
						</tr>
	
						<tr>
							<th>희망근무지</th>
							<td>
								<select name="recruit.location" id="recLocation">
								</select>
							</td>
							<th>근무형태</th>
							<td>
								<select name="recruit.workType" id="workType">
									<option value="M">정규직</option>
									<option value="W">계약직</option>
								</select>
							</td>
						</tr>
					</table>	
				</td>
			</tr>
			<tr>
				<td align="right">
					<h3 align="left">학력</h3>
					<input type="button" value="추가" id="addEduBtn">
					<input type="button" value="삭제" id="removeEduBtn">
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
										<option value="student">재학</option>
										<option value="dropOut">중퇴</option>
										<option value="graduate">졸업</option>
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
					<h3 align="left">경력</h3>
					<input type="button" value="추가" id="addCarBtn">
					<input type="button" value="삭제" id="removeCarBtn">
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
					<h3 align="left">자격증</h3>
					<input type="button" value="추가" id="addCerBtn">
					<input type="button" value="삭제" id="removeCerBtn">
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
			<input type="button" id="saveBtn" value="저장">
			<input type="button" id="submitBtn" value="제출">
		</div>
	</form>
</body>
</html>