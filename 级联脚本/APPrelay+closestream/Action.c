Action()
{
    int result=0;
int iloop=1;//ѭ��ִ�д���
Action()
{   
	if(0)
	{
		play_stop();
		return;
	}
	while(--iloop>=0)
	{
		char filename[32];
		memset(filename,0,32);
		sprintf(filename,".\\%s.log",lr_eval_string("{qId}"));
		
		web_reg_save_param("statu","LB=<statusCode>","RB=</statusCode>",LAST);
		web_reg_save_param("statuStr","LB=<statusString>","RB=</statusString>",LAST);
		web_reg_save_param("mainurl", "LB=<mainUrl>", "RB=</mainUrl>", "Search=Body", LAST);

		result=-1;
		relay();
	
		if (result == 0) {
			long fp1;
			char msg[2048];
			memset(msg,0,2048);
			sprintf(msg,"qid=%s,   relay���ȳɹ�,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
	
			fp1=fopen(filename,"a+");
			fprintf( fp1,"%s\n",msg ); 
			fclose(fp1); 
	
			lr_think_time(4);//
			result=-1;
			play_start();

			if(result == 0) {
				memset(msg,0,2048);
				sprintf(msg,"qid=%s,����play���ȳɹ�,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
		
				fp1=fopen(filename,"a+");
				fprintf( fp1,"%s\n",msg ); 
				fclose(fp1);
		
		
				lr_think_time(50);
				result=-1;
				play_stop();

				memset(msg,0,2048);
				if(result == 0) {
					sprintf(msg,"qid=%s,����stop���ȳɹ�,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
				}
				else{
					sprintf(msg,"qid=%s,����stop����ʧ��,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
				}

				fp1=fopen(filename,"a+");
				fprintf( fp1,"%s\n",msg ); 
				fclose(fp1);
			}
			else{
				memset(msg,0,2048);
				sprintf(msg,"qid=%s,����play����ʧ��,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
		
				fp1=fopen(filename,"a+");
				fprintf( fp1,"%s\n",msg ); 
				fclose(fp1);
			}
		}
		else{
			long fp1;
			char msg[2048];
			memset(msg,0,2048);
			sprintf(msg,"qid=%s,   relay����ʧ��,time=<%s>",lr_eval_string("{qId}"),lr_eval_string("{time}"));
	
			fp1=fopen(filename,"a+");
			fprintf( fp1,"%s\n",msg ); 
			fclose(fp1); 
		}
	
		lr_think_time(6);
	  
	}
	return 0;
}

void relay()
{
	web_add_header("Authorization","Digest userId=1,response= ,qId={qId}");

	lr_start_transaction("getLiveUrl");
    web_custom_request("apprelay",
                       "URL=http://192.168.139.204:8080/sklcloud/app/push/streaming/snDevice/RTMP/live/{qId}",
					   //"URL=http://192.168.139.204:8080/sklcloud/app/push/streaming/snDevice/RTMP/live/AAAAAAAC",
                          "Method=GET",
                          "TargetFrame=",
                          "Resource=0",
                          "Referer=",
                          "Body=",
                          LAST);

	
	result = strcmp(lr_eval_string("{statu}") ,"0");          //�Ƚ�statuscode��0���������result�У�ƥ�������0

	if (result != 0) {
		lr_error_message("%s statusCode FAILED!-->:%s",lr_eval_string("{qId}"),lr_eval_string("{statuStr}"));       //ƥ����������0�����澯
	}
	lr_end_transaction("getLiveUrl", LR_AUTO);

	/*
	�ɹ����أ�
	<?xml version="1.0" encoding="UTF-8"?>
	<appQuerySnDeviceLive xmlns="urn:skylight" version="1.0">
	<mainUrl>rtmp://192.168.139.208:1935/live/AAAAAAAB_MAIN.stream?param=1_AAAAAAAB_44222ca0-09dc-424a-927e-8970cd6f9fd2</mainUrl>
	<ResponseStatus>
	<statusCode>0</statusCode>
	<statusString>0</statusString>
	</ResponseStatus>
	</appQuerySnDeviceLive>

	ʧ�ܷ��أ�	
	
    */
	
}

void play_start()
{
	lr_start_transaction("OnPlay");
	web_custom_request("play",
				  "URL=http://192.168.139.208:9000/skl-cloud/cloud/avr/play/OnPlay",
				  "Method=POST",
				  "TargetFrame=",
				 "Resource=0",
				 "Referer=",
				  "Body=<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
				   "<play>\r\n"
				   " <action>1</action>\r\n"
				   "<uid>{qId}</uid>\r\n"
                   "<url>{mainurl}</url>\r\n"
				   "</play>\r\n",
				  LAST);

	result = strcmp(lr_eval_string("{statu}") ,"0");          //�Ƚ�statuscode��0���������result�У�ƥ�������0
	if (result != 0) {
		lr_error_message("%s OnPlay,statusCode FAILED!-->:%s",lr_eval_string("{qId}"),lr_eval_string("{statu}"));       //ƥ����������0�����澯
	}
	lr_end_transaction("OnPlay", LR_AUTO);
	/*
	�ɹ����أ�
<?xml version="1.0" encoding="utf-8"?>
<play>
<statusCode>0</statusCode>
<statusString>OK</statusString>
</play>

ʧ�ܷ��أ�	
	��
    */
}

void play_stop()
{
	lr_start_transaction("OnStop");
	web_custom_request("stop",
			  "URL=http://192.168.139.208:9000/skl-cloud/cloud/avr/play/OnStop",
			  "Method=POST",
			  "TargetFrame=",
			 "Resource=0",
			 "Referer=",
			  "Body=<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n"
			   "<play>\r\n"
			   " <action>1</action>\r\n"
				"<uid>{qId}</uid>\r\n"
				"<url>{mainurl}</url>\r\n"
			   "</play>\r\n",
			  LAST);
	result = strcmp(lr_eval_string("{statu}") ,"0");          //�Ƚ�statuscode��0���������result�У�ƥ�������0
	if (result != 0) {
		lr_error_message("%s OnStop,statusCode FAILED!-->:%s",lr_eval_string("{qId}"),lr_eval_string("{statu}"));       //ƥ����������0�����澯
	}
	lr_end_transaction("OnStop", LR_AUTO);
	/*
	�ɹ����أ�
<?xml version="1.0" encoding="utf-8"?>
<play>
<statusCode>0</statusCode>
<statusString>OK</statusString>
</play>

ʧ�ܷ��أ�	
	��
    */
}

	return 0;
}
