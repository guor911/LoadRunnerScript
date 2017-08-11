int result;
int iloop=1000;
int i = 1;//循环几次就写几
Action()
{
	if(0)
	{
		ipc_online();
		//stop_LS_streaming();
		//stop_AS_to_LS_streaming();
		return 0;
	}

	while(--iloop>=0)
	{
		char msg[2048];
		char filename[32];
		
		memset(filename,0,32);
		sprintf(filename,".\\%s.log",lr_eval_string("{qId}"));
	
		if (result == 0) {
			i = 1;
			while(--i>=0)
			{
				long fp1;
				lr_think_time(10);
				ls_record();
				memset(msg,0,2048);
				if (result == 0) {
					sprintf(msg,"qid=%s,ls_record调度成功,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
				}
				else{
					sprintf(msg,"qid=%s,ls_record调度失败,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
				}
				fp1=fopen(filename,"a+");
				fprintf( fp1,"%s\n",msg );
				fclose(fp1);
			}
		}
		lr_think_time(60);
	}
	return 0;
}

void ipc_online()
{
	lr_start_transaction("IPConline");
    web_reg_save_param("status","LB=<status>","RB=</status>",LAST);
	web_custom_request("web_custom_request",
		"URL=http://192.168.139.204:8080/sklcloud/skl-cloud/cloud/ipcCommand/connect",
		"Method=GET",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<ipc_command>\r\n"
			"<qId>{qId}</qId>\r\n"
			"<productModel>0103</productModel>\r\n"
			"<connectStatus>0</connectStatus>\r\n"
			"</ipc_command>\r\n",
		LAST);
    result = strcmp(lr_eval_string("{status}") ,"0");          //比较statuscode和0，结果放入result中，匹配则等于0
	if (result != 0) {
		lr_error_message("statusCode FAILED!-->:%s",lr_eval_string("{status}"));       //匹配结果不等于0则错误告警
	}
    lr_end_transaction("IPConline", LR_AUTO);
}

void ls_record()
{
	char count[100];		
	lr_start_transaction("alert");
	itoa(i,count,10);
	lr_save_string(count, "reportid");
	web_reg_save_param("status","LB=<statusCode>","RB=</statusCode>",LAST);
	web_custom_request("web_custom_request",
		"URL=http://192.168.139.204:8080/sklcloud/device/event/postEvent.ipc",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<postEventAlert version=\"1.0\" xmlns=\"urn:skylight\">\r\n"
				   "<qId>{qId}</qId>\r\n"
				   "<event>\r\n"
				   "<dateTime>{qId}</dateTime>\r\n"
				   "<eventId>MotionDetection</eventId>\r\n"
				   "<eventState>active</eventState>\r\n"
				   "<eventDescription>MotionAlarm</eventDescription>\r\n"
				   "</event>\r\n"
				   "</postEventAlert>\r\n",LAST);
	result = strcmp(lr_eval_string("{status}") ,"0");          //比较statuscode和0，结果放入result中，匹配则等于0
	if (result != 0) {
		lr_error_message("statusCode FAILED!-->:%s",lr_eval_string("{status}"));       //匹配结果不等于0则错误告警
	}
	lr_end_transaction("alert", LR_AUTO);
}

void stop_LS_streaming()
{
	web_custom_request("stop",
					   /* 此处填写LS的ip+port*/
			  "URL=http://192.168.139.208:9709/skl-cloud/cloud/stream/stop",
			  "Method=POST",
			  "TargetFrame=",
			 "Resource=0",
			 "Referer=",
			  "Body=<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
			   "<streamStop>\r\n"
				"<qId>{qId}</qId>\r\n"
				"<channelId>MAIN</channelId>\r\n"
				"<destIp>0.0.0.0</destIp>\r\n"
			   "</streamStop>\r\n",
			  LAST);
}


void stop_AS_to_LS_streaming()
{
	web_custom_request("stop",
					   /* 此处填写AS的ip+port*/
			  "URL=http://192.168.139.50:8091/skl-cloud/cloud/stream/stop",
			  "Method=POST",
			  "TargetFrame=",
			 "Resource=0",
			 "Referer=",
			  "Body=<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
			   "<streamStop>\r\n"
				"<qId>{qId}</qId>\r\n"
				"<channelId>MAIN</channelId>\r\n"
				"<outputStreamList><outputStream>\r\n"
				"<outputStreamServiceId>2</outputStreamServiceId>\r\n"
			   "<destIp>0.0.0.0</destIp>\r\n"
			   "<destPort>0</destPort>\r\n"
			   "</outputStream></outputStreamList>"
			   "</streamStop>\r\n",
			  LAST);
}

void stop_AS_to_SS_streaming()
{
		web_custom_request("stop",
					   /* 此处填写AS的ip+port*/
			  "URL=http://192.168.139.50:8091/skl-cloud/cloud/stream/stop",
			  "Method=POST",
			  "TargetFrame=",
			 "Resource=0",
			 "Referer=",
			  "Body=<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
			   "<streamStop>\r\n"
				"<qId>{qId}</qId>\r\n"
				"<channelId>MAIN</channelId>\r\n"
				"<outputStreamList><outputStream>\r\n"
				"<outputStreamServiceId>1</outputStreamServiceId>\r\n"
			   "<destIp>0.0.0.0</destIp>\r\n"
			   "<destPort>0</destPort>\r\n"
			   "</outputStream></outputStreamList>"
			   "</streamStop>\r\n",
			  LAST);
}

