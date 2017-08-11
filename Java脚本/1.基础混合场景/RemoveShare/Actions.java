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
            removeShareRequest();
	    return 0;
	}//end of action


	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void removeShareRequest(){
	    String xmlBody;
	    int code;
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n<request>"
		    + "\r\n<userId_master>1</userId_master>"
		    + "\r\n<userId_share>2</userId_share>"
		    + "\r\n<appModel>1</appModel>"
		    + "\r\n<qId>2</qId>"
		    + "\r\n<model>0201</model>"
		    + "\r\n<companyId><compID></companyId>"
		    + "\r\n<checksum>2b288b1683088432a6067af5d3c5ca25b435fb02f60cdcd0c40c02d23dfcdd7e</checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody);

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB=<code>","RB=</code>","LAST"});
	    lr.start_transaction("RemoveShare");
	    try{
		web.custom_request("remove_share.fam_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<UserManagePlatIP>:8080/sklcloud/webservices/fam/account/remove_share.fam",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
		//lr.end_transaction("RemoveShare",lr.PASS);
	    }
            catch (Exception e) {
		lr.end_transaction("RemoveShare",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    //lr.log_message(lr.eval_string("<codec>"));
	    code = lr.eval_int("<codec>");
	    if (code == 0) {
		lr.end_transaction("RemoveShare",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("RemoveShare",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}
}
