/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 * IPC Report Event
 */

import lrapi.lr;
import lrapi.web;

public class Actions
{
	
	public int init() throws Throwable {
	    lr.save_string("192.168.139.208","BLCIP");
	    return 0;
	}//end of init

	public int action() throws Throwable {
            getURLRequest();
            postEventRequest();
            mergeGifRequest();
	    return 0;
	}//end of action


	public int end() throws Throwable {
	    return 0;
	}//end of end

	private void getURLRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<ipcRequestUrl version=\"1.0\"xmlns=\"urn:skylight\">"
                    + "\r\n<qId>XXX</qId>"
                    + "\r\n<fileUrlList>"
                    + "\r\n<fileUrl>"
		    + "\r\n<fileName>XXX</fileName>"
		    + "\r\n<serviceType>XXX</serviceType>"
                    + "\r\n</fileUrl>"
                    + "\r\n</fileUrlList>"
                    + "\r\n</ipcRequestUrl>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
	    lr.start_transaction("ET001");
	    try{
		web.custom_request("request.ipc_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<BLCIP>:8080/sklcloud/device/file/url/request.ipc",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
	    }
            catch (Exception e) {
		lr.end_transaction("ET001",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code == "0") {
		lr.end_transaction("ET001",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("ET001",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//ET001(POST)

        private void mergeGifRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<ipcRequestGif version=\"1.0\"xmlns=\"urn:skylight\">"
                    + "\r\n<qId>XXX</qId>"
                    + "\r\n<serviceType>XXX</serviceType>"
                    + "\r\n<uuid>XXX</uuid>"
                    + "\r\n</ipcRequestGif>\r\n"
	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
	    lr.start_transaction("ET002");
	    try{
		web.custom_request("gif.ipc_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<BLCIP>:8080/sklcloud/device/file/gif.ipc",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
	    }
            catch (Exception e) {
		lr.end_transaction("ET002",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code == "0") {
		lr.end_transaction("ET002",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("ET002",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//ET002(POST

        private void postEventRequest(){
	    String xmlBody,code;
	    xmlBody = "Body=<postEventAlert version=\"1.0\" xmlns=\"urn:skylight\">"
                    + "\r\n<qId>XXX</qId>"
                    + "\r\n<event>"
		    + "\r\n<dateTime>XXX</dateTime>"
		    + "\r\n<eventId>XXX </eventId>"
		    + "\r\n<eventState>XXX</eventState >"
		    + "\r\n<eventDescription>XXX</eventDescription>"
		    + "\r\n<regionCoordinatesList>"//只有在活动区域侦测或入侵侦测等情况下才有此节点定义
		    + "\r\n<regionId>XXX</regionId>"
                    + "\r\n</regionCoordinatesList>"
                    + "\r\n<extensions>"//离线事件对应的图片、录影在云端的存放地址 -->
                    + "\r\n<eventUuid>"
                    + "\r\n<photoUuid>XXX</photoUuid>"
                    + "\r\n<gifUuid>XXX</gifUuid>"
                    + "\r\n<videoUuid> XXX</videoUuid>"
                    + "\r\n</eventUuid>"
                    + "\r\n</extensions>"
                    + "\r\n<statusExtensions>"//Garage里入侵事件时带上门和灯的状态-->
                    + "\r\n<nodeStatus>"
                    + "\r\n<nodeType>XXX</nodeType>"
		    + "\r\n<nodeSide>XXX</nodeSide>"//nodeType为sensor时才带-->
		    + "\r\n<status>XXX</status>"//返回灯类型状态时，只要有一个灯为亮就返回开，否则返回关
                    + "\r\n</nodeStatus>"
                    + "\r\n</statusExtensions>"
                    + "\r\n</event>"
                    + "\r\n</postEventAlert>"

	    lr.save_string(xmlBody,"xmlbody");
	    System.out.println(xmlBody); 

	    web.disable_keep_alive (); 
	    web.reg_save_param("codec",new String[]{"LB=<statusCode>","RB=</statusCode>","LAST"});
	    lr.start_transaction("ET003");
	    try{
		web.custom_request("postEvent.ipc_request",
    		"Method=POST",
		new String[]{
		    "URL=http://<BLCIP>:8080/sklcloud/device/event/postEvent.ipc",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"}
		);
	    }
            catch (Exception e) {
		lr.end_transaction("ET003",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string("<codec>");
	    if (code == "0") {
		lr.end_transaction("ET003",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("ET003",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//ET003(POST)
}
