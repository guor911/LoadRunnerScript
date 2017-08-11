#include "lrs.h"

#define IPC_RELAY_RSP_LEN "13080"
#define APP_RELAY_CMD_RSP_LEN "12"
extern short fiFromHexBinToShort(char *szBuffer);
extern int custom_lrs_receive(char *sock_desc, char *buf_desc,void *dummy);
Action()
{	
	do{	
		int cnt = 10;//rand()%100;
		int num = 0;
		lr_start_transaction("app_recv_stream");
		
		while(num++ < cnt) 
		{
			lrs_receive("appsocket0", "ipc_relay_rsp", LrsLastArg);
		}		
		
		lr_end_transaction("app_recv_stream", LR_AUTO);

		lr_think_time(1);
		lr_start_transaction("app_relay_cmd");
		{
			if(lrs_send("appsocket0", "app_relay_cmd", LrsLastArg)) return -1;
			lrs_receive("appsocket0", "app_relay_cmd_rsp", LrsLastArg);
			//if(custom_lrs_receive("ipcsocket0", "app_relay_cmd_rsp", LrsLastArg)) return -1;
		}
		lr_end_transaction("app_relay_cmd", LR_AUTO);

	
	}while(0);

    return 0;
}

