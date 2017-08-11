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
            String fwv;
            fwv = getFWInfoRequest();
            updateFWRequest(fwv);
	    return 0;
	}//end of action


	public int end() throws Throwable {
	    return 0;
	}//end of end

	private String getFWInfoRequest(){
	    String xmlBody,code;
	    //lr.save_string(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX",""+lr.eval_string("<userID>")+"","<compID>"),"checks");
	    xmlBody = "Body=<fwInfo version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<fwInfo>")+""
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userID>")+"</userId>"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<compID>")+"</qId>"
		    + "\r\n</fwInfo>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 
	    //System.out.println(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX","<userID>","1")); 

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
            web.reg_save_param("fwver",new String[]{"LB="+lr.eval_string("<fwLatestVersion>")+"","RB=</fwLatestVersion>","LAST"});
	    lr.start_transaction("FW001");
	    try{
		web.custom_request("fwInfo.app_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/app/device/system/fwInfo.app",
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("FW001",lr.PASS);
		lr.output_message("Success code:" + code);
                return lr.eval_string(""+lr.eval_string("<fwver>")+"");
	    }
	    else{
		lr.end_transaction("FW001",lr.FAIL);
                lr.error_message("Error Code:" + code);
		return null;
	    }
	}//FW001(POST)

        private void updateFWRequest(String fwv){
	    String xmlBody,code;
            lr.save_string(fwv,"fwver");
	    //lr.save_string(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX",""+lr.eval_string("<userID>")+"","<compID>"),"checks");
	    xmlBody = "Body=<requestFwUpdate version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<fwInfo>")+""
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userID>")+"</userId>"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<compID>")+"</qId>"
                    + "\r\n"+lr.eval_string("<fwLatestVersion>")+""+lr.eval_string("<fwver>")+"</fwLatestVersion>"
		    + "\r\n</fwInfo>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
            
	    System.out.println(xmlBody); 
	    //System.out.println(HashUtil.getEncCheckSum("SIGNUP_PRIVATE_KEY_QMULUX","<userID>","1")); 

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
	    lr.start_transaction("FW002");
	    if (fwv == null) {
		lr.end_transaction("FW002",lr.FAIL);
		lr.error_message("Error: fwLatesVersion is null.");
	    }
	    else{
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
		code = lr.eval_string(""+lr.eval_string("<codec>")+"");
		if (code == "0") {
		    lr.end_transaction("FW002",lr.PASS);
		    lr.output_message("Success code:" + code);
		}
		else{
		    lr.end_transaction("FW002",lr.FAIL);
		    lr.error_message("Error Code:" + code);
		}
	    }
	}//FW002(POST)
}
