Action()
{
    lr_rendezvous("point");
	lr_start_transaction("LS");
	web_custom_request("LS_control",
		"URL=http://192.168.139.206:9709/skl-cloud/cloud/stream/control",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
             "<streamControl xmlns=\"urn:sky-light\" version=\"1.0\">\r\n"
	         "<inputStream>\r\n"
		     "<qId>{SN}</qId>\r\n"
		     "<channelId>MAIN</channelId>\r\n"
		     "<channelName>guorui</channelName>\r\n"
		     "<streamType>PUSH_TS_RTP_TCP</streamType>\r\n"
		     "<videoCode>h264</videoCode>\r\n"
		     "<audioCode>acc</audioCode>\r\n"
		     "<resolutionH>1080</resolutionH>\r\n"
		     "<resolutionW>1920</resolutionW>\r\n"
		     "<inputStreamProtocol>1</inputStreamProtocol>\r\n"
	         "</inputStream>\r\n"
	         "<outputStreamList>\r\n"
	    	 //"<outputStream>\r\n"
			 //"<outputStreamProtocol>1</outputStreamProtocol>\r\n"
			 //"<destIp>127.0.0.0.1</destIp>\r\n"
			 //"<destPort>11111</destPort>\r\n"
		     //"</outputStream>\r\n"
	         "</outputStreamList>\r\n"
             "</streamControl>\r\n",
		LAST);
	lr_end_transaction("LS", LR_AUTO);
	//lr_think_time(120);
    
	return 0;
}
