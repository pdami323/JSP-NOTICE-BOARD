<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content = "width=device-width", initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
			data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
			aria-expanded = "false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span> <!--메뉴에서 작대기를 의미-->
			</button>
			<a class = "navbar-brand" href = "main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">	<!-- 리스트 -->
				<li><a href = "main.jsp">메인</a></li>	<!-- 리스트 요소 -->
				<li><a href = "bbs.jsp">게시판</a></li>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href = "#" class = "dropdown-toggle"
					data-toggle = "dropdown" role = "button" aria-haspopup="true"
					aria-expanded = "false">접속하기<span class="caret"></span></a>		<!-- caret은 아이콘 -->
					<ul class = "dropdown-menu">
						<li class = "active"><a href = "login.jsp">로그인</a></li>		<!-- active는 현재 선택된 상태를 의미 -->
						<li><a href = "join.jsp">회원가입</a></li>							<!-- active는 선택된 상태이므로 단 1개만 가능 -->
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<!-- 로그인 양식 -->
	<div class = "container">		<!-- container : 하나의 양식처럼 감싸는 역할 -->
		<div class = "col-lg-4"></div>
		<div class = "col-lg-4">
			<div class = "jumbotron" style = "padding-top : 20px;">
				<form method = "post" action = "loginAction.jsp">	<!-- loginAction.jsp로 post방식을 이용하여 정보를 보내겠다는 의미로 로그인 결과 화면 -->
					<h3 style = "text-align : center;">로그인 화면</h3>
					<div class = "form-group">
						<input type = "text" class = "form-control" placeholder = "아이디" name = "userID" maxlength = "20">
						<!-- placeholder : 기본으로 쓰여있는 내용 / name : 서버로 보내질 때의 이름 -->	
					</div>
					<div class = "form-group">
						<input type = "password" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20">
					</div>
					<input type = "submit" class = "btn btn-primary form-control" value = "로그인">
				</form>
			</div>
		</div>
		<div class = "col-lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>