Action()
{
	lr_start_transaction("startrecord");
		web_custom_request("record",
		"URL=http://192.168.139.206:9709/skl-cloud/cloud/stream/live/record",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n"
				"<server>\r\n"
					"<action>startRecording</action>\r\n"
					"<recordingOptions>version</recordingOptions>\r\n"
					"<recordType>event</recordType>\r\n"
					"<qId>{SN}</qId>\r\n"
                    "<recordFileUuid>{num1}{num2}</recordFileUuid>\r\n"
                    "<S3Key></S3Key>\r\n"
					"<channelId>MAIN</channelId>\r\n"
					"<eventName>event_{nowtime}.mp4</eventName>\r\n"
					"<recordIntervalTime>30000</recordIntervalTime>\r\n"
					"<prevIntervalTime>5000</prevIntervalTime>\r\n"
					"<nextIntervalTime>0</nextIntervalTime>\r\n"
					"<streamBufferSize>5</streamBufferSize>\r\n"
				 "</server>\r\n",
				 LAST);
	lr_message(lr_eval_string("{SN}"));
    lr_end_transaction("startrecord", LR_AUTO);
	return 0;
}
