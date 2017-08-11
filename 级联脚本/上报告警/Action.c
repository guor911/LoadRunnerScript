int result;
Action()
{
	lr_start_transaction("Alert");
	web_reg_save_param("status",
		"LB=<statusCode>",
		"RB=</statusCode>",
		LAST);
	web_custom_request("alert_request",
		"URL=http://{BLCIP}:8080/sklcloud/device/event/postEvent.ipc",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<postEventAlert version=\"1.0\" xmlns=\"urn:skylight\">\r\n"
			  "<qId>{qId}</qId>\r\n"
			  "<event>\r\n"
			  "<dateTime>{localtime}</dateTime>\r\n"
			  "<eventId>MotionDetection</eventId>\r\n"
			  "<eventState>active</eventState>\r\n"
			  "<eventDescription>MotionAlarm</eventDescription>\r\n"
			  "</event>\r\n"
			  "</postEventAlert>\r\n",
		LAST);

	//�Ƚ�statuscode��0���������result�У�ƥ�������0
	result = strcmp(lr_eval_string("{status}"), "0");
	lr_end_transaction("Alert", LR_AUTO);

	if (result != 0){
		//ƥ����������0�����澯
		lr_error_message("statusCode FAILED: %s",lr_eval_string("{status}"));
	}
	else{
		lr_think_time(45);
	}
	return 0;
}
