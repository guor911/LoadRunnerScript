int result;
Action()
{
    lr_start_transaction("IPConline");
    web_reg_save_param("status","LB=<statusCode>","RB=</statusCode>",LAST);
	web_custom_request("web_custom_request",
					   "URL=http://{BLCIP}:8080/sklcloud/skl-cloud/cloud/ipcCommand/connect",
					   "Method=GET",
					   "TargetFrame=",
					   "Resource=0",
					   "Referer=",
					   "Body=<ipc_command>\r\n"
					   "<qId>{qId}</qId>\r\n"
					   "<productModel>0201</productModel>\r\n"
					   "<connectStatus>0</connectStatus>\r\n"
					   "</ipc_command>\r\n",
					   LAST);
	//比较statuscode和0，结果放入result中，匹配则等于0
    result = strcmp(lr_eval_string("{status}") ,"0");          
	lr_end_transaction("IPConline");

	if (result != 0){
		//匹配结果不等于0则错误告警
		lr_error_message("statusCode FAILED: %s",lr_eval_string("{status}"));       
	}
	else{
		lr_error_message(lr_eval_string("{localtime}"));
	}
	return 0;
}
