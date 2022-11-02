<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>		<!-- 스크립트 문장을 사용할 수 있도록 import -->
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content = "width=device-width", initial-scale = "1">
<link rel="stylesheet" href = "css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!= null){
			userID = (String) session.getAttribute("userID");
		}
		int bbsID =0 ;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID ==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
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
				<li><a href = "main.jsp">메인</a></li>	<!-- 리스트 요소 --> <!-- active는 현재 접속한 상태를 의미 -->
				<li class = "active"><a href = "bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class = "nav navbar-nav navbar-right">			<!-- 로그인하지 않은 경우에만 보이도록 -->
				<li class="dropdown">
					<a href = "#" class = "dropdown-toggle"
					data-toggle = "dropdown" role = "button" aria-haspopup="true"
					aria-expanded = "false">접속하기<span class="caret"></span></a>		<!-- caret은 아이콘 -->
					<ul class = "dropdown-menu">
						<li><a href = "login.jsp">로그인</a></li>		
						<li><a href = "join.jsp">회원가입</a></li>							<!-- active는 선택된 상태이므로 단 1개만 가능 -->
					</ul>
				</li>
			</ul>
			<%
				}else{
			%>
			<ul class = "nav navbar-nav navbar-right">			<!-- 로그인하지 않은 경우에만 보이도록 -->
				<li class="dropdown">
					<a href = "#" class = "dropdown-toggle"
					data-toggle = "dropdown" role = "button" aria-haspopup="true"
					aria-expanded = "false">회원관리<span class="caret"></span></a>		<!-- caret은 아이콘 -->
					<ul class = "dropdown-menu">
						<li><a href = "logoutAction.jsp">로그아웃</a></li>		
					</ul>
				</li>
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	<div class = "container">
		<div class = "row">
			<table class = "table table-striped" style = "text-align : center; border : 1px solid #dddddd">	<!-- table-striped은 짝홀 나누어 색상 -->
				<thead>
					<tr>
						<th colspan = "3" style = "background-color : #eeeeee; text-align : center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style = "width : 20%;">글 제목</td>
						<td colspan = "2" ><%=bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan = "2" ><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan = "2"><%=bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11, 13) + "시 " + bbs.getBbsDate().substring(14,16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan = "2" >
							<div class = "bbs-content" style="text-align : left; min-height :200px;">
							<%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<a href = "bbs.jsp" class = "btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){	//작성자와 아이디가 동일할 경우 수정도 가능
			%>
					<a href = "update.jsp?bbsID=<%=bbsID%>" class = "btn btn-primary">수정</a> 
					<a href = "deleteAction.jsp?bbsID=<%=bbsID%>" class = "btn btn-primary">삭제</a> 
			<%
				}
			%>
			<input type = "submit" class = "btn btn-primary pull-right" value = "글쓰기">
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>