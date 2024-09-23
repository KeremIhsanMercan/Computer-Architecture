`timescale 1ns / 1ps

module Counter(
    input wire Clock, 
    input wire Reset,
    output reg [2:0] Counter_Out // a.k.a. T
);
    initial begin
    Counter_Out = 3'b000; 
    end
    
    always@(posedge Clock)
        begin
            if(Reset)
                Counter_Out <= 0;
            else
                Counter_Out <= Counter_Out + 1;
    end
endmodule

module Decoder3bit( // to decode T to show it as Tx
    input wire Dec_En,
    input wire [2:0] Dec_Input,
    output reg [7:0] Dec_Output // Tx is 8 bits 
);
    always @(*)
    begin
        if(Dec_En) begin
        case(Dec_Input)
            3'b000: Dec_Output = 8'b00000001;
            3'b001: Dec_Output = 8'b00000010;
            3'b010: Dec_Output = 8'b00000100;
            3'b011: Dec_Output = 8'b00001000;
            3'b100: Dec_Output = 8'b00010000;
            3'b101: Dec_Output = 8'b00100000;
            3'b110: Dec_Output = 8'b01000000;
            3'b111: Dec_Output = 8'b10000000;
            default: Dec_Output = 0;
         endcase
         end
    end
endmodule

module Decoder6bit( // to decode opcode
    input wire Dec_En,
    input wire [5:0] Dec_Input, // Opcode is 6 bits
    output reg [33:0] Dec_Output // there is only 34 operations
);
    always @(*)
    begin
        if(Dec_En) begin
        case(Dec_Input)
            6'h00 : Dec_Output = 34'h000000001; // 0 0000 0001
            6'h01 : Dec_Output = 34'h000000002; // 0 0000 0002
            6'h02 : Dec_Output = 34'h000000004; // ...
            6'h03 : Dec_Output = 34'h000000008; // ..
            6'h04 : Dec_Output = 34'h000000010; // .
            6'h05 : Dec_Output = 34'h000000020;
            6'h06 : Dec_Output = 34'h000000040;
            6'h07 : Dec_Output = 34'h000000080;
            6'h08 : Dec_Output = 34'h000000100;
            6'h09 : Dec_Output = 34'h000000200;
            6'h0A : Dec_Output = 34'h000000400;
            6'h0B : Dec_Output = 34'h000000800;
            6'h0C : Dec_Output = 34'h000001000;
            6'h0D : Dec_Output = 34'h000002000;
            6'h0E : Dec_Output = 34'h000004000;
            6'h0F : Dec_Output = 34'h000008000;
            
            6'h10 : Dec_Output = 34'h000010000;
            6'h11 : Dec_Output = 34'h000020000;
            6'h12 : Dec_Output = 34'h000040000;
            6'h13 : Dec_Output = 34'h000080000;
            6'h14 : Dec_Output = 34'h000100000;
            6'h15 : Dec_Output = 34'h000200000;
            6'h34 : Dec_Output = 34'h000400000;
            6'h17 : Dec_Output = 34'h000800000;
            6'h18 : Dec_Output = 34'h001000000;
            6'h19 : Dec_Output = 34'h002000000;
            6'h1A : Dec_Output = 34'h004000000;
            6'h1B : Dec_Output = 34'h008000000;
            6'h1C : Dec_Output = 34'h010000000;
            6'h1D : Dec_Output = 34'h020000000;
            6'h1E : Dec_Output = 34'h040000000;
            6'h1F : Dec_Output = 34'h080000000; 
            
            6'h20 : Dec_Output = 34'h100000000; // 1 0000 0000
            6'h21 : Dec_Output = 34'h200000000; // 2 0000 0000
            
            default : Dec_Output = 0;
        endcase
        end else begin
            Dec_Output = Dec_Output;
        end
    end
endmodule

module InstructionDecoder(
    input wire [15:0] IR_Out,
    input wire T2,
    output wire [33:0] Decoder_Out,
    output reg [1:0] RSEL  //  IR_Out[15:10] -> Opcode, IR_Out[9:8] -> RSEL, IR_Out[7:0] -> Address
);
   
    Decoder6bit _DecodeOpcode(.Dec_En(T2), .Dec_Input(IR_Out[15:10]), .Dec_Output(Decoder_Out));
    always @(*)
    begin
        if(T2)
        begin
            RSEL <= IR_Out[9:8];
        end
    end
endmodule

module CPUSystem(
    input wire Clock,
    input wire Reset,
    output reg[7:0] T
);

    reg[2:0] RF_OutASel;
    reg[2:0] RF_OutBSel;
    reg[2:0] RF_FunSel;
    reg[3:0] RF_RegSel;
    reg[3:0] RF_ScrSel;

    reg[4:0] ALU_FunSel;
    reg ALU_WF;

    reg[1:0] ARF_OutCSel;
    reg[1:0] ARF_OutDSel;
    reg[2:0] ARF_FunSel;
    reg[2:0] ARF_RegSel;

    reg IR_LH;  
    reg IR_Write;

    reg Mem_WR;
    reg Mem_CS;

    reg[1:0] MuxASel;
    reg[1:0] MuxBSel;
    reg MuxCSel;

    ArithmeticLogicUnitSystem _ALUSystem(
        .RF_OutASel(RF_OutASel),   .RF_OutBSel(RF_OutBSel), 
        .RF_FunSel(RF_FunSel),     .RF_RegSel(RF_RegSel),
        .RF_ScrSel(RF_ScrSel),     .ALU_FunSel(ALU_FunSel),
        .ALU_WF(ALU_WF),           .ARF_OutCSel(ARF_OutCSel), 
        .ARF_OutDSel(ARF_OutDSel), .ARF_FunSel(ARF_FunSel),
        .ARF_RegSel(ARF_RegSel),   .IR_LH(IR_LH),
        .IR_Write(IR_Write),       .Mem_WR(Mem_WR),
        .Mem_CS(Mem_CS),           .MuxASel(MuxASel),
        .MuxBSel(MuxBSel),         .MuxCSel(MuxCSel),
        .Clock(Clock)
    );

    
    reg SC_Reset;

    wire [2:0] temp;
    wire Z = _ALUSystem.ALU_Flags[3];
    wire [7:0] Tx;
    
    initial begin
            _ALUSystem.ARF.PC.Q = 16'h0000;
            _ALUSystem.ARF.SP.Q = 16'h00ff;
            _ALUSystem.ARF.AR.Q = 16'h00a0;
            _ALUSystem.RF.R1.Q = 16'h0000;
            _ALUSystem.RF.R2.Q = 16'h0000;
            _ALUSystem.RF.R3.Q = 16'h0000;
            _ALUSystem.RF.R4.Q = 16'h0000;
            _ALUSystem.RF.S1.Q = 16'h0000;
            _ALUSystem.RF.S2.Q = 16'h0000;
            _ALUSystem.RF.S3.Q = 16'h0000;
            _ALUSystem.RF.S4.Q = 16'h0000;
            ALU_FunSel = 5'b10000;
            
            SC_Reset = 1'b1;
    end
    
    Counter SC(.Clock(Clock), .Reset(SC_Reset), .Counter_Out(temp));
    Decoder3bit _DecodeTx(.Dec_En(1'b1), .Dec_Input(temp), .Dec_Output(Tx));
    
    always @(*) begin
    
        T = Tx;
    end
    
    ///////////////////////////////// FETCH ////////////////////////////////////////////////
    always @(T[0] or T[1])        // always @(*) ?
    begin
        if(T[0])
        begin
            ARF_OutDSel <= 2'b00; // OutD is connected to Memory, 00 and 01 selects PC so it might be 0x as well, CONSIDER!!!     
                   
            Mem_CS <= 1'b0; // enable memory chip
            Mem_WR <= 1'b0; // read LSB from memory
            IR_Write <= 1'b1; // write enables
            IR_LH <= 1'b0; // write low to IR
                
            ARF_RegSel <= 3'b011; // 011 enable PC
            ARF_FunSel <= 3'b001; // PC must be incremented access MSB in T1, FunSel(001) -> Q = Q+1 
        end else 
        if(T[1])
        begin
            ARF_OutDSel <= 2'b00; // OutD is connected to Memory, 00 and 01 selects PC so it might be 0x as well, CONSIDER!!!
                
            Mem_CS <= 1'b0; // enable memory chip
            Mem_WR <= 1'b0; // read LSB from memory            
            IR_Write <= 1'b1; // write enables
            IR_LH <= 1'b1; // write high to IR
            
            RF_OutASel = 3'b000;
            
            ARF_RegSel <= 4'b011; // 011 enable PC
            ARF_FunSel <= 2'b001; // PC must be incremented access LSB of the next instruction, FunSel(001) -> Q = Q+1 
        end else begin
            ARF_OutDSel <= 2'bZZ;
                
            Mem_CS <= 1'bZ;
            Mem_WR <= 1'bZ;
            IR_Write <= 1'bZ;
            IR_LH <= 1'bZ;
                
            ARF_RegSel <= 3'bZZZ;
            ARF_FunSel <= 3'bZZZ;
        end
    end
    
    //////////////////////////////////////////// DECODE //////////////////////////////////////////////////
    wire [33:0] D; // Decoder Output aka Operation number
    wire [1:0] RSEL;
    
    InstructionDecoder DecodeIR(.IR_Out(_ALUSystem.IROut), .T2(T[2]), .Decoder_Out(D), .RSEL(RSEL));
    
    wire [2:0] DSTREG = {RSEL[0], _ALUSystem.IROut[7:6]};
    wire [2:0] SREG1 = _ALUSystem.IROut[5:3];
    wire [2:0] SREG2 = _ALUSystem.IROut[2:0];

    /////////////////////////////////////////// OPERATIONS ///////////////////////////////////////////////
    always @(T or D or _ALUSystem.IROut or RSEL or _ALUSystem.ALU_Flags) begin // may change, (*)?
        if (T[0]) begin
            SC_Reset <= 0;
            Mem_CS <= 1;
            Mem_WR <= 0;
            ALU_FunSel <= 5'b10000;
        end
        case (D)
            34'b0000000000000000000000000000000001: ALU_FunSel <= 5'b10100; // ADD  //opcode 00
            34'b0000000000000000000000000000000010: ALU_FunSel <= 5'b10100; // if(Z==0) + ADD //opcode 01 //conditions are checked below
            34'b0000000000000000000000000000000100: ALU_FunSel <= 5'b10100; // if(Z==1) + ADD //opcode 02 //conditions are checked below
            // ALU_FunSel is not needed in between these operations
            34'b0000000000000000000000000000010000: ALU_FunSel <= 5'b10000; // write to memory //opcode 04
            34'b0000000000000000000000000000100000: begin
                ALU_FunSel <= 5'b10000;
                ALU_WF <= 1'b1;
            end // INC //opcode 05
            34'b0000000000000000000000000001000000: begin
                ALU_FunSel <= 5'b10000;
                ALU_WF <= 1'b1;
            end  // DEC //opcode 06
            34'b0000000000000000000000000010000000: ALU_FunSel <= 5'b11011; // LSL //opcode 07
            34'b0000000000000000000000000100000000: ALU_FunSel <= 5'b11100; // LSR //opcode 08
            34'b0000000000000000000000001000000000: ALU_FunSel <= 5'b11101; // ASR //opcode 09
            34'b0000000000000000000000010000000000: ALU_FunSel <= 5'b11110; // CSL //opcode 0A
            34'b0000000000000000000000100000000000: ALU_FunSel <= 5'b11111; // CSR //opcode 0B
            34'b0000000000000000000001000000000000: ALU_FunSel <= 5'b10111; // AND //opcode 0C
            34'b0000000000000000000010000000000000: ALU_FunSel <= 5'b11000; // OR  //opcode 0D
            34'b0000000000000000000100000000000000: ALU_FunSel <= 5'b10010; // NOT //opcode 0E
            34'b0000000000000000001000000000000000: ALU_FunSel <= 5'b11001; // XOR //opcode 0F
            34'b0000000000000000010000000000000000: ALU_FunSel <= 5'b11010; // NAND //opcode 10
            // ALU_FunSel is not needed in between these operations
            34'b0000000000000010000000000000000000: ALU_FunSel <= 5'b10000; // M[AR] ? Rx (AR is 16-bit register)
            // ALU_FunSel is not needed in between these operations
            34'b0000000000001000000000000000000000: ALU_FunSel <= 5'b10100; // ADD //opcode 15
            34'b0000000000010000000000000000000000: ALU_FunSel <= 5'b10101; // ADD w/carry //opcode 16
            34'b0000000000100000000000000000000000: ALU_FunSel <= 5'b10110; // SUB //opcode 17
            34'b0000000001000000000000000000000000: begin
                ALU_FunSel <= 5'b10000;
                ALU_WF <= RSEL[1];
            end // LOAD FLAGS CHANGE //opcode 18 
            34'b0000000010000000000000000000000000: begin
                ALU_FunSel <= 5'b10100;
                ALU_WF <= RSEL[1];
            end // ADD FLAGS CHANGE //opcode 19
            34'b0000000100000000000000000000000000: begin
                ALU_FunSel <= 5'b10110;
                ALU_WF <= RSEL[1];
            end // SUB FLAGS CHANGE //opcode 1A
            34'b0000001000000000000000000000000000: begin
                ALU_FunSel <= 5'b10111;
                ALU_WF <= RSEL[1];
            end // AND FLAGS CHANGE //opcode 1B
            34'b0000010000000000000000000000000000: begin
                ALU_FunSel <= 5'b11000;
                ALU_WF <= RSEL[1];
            end // OR FLAGS CHANGE //opcode 1C
            34'b0000100000000000000000000000000000: begin
                ALU_FunSel <= 5'b11001;
                ALU_WF <= RSEL[1];
            end // XOR FLAGS CHANGE //opcode 1D
            34'b0001000000000000000000000000000000: ALU_FunSel <= 5'b10000; // M[SP] ? PC, PC ? Rx
        endcase
        
        if(T[0]) begin // reset scratch registers at the begining of each operation
            _ALUSystem.RF.S1.Q <= 16'h0000;
            _ALUSystem.RF.S2.Q <= 16'h0000;
            _ALUSystem.RF.S3.Q <= 16'h0000;
            _ALUSystem.RF.S4.Q <= 16'h0000;
        end
        
        if((D[0] || D[1] || D[2]) && T[2]) begin //loads IR[7:0] to S1
       
            MuxASel <= 2'b11;
            RF_RegSel <= 4'b1111;
            RF_ScrSel <= 4'b0111;
            RF_FunSel <= 3'b010;
            RF_OutASel <= 3'b100;
            RF_OutBSel <= 3'b101;
        end
        
        if((D[0] || D[1] || D[2]) && T[3]) begin // loads PC to S2 
               
            MuxASel <= 2'b01; 
            ARF_OutCSel <= 2'b00;
            RF_RegSel <= 4'b1111;
            RF_ScrSel <= 4'b1011; 
            RF_FunSel <= 3'b010; 
             
        end
        
        if((D[0] || D[1] || D[2]) && T[4]) begin // these operations end in T[4]
            MuxBSel <= 2'b00;
            ARF_RegSel <= 3'b011; // loads ALUOut to PC
            if(D[0] || (D[1] && Z==0) || (D[2] && Z==1)) begin // loads PC+VALUE to PC 
                ARF_FunSel <= 3'b010;
            end else begin
                ARF_FunSel <= 3'bZZZ;
            end  
            
            SC_Reset <= 1; // means SC <- 0
            
        end
                
       
        if(D[3] && (T[3] || T[4])) begin // read M[SP] load it into low and high bits of Rx
            Mem_CS <= 1'b0;
            Mem_WR <= 1'b0;
                    
            ARF_OutDSel <= 2'b11;
                                
            MuxASel <= 2'b10;
                    
            case(RSEL)
                2'b00: RF_RegSel <= 4'b0111;
                2'b01: RF_RegSel <= 4'b1011;
                2'b10: RF_RegSel <= 4'b1101;
                2'b11: RF_RegSel <= 4'b1110;
            endcase
            
            if(T[3]) begin       // load to low bits at T3
                RF_FunSel <= 3'b101;   // T4 is reserved to inc SP to reach higher bits
            end else begin       // load to high bits at T4
                RF_FunSel <= 3'b110;
            end         
        end
        
        if(D[3] && (T[2]||T[3])) begin // inc SP
            ARF_RegSel <= 3'b110;
            ARF_FunSel <= 3'b001;
        end
        
        if(D[3] && T[4]) begin // these operations end in T[3]
            SC_Reset <= 1; // means SC <- 0
                    
        end
        
        if(D[4] && (T[2] || T[3])) begin // write low(T3) and high(T4) bits of Rx to M[SP]
            RF_OutASel <= {1'b0, RSEL};
            ARF_OutDSel <= 2'b11;
            Mem_WR <= 1'b1; 
            Mem_CS <= 1'b0;
            if (T[2]) begin    // write high bits of Rx at T2
                MuxCSel <= 1'b1;    // T4 is reserved to dec SP to reach higher bits
            end else begin     // write low bits of Rx at T3
                MuxCSel <= 1'b0;
            end
        end
                
        if(D[4] && (T[2]||T[3])) begin // dec SP
            ARF_RegSel <= 3'b110;
            ARF_FunSel <= 3'b000;
        end
        
        
        if(D[4] && T[3]) begin // these operations end in T[3]
            SC_Reset <= 1; // means SC <- 0
                            
            
            
            
            
        end
        
        if((D[5] || D[6]) && T[2]) begin // loads SREG1 to DSTREG
            if(DSTREG[2]) begin // DSTREG is in RF 
                if(SREG1[2]) begin // SREG1 is in RF
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                    MuxASel <= 2'b00;
                    
                end else begin // SREG1 is in ARF
                    case(SREG1[1:0])
                        2'b00: ARF_OutCSel <= 2'b00; 
                        2'b01: ARF_OutCSel <= 2'b01; 
                        2'b10: ARF_OutCSel <= 2'b11; 
                        2'b11: ARF_OutCSel <= 2'b10; 
                    endcase
                    MuxASel <= 2'b01;
                end
                
                RF_FunSel <= 3'b010;
                RF_ScrSel <= 4'b1111;
                case(DSTREG[1:0])
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                                    
                endcase
            end else begin // DSTREG is in ARF
                if(SREG1[2]) begin // SREG1 is in RF
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                    MuxBSel <= 2'b00;
                end else begin // SREG1 is in ARF
                    case(SREG1[1:0])
                        2'b00: ARF_OutCSel <= 2'b00; 
                        2'b01: ARF_OutCSel <= 2'b01; 
                        2'b10: ARF_OutCSel <= 2'b11; 
                        2'b11: ARF_OutCSel <= 2'b10; 
                    endcase
                    MuxBSel <= 2'b01;
                end
                
                ARF_FunSel <= 3'b010;
                case(DSTREG[1:0])
                    2'b00: ARF_RegSel <= 3'b011;
                    2'b01: ARF_RegSel <= 3'b011;
                    2'b10: ARF_RegSel <= 3'b110;
                    2'b11: ARF_RegSel <= 3'b101;
                                                    
                endcase
            end
        end
        
        if((D[5] || D[6]) && T[3]) begin // increments or decrements DSTREG
            if(D[5]) begin // increment
                if(DSTREG[2]) begin // increment RF
                    RF_FunSel <= 3'b001;
                    RF_ScrSel <= 4'b1111;
                    
                    case(DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                                                        
                    endcase
                end else begin // increment ARF
                    ARF_FunSel <= 3'b001;
                    
                    case(DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                                                                        
                    endcase
                end
            end else begin // decrement
                if(DSTREG[2]) begin // decrement RF
                    RF_FunSel <= 3'b000;
                    RF_ScrSel <= 4'b1111;
                                
                    case(DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                                                                    
                    endcase 
                            
                end else begin
                    ARF_FunSel <= 3'b000;
                                    
                    case(DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                                                                                        
                    endcase            
                end
            end
            SC_Reset <= 1; // means SC <- 0 
            
            
            
            
            
                            
        end
        
        if((D[7] || D[8] || D[9] || D[10] || D[11] || D[14] || D[24]) && T[2]) begin // shift operations first clock cycle
            if(SREG1[2]) begin // SREG1 is in RF, means that one clock cycle is enough
                RF_OutASel <= {1'b0, SREG1[1:0]};
                if(DSTREG[2]) begin // DSTREG is in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                    RF_ScrSel <= 4'b1111;
                    case(DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    endcase
                end else begin // DSTREG is in ARF
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                    case(DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                    endcase                
                end
                
                SC_Reset <= 1; // means SC <- 0  // ENDS HERE IF SREG1 IS IN RF
                
                
                
                
                
            end else begin // SREG1 is in ARF, means that in first clock cycle we load it in S1 in RF 
                
                case(SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b01;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
                MuxASel <= 2'b01;
                RF_FunSel <= 3'b010; // load
                RF_RegSel <= 4'b1111;
                RF_ScrSel <= 4'b0111; //S1
            end
        end
        
        if((D[7] || D[8] || D[9] || D[10] || D[11] || D[14] || D[24]) && T[3]) begin // these operations go into T[3] only when SREG1 is in ARF
        
            RF_OutASel <= 3'b100; // SREG1 is in S1, it will go into ALU
            
            if(DSTREG[2]) begin // DSTREG is in RF
                MuxASel <= 2'b00; 
                RF_FunSel <= 3'b010; // load into DSTREG
                RF_ScrSel <= 4'b1111;
                case(DSTREG[1:0])
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
            end else begin // DSTREG is in ARF
                MuxBSel <= 2'b00; 
                ARF_FunSel <= 3'b010; // load into DSTREG
                case(DSTREG[1:0])
                    2'b00: ARF_RegSel <= 3'b011;
                    2'b01: ARF_RegSel <= 3'b011;
                    2'b10: ARF_RegSel <= 3'b110;
                    2'b11: ARF_RegSel <= 3'b101;
                endcase            
            end
            
            SC_Reset <= 1; // means SC <- 0  // ENDS HERE IF SREG1 IS IN ARF
                            
            
            
            
                        
        
        end
        
        if((D[12] || D[13] || D[15] || D[16] || D[21] || D[22] || D[23] || D[25] || D[26] || D[27] || D[28] || D[29]) && T[2]) begin
        
            if(SREG1[2] && SREG2[2]) begin // both SREG1 and SREG2 are in RF
                RF_OutASel <= {1'b0, SREG1[1:0]};
                RF_OutBSel <= {1'b0, SREG2[1:0]};
                if(DSTREG[2]) begin // DSTREG is in RF
                    MuxASel <= 2'b00;
                    RF_FunSel <= 3'b010;
                    RF_ScrSel <= 4'b1111;
                    case(DSTREG[1:0])
                        2'b00: RF_RegSel <= 4'b0111;
                        2'b01: RF_RegSel <= 4'b1011;
                        2'b10: RF_RegSel <= 4'b1101;
                        2'b11: RF_RegSel <= 4'b1110;
                    
                    endcase
                end else begin 
                    MuxBSel <= 2'b00;
                    ARF_FunSel <= 3'b010;
                    case(DSTREG[1:0])
                        2'b00: ARF_RegSel <= 3'b011;
                        2'b01: ARF_RegSel <= 3'b011;
                        2'b10: ARF_RegSel <= 3'b110;
                        2'b11: ARF_RegSel <= 3'b101;
                
                    endcase
                end
                
                SC_Reset <= 1; // means SC <- 0  // ENDS HERE IF both SREG1 and SREG2 IS IN RF
                
                
                
                
                
            end else if(SREG1[2]) begin // only SREG1 is in RF, means that in first clock cycle we load SREG2 to S1 in RF 
                case(SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b01;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
                MuxASel <= 2'b01;
                RF_FunSel <= 3'b010; // load
                RF_RegSel <= 4'b1111;
                RF_ScrSel <= 4'b0111; //S1
            end else if(SREG2[2]) begin // only SREG2 is in RF, means that in first clock cycle we load SREG1 to S1 in RF  
                case(SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b01;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
                MuxASel <= 2'b01;
                RF_FunSel <= 3'b010; // load
                RF_RegSel <= 4'b1111;
                RF_ScrSel <= 4'b0111; //S1        
            end else begin // both SREG1 and SREG2 are in ARF, means that in first clock cycle we load it in S1 in RF. we will load SREG2 in S2 in T[3]
                case(SREG1[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b01;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
                MuxASel <= 2'b01;
                RF_FunSel <= 3'b010; // load
                RF_RegSel <= 4'b1111;
                RF_ScrSel <= 4'b0111; //S1                
            end
        end
        
        if((D[12] || D[13] || D[15] || D[16] || D[21] || D[22] || D[23] || D[25] || D[26] || D[27] || D[28] || D[29]) && T[3]) begin // in this clock cycle at least 1 of SREGs is in ARF
            
            if(SREG1[2] || SREG2[2]) begin // one of SREGs is in ARF at most (they cant be 1 both because we ended that case in T[2])
                if(SREG1[2]) begin // SREG1 is in RF
                    RF_OutASel <= {1'b0, SREG1[1:0]};
                    RF_OutBSel <= 3'b100;
                    
                    if(DSTREG[2]) begin // DSTREG is in RF
                        MuxASel <= 2'b00;
                        RF_FunSel <= 3'b010;
                        RF_ScrSel <= 4'b1111;
                        case(DSTREG[1:0])
                            2'b00: RF_RegSel <= 4'b0111;
                            2'b01: RF_RegSel <= 4'b1011;
                            2'b10: RF_RegSel <= 4'b1101;
                            2'b11: RF_RegSel <= 4'b1110;
                        endcase
                    end else begin // DSTREG is in ARF
                        MuxBSel <= 2'b00;
                        ARF_FunSel <= 3'b010;
                        case(DSTREG[1:0])
                            2'b00: ARF_RegSel <= 3'b011;
                            2'b01: ARF_RegSel <= 3'b011;
                            2'b10: ARF_RegSel <= 3'b110;
                            2'b11: ARF_RegSel <= 3'b101;
                        endcase
                    end
                end else begin // SREG2 is in RF
                    RF_OutASel <= 3'b100;
                    RF_OutBSel <= {1'b0, SREG1[1:0]};
                
                    if(DSTREG[2]) begin // DSTREG is in RF
                        MuxASel <= 2'b00;
                        RF_FunSel <= 3'b010;
                        RF_ScrSel <= 4'b1111;
                        case(DSTREG[1:0])
                            2'b00: RF_RegSel <= 4'b0111;
                            2'b01: RF_RegSel <= 4'b1011;
                            2'b10: RF_RegSel <= 4'b1101;
                            2'b11: RF_RegSel <= 4'b1110;
                        endcase
                    end else begin // DSTREG is in ARF
                        MuxBSel <= 2'b00;
                        ARF_FunSel <= 3'b010;
                        case(DSTREG[1:0])
                            2'b00: ARF_RegSel <= 3'b011;
                            2'b01: ARF_RegSel <= 3'b011;
                            2'b10: ARF_RegSel <= 3'b110;
                            2'b11: ARF_RegSel <= 3'b101;
                        endcase
                    end                
                end
                
                SC_Reset <= 1; // means SC <- 0  // ENDS HERE IF only one of SREG1 and SREG2 IS IN RF
                
                
                
                
                                
                
            end else begin // both SREG1 and SREG2 are in ARF, therefore in T[3] WE load SREG2 to S2
                case(SREG2[1:0])
                    2'b00: ARF_OutCSel <= 2'b00;
                    2'b01: ARF_OutCSel <= 2'b01;
                    2'b10: ARF_OutCSel <= 2'b11;
                    2'b11: ARF_OutCSel <= 2'b10;
                endcase
                MuxASel <= 2'b01;
                RF_FunSel <= 3'b010; // load
                RF_RegSel <= 4'b1111;
                RF_ScrSel <= 4'b1011; //S2           
            end
        end
       
        if((D[12] || D[13] || D[15] || D[16] || D[21] || D[22] || D[23] || D[25] || D[26] || D[27] || D[28] || D[29]) && T[4]) begin // in this clock cycle all SREGs are loaded into S registers
            RF_OutASel <= 3'b100; //S1
            RF_OutBSel <= 3'b101; //S2
            
            if(DSTREG[2]) begin // DSTREG is in RF
                MuxASel <= 2'b00;
                RF_FunSel <= 3'b010;
                RF_ScrSel <= 4'b1111;
                case(DSTREG[1:0])
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
            end else begin // DSTREG is in ARF
                MuxBSel <= 2'b00;
                ARF_FunSel <= 3'b010;
                case(DSTREG[1:0])
                    2'b00: ARF_RegSel <= 3'b011;
                    2'b01: ARF_RegSel <= 3'b011;
                    2'b10: ARF_RegSel <= 3'b110;
                    2'b11: ARF_RegSel <= 3'b101;
                endcase
            end  
            
            SC_Reset <= 1; // means SC <- 0  // ENDS HERE IF only both of SREG1 and SREG2 IS IN ARF
            
            
            
            
             
       
        end
       
        if((D[17] || D[20]) && T[2]) begin
            if(D[17]) begin // operation MOVH
                MuxASel <= 2'b11;
                RF_FunSel <= 3'b110; // loads high
                RF_ScrSel <= 4'b1111;
                case(RSEL)
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
            end else begin // operation MOVL
                MuxASel <= 2'b11;
                RF_FunSel <= 3'b101; // loads low
                RF_ScrSel <= 4'b1111;
                case(RSEL)
                    2'b00: RF_RegSel <= 4'b0111;
                    2'b01: RF_RegSel <= 4'b1011;
                    2'b10: RF_RegSel <= 4'b1101;
                    2'b11: RF_RegSel <= 4'b1110;
                endcase
            end
            
            SC_Reset <= 1; // means SC <- 0
            
            
            
            
            
        end
       
       
        if(D[18] && (T[2] || T[3])) begin //loads M[AR] to Rx
            ARF_OutDSel <= 2'b10;
            Mem_CS <= 0;
            Mem_WR <= 0;
            MuxASel <= 2'b10;
            RF_ScrSel <= 4'b1111;
            case(RSEL) 
                2'b00: RF_RegSel <= 4'b0111;
                2'b01: RF_RegSel <= 4'b1011;
                2'b10: RF_RegSel <= 4'b1101;
                2'b11: RF_RegSel <= 4'b1110;
            endcase
            if(T[2]) begin // loads high bits (starts with high bits because assuming AR points highbits)
                RF_FunSel <= 3'b110;
            end else begin // loads low bits
                RF_FunSel <= 3'b101;
            end
        
        end
        
        if(D[19] && (T[2] || T[3])) begin // writes RX to M[AR]
            RF_OutASel <= {1'b0, RSEL};
            Mem_CS <= 0;
            Mem_WR <= 1;
            
            if(T[2]) begin // writes high bits (starts with high bits because assuming AR points highbits)
                MuxCSel <= 1'b1;
            end else begin // writes low bits
                MuxCSel <= 1'b0;
            end
            
        end
       
       
        if((D[18] || D[19]) && (T[2] || T[3])) begin // decrements and increments AR respectively
            if(T[2]) begin
                ARF_FunSel <= 3'b000;
                ARF_RegSel <= 3'b101;
            end else begin // these operations end if AR is incremented
                ARF_FunSel <= 3'b001;
                ARF_RegSel <= 3'b101;
                
                SC_Reset <= 1; // means SC <- 0
                            
                
                
                
                            
            end
        end
        
        if(D[30] && T[2]) begin // load PC to S1
            ARF_OutCSel <= 2'b00;
            MuxASel <= 2'b01;
            RF_FunSel <= 3'b010;
            RF_ScrSel <= 4'b0111;
            RF_RegSel <= 4'b1111;
            
        end        
        
        if(D[30] && (T[3] || T[4])) begin // writes S1 to M[SP], high and low bits respectively
            RF_OutASel <= 3'b100;
            Mem_CS <= 0;
            Mem_WR <= 1;
            
            if(T[3]) begin // writes high bits
                MuxCSel <= 1'b1;
            end else begin // writes low bits
                MuxCSel <= 1'b0;
            end
        end    
        
        if(D[30] && (T[3] || T[4])) begin // decrements SP to reach lower bits 
            ARF_FunSel <= 3'b000;
            ARF_RegSel <= 3'b110;
            
        end
        
        if(D[30] && T[5]) begin // loads Rx to PC
            RF_OutASel <= {1'b0, RSEL};
            MuxBSel <= 2'b00;
            ARF_FunSel <= 3'b010;
            ARF_RegSel <= 3'b011;
            
            SC_Reset <= 1; // means SC <- 0
                        
            
            
            
            
        
        end
        
        if(D[31] && (T[2] || T[4])) begin // SP is incremented to reach higher bits
            ARF_FunSel <= 3'b001;
            ARF_RegSel <= 3'b110;
        end
        
        if(D[31] && (T[3] || T[5])) begin // reads from memory to PC, low bits and high bits respectively
            ARF_OutDSel <= 2'b11;
            Mem_CS <= 0;
            Mem_WR <= 0;
            ARF_RegSel <= 3'b011;
            MuxBSel <= 2'b10;
            
            if(T[3]) begin
                ARF_FunSel <= 3'b101;
            end else begin // operation ends after the high bits are written
                ARF_FunSel <= 3'b110;
                
                SC_Reset <= 1; // means SC <- 0
                            
                
                
                
                
            end
        end 
        
        if(D[32] && T[2]) begin // load ADDRESS bits to Rx
            MuxASel <= 2'b11;
            RF_FunSel <= 3'b010;
            RF_ScrSel <= 4'b1111;
            case(RSEL)
                2'b00: RF_RegSel <= 4'b0111;
                2'b01: RF_RegSel <= 4'b1011;
                2'b10: RF_RegSel <= 4'b1101;
                2'b11: RF_RegSel <= 4'b1110;
            endcase
            
            SC_Reset <= 1; // means SC <- 0
            
            
            
            
            
        end
        
        if(D[33] && T[2]) begin // AR is loaded into S1
            ARF_OutCSel <= 2'b10;
            MuxASel <= 2'b01;
            RF_FunSel <= 3'b010;
            RF_RegSel <= 4'b1111;
            RF_ScrSel <= 4'b0111;
        end
       
        if(D[33] && T[3]) begin // OFFSET is loaded into S2
            MuxASel <= 2'b11;
            RF_FunSel <= 3'b010;
            RF_RegSel <= 4'b1111;
            RF_ScrSel <= 4'b1011;
        end
        
        if(D[33] && T[4]) begin // S1 + S2 is loaded into AR
            RF_OutASel <= 3'b100;
            RF_OutBSel <= 3'b101;
            ALU_FunSel <= 5'b10100;
            MuxBSel <= 2'b00;
            ARF_FunSel <= 3'b010;
            ARF_RegSel <= 3'b101;
        end
        
        if(D[33] && T[5]) begin // high bits of RX is written into M[AR] and AR is decremented to reach low bits
            ARF_OutDSel <= 2'b10;
            ALU_FunSel <= 5'b10000;
            RF_OutASel <= {1'b0, RSEL[1:0]};
            Mem_CS <= 0;
            Mem_WR <= 1;
            MuxCSel <= 1'b1;
            ARF_FunSel <= 3'b000;
            ARF_RegSel <= 3'b101;
            
        end
        
        if(D[33] && T[6]) begin // low bits of RX is written into M[AR] and AR is incremented to preserve its initial value
            ARF_OutDSel <= 2'b10;
            ALU_FunSel <= 5'b10000;
            RF_OutASel <= {1'b0, RSEL[1:0]};
            Mem_CS <= 0;
            Mem_WR <= 1;
            MuxCSel <= 1'b0;
            ARF_FunSel <= 3'b001;
            ARF_RegSel <= 3'b101;
            
            SC_Reset <= 1; // means SC <- 0
            
            
            
            
            
        end
            
    end

endmodule