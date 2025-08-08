module Serializer(
input clk,
input rst ,
input [7:0] p_data,
input enable,
input load,

output reg ser_out,
output reg done,
output reg busy
);

//////shift_register to store data/////
reg [7:0] shift_reg;
reg [2:0] bit_counter;

always@(posedge clk or posedge rst)
begin
    if(rst)
    begin
        bit_counter <= 0;
        done <= 0;
        busy <= 0;
        ser_out <= 0;
    end

    else if(load)
    begin
        shift_reg <= p_data >> 1;           // Shift out the LSB before storing
        ser_out <= p_data[0];               // Output LSB immediately
        bit_counter <= 3'b001;              // We already sent 1 bit
        done <= 0;
        busy <= 1;
    end

    else if (busy && enable)
    begin
        ser_out <= shift_reg[0];           // Output next LSB
        shift_reg <= shift_reg >> 1;

        if (bit_counter == 3'b111)         // Already sent 7 bits, now this is the 8th
        begin
            done <= 1;
            busy <= 0;
        end
        else
        begin
            bit_counter <= bit_counter + 1;
        end
    end
end

endmodule
