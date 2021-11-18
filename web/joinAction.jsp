<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- user패키지에 있는 UserDAO import -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 uft-8로 받을 수 있도록 하는 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 현재 페이지 안에서만 빈즈가 사용될 수 있도록 -->
<jsp:setProperty name="user" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-sclae="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>   
	<%
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String)session.getAttribute("userID");
        }
        if(userID != null) { //이미 로그인이 된 사람은 또 다시 로그인할 수 없도록
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인이 되었습니다.')");
            script.println("</script>");
        }

        // 사용자가 모든 경우에 입력을 안했을때 
        if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || 
        user.getUserGender() == null || user.getUserEmail() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            UserDAO userDAO = new UserDAO();
            int result = userDAO.join(user); // 각각의 변수를 입력받아서 만들어진 하나의 user라는 인스턴스가 join()의 매개변수로 

            if(result == -1) { //데이터베이스 오류 : 해당 아이디가 존재할 때 -> userID가 primary key이기 때문
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 존재하는 아이디입니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else { //회원가입 성공
                session.setAttribute("userID", user.getUserID());
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href='main.jsp'");
                script.println("</script>");
            }
        }
    %>
</body>
</html>