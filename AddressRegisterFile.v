`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITU Computer Engineering Department
// Engineer: Kerem Ihsan Mercan
// Project Name: BLG222E Project 1 AddressRegisterFile
//////////////////////////////////////////////////////////////////////////////////

module AddressRegisterFile(
    input wire[15:0] I,
    input wire[1:0] OutCSel,
    input wire[1:0] OutDSel,
    input wire[2:0] FunSel,
    input wire[2:0] RegSel,
    input wire Clock,
    output reg [15:0] OutC,
    output reg [15:0] OutD
    );
    
    reg PCE, ARE, SPE;
        
    always @(RegSel)
    begin
        SPE = ~RegSel[0];
        ARE = ~RegSel[1];
        PCE = ~RegSel[2];
             
    end
    
    wire [15:0] PCQ, ARQ, SPQ;
    
    Register PC(.I(I), .E(PCE), .FunSel(FunSel), .Clock(Clock), .Q(PCQ));
    Register AR(.I(I), .E(ARE), .FunSel(FunSel), .Clock(Clock), .Q(ARQ));
    Register SP(.I(I), .E(SPE), .FunSel(FunSel), .Clock(Clock), .Q(SPQ));
    
    always @(OutCSel or OutDSel)
    begin
        case(OutCSel)
            2'b00: assign OutC = PCQ;
            2'b01: assign OutC = PCQ;
            2'b10: assign OutC = ARQ;
            2'b11: assign OutC = SPQ;
        endcase
            
        case(OutDSel)
            3'b00: assign OutD = PCQ;
            3'b01: assign OutD = PCQ;
            3'b10: assign OutD = ARQ;
            3'b11: assign OutD = SPQ;                     
        endcase
        
    end
    
endmodule