<%@ page pageEncoding="UTF-8" %>

<%
	int totalvisit = 0;
	int totalhit = 0;
	rs = stmt.executeQuery("select * from counts") ;
	if(rs.next()){
		totalvisit = rs.getInt(2);
		totalhit = rs.getInt(3);
	}

    int tempvisit = 0;
    String temp = (String) application.getAttribute("visitcount");
    if (temp != null)
        tempvisit = Integer.parseInt(temp);
    if (session.isNew()) {
		++tempvisit;
	}
	totalvisit += tempvisit;
	
	if(tempvisit>=100){
		stmt.executeUpdate("update counts set visitCount='"+totalvisit+"' where id=1");
		tempvisit = 0;
	}
	application.setAttribute("visitcount", String.valueOf(tempvisit));
	
	
	
	int temphit = 0;
	temp = (String) application.getAttribute("hitcount");
	if(temp != null)
		temphit = Integer.parseInt(temp);
	totalhit += temphit;
	if(temphit>=100){
		stmt.executeUpdate("update counts set hitCount='"+totalhit+"' where id=1");
		temphit = 0;
		application.setAttribute("hitcount",String.valueOf(temphit));
	}
	
    //out.print("访问量:" + totalvisit + "次");
    //out.print("查询量:" + totalhit + "次");
	
%>