`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITU Computer Engineering Department
// Engineer: Kerem Ihsan Mercan
// Project Name: BLG222E Project 1 Register
//////////////////////////////////////////////////////////////////////////////////

module Register(
    input wire [15:0] I,
    input wire E,
    input wire [2:0] FunSel,
    input wire Clock,
    output reg [15:0] Q
    );
    
    always @(posedge Clock)
    begin
        if(E)
        begin
            case(FunSel)
                3'b000 : Q = Q-1;
                3'b001 : Q = Q+1;
                3'b010 : begin
                            Q[0] = I[0];
                            Q[1] = I[1];
                            Q[2] = I[2];
                            Q[3] = I[3];
                            Q[4] = I[4];
                            Q[5] = I[5];
                            Q[6] = I[6];
                            Q[7] = I[7];
                            Q[8] = I[8];
                            Q[9] = I[9];
                            Q[10] = I[10];
                            Q[11] = I[11];
                            Q[12] = I[12];
                            Q[13] = I[13];
                            Q[14] = I[14];
                            Q[15] = I[15];
                            end
                3'b011 : begin
                            Q[0] = 1'b0;
                            Q[1] = 1'b0;
                            Q[2] = 1'b0;
                            Q[3] = 1'b0;
                            Q[4] = 1'b0;
                            Q[5] = 1'b0;
                            Q[6] = 1'b0;
                            Q[7] = 1'b0;
                            Q[8] = 1'b0;
                            Q[9] = 1'b0;
                            Q[10] = 1'b0;
                            Q[11] = 1'b0;
                            Q[12] = 1'b0;
                            Q[13] = 1'b0;
                            Q[14] = 1'b0;
                            Q[15] = 1'b0;
                            end
                3'b100 : begin
                            Q[0] = I[0];
                            Q[1] = I[1];
                            Q[2] = I[2];
                            Q[3] = I[3];
                            Q[4] = I[4];
                            Q[5] = I[5];
                            Q[6] = I[6];
                            Q[7] = I[7];
                            Q[8] = 1'b0;
                            Q[9] = 1'b0;
                            Q[10] = 1'b0;
                            Q[11] = 1'b0;
                            Q[12] = 1'b0;
                            Q[13] = 1'b0;
                            Q[14] = 1'b0;
                            Q[15] = 1'b0;
                            end
                3'b101 : begin
                            Q[0] = I[0];
                            Q[1] = I[1];
                            Q[2] = I[2];
                            Q[3] = I[3];
                            Q[4] = I[4];
                            Q[5] = I[5];
                            Q[6] = I[6];
                            Q[7] = I[7];
                            end
                3'b110 : begin
                            Q[8] = I[0];
                            Q[9] = I[1];
                            Q[10] = I[2];
                            Q[11] = I[3];
                            Q[12] = I[4];
                            Q[13] = I[5];
                            Q[14] = I[6];
                            Q[15] = I[7];
                            end
                3'b111 : begin
                            Q[0] = I[0];
                            Q[1] = I[1];
                            Q[2] = I[2];
                            Q[3] = I[3];
                            Q[4] = I[4];
                            Q[5] = I[5];
                            Q[6] = I[6];
                            Q[7] = I[7];
                            Q[8] = I[7];
                            Q[9] = I[7];
                            Q[10] = I[7];
                            Q[11] = I[7];
                            Q[12] = I[7];
                            Q[13] = I[7];
                            Q[14] = I[7];
                            Q[15] = I[7];
                         end
            endcase
        end
    end

endmodule