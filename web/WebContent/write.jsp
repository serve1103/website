<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1.0">
<!-- meta 에서 뷰포트는 어떤 모바입, 웹상에서 사용하기 편하게 반응형으로 만드는 명령 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
<script src="js/bootstrap.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- include summernote css/js -->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>
<!-- include summernote-ko-KR -->
<script src="lang/summernote-ko-KR.js"></script>
<script type="text/javascript">
	$(function() {
		$('#summernote').summernote({
			height : 300, // 기본 높이값
			focus : true, // 페이지가 열릴때 포커스를 지정함
			lang : 'ko-KR', // 한국어 지정(기본값은 en-US)
			onImageUpload : function(files, editor, welEditable) {
	            sendFile(files[0], editor, welEditable);
	        }
		});
	});
	function sendFile(file, editor, welEditable) {
	    data = new FormData();
	    data.append("uploadFile", file);
	    $.ajax({
	        data : data,
	        type : "POST",
	        url : "images",
	        cache : false,
	        contentType : false,
	        processData : false,
	        success : function(data) {
	            editor.insertImage(welEditable, data.url);
	        }
	    });
	}
</script>
<title>jsp web homepage</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<!-- 네비게이션  -->
	<nav class="navbar navbar-inverse">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expaned="false">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp">JSP 게시판</a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li class="active"><a href="bbs.jsp">게시판</a></li>
			<li><a href="chat.jsp">채팅방</a></li>
		</ul>
		<%
			if (userID == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-expanded="false"
				aria-haspopup="true">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul></li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-expanded="false"
				aria-haspopup="true">회원관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li>
				</ul></li>
		</ul>
		<%
			}
		%>
	</div>
	</nav>
	<%
		if (userID == null) {
	%>
	<script type="text/javascript">
		alert('로그인이 필요한 페이지입니다.');
		location.href = 'main.jsp';
	</script>
	<%
		} else {
	%>
	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" id="summernote"
									name="bbsContent"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기"
					style="background-color: black; color: white;">
			</form>
		</div>
	</div>
	<%
		}
	%>
</body>
</html>