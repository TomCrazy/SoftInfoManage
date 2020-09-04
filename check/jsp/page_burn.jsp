<%@ page pageEncoding="UTF-8" %>
<%
	int pages=0;            //待显示页面
    int count=0;            //总条数
    int totalpages=0;        //总页数
    int limit=20;            //每页显示记录条数
	int searchType=0;
    String bom = request.getParameter("bom");		//每次加载均从URL获取bom参数
	String plan = request.getParameter("plan");			//每次加载均从URL获取plan参数
    String strPage = request.getParameter("pages");		//获取跳页时传进来的当前页面参数

	if((bom==null)||(bom=="")){					//注意=和==;注意null和"null"
	    rs = stmt.executeQuery("select count(*) from burninfo");
	}else{
		rs = stmt.executeQuery("select count(*) from burninfo where plan_num LIKE '%"+bom+"%' OR plan_num LIKE '%"+plan+"%'");
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
		out.print("<tr><td colspan='30' style='color:midnightblue;font-size:16px'>无结果</td></tr>");
	}else{
		//由(pages-1)*limit算出当前页面第一条记录，由limit查询limit条记录。则得出当前页面的记录
		if((bom==null)||(plan=="")){
			rs = stmt.executeQuery("select * from burninfo order by cpl_id limit " + (pages - 1) * limit + "," + limit);}
		else{
			rs = stmt.executeQuery("select * from burninfo where plan_num LIKE '%"+bom+"%' OR plan_num LIKE '%"+plan+"%' order by cpl_id limit " + (pages - 1) * limit + "," + limit);
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
%>