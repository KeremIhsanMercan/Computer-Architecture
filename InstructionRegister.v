`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITU Computer Engineering Department
// Engineer: Kerem Ihsan Mercan
// Project Name: BLG222E Project 1 InstructionRegister
//////////////////////////////////////////////////////////////////////////////////

module InstructionRegister (
    input wire[7:0] I,
    input wire Write,
    input wire LH,
    input wire Clock,
    output reg [15:0] IROut
    );
    
    always @(posedge Clock)
    begin
        if(Write)
        begin
            if(!LH)
            begin
                IROut[0] = I[0];
                IROut[1] = I[1];
                IROut[2] = I[2];
                IROut[3] = I[3];
                IROut[4] = I[4];
                IROut[5] = I[5];
                IROut[6] = I[6];
                IROut[7] = I[7];
                
            end else begin
                IROut[8] = I[0];
                IROut[9] = I[1];
                IROut[10] = I[2];
                IROut[11] = I[3];
                IROut[12] = I[4];
                IROut[13] = I[5];
                IROut[14] = I[6];
                IROut[15] = I[7];

            end
        end 
    end
    
endmodule