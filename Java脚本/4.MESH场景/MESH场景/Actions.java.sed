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
            //IPC Online
	    simuStartALL();
	    lr.think_time(2);
	    // APP Login
	    signinRequest();			// SS001	# sign in to b mode
	    s = login2BRequest();		// HU006	# login to cloud
	    uploadTokenRequest(s);		// AE003	# upload token
	    serverInfoRequest(s);		// AU022	# APP�����ȡP2P/UPNP/STUN/ָ��������Ϣ
	    //deviceLinkRequest(s);		// AU011	# APP�û���IPC�豸
	    return 0;
	}//end of init


	public int action() throws Throwable {
	    // String nodid;
            // First
	    /*
            creatMESHRequest(s);		 // MH018	# APP�û����ƶ˷��ʹ���mesh��������
            // Second
            groupMESHRequest(s);		 // MH022	# APP�û����ƶ˷������mesh����ڵ�������
            // Third
            modifyGroupNameRequest(s);		 // MH025	# APP�û����ƶ˷����޸�mesh����ڵ�����������
            // Forth
            nodeMESHRequest(s);                  // MH026       # APP�û����ƶ˷������mesh����ڵ�����
            // Fifth
            modifyNodeNameRequest(s);            // MH028       # APP�û����ƶ˷����޸�mesh����ڵ���������
            // Sixth
            getDeviceMESHRInfoRequest(s);	 // MH038       # APP�û����ƶ˷��ͻ�ȡ�û���������IPC�Լ�IPC��mesh�����������豸��Ϣ
            lightOperateRequest(s);        	 // MH029       # APP����Եƽ��в������ƶ����յ�IPC����Ӧ���轫������������ݿ���
            doorOperateRequest(s);         	 // MH030       # APP���󿪹��Ų���
            // Seventh
            removeNodeRequest(s);                // MH027       # APP�û�ɾ��ָ���ڵ㡣APP�û������ƶ˵�URI��idΪ�ڵ��nodeQId���ƶ˸���IPC��idΪnodeId
*/
            removeMESHRequest(s);                // MH020       # APP�û�ɾ��ָ��IPC��mesh����
	    return 0;
	}//end of action


	public int end() throws Throwable {
            lr.think_time(10);
	    simuStopALL();
	    return 0;
	}//end of end

        private void creatMESHRequest(String[] s){
	    /*
		���ӿ�ֻ����APP��mesh��Ϣд��IPC��ͬ�����ƶ�
	    */
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/user/mesh/create.app","uri");
	    lr.save_string("POST","method");
	    lr.save_string(DigestUtil.getOrderIdByUUId(),"netiv");
	    lr.save_string(DigestUtil.getUUID(),"netkey");
	    xmlBody = "Body=<appCreateMesh version=\"1.0\" xmlns=\"urn:skylight\">"
                    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
                    + "\r\n"+lr.eval_string("<netIv>")+""+lr.eval_string("<netiv>")+"</netIv>"
                    + "\r\n"+lr.eval_string("<netKey>")+""+lr.eval_string("<netkey>")+"</netKey>"
                    + "\r\n"+lr.eval_string("<netName>")+""+lr.eval_string("<userID>")+"</netName>"
                    + "\r\n</appCreateMesh>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH018");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("create.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH018",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH018",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH018",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH018(POST)

	private void groupMESHRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/mesh/group.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<appMeshGroup version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<groupId>")+"254</groupId>"
		    + "\r\n"+lr.eval_string("<groupName>")+"testdefault</groupName>"
		    + "\r\n"+lr.eval_string("<nodeInfoList>")+""
		/*
		    + "\r\n"+lr.eval_string("<nodeInfo>")+""	//<!-- req, ������0�����-->
		    + "\r\n"+lr.eval_string("<nodeQId>")+"XXX</nodeQId>"
		    + "\r\n"+lr.eval_string("<nodeId>")+"XXX</nodeId>"
		    + "\r\n</nodeInfo>"
		*/
		    + "\r\n</nodeInfoList>"
		    + "\r\n</appMeshGroup>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH022");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("group.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH022",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH022",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH022",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH022(POST)

	private void modifyGroupNameRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/mesh/groupName.app","uri");
	    lr.save_string("PUT","method");
	    xmlBody = "Body=<meshGroupName version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<groupId>")+"254</groupId>"
		    + "\r\n"+lr.eval_string("<groupName>")+"modifytestdefault</groupName>"
		    + "\r\n</meshGroupName>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH025");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("groupName.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH025",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH025",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH025",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH025(PUT)

	private void nodeMESHRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/mesh/node.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<appAddNode version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<nodeList>")+""
		    + "\r\n"+lr.eval_string("<node>")+""
		    + "\r\n"+lr.eval_string("<nodeQId>")+""+lr.eval_string("<nodeqid1>")+"</nodeQId>"
		    + "\r\n"+lr.eval_string("<nodeType>")+"smartSocket</nodeType>"
		    + "\r\n"+lr.eval_string("<nodeModel>")+"0201</nodeModel>"	
		    + "\r\n"+lr.eval_string("<nodeName>")+"light</nodeName>"
		    + "\r\n"+lr.eval_string("<groupId>")+"254</groupId>"
		    + "\r\n"+lr.eval_string("<nodeId>")+"10</nodeId>"
		    + "\r\n"+lr.eval_string("<nodeStatus>")+"2</nodeStatus>"	//1��ʾ����״̬��2��ʾ�ص�״̬��3��ʾ�뿪��4��ʾ���ߡ�
		    + "\r\n"+lr.eval_string("<nodeSide>")+"left</nodeSide>"	//"left""right";nodeSide���ã�
		    + "\r\n"+lr.eval_string("<nodeMac>")+""+lr.eval_string("<node1mac>")+"</nodeMac>"
		    + "\r\n"+lr.eval_string("<fwVersion>")+"V1.0.00.007</fwVersion>"
		    + "\r\n</node>"
		    + "\r\n"+lr.eval_string("<node>")+""
		    + "\r\n"+lr.eval_string("<nodeQId>")+""+lr.eval_string("<nodeqid2>")+"</nodeQId>"
		    + "\r\n"+lr.eval_string("<nodeType>")+"doorController</nodeType>"
		    + "\r\n"+lr.eval_string("<nodeModel>")+"1201</nodeModel>"
		    + "\r\n"+lr.eval_string("<nodeName>")+"door</nodeName>"
		    + "\r\n"+lr.eval_string("<groupId>")+"254</groupId>"
		    + "\r\n"+lr.eval_string("<nodeId>")+"11</nodeId>"
		    + "\r\n"+lr.eval_string("<nodeStatus>")+"2</nodeStatus>"
		    + "\r\n"+lr.eval_string("<nodeSide>")+"left</nodeSide>"
		    + "\r\n"+lr.eval_string("<nodeMac>")+""+lr.eval_string("<node2mac>")+"</nodeMac>"
		    + "\r\n"+lr.eval_string("<fwVersion>")+"V1.0.00.007</fwVersion>"
		    + "\r\n</node>"
		    + "\r\n</nodeList>"
		    + "\r\n</appAddNode>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH026");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("node.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH026",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH026",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH026",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH026(POST)

        private void modifyNodeNameRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/mesh/nodeName.app","uri");
	    lr.save_string("PUT","method");
	    xmlBody = "Body=<meshGroupName version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<nodeQId>")+""+lr.eval_string("<nodeqid1>")+"</nodeQId>"
		    + "\r\n"+lr.eval_string("<nodeName>")+"modifylight</nodeName>"
		    + "\r\n</meshGroupName>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH028");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("nodeName.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH028",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH028",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH028",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH028(PUT)

	private void getDeviceMESHRInfoRequest(String[] s){
	    String xmlBody,code;
	    //String [] nid = new String[2];
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/getDeviceDetailInfor.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<getDeviceDetailInfo version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userid>")+"</userId>"
		    + "\r\n"+lr.eval_string("<clientKind>")+""+lr.eval_string("<appM>")+"</clientKind>"
		    + "\r\n</getDeviceDetailInfo>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH038");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		//web.reg_save_param("nodeid",new String[]{"LB="+lr.eval_string("<nodeId>")+"","RB=</nodeId>","ORD=all","Search=Body","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("getDeviceDetailInfor.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH038",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH038",lr.PASS);
		lr.output_message("Success Code: " + code);
		//return lr.eval_string("<nodeid>");
	    }
	    else{
		lr.end_transaction("MH038",lr.FAIL);
                lr.error_message("Error Code: " + code);
		//return null;
	    }
	}//MH038(POST)

	private void lightOperateRequest(String[] s){
	    String xmlBody,code;
	    //lr.save_string(nodid,"nodeid");
	    lr.output_message(""+lr.eval_string("<nodeid>")+"");
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/mesh/lightOperate.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<meshOperate version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<groupId>")+"254</groupId>"  //һ�β�����Ӧһ��gropId��nodeId����������ֻ�ܴ�һ��
		    //+ "\r\n"+lr.eval_string("<nodeId>")+""+lr.eval_string("<nodeid>")+"</nodeId>"   //һ�β�����Ӧһ��gropId��nodeId����������ֻ�ܴ�һ��
		    + "\r\n"+lr.eval_string("<action>")+"close</action>"		//open��ʾ������close��ʾ���أ� semiOpen��ʾ�뿪
		    + "\r\n"+lr.eval_string("<parameter>")+"aaa</parameter>"
		    + "\r\n</meshOperate>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH029");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("lightOperate.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH029",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH029",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH029",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH029(POST)

	private void doorOperateRequest(String[] s){
	    //���IPC�ӿ��ĵ��нӿڣ�MH008
	    //ģ��APP��MH008�ӿڷ���
	    String xmlBody,code;
	    //lr.save_string(nodid,"nodeid");
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/appremote/"+lr.eval_string("<qid>")+"/device/mesh/doorOperate","uri");//IDΪ�豸qid
	    lr.save_string("POST","method");
	    //xmlBody = "Body=";
	    xmlBody = "Body=<meshOperate version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<groupId>")+"254</groupId>"  //һ�β�����Ӧһ��gropId��nodeId����������ֻ�ܴ�һ�������������groupid�Ļ���˵���Ը�groupid�µ�����node����������
		    //+ "\r\n"+lr.eval_string("<nodeId>")+""+lr.eval_string("<nodeid>")+"</nodeId>"   //һ�β�����Ӧһ��gropId��nodeId����������ֻ�ܴ�һ��
		    + "\r\n"+lr.eval_string("<action>")+"open</action>"
		    + "\r\n"+lr.eval_string("<parameter>")+"aaa</parameter>"
		    + "\r\n</meshOperate>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH030");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		//web.reg_save_param("gifurl",new String[]{"LB="+lr.eval_string("<gifUrl>")+"","RB=</gifUrl>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("doorOperate_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH030",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH030",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("MH030",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//MH030(GET)

	private void removeNodeRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/"+lr.eval_string("<qid>")+"/mesh/"+lr.eval_string("<nodeqid1>")+"/remove.app","uri");//idΪ�ڵ��nodeQId;IDΪIPC��QID
	    lr.save_string("DELETE","method");
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH027");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("removenode.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH027",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH027",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH027",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH027(DEL)

	private void removeMESHRequest(String[] s){
	    //Ϊ�������߽���ܣ������Ϊֻɾ���ƶ˵�Mesh������Ϣ������Ҫ���ƶ�ת����IPC���Mesh�����ָ��
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/device/"+lr.eval_string("<qid>")+"/mesh/remove.app","uri");//IDΪIPC��QID
	    lr.save_string("DELETE","method");
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("MH020");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",qId="+lr.eval_string("<qid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("removemesh.app_request",
    		"Method="+lr.eval_string("<method>")+"",
		new String[]{
		    "URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
		    "TargetFrame=",
		    "Resource=0",
		    "Referer=",
		    xmlBody,
		    "LAST"});
	    }
            catch (Exception e) {
		lr.end_transaction("MH020",lr.FAIL);
		lr.message("An exception occurred: " + e.toString()); 
	    }
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("MH020",lr.PASS);
		lr.output_message("Success Code: " + code);
	    }
	    else{
		lr.end_transaction("MH020",lr.FAIL);
                lr.error_message("Error Code: " + code);
	    }
	}//MH020(DEL)



        private void simuStartALL(){
	    String xmlBody,code;
	    xmlBody = "Body=";
	    lr.save_string(xmlBody,"xmlbody");
	    lr.save_string("/ipc/startAll","uri");
	    lr.save_string("GET","method");
	    lr.start_transaction("StartALL");
	    try{
		web.disable_keep_alive (); 
		//web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.custom_request("startall_request",
				    "Method="+lr.eval_string("<method>")+"",
				     new String[]{
					"URL=http://"+lr.eval_string("<IPCSIMIP>")+":3000<uri>",//ID:�ƶ��û�ID
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
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
		//web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.custom_request("startall_request",
				    "Method="+lr.eval_string("<method>")+"",
				    new String[]{
					"URL=http://"+lr.eval_string("<IPCSIMIP>")+":3000<uri>",//ID:�ƶ��û�ID
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
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
		lr.save_string(HashUtil.getEncCheckSum("SIGNIN_PRIVATE_KEY_QMULUX",""+lr.eval_string("<userID>")+"",""+lr.eval_string("<compID>")+""),"checks");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    xmlBody = "Body=<?xml version=\"1.0\"?>"
		    + "\r\n"+lr.eval_string("<request>")+""
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userID>")+"</userId>"//customer_user_id
		    + "\r\n"+lr.eval_string("<appModel>")+""+lr.eval_string("<appM>")+"</appModel>"
		    + "\r\n"+lr.eval_string("<companyId>")+""+lr.eval_string("<compID>")+"</companyId>"
		    + "\r\n"+lr.eval_string("<user_random>")+""+lr.eval_string("<userrand>")+"</user_random>"//��Ҫ����16λ��ĸ+���ֵ������
		    + "\r\n"+lr.eval_string("<checksum>")+""+lr.eval_string("<checks>")+"</checksum>"
		    + "\r\n</request>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody); 

	    lr.start_transaction("signin");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<code>")+"","RB=</code>","LAST"});
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
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
		lr.save_string(AESUtil.getEncrypt(lr.eval_string(""+lr.eval_string("<userrand>")+"")),"encodestr");
	    } catch ( Exception err ) {
		System.out.println(err.toString());
	    }
	    
	    xmlBody = "Body=<appUserLogin version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<clientUserId>")+""+lr.eval_string("<userID>")+"</clientUserId>"//����ƽ̨�û�IDcustomer_user_id
		    + "\r\n"+lr.eval_string("<companyId>")+""+lr.eval_string("<compID>")+"</companyId>"
		    + "\r\n"+lr.eval_string("<appModel>")+""+lr.eval_string("<appM>")+"</appModel>"
		    + "\r\n"+lr.eval_string("<encodeClientRandom>")+""+lr.eval_string("<encodestr>")+"</encodeClientRandom>"
		    + "\r\n</appUserLogin>";
	    lr.save_string(xmlBody,"xmlbody");
	    //System.out.println(xmlBody); 
	    lr.start_transaction("HU006");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.reg_save_param("usrid",new String[]{"LB="+lr.eval_string("<userId>")+"","RB=</userId>","LAST"});
		web.reg_save_param("pwd",new String[]{"LB="+lr.eval_string("<random>")+"","RB=</random>","LAST"});
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
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
	    String xmlBody,code;
	    System.out.println(s[0]);
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    xmlBody = "Body=<token version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userid>")+"</userId>"//�ƶ��û�ID(��ѯ���ݿ�)
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
	    lr.start_transaction("AE003");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",response="+lr.eval_string("<resp>")+"");//digest 
		web.custom_request("token.app_request",
				    "Method="+lr.eval_string("<method>")+"",
				    new String[]{
					"URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
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
	    lr.save_string("/sklcloud/app/"+lr.eval_string("<userid>")+"/serverInfo.app","uri");
	    lr.save_string("GET","method");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    lr.start_transaction("AU022");
	    try{
		web.disable_keep_alive (); 
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("serverInfo.app_request",
				    "Method=GET",
				    new String[]{
					"URL=http://"+lr.eval_string("<BLCIP>")+":8080/sklcloud/app/<userid>/serverInfo.app",//ID:�ƶ��û�ID
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("AU022",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU022",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU022(get)

	private void deviceLinkRequest(String[] s){
	    String xmlBody,code;
	    lr.save_string(s[0],"userid");
	    lr.save_string(s[1],"pwd");
	    lr.save_string("/sklcloud/app/Security/AAA/users/deviceLink.app","uri");
	    lr.save_string("POST","method");
	    xmlBody = "Body=<appDeviceLink version=\"1.0\" xmlns=\"urn:skylight\">"
		    + "\r\n"+lr.eval_string("<userId>")+""+lr.eval_string("<userid>")+"</userId>"
		    + "\r\n"+lr.eval_string("<qId>")+""+lr.eval_string("<qid>")+"</qId>"
		    + "\r\n"+lr.eval_string("<dateTime>")+""+lr.eval_string("<nowTime>")+"</dateTime>"
		    + "\r\n</appDeviceLink>\r\n";
	    lr.save_string(xmlBody,"xmlbody");
	    try {
		lr.save_string(DigestUtil.genDigist(""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<userid>")+"",""+lr.eval_string("<pwd>")+"",""+lr.eval_string("<method>")+"",""+lr.eval_string("<uri>")+""),"resp");
	    } catch ( Exception err ) {
		lr.message("An exception occurred: " + err.toString());
	    }
	    //System.out.println(xmlBody); 
	    lr.start_transaction("AU011");
	    try{
		web.disable_keep_alive ();
		web.reg_save_param("codec",new String[]{"LB="+lr.eval_string("<statusCode>")+"","RB=</statusCode>","LAST"});
		web.add_header("Authorization","Digest userId="+lr.eval_string("<userid>")+",response="+lr.eval_string("<resp>")+"");//digest
		web.custom_request("deviceLink.app_request",
				    "Method="+lr.eval_string("<method>")+"",
				    new String[]{
					"URL=http://"+lr.eval_string("<BLCIP>")+":8080<uri>",
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
	    code = lr.eval_string(""+lr.eval_string("<codec>")+"");
	    if (code.equals("0")) {
		lr.end_transaction("AU011",lr.PASS);
		lr.output_message("Success code:" + code);
	    }
	    else{
		lr.end_transaction("AU011",lr.FAIL);
                lr.error_message("Error Code:" + code);
	    }
	}//AU011(post)
}
