Action()
{
	lr_start_transaction("AS_Stop");
		web_custom_request("stopStream_AS",
		"URL=http://192.168.139.206:8091/skl-cloud/cloud/stream/stop",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<streamStop>\r\n"
              "<qId>{SN}</qId>\r\n"
              "<channelId>MAIN</channelId>\r\n"
              "<outputStreamList>\r\n"
			  "<outputStream>\r\n"
			  "<outputStreamServiceId>1</outputStreamServiceId>\r\n"
			  "<destIp>192.168.139.207</destIp>\r\n"
			  "<destPort>11111</destPort>\r\n"
			  "</outputStream>\r\n"
			  "<outputStream>\r\n"
			  "<outputStreamServiceId>2</outputStreamServiceId>\r\n"
			  "<destIp>192.168.139.208</destIp>\r\n"
			  "<destPort>11112</destPort>\r\n"
			  "</outputStream>\r\n"
			  "</outputStreamList>\r\n"
              "</streamStop>\r\n",
		LAST);
		lr_end_transaction("AS_Stop",LR_AUTO);
	return 0;
}
