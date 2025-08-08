module Mux (
    input start_bit ,
    input end_bit,
    input ser_out,
    input parity,
    input [1:0] mux_sel,

    output reg Tx_out
);


always @(*) begin
    case (mux_sel)
        2'b00: Tx_out = start_bit;   
        2'b01: Tx_out = ser_out;     
        2'b10: Tx_out = parity;      
        2'b11: Tx_out = end_bit;     
        default: Tx_out = 1'b1;      
    endcase
end



endmodule