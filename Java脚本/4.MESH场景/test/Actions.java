/*
 * LoadRunner Java script. (Build: _build_number_)
 * 
 * Script Description: 
 *                     
 */

import lrapi.lr;
import lrapi.web;

public class Actions
{

	public int init() throws Throwable {
		return 0;
	}//end of init


	public int action() throws Throwable {

		return 0;
	}//end of action


	public int end() throws Throwable {
		return 0;
	}//end of end

	public void test1(){
	    
		if(!updateFWRequest(fwv,s).equals("0")) {
		test1();
		}
		test2();

	    
	}


	public void test2(){
	    dd = checkProgressRequest(s);
		if (status = 0 || status = 1) {
		    test1();

		}else{
		    test2();
		    
		}
	}
	
		   
}
