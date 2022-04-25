#include "systemc.h"

SC_MODULE (grey_out) {
  sc_in_clk     clock ;         // Clock input of the design
  sc_in<bool>   reset ;         // active high, synchronous Reset input  
  sc_out<sc_uint<3> > led_out;  // 3 bit vector output of the Grey's counter

  //------------Local Variables Here---------------------
  sc_uint<3>	counter;
  sc_uint<3>	left;
  sc_uint<3>	right;
  sc_uint<3>	masked_bit;
  sc_uint<3>	result;

  //------------Code Starts Here-------------------------
  // Below function implements actual counter logic
  void grey_counter_process ()
  {
    // At every rising edge of clock we check if reset is active    
    if (reset.read() == 1)
	{
      counter = 0;
      led_out.write(counter);    
    }     
    else 
	{
		result = 0;
		if (counter == 0){
			result[0] = 0;
			result[1] = 0;
			result[2] = 0;
		}
		else if (counter == 1){
			result[0] = 1;
			result[1] = 0;
			result[2] = 0;
		}
		else if (counter == 2){
			result[0] = 1;
			result[1] = 1;
			result[2] = 0;
		}
		else if (counter == 3){
			result[0] = 0;
			result[1] = 1;
			result[2] = 0;
		}
		else if (counter == 4){
			result[0] = 0;
			result[1] = 1;
			result[2] = 1;
		}
		else if (counter == 5){
			result[0] = 1;
			result[1] = 1;
			result[2] = 1;
		}
		else if (counter == 6){
			result[0] = 1;
			result[1] = 0;
			result[2] = 1;
		}
		else if (counter == 7){
			result[0] = 0;
			result[1] = 0;
			result[2] = 1;
		}
      counter = counter + 1;
	  if (counter == 8)
	  {
		  counter = 0;
	  }
      
      led_out.write(result);
      cout<<"@" << sc_time_stamp() <<" :: Incremented Counter "
        << led_out.read() <<endl;
    }
  } // End of function johnson_process

  // Constructor for the counter
  // Since this counter is a positive edge trigged one,
  // We trigger the below block with respect to positive
  // edge of the clock and also when ever reset changes state
  SC_CTOR(grey_out) {
    cout<<"Executing new"<<endl;
    SC_METHOD(grey_counter_process);
    sensitive << reset;
    sensitive << clock.pos();
  } // End of Constructor

}; // End of Module 
