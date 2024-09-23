`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: ITU Computer Engineering Department
// Engineer: Kerem Ihsan Mercan
// Project Name: BLG222E Project 1 RegisterFile
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile(
    input wire[15:0] I,
    input wire[2:0] OutASel,
    input wire[2:0] OutBSel,
    input wire[2:0] FunSel,
    input wire[3:0] RegSel,
    input wire[3:0] ScrSel,
    input wire Clock,
    output reg [15:0] OutA,
    output reg [15:0] OutB
    );
    
    reg RE1, RE2, RE3, RE4, SE1, SE2, SE3, SE4;
    
    always @(RegSel or ScrSel)
    begin
        RE1 = ~RegSel[3];
        RE2 = ~RegSel[2];
        RE3 = ~RegSel[1];
        RE4 = ~RegSel[0];
        
        SE1 = ~ScrSel[3];
        SE2 = ~ScrSel[2];
        SE3 = ~ScrSel[1];
        SE4 = ~ScrSel[0];
        
        
    end
    
    
    wire [15:0] RQ1, RQ2, RQ3, RQ4, SQ1, SQ2, SQ3, SQ4;
        
    Register R1(.I(I), .E(RE1), .FunSel(FunSel), .Clock(Clock), .Q(RQ1));
    Register R2(.I(I), .E(RE2), .FunSel(FunSel), .Clock(Clock), .Q(RQ2));
    Register R3(.I(I), .E(RE3), .FunSel(FunSel), .Clock(Clock), .Q(RQ3));
    Register R4(.I(I), .E(RE4), .FunSel(FunSel), .Clock(Clock), .Q(RQ4));
    
    Register S1(.I(I), .E(SE1), .FunSel(FunSel), .Clock(Clock), .Q(SQ1));
    Register S2(.I(I), .E(SE2), .FunSel(FunSel), .Clock(Clock), .Q(SQ2));
    Register S3(.I(I), .E(SE3), .FunSel(FunSel), .Clock(Clock), .Q(SQ3));
    Register S4(.I(I), .E(SE4), .FunSel(FunSel), .Clock(Clock), .Q(SQ4));
    
    always @(OutASel or OutBSel)
    begin
        case(OutASel)
            3'b000: assign OutA = RQ1;
            3'b001: assign OutA = RQ2;
            3'b010: assign OutA = RQ3;
            3'b011: assign OutA = RQ4;
            3'b100: assign OutA = SQ1;
            3'b101: assign OutA = SQ2;
            3'b110: assign OutA = SQ3;
            3'b111: assign OutA = SQ4;
        
        endcase
        
        case(OutBSel)
            3'b000: assign OutB = RQ1;
            3'b001: assign OutB = RQ2;
            3'b010: assign OutB = RQ3;
            3'b011: assign OutB = RQ4;
            3'b100: assign OutB = SQ1;
            3'b101: assign OutB = SQ2;
            3'b110: assign OutB = SQ3;
            3'b111: assign OutB = SQ4;
                 
        endcase
    
    end
    
    
    

endmodule
