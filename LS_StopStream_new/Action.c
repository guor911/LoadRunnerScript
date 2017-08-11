Action()
{
	lr_start_transaction("LS_Stop");
		web_custom_request("stopStream_LS",
		"URL=http://192.168.139.206:9709/skl-cloud/cloud/stream/stop",
		"Method=POST",
		"TargetFrame=",
		"Resource=0",
		"Referer=",
		"Body=<streamStop>\r\n"
              "<qId>{SN}</qId>\r\n"
              "<channelId>MAIN</channelId>\r\n"
			  "<destIp>127.0.0.1</destIp>\r\n"
              "</streamStop>\r\n",
		LAST);
		lr_end_transaction("LS_Stop",LR_AUTO);
	return 0;
}
