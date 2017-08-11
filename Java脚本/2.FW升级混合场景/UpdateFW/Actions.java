/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * SignUp to B mode
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
            updateFWRequest();
	    return 0;
	}//end of action


	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void updateFWRequest(){
	    String xmlBody,code;
	    //lr.save_string(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX","<userID>","<compID>"),"checks");
	    xmlBody = "Body=<requestFwUpdate version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n<fwInfo>"
		    + "\r\n<userId><userID></userId>"
		    + "\r\n<qId><compID></qId>"
                    + "\r\n<fwLatestVersion>XXX</fwLatestVersion>"
		    + "\r\n</fwInfo>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 
	    //System.out.println(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX","<userID>","1")); 

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
	    lr.start_transaction("FW002");
	    try{
		web.custom_request("fwInfo.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/app/device/system/updateFw.app",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("FW002",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code == "0") {
		lr.end_transaction("FW002",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("FW002",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//FW002(POST)
}
