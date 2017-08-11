Action()
{
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
		LAST);
	return 0;
}
