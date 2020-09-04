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
				<th>PN</th>
				<th>Model</th>
				<th>MainChip</th>
				<!-- <th>PLMVersion</th> -->
				<th>VersionNo.</th>
				<th>Version</th>
				<th>Stage</th>
				<th>Designer</th>
				<th>OldVersion</th>
				<th>Logo</th>
				<th>Link</th>
				<th>ReleaseDate</th>
				</tr>
			<%@include file="page_model.jsp"%>
				<tr>
				<td><%out.print(rs.getString(1));%></td>
				<td><%out.print(rs.getString(2));%></td>
				<td class="td_jixing link" onclick="filt_model(this)"><%out.print(rs.getString(3));%></td>
				<td class="td_chip link" onclick="filt_chip(this)"><%out.print(rs.getString(4));%></td>
				<!-- <td></td> -->
				<td><%out.print(rs.getString(7));%></td>
				<td><%out.print(trans_version(rs.getString(8)));%></td>
				<td><%out.print(trans_stage(rs.getString(5)));%></td>
				<td><%out.print(rs.getString(10));%></td>
				<td class="td_old"><%out.print(trans_oldversion(rs.getString(11)));%></td>
				<td><%out.print(ifHasLogo(rs.getString(12)));%></td>
				<td class="td_link">
					<a target="_blank" href="<%out.print(rs.getString(13));%>">
						<%out.print(trans_ifHasLink(rs.getString(13)));%>
					</a>
				</td>
				<td><%out.print(rs.getString(14));%></td>
				</tr>
			<% }} %>
			</table>
		</form>
		
		<form method="POST" id="pagination">
			<table id="t3">
				<tr>
				<script type="text/javascript">
					//<!--script中的HTML语句必须用script语句输出.且要注意分行,注意引号嵌套,注意变量的使用方法，URL参数连接用&-->
					document.write("<td><a href='search_model_eng.jsp?pages=1&jixing="+sessionStorage.getItem('jixing')+"'>&#9668;&#9668;</a></td>");
					document.write("<td><a href='search_model_eng.jsp?pages=<%=(pages<1)?pages:(pages-1)%>&jixing="+sessionStorage.getItem('jixing')+"'>&#9668;</a></td>");
					document.write("<td>Page&nbsp;<%=pages%>&nbsp;of&nbsp;Total <%=totalpages%> Pages</td>");
					document.write("<td><a href='search_model_eng.jsp?pages=<%=(pages>=totalpages)?totalpages:(pages+1)%>&jixing="+sessionStorage.getItem('jixing')+"'>&#9658;</a></td>");
					document.write("<td><a href='search_model_eng.jsp?pages=<%=totalpages%>&jixing="+sessionStorage.getItem('jixing')+"'>&#9658;&#9658;</a></td>");
				</script>
				</tr>
			</table> 
		</form>

    </body>
</html>

<!--当link单元格无下载地址时禁用超链接-->
<script>
	var td_links = document.getElementsByClassName("td_link");
	for(var i=0;i<td_links.length;i++){
		if(td_links[i].innerText=="not exist"){
			td_links[i].style.pointerEvents="none";
		}
	}
</script>