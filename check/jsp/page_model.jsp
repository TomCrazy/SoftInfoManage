<%@ page pageEncoding="UTF-8" %>
<%
	int pages=0;            //待显示页面
    int count=0;            //总条数
    int totalpages=0;        //总页数
    int limit=20;            //每页显示记录条数
	int searchType=0;
    String jixing = request.getParameter("jixing");		//每次加载均从URL获取jixing参数
    String strPage = request.getParameter("pages");		//获取跳页时传进来的当前页面参数
	String hitcount = request.getParameter("count");	//获取点击量参数
	
	if(hitcount != null){
		int temphit = 1;
		String temp = (String) application.getAttribute("hitcount");
		if(temp != null)
			temphit = Integer.parseInt(temp)+1;
		application.setAttribute("hitcount", String.valueOf(temphit));
	}
	
    if((jixing==null)||(jixing=="")){					//注意=和==;注意null和"null"
	    rs = stmt.executeQuery("select count(*) from softinfo");
    }else{
		searchType = java.lang.Integer.parseInt(jixing.substring(jixing.length()-1));	//判断jixing最后是1还是2
		jixing = jixing.substring(0,jixing.length()-1).trim();							//去掉1/2和前后空格
		jixing = jixing.replace("（","(");												//替换中文括号
		jixing = jixing.replace("）",")");
		
		if(searchType==1){
			rs = stmt.executeQuery("select count(*) from softinfo where model LIKE '%"+jixing+"%'");
		}
		else if(searchType==2){
			rs = stmt.executeQuery("select count(*) from softinfo where model LIKE '" +jixing+ "'");
		}
		else if(searchType==3){
			rs = stmt.executeQuery("select count(*) from softinfo where project LIKE '%"+jixing+"%'");
		}
		else{
			rs = stmt.executeQuery("select count(*) from softinfo");
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
		out.print("<tr><td colspan='30' style='color:midnightblue;font-size:18px'>无结果 &nbsp&nbsp&nbsp&nbsp No Results</td></tr>");
	}else{
		//由(pages-1)*limit算出当前页面第一条记录，由limit查询limit条记录。则得出当前页面的记录
		if((jixing==null)||(jixing=="")){
			rs = stmt.executeQuery("select * from softinfo order by id limit " + (pages - 1) * limit + "," + limit);}
		else{
			if(searchType==1){
				rs = stmt.executeQuery("select * from softinfo where model LIKE '%"+jixing+"%' order by id limit " + (pages - 1) * limit + "," + limit);
			}
			else if(searchType==2){
				rs = stmt.executeQuery("select * from softinfo where model LIKE '"+jixing+"' order by id limit " + (pages - 1) * limit + "," + limit);
			}
			else if(searchType==3){
				rs = stmt.executeQuery("select * from softinfo where project LIKE '%"+jixing+"%' order by id limit " + (pages - 1) * limit + "," + limit);
			}
			else{
				rs = stmt.executeQuery("select * from softinfo");
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
	
	public String ifHasLogo(String logo){
		String ifHasLogo = "";
		if(logo != null){
			ifHasLogo = logo;
		}
		return ifHasLogo;
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

%>