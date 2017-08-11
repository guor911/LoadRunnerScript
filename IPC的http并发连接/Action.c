Action()
{
    
	//lr_rendezvous("run1000");
	lr_start_transaction("ipc-http-connect");

    //获取流通道信息
    web_disable_keep_alive();

	web_custom_request("getipc",
					   "URL=http://{serverIP}/sklcloud/skl-cloud/appremote/{SN}/PSIA/Streaming/channels/MAIN",
					   "Method=POST",
					   "TargetFrame=",
		               "Resource=0",
		               "Referer=",
					   "Body=<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n"
                       "<request>\r\n"
                       "<httpCmd>\r\n"
                       "<method>GET</method>\r\n"
                       "<uri>/PSIA/Streaming/channels/MAIN</uri>\r\n"
                       "<httpVersion>1.0</httpVersion>\r\n"
                       "</httpCmd>\r\n"
                       "<headers>\r\n"
                       "</headers>\r\n"       
                       "<body></body>\r\n"
                       "</request>\r\n",
					   LAST);
					   
	lr_end_transaction("ipc-http-connect", LR_AUTO);

    //lr_think_time(2);


	return 0;
}
