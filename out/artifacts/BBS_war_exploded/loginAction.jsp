<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- user패키지에 있는 UserDAO import -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 uft-8로 받을 수 있도록 하는 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 현재 페이지 안에서만 빈즈가 사용될 수 있도록 -->
<jsp:setProperty name="user" property="userID" /> <!-- login 페이지에서 넘겨준 userID를 받아서 한 명의 사용자의 userID에 -->
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-sclae="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP  게시판 웹사이트</title>
</head>
<body>
	<%
    /*
        세션:
        - 현재 접속한 회원에게 할당해주는 고유ID
        - 웹 서버는 한 면늬 회원을 세션ID로 구분
        - 로그인에 성공했을 때 세션ID를 부여
    */
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String)session.getAttribute("userID");
        }
        if(userID != null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인이 되었습니다.')");
            script.println("</script>");
        } //이미 로그인이 된 사람은 또 다시 로그인할 수 없도롣

        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getUserID(), user.getUserPassword());

        if(result == 1) {
            session.setAttribute("userID", user.getUserID());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='main.jsp'");
            script.println("</script>");
        } else if(result == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다')");
            script.println("history.back()"); // 이전 페이지로 사용자를 돌려보낸다. 즉 ,다시 로그인 페이지로
            script.println("</script>");
        } else if(result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else if(result == -2) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.')");
            script.println("history.back()"); 
            script.println("</script>");
        }
    %>
</body>
</html>

