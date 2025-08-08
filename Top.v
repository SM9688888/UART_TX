module Top (
    input clk,
    input rst,
    input data_valid,
    input [7:0] p_data,
    input PAR_EN,
    input parity_type,

    output Tx_out,
    output busy_1,
    output wire serializer_enable_debug
);

    // Wires
    wire [1:0] mux_sel;
    wire parity_bit;
    wire ser_out;
    wire start_bit = 1'b0;
    wire end_bit   = 1'b1;
    wire enable;
    wire done;
    wire busy;
    wire load;

    assign load = data_valid & ~busy;
    assign serializer_enable_debug = enable;

    
    Mux M1 (
        .start_bit(start_bit),
        .end_bit(end_bit),
        .ser_out(ser_out),
        .parity(parity_bit),
        .mux_sel(mux_sel),
        .Tx_out(Tx_out)
    );

    
    Par_cal PAR (
        .p_data(p_data),
        .parity_type(parity_type),
        .parity_bit(parity_bit)
    );

    
    Serializer S1 (
        .clk(clk),
        .rst(rst),
        .p_data(p_data),
        .enable(enable),
        .load(load),
        .ser_out(ser_out),
        .done(done),
        .busy(busy)
    );

    
    FSM_control F1 (
        .clk(clk),
        .reset(rst),
        .PAR_EN(PAR_EN),
        .data_valid(data_valid),
        .done(done),
        .enable(enable),
        .mux_sel(mux_sel),
        .busy_1(busy_1)
    );

endmodule

