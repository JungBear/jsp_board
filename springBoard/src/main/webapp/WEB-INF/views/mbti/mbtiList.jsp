<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
	    $j('#form').on('submit', function(e){
	        e.preventDefault();
	        var answers = [];
	        $j('input[type=radio]:checked').each(function(){
	            answers.push($j(this).val());
	        });
	        console.log('Answers:', answers);
	        this.submit();
	    });
	});
	
</script>
<body>
	<h1><a href="/mbti/mbtiList.do">MBTI 테스트</a></h1>
	<form id="form" method="POST" action="/mbti/mbtiAction.do" align="center">
       <input type="hidden" name="page" value="${currentPage}">
       <c:forEach items="${question}" var="question" varStatus="status">
           <div style="display: flex; flex-direction: column;">
               <div>
                   <h3>${question.boardComment}</h3>
               </div>
               
              	<div style="display: flex; justify-content: center; align-items: center;">		
              		<h3>동의</h3>
                   	<c:forEach begin="1" end="7" var="i">
                       	<label>
                        	<input type="radio" name="answers[${status.index}]" value="${i}" required>
                           	<c:choose>
                               	<c:when test="${i == 1}"></c:when>
                               	<c:when test="${i == 2}"></c:when>
                               	<c:when test="${i == 3}"></c:when>
                               	<c:when test="${i == 4}"></c:when>
                               	<c:when test="${i == 5}"></c:when>
                              	<c:when test="${i == 6}"></c:when>
                             	<c:when test="${i == 7}"></c:when>
                           	</c:choose>
                       	</label>
                   	</c:forEach>
                   	<h3>비동의</h3>
               	</div>
           	</div>
       	</c:forEach>
       	<input type="submit" value="${currentPage == 4 ? '결과' : '다음'}">
   	</form>
</body>
</html>