package webService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @version: V2.0
 * @author: JiangTao
 * @className: getInfo
 * @packageName: webService
 * @description: ����WebService������PLMϵͳ���ø÷���������������͡�������Ϣ
 * @data: 2020-06-30
 **/
public class GetInfo {
	
	private Logger logger = LogManager.getLogger(LogManager.class.getName());
	/**
	* @methodsName: GetSoftInfo
	* @description: ��ȡ�����Ϣ
	* @param:  softInfo
	* @return: String
	* @throws: 
	*/
	public String GetSoftInfo(String softInfo) {
		logger.debug("�����Ϣ��" + softInfo);
		SaveInfo saveInfo = new SaveInfo();
		if(saveInfo.SaveSoftInfo(softInfo)) {
			return "Soft OK";
		}else {
			return "Soft NG";
		}
		/*String result = saveInfo.test(softData);
		return result;*/
	}
	
	/**
	* @methodsName: GetModelInfo
	* @description: ��ȡ������Ϣ
	* @param:  modelInfo
	* @return: String
	* @throws: 
	*/
	public String GetModelInfo(String modelInfo) {
		logger.debug("������Ϣ��" + modelInfo);
		SaveInfo saveInfo = new SaveInfo();
		if(saveInfo.SaveModelInfo(modelInfo)) {
			return "Model OK";
		}else {
			return "Model NG";
		}
	}
	
	/**
	* @methodsName: GetOrderInfo
	* @description: ��ȡ������Ϣ
	* @param:  orderInfo
	* @return: boolean
	* @throws: 
	*/
	public String GetOrderInfo(String orderInfo) {
		logger.debug("������Ϣ��" + orderInfo);
		SaveInfo saveInfo = new SaveInfo();
		if(saveInfo.SaveOrderInfo(orderInfo)) {
			return "Order OK";
		}else {
			return "Order NG";
		}
	}
	
	
}
