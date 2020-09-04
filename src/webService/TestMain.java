package webService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class TestMain {

	public static void main(String[] args) throws IOException {
		GetInfo getInfo = new GetInfo();
		//String data = "[{\"name\":\"63933\",\"model\":\"HZ55E3D-M(2023)\",\"project\":\"MT9632\",\"stage\":\"量产\",\"rev\":\"C\",\"releaseNo\":\"C003\",\"revisionNumber\":\"K0304\",\"reviewResult\":\"正常发布\",\"personName\":\"辛化东|刘liuqingyou|\",\"oldtext\":\"全部使用\",\"logo\":\"Hisense\",\"svn\":\"http://dmtsvn2.hisense.com:8000/Factory/MSD668/HZ55E3D-M(2023)/HZ55E3D-M(2023)_Hisense_C003\"}]";
		//getInfo.GetSoftInfo(data);
		
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in ));
		
		//for(int i=1; i<=100;i++) {
			String softData = br.readLine();
			getInfo.GetSoftInfo(softData);
		//}
	}
	

}
