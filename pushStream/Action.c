Action()
{
    //get请求
	lr_start_transaction("get11");
	web_disable_keep_alive();

	//发送报文
	web_custom_request("get110",
					   "URL=http://{serverip}/skl-cloud/cloud/stream/control",
					   "Method=POST",
					   "TargetFrame=",
		               "Resource=0",
		               "Referer=",
					   "Body=<?xml version=\"1.0\" encoding=\"utf-8\" ?>\r\n"
					   "<streamControl>\r\n"
                       "<inputStream>\r\n"
					   "<qId>{get_sn}</qId>\r\n"
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
					   "<destIp>192.168.139.206</destIp>\r\n"
					   "<destPort>{get_port}</destPort>\r\n"
					   "</outputStream>\r\n"
					   "</outputStreamList>\r\n"
					   "</streamControl>\r\n",
					   LAST);

	lr_end_transaction("get11", LR_AUTO);

   

	return 0;
}
