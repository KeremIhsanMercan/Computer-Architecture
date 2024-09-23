`timescale 1ns / 1ps

module ArithmeticLogicUnit(
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [4:0] FunSel,
    input wire WF,
    input wire Clock,
    output reg [15:0] ALUOut,
    output reg [3:0] FlagsOut
    );
    
    always @(FunSel or A or B) // try * if doesnt work
    begin
        case(FunSel)
            5'b00000: begin
                ALUOut[0] = A[0];
                ALUOut[1] = A[1];
                ALUOut[2] = A[2];
                ALUOut[3] = A[3];
                ALUOut[4] = A[4];
                ALUOut[5] = A[5];
                ALUOut[6] = A[6];
                ALUOut[7] = A[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b00001: begin
                ALUOut[0] = B[0];
                ALUOut[1] = B[1];
                ALUOut[2] = B[2];
                ALUOut[3] = B[3];
                ALUOut[4] = B[4];
                ALUOut[5] = B[5];
                ALUOut[6] = B[6];
                ALUOut[7] = B[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b00010: begin
                ALUOut[0] = ~A[0];
                ALUOut[1] = ~A[1];
                ALUOut[2] = ~A[2];
                ALUOut[3] = ~A[3];
                ALUOut[4] = ~A[4];
                ALUOut[5] = ~A[5];
                ALUOut[6] = ~A[6];
                ALUOut[7] = ~A[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b00011: begin
                ALUOut[0] = ~B[0];
                ALUOut[1] = ~B[1];
                ALUOut[2] = ~B[2];
                ALUOut[3] = ~B[3];
                ALUOut[4] = ~B[4];
                ALUOut[5] = ~B[5];
                ALUOut[6] = ~B[6];
                ALUOut[7] = ~B[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b00100: begin
                ALUOut = A + B;
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;                
            end
            5'b00101: begin
                ALUOut = A + B + FlagsOut[2];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;                
            end
            5'b00110: begin
                ALUOut = A - B;
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;                
            end
            5'b00111: begin
                ALUOut[0] = A[0] & B[0];
                ALUOut[1] = A[1] & B[1];
                ALUOut[2] = A[2] & B[2];
                ALUOut[3] = A[3] & B[3];
                ALUOut[4] = A[4] & B[4];
                ALUOut[5] = A[5] & B[5];
                ALUOut[6] = A[6] & B[6];
                ALUOut[7] = A[7] & B[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01000: begin
                ALUOut[0] = A[0] | B[0];
                ALUOut[1] = A[1] | B[1];
                ALUOut[2] = A[2] | B[2];
                ALUOut[3] = A[3] | B[3];
                ALUOut[4] = A[4] | B[4];
                ALUOut[5] = A[5] | B[5];
                ALUOut[6] = A[6] | B[6];
                ALUOut[7] = A[7] | B[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01001: begin
                ALUOut[0] = A[0] ^ B[0];
                ALUOut[1] = A[1] ^ B[1];
                ALUOut[2] = A[2] ^ B[2];
                ALUOut[3] = A[3] ^ B[3];
                ALUOut[4] = A[4] ^ B[4];
                ALUOut[5] = A[5] ^ B[5];
                ALUOut[6] = A[6] ^ B[6];
                ALUOut[7] = A[7] ^ B[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01010: begin
                ALUOut[0] = ~(A[0] & B[0]);
                ALUOut[1] = ~(A[1] & B[1]);
                ALUOut[2] = ~(A[2] & B[2]);
                ALUOut[3] = ~(A[3] & B[3]);
                ALUOut[4] = ~(A[4] & B[4]);
                ALUOut[5] = ~(A[5] & B[5]);
                ALUOut[6] = ~(A[6] & B[6]);
                ALUOut[7] = ~(A[7] & B[7]);
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01011: begin
                ALUOut[0] = 0;
                ALUOut[1] = A[0];
                ALUOut[2] = A[1];
                ALUOut[3] = A[2];
                ALUOut[4] = A[3];
                ALUOut[5] = A[4];
                ALUOut[6] = A[5];
                ALUOut[7] = A[6];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01100: begin
                ALUOut[0] = A[1];
                ALUOut[1] = A[2];
                ALUOut[2] = A[3];
                ALUOut[3] = A[4];
                ALUOut[4] = A[5];
                ALUOut[5] = A[6];
                ALUOut[6] = A[7];
                ALUOut[7] = 0;
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01101: begin
                ALUOut[0] = A[1];
                ALUOut[1] = A[2];
                ALUOut[2] = A[3];
                ALUOut[3] = A[4];
                ALUOut[4] = A[5];
                ALUOut[5] = A[6];
                ALUOut[6] = A[7];
                ALUOut[7] = A[7];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;                
            end
            5'b01110: begin
                ALUOut[0] = FlagsOut[2];
                ALUOut[1] = A[0];
                ALUOut[2] = A[1];
                ALUOut[3] = A[2];
                ALUOut[4] = A[3];
                ALUOut[5] = A[4];
                ALUOut[6] = A[5];
                ALUOut[7] = A[6];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            5'b01111: begin
                ALUOut[0] = A[1];
                ALUOut[1] = A[2];
                ALUOut[2] = A[3];
                ALUOut[3] = A[4];
                ALUOut[4] = A[5];
                ALUOut[5] = A[6];
                ALUOut[6] = A[7];
                ALUOut[7] = FlagsOut[2];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;
            end
            
            
            5'b10000: ALUOut = A;
            5'b10001: ALUOut = B;
            5'b10010: ALUOut = ~A;
            5'b10011: ALUOut = ~B;
            5'b10100: ALUOut = A + B;
            5'b10101: ALUOut = A + B + FlagsOut[2];
            5'b10110: ALUOut = A - B;
            5'b10111: ALUOut = A & B;
            5'b11000: ALUOut = A | B;
            5'b11001: ALUOut = A ^ B;
            5'b11010: ALUOut = ~(A & B);
            5'b11011: begin
                ALUOut[0] = 0;
                ALUOut[1] = A[0];
                ALUOut[2] = A[1];
                ALUOut[3] = A[2];
                ALUOut[4] = A[3];
                ALUOut[5] = A[4];
                ALUOut[6] = A[5];
                ALUOut[7] = A[6];
                ALUOut[8] = A[7];
                ALUOut[9] = A[8];
                ALUOut[10] = A[9];
                ALUOut[11] = A[10];
                ALUOut[12] = A[11];
                ALUOut[13] = A[12];
                ALUOut[14] = A[13];
                ALUOut[15] = A[14];
            end
            5'b11100: begin
                ALUOut[0] = A[1];
                ALUOut[1] = A[2];
                ALUOut[2] = A[3];
                ALUOut[3] = A[4];
                ALUOut[4] = A[5];
                ALUOut[5] = A[6];
                ALUOut[6] = A[7];
                ALUOut[7] = A[8];
                ALUOut[8] = A[9];
                ALUOut[9] = A[10];
                ALUOut[10] = A[11];
                ALUOut[11] = A[12];
                ALUOut[12] = A[13];
                ALUOut[13] = A[14];
                ALUOut[14] = A[15];
                ALUOut[15] = 0;
            end
            5'b11101: begin
                ALUOut[0] = A[1];
                ALUOut[1] = A[2];
                ALUOut[2] = A[3];
                ALUOut[3] = A[4];
                ALUOut[4] = A[5];
                ALUOut[5] = A[6];
                ALUOut[6] = A[7];
                ALUOut[7] = A[8];
                ALUOut[8] = A[9];
                ALUOut[9] = A[10];
                ALUOut[10] = A[11];
                ALUOut[11] = A[12];
                ALUOut[12] = A[13];
                ALUOut[13] = A[14];
                ALUOut[14] = A[15];
                ALUOut[15] = A[15];
            end
            5'b11110: begin
                ALUOut[0] = FlagsOut[2];
                ALUOut[1] = A[0];
                ALUOut[2] = A[1];
                ALUOut[3] = A[2];
                ALUOut[4] = A[3];
                ALUOut[5] = A[4];
                ALUOut[6] = A[5];
                ALUOut[7] = A[6];
                ALUOut[8] = A[7];
                ALUOut[9] = A[8];
                ALUOut[10] = A[9];
                ALUOut[11] = A[10];
                ALUOut[12] = A[11];
                ALUOut[13] = A[12];
                ALUOut[14] = A[13];
                ALUOut[15] = A[14];
            end
            5'b11111: begin
                ALUOut[0] = A[1];
                ALUOut[1] = A[2];
                ALUOut[2] = A[3];
                ALUOut[3] = A[4];
                ALUOut[4] = A[5];
                ALUOut[5] = A[6];
                ALUOut[6] = A[7];
                ALUOut[7] = A[8];
                ALUOut[8] = A[9];
                ALUOut[9] = A[10];
                ALUOut[10] = A[11];
                ALUOut[11] = A[12];
                ALUOut[12] = A[13];
                ALUOut[13] = A[14];
                ALUOut[14] = A[15];
                ALUOut[15] = FlagsOut[2];
            end
        endcase
    end
    
    always@ (posedge Clock)
    begin
        if(WF)
        begin
            case(FunSel)
            
            5'b00000: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b00001: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b00010: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b00011: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b00100: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if (A[7] == B[7])
                begin
                    if (A[7] == 0)
                    begin
                        FlagsOut[2] = 0;
                    end else begin
                        FlagsOut[2] = 1;
                    end
                end else begin
                    if (ALUOut[7] == 0)
                    begin
                        FlagsOut[2] = 1;    
                    end else begin
                        FlagsOut[2] = 0;
                    end
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                if (A[7] == B[7])
                begin
                    if (ALUOut[7] == A[7])
                    begin
                        FlagsOut[0] = 0;
                    end else begin
                        FlagsOut[0] = 1;
                    end
                end else begin
                    FlagsOut[0] = 0;
                end
                    
            end
            5'b00101: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if (A[7] == B[7])
                begin
                    if (A[7] == 0)
                    begin
                        FlagsOut[2] = 0;
                    end else begin
                        FlagsOut[2] = 1;
                    end
                end else begin
                    if (ALUOut[7] == 0)
                    begin
                        FlagsOut[2] = 1;    
                    end else begin
                        FlagsOut[2] = 0;
                    end
                end
                
                ALUOut = A + B + FlagsOut[2];
                ALUOut[8] = 0;
                ALUOut[9] = 0;
                ALUOut[10] = 0;
                ALUOut[11] = 0;
                ALUOut[12] = 0;
                ALUOut[13] = 0;
                ALUOut[14] = 0;
                ALUOut[15] = 0;     
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                if (A[7] == B[7])
                begin
                    if (ALUOut[7] == A[7])
                    begin
                        FlagsOut[0] = 0;
                    end else begin
                        FlagsOut[0] = 1;
                    end
                end else begin
                    FlagsOut[0] = 0;
                end
                    
            end
            5'b00110: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if (A[7] == ~B[7])
                begin
                    if (A[7] == 0)
                    begin
                        FlagsOut[2] = 0;
                    end else begin
                        FlagsOut[2] = 1;
                    end
                end else begin
                    if (ALUOut[7] == 0)
                    begin
                        FlagsOut[2] = 1;    
                    end else begin
                        FlagsOut[2] = 0;
                    end
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                if (A[7] == ~B[7])
                begin
                    if (ALUOut[7] == A[7])
                    begin
                        FlagsOut[0] = 0;
                    end else begin
                        FlagsOut[0] = 1;
                    end
                end else begin
                    FlagsOut[0] = 0;
                end
                    
            end
            5'b00111: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b01000: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b01001: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b01010: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b01011: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[7];
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b01100: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[0];
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b01101: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[0];
                
            end
            5'b01110: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[7];
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                
                ALUOut[0] = FlagsOut[2];
            end
            5'b01111: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[0];
                
                if(ALUOut[7] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                
                ALUOut[7] = FlagsOut[2];
            end
            
            5'b10000: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b10001: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b10010: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b10011: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b10100: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if (A[15] == B[15])
                begin
                    if (A[15] == 0)
                    begin
                        FlagsOut[2] = 0;
                    end else begin
                        FlagsOut[2] = 1;
                    end
                end else begin
                    if (ALUOut[15] == 0)
                    begin
                        FlagsOut[2] = 1;    
                    end else begin
                        FlagsOut[2] = 0;
                    end
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                if (A[15] == B[15])
                begin
                    if (ALUOut[15] == A[15])
                    begin
                        FlagsOut[0] = 0;
                    end else begin
                        FlagsOut[0] = 1;
                    end
                end else begin
                    FlagsOut[0] = 0;
                end
                    
            end
            5'b10101: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if (A[15] == B[15])
                begin
                    if (A[15] == 0)
                    begin
                        FlagsOut[2] = 0;
                    end else begin
                        FlagsOut[2] = 1;
                    end
                end else begin
                    if (ALUOut[15] == 0)
                    begin
                        FlagsOut[2] = 1;    
                    end else begin
                        FlagsOut[2] = 0;
                    end
                end
                
                ALUOut = A + B + FlagsOut[2];
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                if (A[15] == B[15])
                begin
                    if (ALUOut[15] == A[15])
                    begin
                        FlagsOut[0] = 0;
                    end else begin
                        FlagsOut[0] = 1;
                    end
                end else begin
                    FlagsOut[0] = 0;
                end
                    
            end
            5'b10110: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if (A[15] == ~B[15])
                begin
                    if (A[15] == 0)
                    begin
                        FlagsOut[2] = 0;
                    end else begin
                        FlagsOut[2] = 1;
                    end
                end else begin
                    if (ALUOut[15] == 0)
                    begin
                        FlagsOut[2] = 1;    
                    end else begin
                        FlagsOut[2] = 0;
                    end
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                if (A[15] == ~B[15])
                begin
                    if (ALUOut[15] == A[15])
                    begin
                        FlagsOut[0] = 0;
                    end else begin
                        FlagsOut[0] = 1;
                    end
                end else begin
                    FlagsOut[0] = 0;
                end
                    
            end
            5'b10111: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b11000: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b11001: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b11010: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b11011: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[15];
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b11100: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[0];
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
            end
            5'b11101: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[0];
                
            end
            5'b11110: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[15];
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                
                ALUOut[0] = FlagsOut[2];
            end
            5'b11111: begin 
                if(ALUOut == 0)
                begin
                    FlagsOut[3] = 1;
                end else begin
                    FlagsOut[3] = 0;
                end
                
                FlagsOut[2] = A[0];
                
                if(ALUOut[15] == 0)
                begin
                    FlagsOut[1] = 0;
                end else begin
                    FlagsOut[1] = 1;
                end
                                
                ALUOut[15] = FlagsOut[2];
            end
            
            endcase
        end
    end
    
    
endmodule