/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * Device Share 
 */

import java.util.UUID;
import lrapi.lr;
import lrapi.web;
//import java.io.ByteArrayInputStream;
//import java.io.IOException;

public class Actions
{
	

	public int init() throws Throwable {
	    lr.save_string("192.168.139.208","UserManagePlatIP");	    
	    return 0;
	}//end of init

	public int action() throws Throwable {
            deviceShareRequest();
	    return 0;
	}//end of action

	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void deviceShareRequest(){
	    String xmlBody, code;
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		+ "\r\n"+lr.eval_string("<request>")+""
                + "\r\n"+lr.eval_string("<userId_master>")+"1</userId_master>"
                + "\r\n"+lr.eval_string("<userId_share>")+"2</userId_share>"
                + "\r\n"+lr.eval_string("<appModel>")+"1</appModel>"
                + "\r\n"+lr.eval_string("<qId>")+"2</qId>"
                + "\r\n"+lr.eval_string("<model>")+"0201</model>"
		+ "\r\n"+lr.eval_string("<companyId>")+""+lr.eval_string("<compID>")+"</companyId>"
		+ "\r\n"+lr.eval_string("<checksum>")+"2b288b1683088432a6067af5d3c5ca25b435fb02f60cdcd0c40c02d23dfcdd7e</checksum>"
		+ "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");

	    web.disable_keep_alive ();
	    web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<code>")+"","RB=</code>","LAST"});
	    lr.start_transaction("DeviceShare");
	    try{
		web.custom_request("device_share.fam_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/webservices/fam/account/device_share.fam",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("DeviceShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("DeviceShare",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code == "0") {
		lr.end_transaction("DeviceShare",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("DeviceShare",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }

	}
}
