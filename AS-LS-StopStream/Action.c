Action()
{
	//Stop Stream-------------------------------------------------------------------------
	lr_start_transaction("stopstream");
	web_custom_request("stopStream",
		"URL=http://192.168.139.207:8091/skl-cloud/cloud/stream/stop",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<streamStop>\r\n"
              "<sn>{SN}</sn>\r\n"
              "<channelId>MAIN</channelId>\r\n"
              "<destIp>192.168.139.207</destIp>\r\n"
              "</streamStop>\r\n",
    lr_end_transaction("stopstream", LR_AUTO);

    //LS---------------------------------------------------------------------------------
   	web_reg_save_param("inputStreamPort",
					   "LB=<inputStreamPort>",
					   "RB=</inputStreamPort>",
					   LAST);

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
             //"<destPort>{streamPort}</destPort>\r\n"
			"<destPort>11111</destPort>\r\n"
			"</outputStream>\r\n"
             "</outputStreamList>\r\n"
             "</streamControl>\r\n",
		LAST);
	lr_end_transaction("LS", LR_AUTO);

	//AS----------------------------------------------------------------------------
	web_custom_request("AS",
		"URL=http://192.168.139.207:8091/skl-cloud/cloud/stream/control",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
              "<streamControl xmlns=\"urn:sky-light\" version=\"1.0\">\r\n"
	          "<inputStream>\r\n"
		      "<sn>{SN}</sn>\r\n"
		     "<channelId>MAIN</channelId>\r\n"
		     "<channelName>stream0</channelName>\r\n"
		     "<streamType>PUSH_TS_RTP_TCP</streamType>\r\n"
		     "<videoCode>H.264</videoCode>\r\n"
		     "<audioCode>AAC</audioCode>\r\n"
		     "<resolutionH>1080</resolutionH>\r\n"
		     "<resolutionW>1920</resolutionW>\r\n"
		     "<inputStreamProtocol>1</inputStreamProtocol>\r\n"
	        "</inputStream>\r\n"
	        "<outputStreamList>\r\n"
	    	"<outputStream>\r\n"
			"<outputStreamProtocol>1</outputStreamProtocol>\r\n"
			"<destIp>192.168.139.207</destIp>\r\n"
			"<destPort>{inputStreamPort}</destPort>\r\n"
		    "</outputStream>\r\n"
	        "</outputStreamList>\r\n"
            "</streamControl>\r\n",
		LAST);
	return 0;
}
