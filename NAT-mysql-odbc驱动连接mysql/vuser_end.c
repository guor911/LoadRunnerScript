vuser_end()
{

	lrd_close_cursor(&Csr1, 0);   
	//�ٹر�����   
	lrd_close_connection(&Con1, 0, 0);  
	//�ͷ����ӣ���alloc���Ӧ���������ڴ�й¶   
	lrd_free_connection(&Con1, 0 , 0);  
	//�ٹر�������   
	lrd_close_context(&Ctx1, 0, 0); 
	return 0;
}
