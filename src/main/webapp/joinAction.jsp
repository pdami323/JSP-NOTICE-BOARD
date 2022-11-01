<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "user" class = "user.User" scope="page"/>
<jsp:setProperty name = "user" property="userID"/>
<jsp:setProperty name = "user" property="userPassword"/>	<!-- login 페이지에서 아이디와 비밀번호를 받아옴 -->
<jsp:setProperty name = "user" property="userName"/>
<jsp:setProperty name = "user" property="userGender"/>
<jsp:setProperty name = "user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			||user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back();");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);	//회원가입 실행
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back();");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");	//회원가입 성공 시 메인 페이지로 이동
				script.println("</script>");
			}
		}
	%>
</body>
</html>