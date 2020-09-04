
//首次打开时防止jixing为null；sessionStorage里无值时,request.get得到的值是字符串"null"
if(sessionStorage.getItem("jixing")==null){sessionStorage.setItem("jixing","");}
if(sessionStorage.getItem("order")==null){sessionStorage.setItem("order","");}

//<--!--------------------------------机型信息页面---------------------------------------->

//<!--通过机型名搜索-->
function search_model(){
	var tempKey = document.getElementById("key").value +"1";
	sessionStorage.setItem("jixing",tempKey);
	if(localStorage.getItem("language")=="EN"){
		window.location.href="search_model_eng.jsp?count=1&jixing="+tempKey;
	}else{
		window.location.href="search_model.jsp?count=1&jixing="+tempKey;
	}
	//<!--在点击搜索按钮的时候如果利用submit自动跳转，则jsp页获取的jixing仍为空-->
}

//<!--点击机型名进行精确筛选-->
function filt_model(td){
	var tempKey = td.innerHTML +"2";
	sessionStorage.setItem("jixing",tempKey);
	window.location.href=location.pathname+"?jixing="+tempKey;
}

//<!--点击机芯进行筛选同方案的机型-->
function filt_chip(td){
	var tempKey = td.innerHTML +"3";
	sessionStorage.setItem("jixing",tempKey);
	window.location.href=location.pathname+"?jixing="+tempKey;
}

//<!--旧版本颜色标记-->
window.onload = function(){
	var td_olds = document.getElementsByClassName("td_old");
	for(var i=0;i<td_olds.length;i++){
		if(td_olds[i].innerHTML=="不能使用"||td_olds[i].innerHTML=="废弃"||td_olds[i].innerHTML=="作废"||td_olds[i].innerHTML=="abandon"){
			td_olds[i].style.color = "darkred";
		}
	}
}

//<--!------------------------------订单信息页面------------------------------------->

//<!--通过订单号搜索-->
function search_order(){
	var tempKey = document.getElementById("key").value +"1";
	sessionStorage.setItem("order",tempKey);
	if(localStorage.getItem("language")=="EN"){
		window.location.href="search_order_eng.jsp?count=1&order="+tempKey;
	}else{
		window.location.href="search_order.jsp?count=1&order="+tempKey;
	}
	//<!--在点击搜索按钮的时候如果利用submit自动跳转，则jsp页获取的jixing仍为空-->
}

//<!--点击机型名进行精确筛选-->
function filt_model_from_order(td){
	var tempKey = td.innerHTML +"2";
	sessionStorage.setItem("jixing",tempKey);
	if(localStorage.getItem("language")=="EN"){
		window.location.href = "search_model_eng.jsp?jixing="+tempKey;
	}else{
		window.location.href="search_model.jsp?jixing="+tempKey;
	}
}

//<!--获取订单信息中的详情行-->
function get_order_detail(){
	document.getElementById("order_detail").hidden="hidden";
	document.getElementById("tr24").hidden="";
	document.getElementById("tr25").hidden="";
	document.getElementById("tr26").hidden="";
	document.getElementById("tr27").hidden="";
	document.getElementById("tr28").hidden="";
}

//<!--通过BOM号或订单号搜索写片信息-->
function filt_burn_from_order(id){
	var num = id.substring(13);
	var bom = document.getElementById("td_order_bom"+num).innerText;
	var plan = document.getElementById("td_order_plan"+num).innerText;
	bom = bom.substring(5,12);
	sessionStorage.setItem("bom",bom);
	sessionStorage.setItem("plan",plan);
	if(localStorage.getItem("language")=="EN"){
		window.location.href = "search_burn_eng.jsp?bom="+bom+"&plan="+plan;
	}else{
		window.location.href="search_burn.jsp?bom="+bom+"&plan="+plan;
	}
}

//<--!------------------------------写片信息页面------------------------------------->

//<!--获取写片信息中的详情行-->
function get_burn_detail(){
	var burn_detail = document.getElementsByClassName("burn_detail");
	for(var i=0; i<burn_detail.length; i++){
		burn_detail[i].hidden = "hidden";
	}
	
	var burn_hide = document.getElementsByClassName("burn_hide");
	for(var i=0; i<burn_hide.length; i++){
		burn_hide[i].hidden="";
	}
}

//<!--自定义搜索-->
function search_custom(){
	var tempKey1 = document.getElementById("key1").value;
	var tempKey2 = document.getElementById("key2").value;
	var tempKey3 = document.getElementById("key3").value;
	var tempKey4 = document.getElementById("key4").value;
	var tempKey5 = document.getElementById("key5").value;
	var tempKey6 = document.getElementById("key6").value;
	var tempKey7 = document.getElementById("key7").value;
	var tempKey8 = document.getElementById("key8").value;
	
	sessionStorage.setItem("tempKey1",tempKey1);
	sessionStorage.setItem("tempKey2",tempKey2);
	sessionStorage.setItem("tempKey3",tempKey3);
	sessionStorage.setItem("tempKey4",tempKey4);
	sessionStorage.setItem("tempKey5",tempKey5);
	sessionStorage.setItem("tempKey6",tempKey6);
	sessionStorage.setItem("tempKey7",tempKey7);
	sessionStorage.setItem("tempKey8",tempKey8);
	
 	window.location.href="search_burn_custom.jsp?key1="+tempKey1+"&key2="+tempKey2+"&key3="+tempKey3+"&key4="+tempKey4+"&key5="+tempKey5+"&key6="+tempKey6+"&key7="+tempKey7+"&key8="+tempKey8;
// 	window.location.href="index.jsp";
	//<!--在点击搜索按钮的时候如果利用submit自动跳转，则jsp页获取的jixing仍为空-->
}

//<--!---------------------------切换语言函数------------------------------------>

//<!--切换为英文版-->
function switchToEng(){
	localStorage.setItem("language","EN");
}
//<!--切换为中文版-->
function switchToChz(){
	localStorage.setItem("language","CN");
}

//<--!---------------------------联系我们函数------------------------------------>
//<!--此处引用JS函数，美化过的alert提示框（需引用jquery-1.7.1.min.js和window.js）-->
function contact_us(){
			win.alert('联系我们', '制作单位：电器股份 工艺部电路室<br/>如有问题或建议请联系电路工艺人员<br/>谢谢!<br/>');
		}