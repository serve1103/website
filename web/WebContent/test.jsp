<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>JDBC드라이버 테스트</h2>
<%
	Connection conn=null;

	try{
		String jdbcUrl="jdbc:mysql://localhost:3306/DB?characterEncoding=UTF-8&serverTimezone=UTC";
		String dbId="root";
		String dbPass = "nlcfjb1129";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection(jdbcUrl,dbId,dbPass);
		out.println("제대로 연결되었습니다.");
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>