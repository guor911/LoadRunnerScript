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
	    web.save_timestamp_param("time",LAST);
	    lr.output_message(lr.eval_string(""+lr.eval_string("<time>")+""));
		return 0;
	}//end of action


	public int end() throws Throwable {
		return 0;
	}//end of end
}
