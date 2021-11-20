<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %> <!-- user패키지에 있는 UserDAO import -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트를 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 uft-8로 받을 수 있도록 하는 -->

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
    if(userID == null) { //로그인이 되어있을 때 게시글 작성 가능
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.')");
        script.println("location.href='login.jsp'");
        script.println("</script>");
    }

    int bbsID = 0;
    if(request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);

    if(!userID.equals(bbs.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
    } else {
        BbsDAO bbsDAO = new BbsDAO();
        int result = bbsDAO.delete(bbsID);

        if(result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글 삭제에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='bbs.jsp'");
            script.println("</script>");
        }
    }
%>
</body>
</html>