module Par_cal(
input [7:0] p_data,
input parity_type ,

output parity_bit

);
assign parity_bit = (parity_type == 1'b0) ? ^p_data : ~^p_data;
endmodule 