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
 * @description: ���ڽ����յ������ݴ洢���������ݿ�
 * @data: 2020-06-30
 **/
public class SaveInfo {

	private static final String DBDRIVER = "com.mysql.jdbc.Driver";		//����������					
	private static final String DBURL = "jdbc:mysql://localhost:3306/softinfomanage?useSSL=false";	//Ҫ���ʵ����ݿ���
	private static final String DBUSER = "jiang";	//MySQL����ʱ���û���
	private static final String DBPASSWORD = "1234";	//MySQL����ʱ������
	private Connection conn;
	private Statement stam;
	private PreparedStatement ps;
	private String sql = "";
	private SimpleDateFormat sdf;
	private Calendar cal;
	private Logger logger = LogManager.getLogger(LogManager.class.getName());
	
	//���캯������ʼ�����ݿ�����
	public SaveInfo() {
		sdf = new SimpleDateFormat("yyyy-MM-dd");
		cal = Calendar.getInstance();
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
			stam = conn.createStatement();
		} catch (ClassNotFoundException e) {
			logger.error("���ݿⶨ�����"+e.getMessage() +" \r\n");
		} catch(SQLException e) {
			logger.error("���ݿ����Ӵ���"+e.getMessage() +" \r\n");
		}
	}
	
	/******
	* @methodsName: SaveSoftInfo
	* @description: ���������Ϣ
	* @param: String
	* @return: boolean
	* @throws: 
	*/
	public boolean SaveSoftInfo(String softData) {
		
		String currentDate = sdf.format(cal.getTime());
		final int softInfoElementsCount = 13;	//�����Ϣ������Ԫ����
		
		//ԭʼ��Ϣ����
		if (softData.length()<100) {
			logger.debug("�����Ϣд��ʧ�ܣ����ݹ��̡�\r\n");
			return false;
		}else {
			String data1 = softData.replaceAll("name\":\"|,\"model\"|,\"project\"|,\"stage\"|,\"rev\"|,\"releaseNo\"|,\"revisionNumber\"|,\"reviewResult\"|,\"personName\"|,\"oldtext\"|,\"logo\"|,\"svn\"|,\"des\"", "");
			data1 = data1.replaceAll("\\[|\\{\"|\"\\}|\\]", "");		//ȥ����һ��[{"�����һ��"}],����\\��Ӱ��ʶ��
			
			String [] temp = new String[softInfoElementsCount];
			temp = data1.split("\":\"");			//����":"�ָ�������ݳ�Ԫ�ش���temp[]
			//�жϸ����ֶ��Ƿ񳬳��������ƣ���������ض�
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
			if(temp[8].contains("|"))		//ȥ��������е����һ���ַ�"|"
			{
				temp[8] = temp[8].substring(0, (temp[8].length()-1));
			}
			if(temp[9].length() > 1)		//ȥ���ɰ汾�ж����-�Լ��޹��ַ�
			{
				temp[9] = temp[9].replaceAll("[^\\u4e00-\\u9fa5]","");
			}else {
				temp[9] = "-";
			}
			
			
			// д�����ݿ�
			try {
				//�Ȳ�ѯ���°沢д��ɰ汾���
				sql = "update softinfo set old=? where id=?";
				ps = conn.prepareStatement(sql);
				int oldId = GetOldID(temp[0]);			//��ѯ��һ����������
				ps.setString(1, temp[9]);		//д��ɰ汾���
				ps.setInt(2, oldId);
				ps.executeUpdate();
				temp[9]="";
				
				//Ȼ��д������11������
				sql = "insert into softinfo (name,model,project,stage,PLMrevision,releaseNo,revisionNo,result,designer,old,logo,svn,description,date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				for (int i=0; i<softInfoElementsCount; i++) {		//�ɰ汾���Ϊ""
					ps.setString(i+1, temp[i]);
				}
				ps.setString(14,currentDate);
				ps.executeUpdate();
				
				CloseMySQL();
				logger.debug("�����Ϣд��ɹ� \r\n");
				System.out.println();
				return true;
			} catch (SQLException e) {
				logger.error("�����Ϣд��ʧ�ܣ�" + e.getMessage()+"\r\n");
				e.printStackTrace();
				return false;
			}
		}
	}
	
	/******
	* @methodsName: SaveModelInfo
	* @description: ���������Ϣ
	* @param: String
	* @return: boolean
	* @throws: 
	*/
	public boolean SaveModelInfo(String modelData) {
		String currentDate = sdf.format(cal.getTime());

		if (modelData.length()<80) {
			logger.debug("������Ϣд��ʧ�ܣ����ݹ��̡� \r\n");
			return false;
		}else {
			String data = modelData;
			String[] dataArray = new String[2];		//��Ϊ������Ϣ�͹��ص������Ϣ������
			String dataModel;
			String dataSoft;
			String[] dataModelArrayItems = new String[4];	//��Ϊname��revision��des��sHSRelationProductModel �ĸ��ֶ�
			String[] dataSoftArrayItems = new String[9];	//�����ȡ3�������Ϣ��ÿ������3���ֶ�
			String[] dataArrayItems = new String[13];		//����
			
			data = data.substring(2,modelData.length()-2);		//ȥ��ǰ��[{ }]
			dataArray = data.split("\",\"Soft\":");			//���� ","Soft": ����
			dataModel = dataArray[0].replaceAll("\"name\":\"|,\"revision\"|,\"des\"|,\"sHSRelationProductModel\"", "");
			dataModelArrayItems = dataModel.split("\":\"");				//���� ":" ����
			for(int i=0; i< 4; i++) {
				dataArrayItems[i] = dataModelArrayItems[i];		//����
			}
			
			dataSoft = dataArray[1];
			if(dataSoft.length() > 30) {
				dataSoft = dataSoft.substring(2, dataSoft.length()-3);		//ȥ��ǰ��[{ "}]
				dataSoft = dataSoft.replaceAll("\"sName\":\"|,\"sCurrent\"|,\"sDes\"", "");
				String[] dataSoftArray = dataSoft.split("\"},\\{");			//���� "},{ ����
				for(int i =0; i< dataSoftArray.length; i++) {
					String[] dataSoftArrayTemp = dataSoftArray[i].split("\":\"");
					dataSoftArrayItems[i*3 +0] = dataSoftArrayTemp[0];
					dataSoftArrayItems[i*3 +1] = dataSoftArrayTemp[1];
					dataSoftArrayItems[i*3 +2] = dataSoftArrayTemp[2];
					if(i==2) break;
				}
			}
			for(int i=0; i<9; i++) {
				dataArrayItems[i+4] = dataSoftArrayItems[i];	//����
			}
			
			// д�����ݿ�
			try {
				sql = "insert into modelinfo (name,PLMrevision,description,model,softName1,softResult1,softDescription1,softName2,softResult2,softDescription2,softName3,softResult3,softDescription3,date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				for (int i=0; i<13; i++) {
					ps.setString(i+1, dataArrayItems[i]);
				}
				ps.setString(14,currentDate);
				ps.executeUpdate();
				
				CloseMySQL();
				logger.debug("������Ϣд��ɹ� \r\n");
				System.out.println();
				return true;
			} catch (SQLException e) {
				logger.error("������Ϣд��ʧ�ܣ�" + e.getMessage() +" \r\n");
				e.printStackTrace();
				return false;
			}
		}
	}
	
	
	/******
	* @methodsName: SaveOrderInfo
	* @description: ���涩����Ϣ
	* @param:  String
	* @return: void
	* @throws: 
	*/
	public boolean SaveOrderInfo(String orderData) {

		String currentDate = sdf.format(cal.getTime());
		final int orderInfoElementsCount = 24;	//������Ϣ������Ԫ����
		
		//ԭʼ��Ϣ����
		if (orderData.length()<100) {
			logger.debug("������Ϣд��ʧ�ܣ����ݹ��̡� \r\n");
			return false;
		}else {
			String data1 = orderData.replaceAll("name\":\"|,\"revision\"|,\"des\"|,\"sHSRelationProductModel\"|,\"sHSExportModelNo\"|,\"sHSRollingPlanNo\"|,\"sHSBrand\"|,\"sHSExportMode\"|,\"sHSPlannedVolume\"|,\"sHSOrderEngineer\"|,\"sHSCircuitDesigner\"|,\"sHSStructureDesigner\"|,\"sHSSoftwareDesigner\"|,\"sHSPowerDesigner\"|,\"sHSElectronicTechnologist\"|,\"sHSMechanicalTechnologist\"|,\"sHSInternationalSaleManager\"|,\"sHSFactory\"|,\"sHSExportArea\"|,\"sHSInterfaceCountry\"|,\"sHSInterfaceLanguage\"|,\"sHSInterfaceLogo\"|,\"sHSInterfaceProjectID\"|,\"sRiskOrder\"", "");
			//data1 = data1.replaceAll("\"\"\\}", "\"-\"\\}");
			data1 = data1.replaceAll("\\[\\{\"|\"\\}\\]", "");		//ȥ����һ��[{"�����һ��"}],����\��Ӱ��ʶ��
			
			String [] dataArrayItems = new String[orderInfoElementsCount];
			dataArrayItems = data1.split("\":\"");			//����":"�ָ�������ݳ�Ԫ��
			
			try {
				//д��24������
				sql = "insert into orderinfo (name,PLMrevision,description,model,exmodel,rollplan,brand,exmode,quantity,orderengineer,circuitdesigner,structuredesigner,softwaredesigner,powerdesigner,electronictechnologist,mechanicaltechnologist,salemanager,factory,exportArea,country,language,logo,projectid,riskOrder,date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(sql);
				for (int i = 0; i<orderInfoElementsCount; i++) {
					ps.setString(i+1, dataArrayItems[i]);
				}
				ps.setString(orderInfoElementsCount+1, currentDate);
				ps.executeUpdate();
				
				//�ر�
				CloseMySQL();
				logger.debug("������Ϣд��ɹ� \r\n");
				return true;
			} catch (SQLException e) {
				logger.error("������Ϣд��ʧ�ܣ�" + e.getMessage() +" \r\n");
				e.printStackTrace();
				return false;
			}
		}
		
		
	}
	

	/******
	* @methodsName: getOldID
	* @description: �������������һ�汾�����к�
	* @param:  
	* @return: id�����ݿ��ж�Ӧ��¼����ţ�
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
			logger.debug("����ɰ汾ID�ǣ�"+id);
			rs.close();
			return id;
		} catch (SQLException e) {
			logger.error("��ѯ�ɰ汾IDʧ�ܣ�" + e.getMessage() +" \r\n");
			e.printStackTrace();
			return -1;
		}
		
	}

	/******
	* @methodsName: CloseMySQL
	* @description: �ر�MySQL����
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
			logger.error("�ر�MySQL����ʧ�ܣ�" + e.getMessage() +" \r\ns");
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
			System.out.println("����д��ɹ�");
			return "OK";
		} catch (SQLException e) {
			System.out.println("����д�����");
			e.printStackTrace();
			return "������";
		}
		
	}

	
}
