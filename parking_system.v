`timescale 1ns/1ns
module parking_system(clock,register, g1_reset, car_exit, exit_from, exit_code, car_arrival,available_slots,can_park, l0,l1,l2,l3,l4,l5,l6,l7);
input clock, g1_reset;
input car_arrival, car_exit;
input[2:0]exit_from;
input[7:0]exit_code;
output reg [2:0] available_slots;
output reg can_park;
output reg [7:1]register;
reg[2:0]spot;
reg[7:0]temp;
integer i;
output reg [7:0]l0,l1,l2,l3,l4,l5,l6,l7;
reg match;
always @(posedge clock) begin
    if(car_exit)
    begin 
        case (exit_from)
            7:begin
                if (exit_code==l7) match =1;
                else match = 0;
              end 
              6:begin
                if (exit_code==l6) match =1;
                else match = 0;
              end 
              5:begin
                if (exit_code==l5) match =1;
                else match = 0;
              end 
              4:begin
                if (exit_code==l4) match =1;
                else match = 0;
              end 
              3:begin
                if (exit_code==l3) match =1;
                else match = 0;
              end 
              2:begin
                if (exit_code==l2) match =1;
                else match = 0;
              end 
              1:begin
                if (exit_code==l1) match =1;
                else match = 0;
              end 
              0:begin
                if (exit_code==l0) match =1;
                else match = 0;
              end 
           
        endcase
        if(match)
        begin
            available_slots <= available_slots + 1;
            can_park <= 1;
            register[exit_from] <= 0;
        end
        else
        begin
            available_slots <= available_slots;
            register[exit_from] <= register[exit_from];
        end
    end
    if (g1_reset) 
    begin

    available_slots <= 3'b111;
    register <= 0;
    can_park <= 1;
    end

    else if(!available_slots)
    can_park <= 0;

    else if(car_arrival)
    begin 
        can_park <=1;
        available_slots <= available_slots - 1;

    for (i=1; i<7; i++) 
    begin
    if(register[i]==0) 
    spot = 1;
    end
register[spot] <=1;
task_passcode(spot, temp);
begin

    case(spot)
         7 : l7 = temp;
         6 : l6 = temp;
         5 : l5 = temp;
         4 : l4 = temp;
         3 : l3 = temp;
         2 : l2 = temp;
         1 : l1 = temp;
         0 : l0 = temp;
            endcase
end

end
end
task task_passcode;
input [2:0]slot_number;
output reg[7:0]Q;

begin
    case(slot_number)
    3'b111: Q = 1+2+3+5+8+13+21+34;
    3'b110: Q = 1+2+3+5+8+13+21;
    3'b101: Q = 1+2+3+5+8+13;
    3'b100: Q = 1+2+3+5+8;
    3'b011: Q = 1+2+3+5;
    3'b010: Q = 1+2+3;
    3'b001: Q = 1+2;
    3'b000: Q = 1;
endcase
end
endtask
endmodule