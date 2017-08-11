/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * Remove Share 
 */


import lrapi.lr;
import lrapi.web;


public class Actions
{
	public int init() throws Throwable {
	    lr.save_string("192.168.139.208","UserManagePlatIP");
	    return 0;
	}//end of init

	public int action() throws Throwable {
            queryIPCRequest();
	    ownedByOtherRequest();
	    isLiveIPCRequest();
	    deleteLinkRequest();
	    deviceLinkRequest();
	    xxx();//AU024
	    return 0;
	}//end of action

	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void queryIPCRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<appVerifyDevice version=\"1.0\" xmlns=\"urn:skylight\">"
                 + "\r\n"+lr.eval_string("<userId>")+"</userId>"
                 + "\r\n"+lr.eval_string("<qId>")+"</qId>"
                 + "\r\n"+lr.eval_string("<dateTime>")+"</dateTime>"
                 + "\r\n"+lr.eval_string("<encodeQKey>")+"</encodeQKey>"
                 + "\r\n</appVerifyDevice>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    lr.start_transaction("AU008");
	    try{
		web.custom_request("query.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/app/device/validity/query.app",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("AU008",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("AU008",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU008",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU008(post)

	private void ownedByOtherRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    web.reg_save_param("owner",new String[]{"LB="+lr.eval_string("<isOwnedByOther>")+"","RB=</isOwnedByOther>","LAST"});
	    lr.start_transaction("AU023");
	    try{
		web.custom_request("ownedByOther_request",
    		"Method=GET",
		new String[]{
		    "URL=http://"+lr.eval_string("<UserManagePlatIP>")+":8080/sklcloud/app/device/<ID>/ownedByOther",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("AU023",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("AU023",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU023",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU023(get)

	private void isLiveIPCRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    web.reg_save_param("live",new String[]{"LB="+lr.eval_string("<isLive>")+"","RB=</isLive>","LAST"});
	    lr.start_transaction("AU010");
	    try{
		web.custom_request("isLiveDevice.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://"+lr.eval_string("<UserManagePlatIP>")+":8080/sklcloud/app/device/<ID>/isLiveDevice.app",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("AU010",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("AU010",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU010",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU010(get)

	private void deleteLinkRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<appDeleteLink version=\"1.0\" xmlns=\"urn:skylight\">"
                 + "\r\n"+lr.eval_string("<userId>")+"</userId>"
                 + "\r\n"+lr.eval_string("<qId>")+"</qId>"
                 + "\r\n</appDeleteLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    lr.start_transaction("AU0018");
	    try{
		web.custom_request("deleteLink.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/app/Security/AAA/users/deleteLink.app",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("AU0018",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("AU0018",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU0018",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU0018(post)

	private void deviceLinkRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<appDeviceLink version=\"1.0\" xmlns=\"urn:skylight\">"
                 + "\r\n"+lr.eval_string("<userId>")+"</userId>"
                 + "\r\n"+lr.eval_string("<qId>")+"</qId>"
		 + "\r\n"+lr.eval_string("<dateTime>")+"XXX</dateTime>"
                 + "\r\n</appDeviceLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    lr.start_transaction("AU0011");
	    try{
		web.custom_request("deviceLink.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/app/Security/AAA/users/deviceLink.app",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("AU0011",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("AU0011",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU0011",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU0011(post)

	private void xxx(){

	}////AU024
}
