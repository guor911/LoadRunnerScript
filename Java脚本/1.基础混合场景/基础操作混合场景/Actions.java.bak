/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 *                     
 */

import lrapi.lr;
import lrapi.web;
import test.*;
/*
import test.AESUtil;
import test.HashUtil;
import test.DigestUtil;
*/


public class Actions
{
	public int init() throws Throwable {
            lr.save_string("192.168.139.206","BLCIP");
	    lr.save_string("192.168.139.207","IPCSIMIP");
	    // IPC Online
	    simuStartALL();
	    //lr.think_time(2);
	    return 0;
	}//end of init

	public int action() throws Throwable {
            String[] s;
            // First Step
            //signUpRequest();			// SS002	# sign up to b mode
            // Second Step
	    signinRequest();			// SS001	# sign in to b mode
	    s = login2BRequest();		// HU006	# login to cloud
	    uploadTokenRequest(s);		// AE003	# upload token
	    serverInfoRequest(s);		// AU022	# APP请求获取P2P/UPNP/STUN/指令中心信息
	    // Forth Step
            queryIPCRequest(s);			// AU008 	# 验证IPC设备有效性
	    ownedByOtherRequest(s);		// AU023 	# 查询IPC被谁绑定（isOwnedByOther[0:没有被关联，1:被自己关联，2:被其它人关联]）
	    isLiveIPCRequest(s);		// AU010 	# APP用户查询IPC设备是否在线(isLive[True:表示已连上,False:表示未连上])
	    //---deleteLinkRequest(s);		// AU018 	# APP用户解除设备关联
            factoryResetRequest(s);		// AS018 	# APP向云端上报IPC已被Factory Reset 
	    deviceLinkRequest(s);		// AU011 	# APP用户绑定IPC设备
	    //---heartBeatRequest();		// AU024 	# APP心跳包请求(App每隔30秒向cloud发次心跳，5分钟无回应则判断为离线) To C Mode
            // Fifth Step
            deviceShareRequest();		// SS006 	# APP用户分享设备
            // Sixth Step
	    queryIPCListRequest(s);		// AU019 	# APP用户获取关联设备列表
	    modifyMotionRequest(s);		// AS001 	# APP用户请求修改Motion Sensitivity
	    doorOpenedRemindRequest(s);		// AS015   	# APP用户查询doorOpenedRemind使能
	    getSettingInfoRequest(s);		// AS012 	# APP用户请求获取Setting信息
            // Seventh Step
            removeShareRequest();		// SS007	# APP用户解除分享设备

	    return 0;
	    
	}//end of action

	public int end() throws Throwable {
	    // IPC Offline
	    lr.think_time(10);
	    simuStopALL();
	    return 0;
	}//end of end

        //-------first step
        private void signUpRequest(){
	    String xmlBody,code;
	    lr.save_string(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX","<userID>","<compID>"),"checks");
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n<request>"
		    + "\r\n<userId><userID></userId>"
		    + "\r\n<companyId><compID></companyId>"
		    + "\r\n<checksum><checks></checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    //System.out.println(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX","<userID>","1")); 
	    lr.start_transaction("signup");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<code>","RB=</code>","LAST"});
		web.custom_request("signup.fam_request",
				    "Method=POST",
				    new String[]{
					"URL=http://<BLCIP>:8080/sklcloud/webservices/fam/account/signup.fam",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
				    //lr.end_transaction("signup",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("signup",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("signup",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("signup",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}

        //-------second step
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
	    //System.out.println(xmlBody); 

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
	    //lr.log_message(lr.eval_string("<codec>"));
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
	    System.out.println(s[0]);
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

        //-------third step
	/*start simulator and stop simulator*/

        //-------forth step
	private void queryIPCRequest(String[] s){
	    String xmlBody,time,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/validity/query.app","uri");
	    lr.save_string("POST","method");
	    time = lr.eval_string("<nowTime>");
	    //System.out.print(time);
	    lr.save_string(time,"thisTime");
	    try	{
		lr.save_string(AESUtil.getEncodeQKey(lr.eval_string("<mdqkey>"),time),"encodemdqKey");
		//System.out.println(lr.eval_string("<encodemdqKey>"));
	    }catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<appVerifyDevice version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n<dateTime><thisTime></dateTime>"
		    + "\r\n<encodeQKey><encodemdqKey></encodeQKey>"
		    + "\r\n</appVerifyDevice>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AU008");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("query.app_request",
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
		lr.end_transaction("AU008",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU008",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU008",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU008(post)

	private void ownedByOtherRequest(String[] s){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/<qid>/ownedByOther","uri");
	    lr.save_string("GET","method");
	    //System.out.println(xmlBody);
	    lr.start_transaction("AU023");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    try{
		web.disable_keep_alive (); 
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.reg_save_param("owner",new String[]{"LB=<isOwnedByOther>","RB=</isOwnedByOther>","LAST"});
		web.custom_request("ownedByOther_request",
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
		lr.end_transaction("AU023",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU023",lr.PASS);
		lr.output_message("Success code: " + code);
		lr.output_message("isOwnedByOther: " + lr.eval_string("<owner>"));
	    }
	    else{
		lr.end_transaction("AU023",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU023(get)

	private void isLiveIPCRequest(String[] s){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/<qid>/isLiveDevice.app","uri");
	    lr.save_string("GET","method");
	    lr.start_transaction("AU010");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.reg_save_param("live",new String[]{"LB=<isLive>","RB=</isLive>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("isLiveDevice.app_request",
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
		lr.end_transaction("AU010",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU010",lr.PASS);
		lr.output_message("Success code: " + code);
		lr.output_message("Live Or Not: " + lr.eval_string("<live>"));
	    }
	    else{
		lr.end_transaction("AU010",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU010(get)

	private void deleteLinkRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/Security/AAA/users/deleteLink.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<appDeleteLink version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n</appDeleteLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    lr.start_transaction("AU018");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("deleteLink.app_request",
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
		lr.end_transaction("AU018",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU018",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU018",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU018(post)

	private void factoryResetRequest(String[] s){
	    String xmlBody,time,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/Security/device/factoryReset.app","uri");
	    lr.save_string("POST","method");
	    time = lr.eval_string("<nowTime>");
	    //System.out.print(time);
	    lr.save_string(time,"thisTime");
	    try	{
		lr.save_string(AESUtil.getEncodeQKey(lr.eval_string("<mdqkey>"),time),"encodemdqKey");
		//System.out.println(lr.eval_string("<encodemdqKey>"));
	    }catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<appDeleteLink version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n<dateTime><thisTime></dateTime>"
		    + "\r\n<encodeQKey><encodemdqKey></encodeQKey>"
		    + "\r\n</appDeleteLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    lr.start_transaction("AS018");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("factoryReset.app_request",
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
		lr.end_transaction("AS018",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AS018",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AS018",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AS018(post)

	private void deviceLinkRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/Security/AAA/users/deviceLink.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<appDeviceLink version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId><userid></userId>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n<dateTime><nowTime></dateTime>"
		    + "\r\n</appDeviceLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    //System.out.println(xmlBody); 
	    lr.start_transaction("AU011");
	    try{
		web.disable_keep_alive ();
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("deviceLink.app_request",
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
		lr.end_transaction("AU011",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU011",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU011",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU011(post)

	private void heartBeatRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<appDeviceLink version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<userId></userId>"
		    + "\r\n<qId></qId>"
		    + "\r\n<dateTime>XXX</dateTime>"
		    + "\r\n</appDeviceLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    lr.start_transaction("AU024");
	    try{
		web.disable_keep_alive ();
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.custom_request("heartBeat_request",
				    "Method=POST",
				    new String[]{
					"URL=http://<BLCIP>:8080/sklcloud/app/Security/AAA/users/heartBeat",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("AU024",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU024",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU024",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU024(get)heartbeat package

        //-------fifth step
	private void deviceShareRequest(){
	    String xmlBody,code;
	    lr.save_string("/sklcloud/webservices/fam/account/device_share.fam","uri");
	    lr.save_string("POST","method");
	    try {
		lr.save_string(HashUtil.getEncCheckSum("SHARE_DEVICE","<userID>","<compID>"),"checks");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n<request>"
		    + "\r\n<userId_master><userID></userId_master>"
		    + "\r\n<userId_share>666666</userId_share>"
		    + "\r\n<appModel><appM></appModel>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n<model><cameraM></model>"
		    + "\r\n<companyId><compID></companyId>"
		    + "\r\n<checksum><checks></checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.start_transaction("SS006");
	    try{
		web.disable_keep_alive ();
		web.reg_save_param("codec",new String[]{"LB=<code>","RB=</code>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("device_share.fam_request",
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
		lr.end_transaction("SS006",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("SS006",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("SS006",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }

	}//SS006

        //-------sixth step
	private void queryIPCListRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/<userid>/query.app","uri");
	    lr.save_string("GET","method");
	    xmlBody = "Body=";
	    //System.out.println(xmlBody);
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(HashUtil.getEncCheckSum("SIGNIN_PRIVATE_KEY_QMULUX","<userID>","<compID>"),"checks");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AU019");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,response=<resp>");//digest
		web.custom_request("query.app_request",
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
		lr.end_transaction("AU019",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AU019",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU019",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU019(GET)

	private void modifyMotionRequest(String[] s){
	    //指令中心请求IPC，在IPCsimu中配置IPC接口ES001
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/motion/motionSensitivity.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<motionSensitivity version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n<sensitivity>50</sensitivity>"
		    + "\r\n<enabled>true</enabled>"
		    + "\r\n</motionSensitivity>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AS001");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,qId=<qid>,response=<resp>");//digest
		web.custom_request("motionSensitivity.app_request",
				    "Method=POST",
				    new String[]{
					"URL=http://<BLCIP>:8080<uri>",
					"TargetFrame=",
					"Resource=0",
					"Referer=",
					xmlBody,
					"LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("AS001",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AS001",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AS001",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AS001(POST)

	private void doorOpenedRemindRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/appremote/<qid>/device/doorOpenedRemind","uri");
	    lr.save_string("GET","method");
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AS015");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,qId=<qid>,response=<resp>");//digest
		web.custom_request("doorOpenedRemind_request",
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
		lr.end_transaction("AS015",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AS015",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AS015",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AS015(GET)

	private void getSettingInfoRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/<qid>/getSettingInfo.app","uri");
	    lr.save_string("GET","method");
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist("<pwd>","<userid>","<pwd>","<method>","<uri>"),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AS012");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId=<userid>,qId=<qid>,response=<resp>");//digest
		web.custom_request("getSettingInfo.app_request",
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
		lr.end_transaction("AS012",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("AS012",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AS012",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AS012(GET)

        //-------seventh step
        private void removeShareRequest(){
	    String xmlBody,code;
	    lr.save_string("/sklcloud/webservices/fam/account/remove_share.fam","uri");
	    lr.save_string("POST","method");
	    try {
		lr.save_string(HashUtil.getEncCheckSum("REMOVE_SHARE_DEVICE","<userID>","<compID>"),"checks");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n<request>"
		    + "\r\n<userId_master><userID></userId_master>"
		    + "\r\n<userId_share>666666</userId_share>"
		    + "\r\n<appModel><appM></appModel>"
		    + "\r\n<qId><qid></qId>"
		    + "\r\n<model><cameraM></model>"
		    + "\r\n<companyId><compID></companyId>"
		    + "\r\n<checksum><checks></checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);
	    lr.start_transaction("SS007");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB=<code>","RB=</code>","LAST"});
		web.custom_request("remove_share.fam_request",
    		"Method=<method>",
		new String[]{
		    "URL=http://<BLCIP>:8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("SS007",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string("<codec>");
	    if (code.equals("0")) {
		lr.end_transaction("SS007",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("SS007",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//SS007(POST)

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

}
