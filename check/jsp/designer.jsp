<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="conn_mysql.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="../css/table.css" />
		<link rel="stylesheet" type="text/css" href="../css/page.css" />
		<title>软件主设计</title>		
	</head>
	<body>
		<table id="t5" style="margin-bottom: 10px; margin-top: 10px;">
			<tr>
				<th>序号</th>
				<th>姓名</th>
				<th>邮箱</th>
				<th>电话</th>
				<th>手机</th>
			</tr>
		<%
			rs = stmt.executeQuery("select * from designer order by id");
			while(rs.next()){
		%>
			<tr>
				<td><%out.print(rs.getString(1));%></td>
				<td><%out.print(rs.getString(2));%></td>
				<td><%out.print(rs.getString(3));%></td>
				<td><%out.print(rs.getString(4));%></td>
				<td><%out.print(rs.getString(5));%></td>
			</tr>
		<% } %>
		</table>
	</body>
</html>