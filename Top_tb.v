module Top_tb();
    reg clk;
    reg rst;
    reg data_valid;
    reg [7:0] p_data;
    reg PAR_EN;
    reg parity_type;
    
    
    wire  Tx_out;
    wire  busy_1;
    wire serializer_enable_debug;
    
    
    Top DUT(
    .clk(clk),
    .rst(rst),
    .data_valid(data_valid),
    .p_data(p_data),
    .PAR_EN(PAR_EN),
    .parity_type(parity_type),
    .Tx_out(Tx_out),
    .busy_1(busy_1),
     .serializer_enable_debug(serializer_enable_debug)
    );
    
    initial begin
      //reset every thing to ensure proper work for registers , to avoid meatastability and to mimic real cases
    clk = 0;
    rst = 1;
    data_valid = 0;
    p_data = 8'b0;
    PAR_EN = 0;
    parity_type = 0;
    #10;
    rst = 0; 
    #10;
    //my test cases 
    //1st test case :send data without any parity 
    /*@(posedge clk);
p_data = 8'b01010101;
PAR_EN = 0;
parity_type = 0;      //don't care but we write to gurantee free errors

@(posedge clk);
data_valid = 1;

@(posedge clk);
data_valid = 0;

// dont make any changes untill sending is done 
wait (busy_1 == 0);
*/
/*
data_valid = 1;
p_data = 8'b10101010;
PAR_EN = 1;
parity_type = 0;
#20;  // data_valid remains high for 2 clock cycles

data_valid = 0;
#100;*/

 
//2nd test case : data changes suddenly

/*
data_valid = 1;
p_data = 8'b11110000;
PAR_EN = 1;
parity_type = 1;  
#10;  

p_data = 8'b10101010;  
#10;

data_valid = 0;
#100;
*/

    
      
    data_valid = 1;
    p_data = 8'b11001100;
    PAR_EN = 1;
    parity_type = 0;
    #20;
    data_valid = 0;

    
    #40;

   
    data_valid = 1;
    p_data = 8'b10101010;
    #20;
    data_valid = 0;
  
    
    
    
    
    
    
end
 //clock generation 
 always #5 clk = ~clk;





    
    
    
    
    
endmodule
