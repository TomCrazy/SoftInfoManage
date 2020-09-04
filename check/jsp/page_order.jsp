<%@ page pageEncoding="UTF-8" %>
<%
	int pages=0;            //待显示页面
    int count=0;            //总条数
    int totalpages=0;        //总页数
    int limit=3;            //每页显示记录条数
	int searchType=0;
    String order = request.getParameter("order");		//每次加载均从URL获取order参数
    String strPage = request.getParameter("pages");		//获取跳页时传进来的当前页面参数
	String hitcount = request.getParameter("count");	//获取点击量参数
	
	if(hitcount != null){
		int temphit = 1;
		String temp = (String) application.getAttribute("hitcount");
		if(temp != null)
			temphit = Integer.parseInt(temp)+1;
		application.setAttribute("hitcount", String.valueOf(temphit));
	}

    if((order==null)||(order=="")){					//注意=和==;注意null和"null"
	    rs = stmt.executeQuery("select count(*) from orderinfo");}
    else{
		searchType = java.lang.Integer.parseInt(order.substring(order.length()-1));	//判断order最后是1还是2
		order = order.substring(0,order.length()-1).trim();							//去掉1/2和前后空格
		order = order.replace("（","(");												//替换中文括号
		order = order.replace("）",")");
		
		if(searchType==1){
			rs = stmt.executeQuery("select count(*) from orderinfo where rollplan LIKE '%" +order+ "%' OR name LIKE '%" +order+ "%'");
		}
		else if(searchType==2){
			rs = stmt.executeQuery("select count(*) from orderinfo where rollplan LIKE '" +order+ "' OR name LIKE '" +order+ "'");
		}
		else{
			rs = stmt.executeQuery("select count(*) from orderinfo");
			out.print("<script>alert('错误');</script>");
		}
	}
		
    if(rs.next()){									//获取数据总条数
        count = rs.getInt(1);						//结果为count(*)表，只有一行。通过列的下标索引1来获取值
    }
    
    totalpages = (int)Math.ceil(count/(limit*1.0));	//计算总页数
    if(totalpages<1){totalpages=1;}
    
    //判断当前页面参数的合法性并处理非法页号
    if (strPage == null) { 							//首次加载，尚无pages参数传递
        pages = totalpages;
    } else {
        try{
            pages = java.lang.Integer.parseInt(strPage);
        }catch(Exception e){
            pages = 1;
        }
        
        if (pages < 1){
            pages = 1;
        }
        
        if (pages > totalpages){
            pages = totalpages;
        }
    }
	if(count<1){
		out.print("<tr><td colspan='10' style='color:midnightblue;font-size:16px'>无结果</td></tr>");
	}else{
		//由(pages-1)*limit算出当前页面第一条记录，由limit查询limit条记录。则得出当前页面的记录
		if((order==null)||(order=="")){
			rs = stmt.executeQuery("select * from orderinfo order by id limit " + (pages - 1) * limit + "," + limit);}
		else{
			if(searchType==1){
				rs = stmt.executeQuery("select * from orderinfo where rollplan LIKE '%"+order+"%' OR name LIKE '%" +order+ "%' order by id limit " + (pages - 1) * limit + "," + limit);
			}
			else if(searchType==2){
					rs = stmt.executeQuery("select * from orderinfo where rollplan LIKE '"+order+"' OR name LIKE '" +order+ "' order by id limit " + (pages - 1) * limit + "," + limit);
			}
			else{
				rs = stmt.executeQuery("select * from orderinfo");
				out.print("<script>alert('错误');</script>");
			}
		}
		while (rs.next()){
%>

<%!	//翻译函数定义
	public String trans_oldversion(String old){
		String trans_old = old;
		if(old.contains("全部使用")&&old.length()<6){
			trans_old = "AllUse";
		}else if(old.contains("作废")||old.contains("废弃")||old.contains("不能使用")&&old.length()<6){
			trans_old = "abandon";
		}
		return trans_old;
	}
	
	public String trans_stage(String stage){
		String trans_stage = stage;
		if(stage.contains("量产")){
			trans_stage = "MP";
		}else if(stage.contains("设计性")){
			trans_stage = "DR";
		}else if(stage.contains("工艺性")){
			trans_stage = "IR";
		}else if(stage.contains("样机")){
			trans_stage = "Prototype";
		}
		return trans_stage;
	}
	
	public String trans_version(String version){
		String trans_version = version;
		if(version.contains("预发放")){
			trans_version = "Pre-Release";
		}else if(version.contains("联系书")){
			trans_version = "refer to the Contact Sheet";
		}
		return trans_version;
	}
	
	public String ifHasLink(String link){
		String ifHasLink = "";
		if(link != null){
			if(link.length()<10){
				ifHasLink = "暂无";
			}else{
				ifHasLink = "下载地址";
			}
		}
		return ifHasLink;
	}
	
	public String trans_ifHasLink(String link){
		String ifHasLink = "";
		if(link != null){
			if(link.length()<10){
				ifHasLink = "not exist";
			}else{
				ifHasLink = "Download";
			}
		}
		return ifHasLink;
	}
	
	public String ifHasLogo(String logo){
		String ifHasLogo = "";
		if(logo != null){
			ifHasLogo = logo;
		}
		return ifHasLogo;
	}
%>