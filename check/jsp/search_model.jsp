<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="conn_mysql.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>软件信息查询系统</title>
		<link rel="icon" type="image/x-icon" href="../img/icon.png" />
		<link rel="stylesheet" type="text/css" href="../css/table.css" />
		<link rel="stylesheet" type="text/css" href="../css/page.css" />
		<link rel="stylesheet" type="text/css" href="../css/window.css" />
		<script type="text/javascript" src="../JS/function.js"></script>
		<script type="text/javascript" src="../JS/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="../JS/window.js"></script>
    </head>
    
    <body>

		<%@ include file="../html/head_banner.html"%>
		
		<p id="head1"><a href="index.jsp">软件信息查询系统</a></p>
		<!--不需要submit自动跳转了，因此去掉form-->
		<div id="search">
		<input id="key" type="text" size=25 style="background-color: #F3F3F3;" placeholder="请输入机型或订单号" autofocus="on"/>
		<button onclick="search_model()">搜机型</button>
		<button onclick="search_order()">搜订单</button>
		</div>
		
		<form method="post" id="display">
			<table id="t2">
				<tr>
				<th>序号</th>
				<th>物料号</th>
				<th>机型</th>
				<th>芯片</th>
				<!--<th>编号</th>-->
				<th>版本号</th>
				<th>版本</th>
				<th>阶段</th>
				<th>主设计</th>
				<th>旧版本</th>
				<th>品牌</th>
				<th>下载地址</th>
				<th>发布日期</th>
				</tr>
			<%@include file="page_model.jsp"%>
				<tr>
				<td><%out.print(rs.getString(1));%></td>
				<td><%out.print(rs.getString(2));%></td>
				<td class="td_jixing link" onclick="filt_model(this)"><%out.print(rs.getString(3));%></td>
				<td class="td_chip link" onclick="filt_chip(this)"><%out.print(rs.getString(4));%></td>
				<!-- <td></td> -->
				<td><%out.print(rs.getString(7));%></td>
				<td><%out.print(rs.getString(8));%></td>
				<td><%out.print(rs.getString(5));%></td>
				<td><%out.print(rs.getString(10));%></td>
				<td class="td_old"><%out.print(rs.getString(11));%></td>
				<td><%out.print(ifHasLogo(rs.getString(12)));%></td>
				<td class="td_link">
					<a target="_blank" href="<%out.print(rs.getString(13));%>">
						<%out.print(ifHasLink(rs.getString(13)));%>
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
					document.write("<td><a href='search_model.jsp?pages=1&jixing="+sessionStorage.getItem('jixing')+"'>&#9668;&#9668;</a></td>");
					document.write("<td><a href='search_model.jsp?pages=<%=(pages<1)?pages:(pages-1)%>&jixing="+sessionStorage.getItem('jixing')+"'>&#9668;</a></td>");
					document.write("<td>第<%=pages%>页 &nbsp;共<%=totalpages%>页 </td>");
					document.write("<td><a href='search_model.jsp?pages=<%=(pages>=totalpages)?totalpages:(pages+1)%>&jixing="+sessionStorage.getItem('jixing')+"'>&#9658;</a></td>");
					document.write("<td><a href='search_model.jsp?pages=<%=totalpages%>&jixing="+sessionStorage.getItem('jixing')+"'>&#9658;&#9658;</a></td>");
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
		if(td_links[i].innerText=="暂无"){
			td_links[i].style.pointerEvents="none";
		}
	}
	
</script>