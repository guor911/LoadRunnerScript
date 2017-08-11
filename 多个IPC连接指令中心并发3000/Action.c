#include "lrs.h"

Action()
{
	lr_start_transaction("ipccomand");
	lrs_send("socket0","buf2",LrsLastArg);
	lrs_receive("socket0","buf3",LrsLastArg);
    lr_end_transaction("ipccomand", LR_AUTO);
    lr_think_time(30);
    return 0;
}
