;WSRData 2 1


send  ipc_login 81
	"\x12\x34\x00\x49\x00\x01\x00\x00"
	"<ipc_uuid>"
	"\n"
	"<app_uuid>"


recv  ipc_login_rsp 8

send  app_login 81
	"\x12\x34\x00\x49\x00\x01\x00\x00"
	"<app_uuid>"
	"\n"
	"<ipc_uuid>"

recv  app_login_rsp 8


send  app_relay_cmd 12
	"\x12\x34\x00\x04\x00\x04\x00\x00"
	"\x00\x00\x00\x01"

recv  app_relay_cmd_rsp 12
#if 1
send  ipc_relay 1308
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	
recv  ipc_relay_rsp 8

#else
send  ipc_relay 13080
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"\x12\x34\x05\x14\x00\x03\x00\x00"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	
recv  ipc_relay_rsp 8
#endif
-1
