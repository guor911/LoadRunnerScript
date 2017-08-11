/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * SignUp to B mode
 */

import lrapi.lr;
import lrapi.web;
import test.HashUtil;

public class Actions
{
	
	public int init() throws Throwable {
	    lr.save_string("192.168.139.208","BLCIP");
	    return 0;
	}//end of init

	public int action() throws Throwable {
            signUpRequest();
	    return 0;
	}//end of action


	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void signUpRequest(){
	    String xmlBody;
	    int code;
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

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB=<code>","RB=</code>","LAST"});
	    lr.start_transaction("signup");
	    try{
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
	    code = lr.eval_int("<codec>");
	    if (code == 0) {
		lr.end_transaction("signup",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("signup",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}
}
