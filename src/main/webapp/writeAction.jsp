<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "bbs" class = "bbs.Bbs" scope="page"/>
<jsp:setProperty name = "bbs" property="bbsTitle"/>
<jsp:setProperty name = "bbs" property="bbsContent"/>	<!-- login 페이지에서 아이디와 비밀번호를 받아옴 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		//로그인이 되어 회원가입 불가
		String userID =null;
		if(session.getAttribute("userID")!= null){
			userID = (String) session.getAttribute("userID");		//세션이 존재하는 회원들은 userID에 해당 세션 값을 주어진다. 
		}
		if(userID == null){		//로그인을 하지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else{
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back();");
					script.println("</script>");
				}
				else{
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());	//회원가입 실행
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back();");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");	//회원가입 성공 시 메인 페이지로 이동
						script.println("</script>");
					}
				}
		}
		
	%>
</body>
</html>