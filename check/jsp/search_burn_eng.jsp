<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="conn_mysql.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Software Query System</title>
        <link rel="icon" type="image/x-icon" href="../img/icon.png" />
        <link rel="stylesheet" type="text/css" href="../css/table.css" />
        <link rel="stylesheet" type="text/css" href="../css/page.css" />
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
		
		<p id="head1"><a href="index_eng.jsp">Software Information Query System</a></p>
		<div id="search">
		<input id="key" type="text" size=25 style="background-color: #F3F3F3;" placeholder="input Model or Order" autofocus="on"/>
		<button onclick="search_model()">MODEL</button>
		<button onclick="search_order()">ORDER</button>
		</div>
		
		<form method="post" id="display">
			<table id="t2">
				<tr>
				<th>No.</th>
				<th>Order No.</th>
				<th>Model</th>
				<th>RollPlan</th>
				<th class="burn_hide" hidden="hidden">SemiNo.</th>
				<th>Software</th>
				<th>Chip</th>
				<th>Quantity</th>
				<th>Country</th>
				<th class="burn_hide" hidden="hidden">EMP_No.</th>
				<th>Factory</th>
				<th class="burn_hide" hidden="hidden">EMP_Name</th>
				<th>Operation Time</th>
				<th class="burn_hide" hidden="hidden">Area</th>
				<th>Operation</th>
				<th class="burn_hide" hidden="hidden">Position</th>
				<th>OpQuantity</th>
				<th class="burn_hide" hidden="hidden">OpName</th>
				<th class="burn_hide" hidden="hidden">Device</th>
				<th class="burn_detail">Detail</th>
				</tr>
			<%@include file="page_burn.jsp"%>
				<tr>
				<td><%out.print(rs.getString(1));%></td>
				<td><%out.print(rs.getString(2));%></td>
				<td><%out.print(rs.getString(3));%></td>
				<td><%out.print(rs.getString(4));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(5));%></td>
				<td><%out.print(rs.getString(6));%></td>
				<td><%out.print(rs.getString(7));%></td>
				<td><%out.print(rs.getString(8));%></td>
				<td><%out.print(rs.getString(9));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(10));%></td>
				<td><%out.print(rs.getString(11));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(12));%></td>
				<td><%out.print(rs.getString(13));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(14));%></td>
				<td><%out.print(rs.getString(15));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(16));%></td>
				<td><%out.print(rs.getString(17));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(18));%></td>
				<td class="burn_hide" hidden="hidden"><%out.print(rs.getString(19));%></td>
				<td class="burn_detail link" onclick="get_burn_detail()">View Details</td>
				</tr>
			<% }} %>
			</table>
		</form>
		
		<form method="POST" id="pagination">
			<table id="t3">
				<tr>
				<script type="text/javascript">
					//<!--script中的HTML语句必须用script语句输出.且要注意分行,注意引号嵌套,注意变量的使用方法，URL参数连接用&-->
					document.write("<td><a href='search_burn_eng.jsp?pages=1&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9668;&#9668;</a></td>");
					document.write("<td><a href='search_burn_eng.jsp?pages=<%=(pages<1)?pages:(pages-1)%>&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9668;</a></td>");
					document.write("<td>Page&nbsp;<%=pages%>&nbsp;of&nbsp;Total <%=totalpages%> Pages</td>");
					document.write("<td><a href='search_burn_eng.jsp?pages=<%=(pages>=totalpages)?totalpages:(pages+1)%>&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9658;</a></td>");
					document.write("<td><a href='search_burn_eng.jsp?pages=<%=totalpages%>&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9658;&#9658;</a></td>");
				</script>
				</tr>
			</table>
		</form>

    </body>
</html>


