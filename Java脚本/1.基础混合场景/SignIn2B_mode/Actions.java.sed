/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * SignIn to B mode
 */

import lrapi.lr;
import lrapi.web;

import test.AESUtil;
import test.HashUtil;
import test.DigestUtil;

public class Actions
{
	public int init() throws Throwable {
	    lr.save_string("192.168.139.208","UserManagePlatIP");
	    lr.save_string("192.168.139.208","BLCIP");
	    return 0;
	}//end of init

	public int action() throws Throwable {
	    String[] s;
	    signinRequest();
	    s = login2BRequest();
	    uploadTokenRequest(s);
	    serverInfoRequest(s);
	    return 0;
	}//end of action

	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void signinRequest(){
	    String xmlBody;
	    int code;
	    try {
		lr.save_string(HashUtil.getEncCheckSum("SIGNIN_PRIVATE_KEY_QMULUX",""+lr.eval_string("<userID>")+"",""+lr.eval_string("<compID>")+""),"checks");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n"+lr.eval_string("<request>")+""
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userID>")+"</userId>"//customer_user_id
		    + "\r\n"+lr.eval_string("<appModel>")+""+lr.eval_string("<appM>")+"</appModel>"
		    + "\r\n"+lr.eval_string("<companyId>")+""+lr.eval_string("<compID>")+"</companyId>"
		    + "\r\n"+lr.eval_string("<user_random>")+""+lr.eval_string("<userrand>")+"</user_random>"//需要增加16位字母+数字的随机数
		    + "\r\n"+lr.eval_string("<checksum>")+""+lr.eval_string("<checks>")+"</checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 
            web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<code>")+"","RB=</code>","LAST"});
	    lr.start_transaction("signin");
	    try{
		web.custom_request("signin.fam_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<BLCIP>:8080/sklcloud/webservices/fam/account/signin.fam",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
	    }
            catch (Exception e) {
		lr.end_transaction("signin",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_int(""+lr.eval_string("<codec>")+"");
	    if (code == 0) {
		lr.end_transaction("signin",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("signin",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//SS001(post)

	private String[] login2BRequest(){
	    String xmlBody;
	    int code;
	    String[] s = new String[2];
	    try {
		lr.save_string(AESUtil.getEncrypt(lr.eval_string(""+lr.eval_string("<userrand>")+"")),"encodestr");
	    } catch ( Exception err ) {
		System.out.println(err.toString());
	    }
	    
	    xmlBody = "Body=<appUserLogin version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<clientUserId>")+""+lr.eval_string("<userID>")+"</clientUserId>"//管理平台用户IDcustomer_user_id
		    + "\r\n"+lr.eval_string("<companyId>")+""+lr.eval_string("<compID>")+"</companyId>"
		    + "\r\n"+lr.eval_string("<appModel>")+""+lr.eval_string("<appM>")+"</appModel>"
		    + "\r\n"+lr.eval_string("<encodeClientRandom>")+""+lr.eval_string("<encodestr>")+"</encodeClientRandom>"
		    + "\r\n</appUserLogin>";
	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 
            web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    web.reg_save_param("usrid",new String[]{"LB="+lr.eval_string("<userId>")+"","RB=</userId>","LAST"});
	    web.reg_save_param("pwd",new String[]{"LB="+lr.eval_string("<random>")+"","RB=</random>","LAST"});
	    lr.start_transaction("HU006");
	    try{
		web.custom_request("login.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<BLCIP>:8080/sklcloud/app/Security/AAA/users/server/login.app",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
	    }
            catch (Exception e) {
		lr.end_transaction("HU006",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_int(""+lr.eval_string("<codec>")+"");
	    if (code == 0) {
		lr.end_transaction("HU006",lr.PASS);
		lr.output_message("Success code:" + code);
		s[0] = lr.eval_string(""+lr.eval_string("<usrid>")+"");
		s[1] = lr.eval_string(""+lr.eval_string("<pwd>")+"");
		return s;
	    }
	    else{
		lr.end_transaction("HU006",lr.FAIL);
                lr.error_message("Error Code:" + code);
		return null;
	    }
	}//HU006(post)

	private void uploadTokenRequest(String[] s){
	    String xmlBody;
	    int code;
	    System.out.println(s[0]);
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    xmlBody = "Body=<token version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<userId>")+"<s[0]></userId>"//云端用户ID(查询数据库)
		    + "\r\n"+lr.eval_string("<pushToken>")+"561b1902e6fff0a1f81df04d7af7f8548eef7ab84f9a12d1c34644f5b8fb5462</pushToken>"//IOS: 561b1902e6fff0a1f81df04d7af7f8548eef7ab84f9a12d1c34644f5b8fb5462 ||Android:
		    + "\r\n"+lr.eval_string("<systemType>")+"ios</systemType>"
		    + "\r\n</token>";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string("/sklcloud/app/Security/AAA/users/token.app","uri");
	    lr.save_string("PUT","method");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
            web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    lr.start_transaction("AE003");
	    try{
		web.add_header("Authorization",
			       "Digest userId="+lr.eval_string("<userid>")+",response="+lr.eval_string("<resp>")+"");//digest 
		web.custom_request("token.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://<BLCIP>:8080/sklcloud/app/Security/AAA/users/token.app",
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
	    code = lr.eval_int(""+lr.eval_string("<codec>")+"");
	    if (code == 0) {
		lr.end_transaction("AE003",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AE003",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AE003(put)

	private void serverInfoRequest(String[] s){
	    String xmlBody;
	    int code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
            web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/"+lr.eval_string("<userid>")+"/serverInfo.app","uri");
	    lr.save_string("GET","method");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AU022");
	    try{
		web.add_header("Authorization",
			       "Digest userId="+lr.eval_string("<userid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("serverInfo.app_request",
    		"Method=GET",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080/sklcloud/app/<userid>/serverInfo.app",//ID:云端用户ID
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
	    code = lr.eval_int(""+lr.eval_string("<codec>")+"");
	    if (code == 0) {
		lr.end_transaction("AU022",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU022",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU022(get)
}
