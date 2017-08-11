#include "lrs.h"


vuser_init()
{
    lrs_startup(257);	
	lr_log_message(lr_eval_string("<snn>"));
    lrs_create_socket("socket0","TCP","RemoteHost=192.168.139.202:26800",LrsLastArg);
	//IPC连接指令中心
	lrs_send("socket0","buf0",LrsLastArg);
	lrs_receive("socket0","buf1",LrsLastArg);
	//lrs_save_param("socket0",NULL,"fff",0,28);
	//lr_output_message(lr_eval_string("<fff>"));
    return 0;
}

