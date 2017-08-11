/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 *                     
 */

import lrapi.lr;
import lrapi.web;
import test.*;

public class Actions
{
	String[] s;
	public int init() throws Throwable {
            lr.save_string("192.168.139.206","BLCIP");
	    lr.save_string("192.168.139.207","IPCSIMIP");
	    // IPC Online
	    simuStartALL();
	    //lr.think_time(2);
	    // APP Login
	    signinRequest();			// SS001	# sign in to b mode
	    s = login2BRequest();		// HU006	# login to cloud
	    uploadTokenRequest(s);		// AE003	# upload token
	    serverInfoRequest(s);		// AU022	# APP请求获取P2P/UPNP/STUN/指令中心信息
	    return 0;
	}//end of init


	public int action() throws Throwable {
	    String fwv,code,updates;
	    /*
             * fwv = getFWInfoRequest(s);    	// FW001	# APP用户向云端请求获得IPC设备当前固件信息及云端最新的IPC设备固件信息的请求
             * code = updateFWRequest(fwv,s);  	// FW002	# APP用户向云端发送请求IPC设备更新固件的请求
	     * checkProgressRequest(s);		// FW004	# APP向云端查询IPC设备固件升级的状态及进度
	     */
	    fwv = getFWInfoRequest(s);
	    if (updateFWRequest(fwv,s).equals("0")) {
		updates = checkProgressRequest(s);
		checkUpdateStatus(updates);
		//return 0;
	    }
	    //else if (updateFWRequest(fwv,s).equals("1")) {
		//return 0;
	    //}
	    return 0;
	}//end of action

	public int end() throws Throwable {
	    //lr.think_time(10);
	    simuStopALL();
	    return 0;
	}//end of end

	public void checkUpdateStatus(String us){
		//if (us.equals("0") ||us.equals("1")) {
		//    return 0;
		//}
		if (us.equals("2")) {
		    String str = checkProgressRequest(s);
		    checkUpdateStatus(str);
		}
		//return 0;
	    }

        private String getFWInfoRequest(String[] s){
	    String xmlBody,code,fw;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/system/fwInfo.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<fwInfo version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n</fwInfo>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("FW001");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.reg_save_param("fwver",new String[]{"LB=<fwLatestVersion>","RB=</fwLatestVersion>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,qId=<qid>,response=<resp>");//digest 
		web.custom_request("fwInfo.app_request",
    		"Method=<method>",
		new String[]{
		    "URL=http://<BLCIP>:8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("FW001",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    fw = lr.eval_string("<fwver>");
	    if (code.equals("0")) {
		if (fw == null) {
		    lr.end_transaction("FW001",lr.FAIL);
		    lr.error_message("Error: fwLatesVersion is not available.");
		    return null;
		}
		
		else{
		    lr.end_transaction("FW001",lr.PASS);
		    lr.output_message("Success code:" + code);
		    System.out.println(fw);
		    return fw;
		}
	    }
	    else{
		lr.end_transaction("FW001",lr.FAIL);
                lr.error_message("Error Code:" + code);
		return null;
	    }
	}//FW001(POST)

        private String updateFWRequest(String fwv,String[] s){
	    String xmlBody,code;
	    lr.save_string(fwv,"fwver");
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/system/updateFw.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<requestFwUpdate version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
                    + "\r\n<fwLatestVersion><fwver></fwLatestVersion>"
		    + "\r\n</requestFwUpdate>\r\n";
	
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("FW002");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,qId=<qid>,response=<resp>");//digest 
		web.custom_request("fwInfo.app_request",
		"Method=<method>",
		new String[]{
		    "URL=http://<BLCIP>:8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }catch (Exception e) {
		lr.end_transaction("FW002",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("FW002",lr.PASS);
		lr.output_message("Success code:" + code);
		return code;
	    }
	    else{
		lr.end_transaction("FW002",lr.FAIL);
		lr.error_message("Error Code:" + code);
		return null;
	    }
	}//FW002(POST)

        private String checkProgressRequest(String[] s){
	    lr.think_time(2);
	    String xmlBody,code,per,us;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/system/updateFw/progress.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<fwUpdateStatus version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n</fwUpdateStatus>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("FW004");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		//web.reg_save_param("percent",new String[]{"LB=<downloadPercentage>","RB=</downloadPercentage>","LAST"});
		web.reg_save_param("updatestatus",new String[]{"LB=<updateSuccess>","RB=</updateSuccess>","LAST"});//0为成功、1为失败、2为升级中
		web.add_header("Authorization","Digest userId=<userid>,qId=<qid>,response=<resp>");//digest 
		web.custom_request("progress.app_request",
    		"Method=<method>",
		new String[]{
		    "URL=http://<BLCIP>:8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("FW004",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    us = lr.eval_string("<updatestatus>");
	    if (code.equals("0") ) {
		//if (us.equals("2")) {
		    //per = lr.eval_string("<percent>");
		    //System.out.println("percent: "+per+" "+"status: "+us);
		//}
		lr.end_transaction("FW004",lr.PASS);
		lr.output_message("Success code:" + code);
		//System.out.println("percent: "+per+" "+"status: "+us);
		return us;
	    }
	    else{
		lr.end_transaction("FW004",lr.FAIL);
                lr.error_message("Error Code:" + code);
		return null;
	    }
	}//FW004(POST)

	/*
	 * 初始化
         */
	private void simuStartALL(){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string("/ipc/startAll","uri");
	    lr.save_string("GET","method");
	    lr.start_transaction("StartALL");
	    try{
		web.disable_keep_alive (); 
		//web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.custom_request("startall_request",
				    "Method=<method>",
				     new String[]{
					"URL=http://<IPCSIMIP>:3000<uri>",//ID:云端用户ID
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
	    catch (Exception e) {
		lr.end_transaction("StartALL",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    lr.end_transaction("StartALL",lr.AUTO);
	    /*
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU022",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU022",lr.FAIL);
		lr.error_message("Error Code:" + code);
	    }
	    */
	}//startall(get)

	private void simuStopALL(){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string("/ipc/stopAll","uri");
	    lr.save_string("GET","method");
	    lr.start_transaction("StopALL");
	    try{
		web.disable_keep_alive (); 
		//web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.custom_request("startall_request",
				    "Method=<method>",
				    new String[]{
					"URL=http://<IPCSIMIP>:3000<uri>",//ID:云端用户ID
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
	    catch (Exception e) {
		lr.end_transaction("StopALL",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    lr.end_transaction("StopALL",lr.AUTO);
	    /*
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("StopALL",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("StopALL",lr.FAIL);
		lr.error_message("Error Code:" + code);
	    }
	    */
	}//stopall(get)

	private void signinRequest(){
	    String xmlBody,code;
	    try {
		lr.save_string(HashUtil.getEncCheckSum("SIGNIN_PRIVATE_KEY_QMULUX","<userID>","<compID>"),"checks");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n<request>"
		    + "\r\n<userId><userID></userId>"//customer_user_id
		    + "\r\n<appModel><appM></appModel>"
		    + "\r\n<companyId><compID></companyId>"
		    + "\r\n<user_random><userrand></user_random>"//需要增加16位字母+数字的随机数
		    + "\r\n<checksum><checks></checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");

	    lr.start_transaction("signin");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<code>","RB=</code>","LAST"});
		web.custom_request("signin.fam_request",
				   "Method=POST",
				    new String[]{
					"URL=http://<BLCIP>:8080/sklcloud/webservices/fam/account/signin.fam",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("signin",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("signin",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("signin",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//SS001(post)

	private String[] login2BRequest(){
	    String xmlBody,code;
	    String[] s = new String[2];
	    try {
		lr.save_string(AESUtil.getEncrypt(lr.eval_string("<userrand>")),"encodestr");
	    } catch ( Exception err ) {
		System.out.println(err.toString());
	    }
	    
	    xmlBody = "Body=<appUserLogin version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<clientUserId><userID></clientUserId>"//管理平台用户IDcustomer_user_id
		    + "\r\n<companyId><compID></companyId>"
		    + "\r\n<appModel><appM></appModel>"
		    + "\r\n<encodeClientRandom><encodestr></encodeClientRandom>"
		    + "\r\n</appUserLogin>";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody); 
	    lr.start_transaction("HU006");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.reg_save_param("usrid",new String[]{"LB=<userId>","RB=</userId>","LAST"});
		web.reg_save_param("pwd",new String[]{"LB=<random>","RB=</random>","LAST"});
		web.custom_request("login.app_request",
				    "Method=POST",
				    new String[]{
					"URL=http://<BLCIP>:8080/sklcloud/app/Security/AAA/users/server/login.app",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("HU006",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("HU006",lr.PASS);
		lr.output_message("Success code:" + code);
		s[0] = lr.eval_string("<usrid>");
		s[1] = lr.eval_string("<pwd>");
		return s;
	    }
	    else{
		lr.end_transaction("HU006",lr.FAIL);
                lr.error_message("Error Code:" + code);
		return null;
	    }
	}//HU006(post)

	private void uploadTokenRequest(String[] s){
	    String xmlBody,code;
	    //System.out.println(s[0]);
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    xmlBody = "Body=<token version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"//云端用户ID(查询数据库)
		    + "\r\n<pushToken>561b1902e6fff0a1f81df04d7af7f8548eef7ab84f9a12d1c34644f5b8fb5462</pushToken>"//IOS: 561b1902e6fff0a1f81df04d7af7f8548eef7ab84f9a12d1c34644f5b8fb5462 ||Android:
		    + "\r\n<systemType>ios</systemType>"
		    + "\r\n</token>";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string("/sklcloud/app/Security/AAA/users/token.app","uri");
	    lr.save_string("PUT","method");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AE003");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest 
		web.custom_request("token.app_request",
				    "Method=<method>",
				    new String[]{
					"URL=http://<BLCIP>:8080<uri>",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("AE003",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AE003",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AE003",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AE003(put)

	private void serverInfoRequest(String[] s){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/<userid>/serverInfo.app","uri");
	    lr.save_string("GET","method");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AU022");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("serverInfo.app_request",
				    "Method=GET",
				    new String[]{
					"URL=http://<BLCIP>:8080/sklcloud/app/<userid>/serverInfo.app",//ID:云端用户ID
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("AU022",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU022",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU022",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU022(get)
}
