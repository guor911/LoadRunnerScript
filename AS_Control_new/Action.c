Action()
{
	//lr_rendezvous("point");
	lr_start_transaction("AS");
	web_custom_request("AS",
		"URL=http://192.168.139.206:8091/skl-cloud/cloud/stream/control",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
             "<streamControl xmlns=\"urn:sky-light\" version=\"1.0\">\r\n"
	         "<inputStream>\r\n"
		     "<qId>{SN}</qId>\r\n"
		     "<channelId>MAIN</channelId>\r\n"
		     "<channelName></channelName>\r\n"
		     "<streamType>1</streamType>\r\n"
		     "<videoCode>h264</videoCode>\r\n"
		     "<audioCode>acc</audioCode>\r\n"
		     "<resolutionH>1080</resolutionH>\r\n"
		     "<resolutionW>1920</resolutionW>\r\n"
		     "<inputStreamProtocol>1</inputStreamProtocol>\r\n"
	         "</inputStream>\r\n"
	         "<outputStreamList>\r\n"
	    	 "<outputStream>\r\n"
             "<outputStreamServiceId>1</outputStreamServiceId>\r\n"
			 "<outputStreamProtocol>1</outputStreamProtocol>\r\n"
			 "<destIp>192.168.139.207</destIp>\r\n"
			 "<destPort>11111</destPort>\r\n"
		     "</outputStream>\r\n"
			 "<outputStream>\r\n"
             "<outputStreamServiceId>2</outputStreamServiceId>\r\n"
			 "<outputStreamProtocol>1</outputStreamProtocol>\r\n"
			 "<destIp>192.168.139.208</destIp>\r\n"
			 "<destPort>11112</destPort>\r\n"
		     "</outputStream>\r\n"
	         "</outputStreamList>\r\n"
             "</streamControl>\r\n",
		LAST);
	lr_end_transaction("AS", LR_AUTO);
	return 0;
}
