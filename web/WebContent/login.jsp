<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>jsp web homepage</title>
</head>
<body>
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
			<li><a href="bbs.jsp">게시판</a></li>
			<li><a href="chat.jsp">채팅방</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-expanded="false"
				aria-haspopup="true">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li class="active"><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul></li>
		</ul>
	</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<!-- 컨테이너의 사이즈를 col-lg-4로 조정 -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- jumbotron은 기본적인 반응형 컨포넌트입니다. -->
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center;">로그인 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">
						<!-- form-control은 반응형 웹사이트에서 일관된 form style을 갖게합니다. -->
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control"
						style="background-color: black;" value="로그인">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
</body>
</html>