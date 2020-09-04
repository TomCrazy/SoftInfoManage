<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="conn_mysql.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>软件信息查询系统</title>
	<link rel="icon" type="image/x-icon" href="../img/icon.png" />
	<link rel="stylesheet" type="text/css" href="../css/home.css" />
	<link rel="stylesheet" type="text/css" href="../css/window.css" />
	<script type="text/javascript" src="../JS/function.js"></script>
	<script type="text/javascript" src="../JS/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../JS/window.js"></script>
</head>

<body>
	
	<%@ include file="../html/head_banner.html"%>
	
	<div>
		<div>
			<h1></h1>
			<h1>软件信息查询系统</h1>
			<h2>欢迎使用</h2>
		</div>
		<div id="search">
			<div>
				<input id="key" type="text" size=25 placeholder="请输入机型名或订单号" autofocus="on"/>
			</div>
			<div>
				<button onclick="search_model()">搜机型</button>
				<button onclick="search_order()">搜订单</button>
			</div>
		</div>
		<div id="info">
			<p>软件信息<%=count_model%>条，订单信息<%=count_order%>条，贴片信息<%=count_burn%>条</p>
			<p>更新日期：<%=date%></p>
			<%@include file="count.jsp"%>
			<p>访问量：<%=totalvisit%>次&nbsp;&nbsp;&nbsp;&nbsp;查询量：<%=totalhit%>次</p>
		</div>
	</div>
	

</body>
	
</html>