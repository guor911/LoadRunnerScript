Action()
{
	lr_start_transaction("startrecord");
		web_custom_request("record",
		"URL=http://192.168.139.207:9709/skl-cloud/cloud/stream/live/record",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n"
				"<server>\r\n"
					"<action>startRecording</action>\r\n"
					"<recordingOptions>version</recordingOptions>\r\n"
					"<recordType>event</recordType>\r\n"
					"<sn>{SN}</sn>\r\n"
					"<channelId>MAIN</channelId>\r\n"
					"<eventName>guorui{SN}.mp4</eventName>\r\n"
					"<recordIntervalTime>25000</recordIntervalTime>\r\n"
					"<prevIntervalTime>5000</prevIntervalTime>\r\n"
					"<nextIntervalTime>0</nextIntervalTime>\r\n"
					"<streamBufferSize>5</streamBufferSize>\r\n"
				"</server>\r\n",
						   LAST);
	lr_message(lr_eval_string("{SN}"));
    lr_end_transaction("startrecord", LR_AUTO);
	return 0;
}
