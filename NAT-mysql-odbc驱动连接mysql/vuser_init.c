

vuser_init()
{ 

	//��ѯ����   
	//unsigned long count=0;  
	//��ʼ   
	lrd_init(&InitInfo, DBTypeVersion);  
	//��������   
	lrd_open_context(&Ctx1, LRD_DBTYPE_ODBC, 0, 0, 0);  
	//�������ӵ��ڴ�   
	lrd_alloc_connection(&Con1, LRD_DBTYPE_ODBC, Ctx1, 0 , 0);  
	//�����ӣ�ע��DRIVER�������氲װ��   
	lrd_open_connection(&Con1, LRD_DBTYPE_ODBC, "", "","", "Driver={MySQL ODBC 3.51 Driver};Server=192.168.139.206;Database=acc;User=cloud_acc; Password=123456;Option=3;", Ctx1, 1, 0);  
	//���α�   
	lrd_open_cursor(&Csr1,Con1,0); 
	return 0;
}
