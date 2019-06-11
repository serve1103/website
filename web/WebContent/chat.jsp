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
<script type="text/javascript">
	var last = 0;
	function submitFunction() {
		//메세지를 디비에 전달하는 함수
		var chatName = $('#chatName').val();
		var chatContent = $('#chatContent').val();
		$.ajax({
			type : "POST",
			url : "ChatSubmitServlet",
			data : {
				chatName : encodeURIComponent(chatName),
				chatContent : encodeURIComponent(chatContent)
			//encodeURIComponent를 이용해 특수문자 같은 문자도 깨지지않게 인코딩을 한번해준다.
			},
			success : function(result) {
				if (result == "1") {
					autoClosingAlert('#successMessage', 2000);
				} else if (result == "0") {
					autoClosingAlert('#dangerMessage', 2000);
				} else {
					autoClosingAlert('#warningMessage', 2000);
				}
			},//https://shxrecord.tistory.com/108
		});
		$('#chatContent').val('');
	}
	function autoClosingAlert(selector, delay) {
		//전송에 따른 알림메세지를 자동으로 지워주는 함
		var alert = $(selector)
		alert.show();
		window.setTimeout(function() {
			alert.hide()
		}, delay);
	}
	function chatListFunction(type) {
		//리스트를 가져오는 함수
		$.ajax({
			type : "POST",
			url : "ChatListServlet",
			data : {
				listType : type,
			},
			success : function(data) {
				if (data == "")
					return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value,
							result[i][2].value);
				}
				lastID = Number(parsed.last);
			},
		});
	}
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList')
				.append(
						'<div class="row">'
								+ '<div class="col-lg-12">'
								+ '<div class="media">'
								+ '<a class="pull-left" href="#">'
								+ '<img class="media-object img-circle" width="50px" src="images/icon.png" alt="">'
								+ '</a>' + '<div class="media-body">'
								+ '<h4 class="media-heading">' + chatName
								+ '<span class="small pull-right">' + chatTime
								+ '</span>' + '</h4>' + '<p>' + chatContent
								+ '</p>' + '</div>' + '</div>' + '</div>'
								+ '</div>' + '<hr>');
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
		//스크롤바를 최신 메세지로 이동
	}
	function getInfiniteChat() {
		setInterval(function() {
			//반복적으로 서버와 1초마다 통신
			chatListFunction(lastID);
		}, 500)
	}
</script>
<title>Insert title here</title>
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
			<li><a href="bbs.jsp">게시판</a></li>
			<li class="active"><a href="chat.jsp">채팅방</a></li>
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
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-12">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green"></i>실시간 채팅방
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget"
								style="overflow-y: auto; width: auto; height: 600px;">
								<!-- overflow-y는 y축의 길이를 얘기 auto로 설정하고 드래그바가 생기고 증가 -->
							</div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="text" id="chatName"
											class="form-control" placeholder="이름" maxlength="20">
									</div>
								</div>
								<div class="row" style="height: 90px;">
									<div class="form-group col-xs-10">
										<textarea style="height: 80px;" id="chatContent"
											class="form-control" placeholder="메세지를 입력하세요."
											maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right"
											onclick="submitFunction();">전송</button>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="alert alert-success" id="successMessage"
			style="display: none;">
			<strong>메세지 전송에 성공하였습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage"
			style="display: none;">
			<strong>이름과 내용을 모두 입력해주세요.</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage"
			style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>
	<script type="text/javascript">
		//페이지가 실행되자마자 최근 대화내용10개를 불러온다.
		$(document).ready(function() {
			chatListFunction('ten');
			getInfiniteChat();
		});
	</script>
	<%
		}
	%>
</body>
</html>