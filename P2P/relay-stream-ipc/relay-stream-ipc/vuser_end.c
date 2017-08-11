#include "lrs.h"


vuser_end()
{
	lrs_close_socket("ipcsocket0");
    lrs_cleanup();

    return 0;
}

