Action()
{
    //requireRecord	0：截图模式； 1：录像模式； 默认是截图模式
    //lr_save_string("0","rRecord");
	web_custom_request("setStreamConfig",
		"URL=http://192.168.139.207:9709/skl-cloud/cloud/stream/setStreamConfig",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
				"<setStreamConfig xmlns=\"urn:sky-light\" version=\"1.0\">\r\n"
				"<sn>{SN}</sn>\r\n"
				"<channelId>MAIN</channelId>\r\n"
				"<streamConfig>\r\n"
				"<requireRecord>1</requireRecord>\r\n"
				"<recordIntervalTime>25000</recordIntervalTime>\r\n"
				"<prevIntervalTime>5000</prevIntervalTime>\r\n"
				"<nextIntervalTime>0</nextIntervalTime>\r\n"
				"<streamBufferSize>5</streamBufferSize>\r\n"
				"</streamConfig>\r\n"
				"</setStreamConfig>\r\n",
		LAST);
	return 0;
}
