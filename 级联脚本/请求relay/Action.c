int result;
Action()
{
	web_reg_save_param("status","LB=<statusCode>","RB=</statusCode>",LAST);
	web_reg_save_param("mainurl", "LB=<mainUrl>", "RB=</mainUrl>", "Search=Body", LAST);
	//web_add_header("Authorization","Digest userId=1,response= ,qId={qId}");

	lr_start_transaction("getLiveUrl");
    web_custom_request("apprelay",
					   "URL=http://{BLCIP}:8080/sklcloud/app/push/streaming/snDevice/RTMP/live/{qId}",
					   "Method=GET",
					   "TargetFrame=",
					   "Resource=0",
					   "Referer=",
					   "Body=",
					   LAST);
	//比较statuscode和0，结果放入result中，匹配则等于0
	result = strcmp(lr_eval_string("{status}") ,"0");
	lr_end_transaction("getLiveUrl", LR_AUTO);

	if (result != 0) {
		//匹配结果不等于0则错误告
		lr_error_message("statusCode FAILED: %s",lr_eval_string("{statu}"));
	}
	else{
		lr_log_message("响应URL：%s\n", lr_eval_string("{mainurl}"));
		web_custom_request("getStreamTool",
					   "URL=http://{StreamToolIP}:9000/skl-cloud/cloud/avr/play/OnPlay",
					   "Method=POST",
					   "TargetFrame=",
					   "Resource=0",
					   "Referer=",
					   "Body=<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
					   "<play>\r\n"
					   "<action>1</action>\r\n"
					   "<uid>001</uid>\r\n"
					   //"<url>rtmp://192.168.139.191:1935/live/AAAAAAAE_MAIN.stream</url>\r\n"
					   //"<url>rtmp://192.168.139.208:1935/live/{qId}_MAIN.stream</url>\r\n"
					   "<url>{mainurl}</url>\r\n"
					   "</play>\r\n",
					   LAST);
	}
	return 0;
}
