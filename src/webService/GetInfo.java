package webService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @version: V2.0
 * @author: JiangTao
 * @className: getInfo
 * @packageName: webService
 * @description: 定义WebService方法，PLM系统调用该方法传递软件、机型、订单信息
 * @data: 2020-06-30
 **/
public class GetInfo {
	
	private Logger logger = LogManager.getLogger(LogManager.class.getName());
	/**
	* @methodsName: GetSoftInfo
	* @description: 获取软件信息
	* @param:  softInfo
	* @return: String
	* @throws: 
	*/
	public String GetSoftInfo(String softInfo) {
		logger.debug("软件信息：" + softInfo);
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
	* @description: 获取机型信息
	* @param:  modelInfo
	* @return: String
	* @throws: 
	*/
	public String GetModelInfo(String modelInfo) {
		logger.debug("机型信息：" + modelInfo);
		SaveInfo saveInfo = new SaveInfo();
		if(saveInfo.SaveModelInfo(modelInfo)) {
			return "Model OK";
		}else {
			return "Model NG";
		}
	}
	
	/**
	* @methodsName: GetOrderInfo
	* @description: 获取订单信息
	* @param:  orderInfo
	* @return: boolean
	* @throws: 
	*/
	public String GetOrderInfo(String orderInfo) {
		logger.debug("订单信息：" + orderInfo);
		SaveInfo saveInfo = new SaveInfo();
		if(saveInfo.SaveOrderInfo(orderInfo)) {
			return "Order OK";
		}else {
			return "Order NG";
		}
	}
	
	
}
