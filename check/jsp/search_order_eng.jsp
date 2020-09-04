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
			<!--不需要submit自动跳转了，因此去掉form-->
		<div id="search">
		<input id="key" type="text" size=25 style="background-color: #F3F3F3;" placeholder="input Model or Order" autofocus="on"/>
		<button onclick="search_model()">MODEL</button>
		<button onclick="search_order()">ORDER</button>
		</div>
		
		<form method="post" id="display">
			<table id="t2">
				
				<tr id="tr1"><th class="vhead">No.</th></tr>
				<tr id="tr2"><th class="vhead">Name</th></tr>
				<tr id="tr3"><th class="vhead">Revision</th></tr>
				<tr id="tr4"><th class="vhead">Model</th></tr>
				<tr id="tr5" hidden="hidden"><th class="vhead">BasisBOM</th></tr>
				<tr id="tr13" hidden="hidden"><th class="vhead">Explanation</th></tr><!-- 由于奇偶变色原因将两个隐藏行放在一起 -->
				<tr id="tr6"><th class="vhead">ExportModel</th></tr>
				<tr id="tr7"><th class="vhead">PlanNo.</th></tr>
				<tr id="tr8"><th class="vhead">TVColor</th></tr>
				<tr id="tr9"><th class="vhead">Brand</th></tr>
				<tr id="tr10"><th class="vhead">ExportMode</th></tr>
				<tr id="tr11"><th class="vhead">Volume</th></tr>
				<tr id="tr12"><th class="vhead">OrderType</th></tr>
				<tr id="tr14"><th class="vhead">OrderEngineer</th></tr>
				<tr id="tr15"><th class="vhead">CircuitDesigner</th></tr>
				<tr id="tr16"><th class="vhead">StructureDesigner</th></tr>
				<tr id="tr17"><th class="vhead">SoftwareDesigner</th></tr>
				<tr id="tr18"><th class="vhead">PowerDesigner</th></tr>
				<tr id="tr19"><th class="vhead">ElectronicTechnologist</th></tr>
				<tr id="tr20"><th class="vhead">MechanicalTechnologist</th></tr>
				<tr id="tr21"><th class="vhead">SaleManager</th></tr>
				<tr id="tr22"><th class="vhead">Factory</th></tr>
				<tr id="tr23"><th class="vhead">Area</th></tr>
				<tr id="tr24" hidden="hidden"><th class="vhead">Country</th></tr>
				<tr id="tr25" hidden="hidden"><th class="vhead">Language</th></tr>
				<tr id="tr26" hidden="hidden"><th class="vhead">Logo</th></tr>
				<tr id="tr27" hidden="hidden"><th class="vhead">ProjectID</th></tr>
				<tr id="tr28" hidden="hidden"><th class="vhead">CustomerModel</th></tr>
				<tr id="tr29"><th class="vhead">date</th></tr>
				<tr id="order_detail" onclick="get_order_detail()"><th class="vhead">Detail</th></tr>
				<tr id="tr30"><th class="vhead">BurnInfo</th></tr>
				
			<%@include file="page_order.jsp"%>
			
			<script type="text/javascript">
				
				<% for(int i=1;i<30;i++){ %>
					var td = document.createElement("td");
					var text = "<%=rs.getString(i)%>";
					var reg = /[\u4e00-\u9fa5]/g;
					if(<%=i%>==21){
						text = text.match(reg);
						text = text.join("");				//若无这句话则每个汉字中间会有一个逗号
					}
					var tdtext = document.createTextNode(text);
					td.appendChild(tdtext);
					document.getElementById("tr"+<%=i%>).appendChild(td);
				<% } %>
				
				var td_detail = document.createElement("td");
				td_detail.className = "link";
				td_detail.appendChild(document.createTextNode("View Details"));
				document.getElementById("order_detail").appendChild(td_detail);
				
				var td_burn = document.createElement("td");
				td_burn.className = "link";
				td_burn.appendChild(document.createTextNode("Search"));
				document.getElementById("tr30").appendChild(td_burn);
				
			</script>
			
			<% }} %>
			</table>
		</form>
		
		<form method="POST" id="pagination">
			<table id="t3">
				<tr>
				<script type="text/javascript">
					//<!--script中的HTML语句必须用script语句输出.且要注意分行,注意引号嵌套,注意变量的使用方法，URL参数连接用&-->
					document.write("<td><a href='search_order_eng.jsp?pages=1&order="+sessionStorage.getItem('order')+"'>&#9668;&#9668;</a></td>");
					document.write("<td><a href='search_order_eng.jsp?pages=<%=(pages<1)?pages:(pages-1)%>&order="+sessionStorage.getItem('order')+"'>&#9668;</a></td>");
					document.write("<td>Page&nbsp;<%=pages%>&nbsp;of&nbsp;Total <%=totalpages%> Pages</td>");
					document.write("<td><a href='search_order_eng.jsp?pages=<%=(pages>=totalpages)?totalpages:(pages+1)%>&order="+sessionStorage.getItem('order')+"'>&#9658;</a></td>");
					document.write("<td><a href='search_order_eng.jsp?pages=<%=totalpages%>&order="+sessionStorage.getItem('order')+"'>&#9658;&#9658;</a></td>");
				</script>
				</tr>
			</table>
		</form>

    </body>
</html>

<!--为机型单元格和写片单元格添加搜索动作-->
<script>
	
	var tr2_tds = document.getElementById("tr2").getElementsByTagName("td");
	var tr4_tds = document.getElementById("tr4").getElementsByTagName("td");
	var tr7_tds = document.getElementById("tr7").getElementsByTagName("td");
	var tr30_tds = document.getElementById("tr30").getElementsByTagName("td");
	for(var i=0; i<tr4_tds.length; i++){
		<!--为BOM和订单号单元格添加id-->
		tr2_tds[i].setAttribute("id","td_order_bom"+i);
		tr7_tds[i].setAttribute("id","td_order_plan"+i);
		
		tr4_tds[i].className = "td_jixing link";
		tr4_tds[i].setAttribute("onclick","filt_model_from_order(this)");
		
		tr30_tds[i].setAttribute("id","td_filt_burn_"+i);
		tr30_tds[i].setAttribute("onclick","filt_burn_from_order(this.id)");
	}
	
</script>