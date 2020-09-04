<%@ page pageEncoding="UTF-8" %>
<%
	int pages=0;            //待显示页面
    int count=0;            //总条数
    int totalpages=0;        //总页数
    int limit=30;            //每页显示记录条数
	int searchType=0;
	String sql1 = "";
    String key1 = request.getParameter("key1");		//每次加载均从URL获取参数MP_MODEL_CODE
	String key2 = request.getParameter("key2");		//每次加载均从URL获取参数PLAN_NUM
	String key3 = request.getParameter("key3");		//每次加载均从URL获取参数ITEM_CODE
	String key4 = request.getParameter("key4");		//每次加载均从URL获取参数SOFTWARE_VER
	String key5 = request.getParameter("key5");		//每次加载均从URL获取参数CHIP_MODEL
	String key6 = request.getParameter("key6");		//每次加载均从URL获取参数CHIP_QTY
	String key7 = request.getParameter("key7");		//每次加载均从URL获取参数COUNTRIES
	String key8 = request.getParameter("key8");		//每次加载均从URL获取参数FACTORY_NAME
	
    String strPage = request.getParameter("pages");		//获取跳页时传进来的当前页面参数
	
	sql1="select count(*) from burninfo where MP_MODEL_CODE LIKE '%"+key1+"%' AND PLAN_NUM LIKE '%"+key2+"%' AND ITEM_CODE LIKE '%"+key3+"%' AND SOFTWARE_VER LIKE '%"+key4+"%' AND CHIP_MODEL LIKE '%"+key5+"%' AND CHIP_QTY LIKE '%"+key6+"%' AND COUNTRIES LIKE '%"+key7+"%' AND FACTORY_NAME LIKE '%"+key8+"%'";
	
	rs = stmt.executeQuery(sql1);
	
    
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
		
		rs = stmt.executeQuery("select * from burninfo where MP_MODEL_CODE LIKE '%"+key1+"%' AND PLAN_NUM LIKE '%"+key2+"%' AND ITEM_CODE LIKE '%"+key3+"%' AND SOFTWARE_VER LIKE '%"+key4+"%' AND CHIP_MODEL LIKE '%"+key5+"%' AND CHIP_QTY LIKE '%"+key6+"%' AND COUNTRIES LIKE '%"+key7+"%' AND FACTORY_NAME LIKE '%"+key8+"%' order by cpl_id limit " + (pages - 1) * limit + "," + limit);
		
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