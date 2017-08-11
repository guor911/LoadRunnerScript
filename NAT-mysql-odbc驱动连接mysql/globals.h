#ifndef _GLOBALS_H
#define _GLOBALS_H

//--------------------------------------------------------------------
// Include Files
#include "lrun.h"
#include "print.inl"
#include "web_api.h"
#include "vdf.h"
#include "lrw_custom_body.h"
#include "lrd.h"

//--------------------------------------------------------------------
// Global Variables

	static LRD_INIT_INFO InitInfo = {LRD_INIT_INFO_EYECAT};  
	static LRD_DEFAULT_DB_VERSION DBTypeVersion[] =  
		{  
			{LRD_DBTYPE_ODBC, LRD_DBVERSION_ODBC_30},  
			{LRD_DBTYPE_NONE, LRD_DBVERSION_NONE}  
		};  
	static LRD_CONTEXT FAR * Ctx1;  
	static LRD_CONNECTION FAR * Con1;  
	static LRD_CURSOR FAR *     Csr1; 


#endif // _GLOBALS_H
