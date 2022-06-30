`include "parking_system.v"


module tb_parking_system;
reg clock, g1_reset;
reg car_arrival, car_exit;
reg [2:0]exit_from;
reg [7:0]exit_code;

wire [2:0] available_slots;
wire can_park;
wire [7:1]register;
wire [7:0]l0,l1,l2,l3,l4,l5,l6,l7;

parking_system  test( clock,register, g1_reset, car_exit, exit_from, exit_code, car_arrival,available_slots,can_park, l0,l1,l2,l3,l4,l5,l6,l7
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clock=~clock;

initial begin
    $dumpfile("tb_parking_system.vcd");
    $dumpvars(0, tb_parking_system);
end

initial begin
  g1_reset=0;
  car_arrival=0;
  car_exit=0;
  exit_from=0;
  exit_code=0;
end
initial begin
    #10 car_arrival=1;
    #10 car_arrival=0;
    #10 car_exit=1; exit_from=3'b111; exit_code=54;
    #10 car_exit=0;  exit_from=3'b000; exit_code=0;
    #10 car_arrival=1; #10 car_arrival=0;
    #30 car_arrival=1; #10 car_arrival=0;
    #10 car_exit=1; exit_from=3'b110; exit_code=53;  #10 car_exit=0; exit_from=3'b000; exit_code=0;

end

endmodule
