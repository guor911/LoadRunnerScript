#include "lrs.h"


int count;
int i = 1;        
char port[100];
int result;
char recvbuf[1024];
int len = 0;
char *ipcPort;
char *appPort;
const char *RHost = "RemoteHost=192.168.139.207:8300";

int ch = 0;
/* 
    szBuffer - length = Fix size 2 bytes. 
*/ 
short fiFromHexBinToShort(char *szBuffer) 
{ 
    int i = 0, iShortValue = 0, iExp = 16*16; 
    
	iShortValue += (szBuffer[i] & 0x000f) * iExp + ((szBuffer[i] & 0x00f0) >> 4) * iExp * 16; 
	++i;
	iExp = 1;
	iShortValue += (szBuffer[i] & 0x000f) * iExp + ((szBuffer[i] & 0x00f0) >> 4) * iExp * 16; 
    
    return iShortValue;
} 

int custom_lrs_receive(char *sock_desc, char *buf_desc,void *dummy) 
{ 
	int rc;
	short len = 0,code = 0;
	int buf_len = 8;
	char szBytesLength[30], *buf = NULL, *pszError, *pszLastChar;
	/* Get first 8 bytes */ 
	rc = lrs_receive_ex(sock_desc, buf_desc, "NumberOfBytesToRecv=8", LrsLastArg); 
	if (rc != 0) 
	{ 
		lr_error_message("Receive 8 bytes failed. The error code = %d", rc);
		return -1; 
	}    /* Receive failed */ 

	lrs_get_last_received_buffer(sock_desc, &buf, &buf_len); 	
	if (buf == NULL || buf_len != 8) 	
	{ 	
		lr_error_message("receive of %s failed", buf_desc); 	
		return -1; 
	} 
	/* Compute buffer length */ 
	len = fiFromHexBinToShort(buf+2);
	code = fiFromHexBinToShort(buf+6);
	if(code)
	{
		lr_error_message("+++++++++++svr rsp error code :%d--------------", code);
		return -1;
	}
	if(len)
	{
		sprintf (szBytesLength, "NumberOfBytesToRecv=%d",len);
		lr_debug_message(LR_MSG_CLASS_FULL_TRACE, "++++++++++++++Bytes length = %s", szBytesLength); 
		/* Get the buffer according to the length */
		rc = lrs_receive_ex(sock_desc, buf_desc, szBytesLength, LrsLastArg); 
		if (rc != 0) /* Receive failed */ 
		return -1; 
	}	

	return 0; 
} 

vuser_init()
{
	int ret = 0;
    lrs_startup(257);

	srand(time(NULL));
	
	lrs_create_socket("appsocket0", "TCP", RHost,  LrsLastArg);
	
	appPort = lrs_get_socket_attrib("appsocket0", LOCAL_PORT );
	itoa(appPort, port, 10);
	lr_save_string(port,"remoteport2");

	lr_start_transaction("app_login");
	{
		if(lrs_send("appsocket0", "app_login", LrsLastArg)) return -1;
		if(custom_lrs_receive("appsocket0", "app_login_rsp", LrsLastArg)) return -1;
	}
	lr_end_transaction("app_login", LR_AUTO);

	lrs_set_send_timeout(60,0);
	lrs_set_recv_timeout(0,10000);
	lrs_set_recv_timeout2(0,100000);

    return 0;
}

