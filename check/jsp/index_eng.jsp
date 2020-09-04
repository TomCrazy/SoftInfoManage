<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="conn_mysql.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Software Query System</title>
	<link rel="icon" type="image/x-icon" href="../img/icon.png" />
	<link rel="stylesheet" type="text/css" href="../css/home.css" />
	<link rel="stylesheet" type="text/css" href="../css/window.css" />
	<script type="text/javascript" src="../JS/function.js"></script>
	<script type="text/javascript" src="../JS/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../JS/window.js"></script>
</head>

<body>

	<div id="header">
		<div id="logo"><img src="../img/logo.png" width="115" height="25"></div>
		<div id="language" onclick="switchToChz()"><a href="index.jsp">中文版</a></div>
		<div id="contact" onclick="contact_us()"><a href="#">Suggestions</a></div>
		<div id="instruction"><a href="../html/help.html">Instructions</a></div>
	</div>
	
	<div>
		<div>
			<h1></h1>
			<h1 style="letter-spacing: -3px;">Software Information Query System</h1>
			<h2>Welcome!</h2>
		</div>
		<div id="search">
			<div>
			<input id="key" type="text" size=25 style="background-color: #F3F3F3;" placeholder="input Model or Order" autofocus="on"/>
			</div>
			<div>
			<button onclick="search_model()">MODEL</button>
			<button onclick="search_order()">ORDER</button>
			</div>
		</div>
		<div id="info">
			<p>software infomation : <%=count_model%> items</p>
			<p>order infomation : <%=count_order%> items</p>
			<p>burn infomation : <%=count_burn%> items</p>
			<p>update：<%=date%></p>
			<%@include file="count.jsp"%>
		</div>
	</div>

</body>
	
	
</html>