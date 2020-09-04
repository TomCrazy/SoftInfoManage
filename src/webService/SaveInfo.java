package webService;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/********
 * @version: V2.0
 * @author: JiangTao
 * @className: SaveInfo
 * @packageName: webService
 * @description: 用于将接收到的数据存储至本地数据库
 * @data: 2020-06-30
 **/
public class SaveInfo {

	private static final String DBDRIVER = "com.mysql.jdbc.Driver";		//驱动程序名					
	private static final String DBURL = "jdbc:mysql://localhost:3306/softinfomanage?useSSL=false";	//要访问的数据库名
	private static final String DBUSER = "jiang";	//MySQL配置时的用户名
	private static final String DBPASSWORD = "1234";	//MySQL配置时的密码
	private Connection conn;
	private Statement stam;
	private PreparedStatement ps;
	private String sql = "";
	private SimpleDateFormat sdf;
	private Calendar cal;
	private Logger logger = LogManager.getLogger(LogManager.class.getName());
	
	//构造函数，初始化数据库连接
	public SaveInfo() {
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		cal = Calendar.getInstance();
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
			stam = conn.createStatement();
		} catch (ClassNotFoundException e) {
			logger.error("数据库定义错误："+e.getMessage() +" \r\n");
		} catch(SQLException e) {
			logger.error("数据库连接错误："+e.getMessage() +" \r\n");
		}
	}
	
	/******
	* @methodsName: SaveSoftInfo
	* @description: 保存软件信息
	* @param: String
	* @return: boolean
	* @throws: 
	*/
	public boolean SaveSoftInfo(String softData) {
		
		String currentDate = sdf.format(cal.getTime());
		final int softInfoElementsCount = 13;	//软件信息包含的元素数
		
		//原始信息处理
		if (softData.length()<100) {
			logger.debug("软件信息写入失败：数据过短。\r\n");
			return false;
		}else {
			String data1 = softData.replaceAll("name\":\"|,\"model\"|,\"project\"|,\"stage\"|,\"rev\"|,\"releaseNo\"|,\"revisionNumber\"|,\"reviewResult\"|,\"personName\"|,\"oldtext\"|,\"logo\"|,\"svn\"|,\"des\"", "");
			data1 = data1.replaceAll("\\[|\\{\"|\"\\}|\\]", "");		//去除第一个[{"和最后一个"}],不加\\会影响识别
			
			String [] temp = new String[softInfoElementsCount];
			temp = data1.split("\":\"");			//根据":"分割各条数据成元素存至temp[]
			//判断各个字段是否超出长度限制，若超出则截短
			if(temp[0].length() > 10)	//name
			{
				temp[0] = temp[0].substring(0, 9);
			}
			if(temp[3].length() > 20)	//stage
			{
				temp[3] = temp[3].substring(0, 19);
			}
			if(temp[4].length() > 10) 	//rev
			{
				temp[4] = temp[4].substring(0, 9);
			}
			if(temp[5].length() > 10)	//releaseNo
			{
				temp[5] = temp[5].substring(0, 9);
			}
			if(temp[7].length() > 20)	//reviewResult
			{
				temp[7] = temp[7].substring(0, 19);
			}
			if(temp[10].length() > 30)	//logo
			{
				temp[10] = temp[10].substring(0, 29);
			}
			if(temp[8].contains("|"))		//去掉主设计中的最后一个字符"|"
			{
				temp[8] = temp[8].substring(0, (temp[8].length()-1));
			}
			if(temp[9].length() > 1)		//去掉旧版本中多余的-以及无关字符
			{
				temp[9] = temp[9].replaceAll("[^\\u4e00-\\u9fa5]","");
			}else {
				temp[9] = "-";
			}
			
			
			// 写入数据库
			try {
				//先查询次新版并写入旧版本意见
				sql = "update softinfo set old=? where id=?";
				ps = conn.prepareStatement(sql);
				int oldId = GetOldID(temp[0]);			//查询上一版软件的序号
				ps.setString(1, temp[9]);		//写入旧版本意见
				ps.setInt(2, oldId);
				ps.executeUpdate();
				temp[9]="";
				
				//然后写入其他11项数据
				sql = "insert into softinfo (name,model,project,stage,PLMrevision,releaseNo,revisionNo,result,designer,old,logo,svn,description,date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				for (int i=0; i<softInfoElementsCount; i++) {		//旧版本意见为""
					ps.setString(i+1, temp[i]);
				}
				ps.setString(14,currentDate);
				ps.executeUpdate();
				
				CloseMySQL();
				logger.debug("软件信息写入成功 \r\n");
				System.out.println();
				return true;
			} catch (SQLException e) {
				logger.error("软件信息写入失败：" + e.getMessage()+"\r\n");
				e.printStackTrace();
				return false;
			}
		}
	}
	
	/******
	* @methodsName: SaveModelInfo
	* @description: 保存机型信息
	* @param: String
	* @return: boolean
	* @throws: 
	*/
	public boolean SaveModelInfo(String modelData) {
		String currentDate = sdf.format(cal.getTime());

		if (modelData.length()<80) {
			logger.debug("机型信息写入失败：数据过短。 \r\n");
			return false;
		}else {
			String data = modelData;
			String[] dataArray = new String[2];		//分为机型信息和挂载的软件信息两部分
			String dataModel;
			String dataSoft;
			String[] dataModelArrayItems = new String[4];	//分为name、revision、des、sHSRelationProductModel 四个字段
			String[] dataSoftArrayItems = new String[9];	//最多收取3条软件信息，每条包含3个字段
			String[] dataArrayItems = new String[13];		//汇总
			
			data = data.substring(2,modelData.length()-2);		//去掉前后[{ }]
			dataArray = data.split("\",\"Soft\":");			//根据 ","Soft": 分组
			dataModel = dataArray[0].replaceAll("\"name\":\"|,\"revision\"|,\"des\"|,\"sHSRelationProductModel\"", "");
			dataModelArrayItems = dataModel.split("\":\"");				//根据 ":" 分组
			for(int i=0; i< 4; i++) {
				dataArrayItems[i] = dataModelArrayItems[i];		//汇总
			}
			
			dataSoft = dataArray[1];
			if(dataSoft.length() > 30) {
				dataSoft = dataSoft.substring(2, dataSoft.length()-3);		//去掉前后[{ "}]
				dataSoft = dataSoft.replaceAll("\"sName\":\"|,\"sCurrent\"|,\"sDes\"", "");
				String[] dataSoftArray = dataSoft.split("\"},\\{");			//根据 "},{ 分组
				for(int i =0; i< dataSoftArray.length; i++) {
					String[] dataSoftArrayTemp = dataSoftArray[i].split("\":\"");
					dataSoftArrayItems[i*3 +0] = dataSoftArrayTemp[0];
					dataSoftArrayItems[i*3 +1] = dataSoftArrayTemp[1];
					dataSoftArrayItems[i*3 +2] = dataSoftArrayTemp[2];
					if(i==2) break;
				}
			}
			for(int i=0; i<9; i++) {
				dataArrayItems[i+4] = dataSoftArrayItems[i];	//汇总
			}
			
			// 写入数据库
			try {
				sql = "insert into modelinfo (name,PLMrevision,description,model,softName1,softResult1,softDescription1,softName2,softResult2,softDescription2,softName3,softResult3,softDescription3,date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				for (int i=0; i<13; i++) {
					ps.setString(i+1, dataArrayItems[i]);
				}
				ps.setString(14,currentDate);
				ps.executeUpdate();
				
				CloseMySQL();
				logger.debug("机型信息写入成功 \r\n");
				System.out.println();
				return true;
			} catch (SQLException e) {
				logger.error("机型信息写入失败：" + e.getMessage() +" \r\n");
				e.printStackTrace();
				return false;
			}
		}
	}
	
	
	/******
	* @methodsName: SaveOrderInfo
	* @description: 保存订单信息
	* @param:  String
	* @return: void
	* @throws: 
	*/
	public boolean SaveOrderInfo(String orderData) {

		String currentDate = sdf.format(cal.getTime());
		final int orderInfoElementsCount = 24;	//订单信息包含的元素数
		
		//原始信息处理
		if (orderData.length()<100) {
			logger.debug("订单信息写入失败：数据过短。 \r\n");
			return false;
		}else {
			String data1 = orderData.replaceAll("name\":\"|,\"revision\"|,\"des\"|,\"sHSRelationProductModel\"|,\"sHSExportModelNo\"|,\"sHSRollingPlanNo\"|,\"sHSBrand\"|,\"sHSExportMode\"|,\"sHSPlannedVolume\"|,\"sHSOrderEngineer\"|,\"sHSCircuitDesigner\"|,\"sHSStructureDesigner\"|,\"sHSSoftwareDesigner\"|,\"sHSPowerDesigner\"|,\"sHSElectronicTechnologist\"|,\"sHSMechanicalTechnologist\"|,\"sHSInternationalSaleManager\"|,\"sHSFactory\"|,\"sHSExportArea\"|,\"sHSInterfaceCountry\"|,\"sHSInterfaceLanguage\"|,\"sHSInterfaceLogo\"|,\"sHSInterfaceProjectID\"|,\"sRiskOrder\"", "");
			//data1 = data1.replaceAll("\"\"\\}", "\"-\"\\}");
			data1 = data1.replaceAll("\\[\\{\"|\"\\}\\]", "");		//去除第一个[{"和最后一个"}],不加\会影响识别
			
			String [] dataArrayItems = new String[orderInfoElementsCount];
			dataArrayItems = data1.split("\":\"");			//根据":"分割各条数据成元素
			
			try {
				//写入24项数据
				sql = "insert into orderinfo (name,PLMrevision,description,model,exmodel,rollplan,brand,exmode,quantity,orderengineer,circuitdesigner,structuredesigner,softwaredesigner,powerdesigner,electronictechnologist,mechanicaltechnologist,salemanager,factory,exportArea,country,language,logo,projectid,riskOrder,date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				for (int i = 0; i<orderInfoElementsCount; i++) {
					ps.setString(i+1, dataArrayItems[i]);
				}
				ps.setString(orderInfoElementsCount+1, currentDate);
				ps.executeUpdate();
				
				//关闭
				CloseMySQL();
				logger.debug("订单信息写入成功 \r\n");
				return true;
			} catch (SQLException e) {
				logger.error("订单信息写入失败：" + e.getMessage() +" \r\n");
				e.printStackTrace();
				return false;
			}
		}
		
		
	}
	

	/******
	* @methodsName: getOldID
	* @description: 搜索该软件的上一版本的序列号
	* @param:  
	* @return: id（数据库中对应记录的序号）
	* @throws: SQLException
	*/
	public int GetOldID(String name){
		try {
			int id = 0;
			String sql = "select id from softinfo where name='"+ name +"' order by PLMrevision DESC limit 1";
			ResultSet rs = stam.executeQuery(sql);
			if(rs.next()) {
				id = rs.getInt("id");
			}
			logger.debug("软件旧版本ID是："+id);
			rs.close();
			return id;
		} catch (SQLException e) {
			logger.error("查询旧版本ID失败：" + e.getMessage() +" \r\n");
			e.printStackTrace();
			return -1;
		}
		
	}

	/******
	* @methodsName: CloseMySQL
	* @description: 关闭MySQL对象
	* @param: None
	* @return: void
	* @throws SQLException 
	*/
	private void CloseMySQL(){
		try {
			if(conn != null) {
				conn.close();
			}
			if(stam != null) {
				stam.close();
			}
			if(ps != null) {
				ps.close();
			}
		} catch (SQLException e) {
			logger.error("关闭MySQL连接失败：" + e.getMessage() +" \r\ns");
			e.printStackTrace();
		}
		
		
	}
	

	public String test(String data) {
		try {
			sql = "insert into test1 (testData,currentDate) values(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,data);
			ps.setString(2,"2020.06.08");
			ps.executeUpdate();
			System.out.println("数据写入成功");
			return "OK";
		} catch (SQLException e) {
			System.out.println("数据写入出错");
			e.printStackTrace();
			return "错错错错错";
		}
		
	}

	
}
