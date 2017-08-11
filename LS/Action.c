Action()
{
    lr_rendezvous("point");
	lr_start_transaction("LS");
	web_custom_request("LS",
		   "URL=http://192.168.139.207:9709/skl-cloud/cloud/stream/control",
		   "Method=POST",
		   "TargetFrame=",
		   "Resource=0",
		   "Referer=",
		   "Body=<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n"
				"<streamControl>\r\n"
				"<inputStream>\r\n"
				"<sn>{SN}</sn>\r\n"
				"<channelId>MAIN</channelId>\r\n"
				"<channelName>xiaowenbin</channelName>\r\n"
				"<streamType>PUSH_TS_RTP_TCP</streamType>\r\n"
				"<videoCode>h264</videoCode>\r\n"
				"<audioCode>aac</audioCode>\r\n"
				"<resolutionH>640</resolutionH>\r\n"
				"<resolutionW>320</resolutionW>\r\n"
				"<inputStreamProtocol>1</inputStreamProtocol>\r\n"
				"</inputStream>\r\n"
				"<outputStreamList>\r\n"
				"<outputStream>\r\n"
				"<outputStreamProtocol>1</outputStreamProtocol>\r\n"
				"<destIp>192.168.139.208</destIp>\r\n"
				//"<destPort>{destPort}</destPort>\r\n"
				"<destPort>11111</destPort>\r\n"
				"</outputStream>\r\n"
				"</outputStreamList>\r\n"
				"</streamControl>\r\n",
		   LAST);
    
	lr_end_transaction("LS", LR_AUTO);
	//lr_think_time(120);
    
	return 0;
}
