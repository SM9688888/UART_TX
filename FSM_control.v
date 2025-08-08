module FSM_control (
input clk,
input reset,
input PAR_EN,
input data_valid,
input done,
output reg  enable,
output reg  [1:0] mux_sel,
output reg busy_1

);
localparam IDLE   = 3'b000,
           START  = 3'b001,
           DATA   = 3'b010,
           PARITY = 3'b011,
           STOP   = 3'b100;
reg [2:0] current_state, next_state;
always @(posedge clk or posedge reset)
 begin
    if (reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end
always @(*) 
begin
    case (current_state)

        IDLE: 
        begin
            if (data_valid)
                next_state = START;
            else
                next_state = IDLE;
        end
        START: 
        begin
             next_state = DATA;
        end
        DATA:
        begin
            if(done)
            begin
               if (PAR_EN==1)
               begin
                next_state = PARITY;
               end
               else 
                 next_state = STOP;
            end
            else
                next_state = DATA;
        end
        PARITY:
        begin
            next_state = STOP;
        end
        STOP:
        begin
            next_state = IDLE;
        end

    endcase
end


//output logic
always @(*)
   
begin
    enable  = 0;
    mux_sel = 2'b00;
    busy_1  = 0;
        case (current_state)
        IDLE:
        begin
            enable  = 1'b0;
            mux_sel = 2'b11;
            busy_1  = 1'b0;
        end

        START:
        
        begin
            enable  = 1'b0;
            mux_sel = 2'b00;
            busy_1  = 1'b1;

        end

        DATA:
        begin
            enable = 1'b1;
            mux_sel = 2'b01;
            busy_1 = 1'b1;
        end
        PARITY:
        begin
            enable  = 1'b0;  //stop serializing   
            mux_sel = 2'b10;    
            busy_1  = 1'b1;  
        end
        STOP:
        begin
            enable  = 1'b0;    
            mux_sel = 2'b11;    
            busy_1  = 1'b1;  
        end         
        endcase 
end

endmodule