#include "lrs.h"

#define IPC_RELAY_RSP_LEN "80"
#define APP_RELAY_CMD_RSP_LEN "12"
#define TEST   "1080"

extern short fiFromHexBinToShort(char *szBuffer);
extern int custom_lrs_receive(char *sock_desc, char *buf_desc,void *dummy);

Action()
{	
	int sec = 1;
	do{	
		int cnt = 10;//rand()%100;
		int num = 0;
        merc_timer_handle_t timer;
		double delta;
		timer = lr_start_timer();
        
	   //lr_rendezvous("ipc_relay_rendezvous");

		lr_start_transaction("ipc_relay");
		while(num++ < cnt) 
		{
			if(lrs_send("ipcsocket0", "ipc_relay_mutli"TEST, LrsLastArg)) return -1; 

			//if(lrs_send("ipcsocket0", "ipc_relay", LrsLastArg)) return -1; 
			//if(lrs_receive_ex("appsocket0", "ipc_relay_rsp", "NumberOfBytesToRecv="IPC_RELAY_RSP_LEN, LrsLastArg)) return -1;
		}
		//if(lrs_receive_ex("ipcsocket0", "ipc_relay_rsp", "NumberOfBytesToRecv="IPC_RELAY_RSP_LEN, LrsLastArg)) return -1;
		//lrs_receive("ipcsocket0", "ipc_relay_rsp", LrsLastArg);
		lrs_receive("ipcsocket0", "ipc_relay_mutli_rsp"TEST, LrsLastArg);

		lr_end_transaction("ipc_relay", LR_AUTO);

		delta = 1 - lr_end_timer(timer);
		if(delta > 0)lr_think_time(delta);

	}while(--sec);

    //lr_think_time(2);

    return 0;
}

