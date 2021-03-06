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
				<th>工单号</th>
				<th>机型</th>
				<th>滚动计划号</th>
				<th class="burn_hide" hidden="hidden">半品料号</th>
				<th>软件版本</th>
				<th>芯片型号</th>
				<th>芯片数量</th>
				<th>国家</th>
				<th class="burn_hide" hidden="hidden">写入人工号</th>
				<th>工厂名</th>
				<th class="burn_hide" hidden="hidden">写入人</th>
				<th>操作时间</th>
				<th class="burn_hide" hidden="hidden">库区</th>
				<th>操作类型</th>
				<th class="burn_hide" hidden="hidden">库位</th>
				<th>操作数量</th>
				<th class="burn_hide" hidden="hidden">出入库人</th>
				<th class="burn_hide" hidden="hidden">写入设备</th>
				<th class="burn_detail">详情</th>
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
				<td class="burn_detail link" onclick="get_burn_detail()">展开详情</td>
				</tr>
			<% }} %>
			</table>
		</form>
		
		<form method="POST" id="pagination">
			<table id="t3">
				<tr>
				<script type="text/javascript">
					//<!--script中的HTML语句必须用script语句输出.且要注意分行,注意引号嵌套,注意变量的使用方法，URL参数连接用&-->
					document.write("<td><a href='search_burn.jsp?pages=1&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9668;&#9668;</a></td>");
					document.write("<td><a href='search_burn.jsp?pages=<%=(pages<1)?pages:(pages-1)%>&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9668;</a></td>");
					document.write("<td>第<%=pages%>页 &nbsp;共<%=totalpages%>页 </td>");
					document.write("<td><a href='search_burn.jsp?pages=<%=(pages>=totalpages)?totalpages:(pages+1)%>&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9658;</a></td>");
					document.write("<td><a href='search_burn.jsp?pages=<%=totalpages%>&bom="+sessionStorage.getItem('bom')+"&plan="+sessionStorage.getItem('plan')+"'>&#9658;&#9658;</a></td>");
				</script>
				</tr>
			</table>
		</form>

    </body>
</html>