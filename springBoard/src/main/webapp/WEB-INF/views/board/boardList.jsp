<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		$j('#all').on('change', function(){
			var isChecked = $j('#all').is(':checked');
			$j('.boardType').prop('checked', isChecked);
		})
        $j('.boardType').on('change', function() {
		 	var $all = $j('#all');
	        var $types = $j('.boardType');
	
	        if ($all.prop('checked')) {
	            // 전체가 체크되어 있을 때 개별 체크박스 클릭
	            $all.prop('checked', false);
	        }
	
	        // 모든 개별 체크박스가 선택되면 전체 체크박스도 선택
	        if ($types.filter(':checked').length === $types.length) {
	            $all.prop('checked', true);
	        }
        });
	});
	

</script>
<body>
<form id="form" method="GET" action="/board/boardList.do">
	<table align="center">
		<tr>
			<td align="left">
				<a href="/user/login.do">login</a>
				<a href="">join</a>	
			</td>
			<td align="right">
				total : ${totalCnt}
			</td>
		</tr>
		<tr>
			<td>
				<table id="boardTable" border = "1">
					<tr>
						<td width="80" align="center">
							Type
						</td>
						<td width="40" align="center">
							No
						</td>
						<td width="300" align="center">
							Title
						</td>
					</tr>
					<c:forEach items="${boardList}" var="list">
						<tr>
							<td align="center">
								${list.boardTypeName}
							</td>
							<td>
								${list.boardNum}
							</td>
							<td>
								<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
							</td>
						</tr>	
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href ="/board/boardWrite.do">글쓰기</a>
			</td>
		</tr>
		<tr align="left">
			<td>
				<input type="checkbox" name="boardType" 
					value="all" id="all">
				<label for="all">전체</label>
				<c:forEach var="type" items="${boardTypes}">
				    <input class="boardType" type="checkbox" name="boardType" value="${type.codeId}" 
				    	id="${type.codeId}">
				    <label for="${type.codeId}">${type.codeName}</label>
				</c:forEach>
				<input type="submit" value="조회">
			</td>
		</tr>
	</table>
	
</form>	
</body>
</html>