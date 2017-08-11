Action()
{
   int i;
   char sqlstring[200];
   char sqlstring1[200];
   memset(sqlstring,0,200); 
   memset(sqlstring1,0,200);

 /* static LRD_INIT_INFO InitInfo = {LRD_INIT_INFO_EYECAT};  
  static LRD_DEFAULT_DB_VERSION DBTypeVersion[] =  
	  {  
		  {LRD_DBTYPE_ODBC, LRD_DBVERSION_ODBC_30},  
		  {LRD_DBTYPE_NONE, LRD_DBVERSION_NONE}  
	  };  
  static LRD_CONTEXT FAR * Ctx1;  
  static LRD_CONNECTION FAR * Con1;  
  static LRD_CURSOR FAR *     Csr1; 
char sqlstring[200];
  memset(sqlstring,0,200); 
		//查询行数   
	//unsigned long count=0;  
	//初始   
	lrd_init(&InitInfo, DBTypeVersion);  
	//打开上下文   
	lrd_open_context(&Ctx1, LRD_DBTYPE_ODBC, 0, 0, 0);  
	//申请连接的内存   
	lrd_alloc_connection(&Con1, LRD_DBTYPE_ODBC, Ctx1, 0 , 0);  
	//打开连接，注意DRIVER就是上面安装的   
	lrd_open_connection(&Con1, LRD_DBTYPE_ODBC, "", "","", "Driver={MySQL ODBC 3.51 Driver};Server=192.168.139.207;Database=sklCloud;User=cloud; Password=cloudtest;Option=3;", Ctx1, 1, 0);  
	//打开游标   
	lrd_open_cursor(&Csr1,Con1,0); */

  // for(i=1;i<10000;i++){

	lr_save_string(lr_eval_string("{ud}"),"uuid");
    lr_save_string(lr_eval_string("{ip}"),"ip");
    lr_save_string(lr_eval_string("{port}"),"port");

	strcat(sqlstring,"call HeartBeat('");
	strcat(sqlstring,lr_eval_string("{ud}"));
	strcat(sqlstring,"','");
    strcat(sqlstring,lr_eval_string("{ip}"));
	strcat(sqlstring,"','");
	strcat(sqlstring,lr_eval_string("{port}"));
	strcat(sqlstring,"');");


	strcat(sqlstring1,"call P2pRequest('");
	strcat(sqlstring1,lr_eval_string("{ud}"));
	strcat(sqlstring1,"');");

	for(i=1;i<6000;i++){
         //Sql语句，注意1代表的意思是，立马执行 
	 lr_start_transaction("callheartBeat");
     lrd_stmt(Csr1, sqlstring, -1, 1, 0 , 0); 
	 lr_end_transaction("callheartBeat", LR_AUTO);

	 lr_start_transaction("callP2pRequest");
     lrd_stmt(Csr1, sqlstring1, -1, 1, 0 , 0); 
	 lr_end_transaction("callP2pRequest", LR_AUTO);
     //memset(sqlstring,'\0',sizeof(sqlstring));
	}


/*		lrd_close_cursor(&Csr1, 0);   
	//再关闭连接   
	lrd_close_connection(&Con1, 0, 0);  
	//释放连接，和alloc相呼应，否则有内存泄露   
	lrd_free_connection(&Con1, 0 , 0);  
	//再关闭上下文   
	lrd_close_context(&Ctx1, 0, 0); 


*/
	return 0;
}
