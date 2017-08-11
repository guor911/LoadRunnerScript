

vuser_init()
{ 

	//查询行数   
	//unsigned long count=0;  
	//初始   
	lrd_init(&InitInfo, DBTypeVersion);  
	//打开上下文   
	lrd_open_context(&Ctx1, LRD_DBTYPE_ODBC, 0, 0, 0);  
	//申请连接的内存   
	lrd_alloc_connection(&Con1, LRD_DBTYPE_ODBC, Ctx1, 0 , 0);  
	//打开连接，注意DRIVER就是上面安装的   
	lrd_open_connection(&Con1, LRD_DBTYPE_ODBC, "", "","", "Driver={MySQL ODBC 3.51 Driver};Server=192.168.139.206;Database=acc;User=cloud_acc; Password=123456;Option=3;", Ctx1, 1, 0);  
	//打开游标   
	lrd_open_cursor(&Csr1,Con1,0); 
	return 0;
}
