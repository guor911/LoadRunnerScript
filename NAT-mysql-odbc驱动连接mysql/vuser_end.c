vuser_end()
{

	lrd_close_cursor(&Csr1, 0);   
	//再关闭连接   
	lrd_close_connection(&Con1, 0, 0);  
	//释放连接，和alloc相呼应，否则有内存泄露   
	lrd_free_connection(&Con1, 0 , 0);  
	//再关闭上下文   
	lrd_close_context(&Ctx1, 0, 0); 
	return 0;
}
