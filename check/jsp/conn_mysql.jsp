<%@page language="java"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.*"%>
<%
//数据库信息 
String dbName="soft";
String url="jdbc:mysql://localhost:3306/soft";
String sql="";
int count_model=0;
int count_order=0;
int count_burn=0;
String date = "";

//加载驱动程序
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn=DriverManager.getConnection(url,"root","1");
Statement stmt = conn.createStatement();
ResultSet rs;

	//获取三个数据库的数据条数
	rs = stmt.executeQuery("select count(*) from softinfo");
	if(rs.next()){
		count_model = rs.getInt(1);}
	rs = stmt.executeQuery("select count(*) from orderinfo");
	if(rs.next()){
		count_order = rs.getInt(1);}
	rs = stmt.executeQuery("select count(*) from burninfo");
	if(rs.next()){
		count_burn = rs.getInt(1);}
	rs = stmt.executeQuery("select * from softinfo order by id DESC limit 1");
	if(rs.next()){
		date = rs.getString(14);
	}
%>
