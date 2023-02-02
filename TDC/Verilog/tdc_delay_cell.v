// Code your design here
`timescale 1ps/1ps

module tdc_delay_cell
	#(parameter nrTDC = 1,
	  parameter nrDelayCells = 3,
      parameter gatesInDelayCell = 3,
	  parameter gateDelay = 40 )
  ( input wire start, stop, R,
     input sclk, sdata,
     output reg [$clog2(nrDelayCells) :0 ] dec);
     
     wire [$clog2(nrDelayCells) : 0] dec_n [1:nrTDC];
     
     integer k;
     
     genvar i;
     generate 
		 for( i = 1; i <=  nrTDC; i = i + 1) 
			tdc_delay_cell_single #(nrDelayCells,gatesInDelayCell,gateDelay) 
				tdc_delay_cell_i (.start(start), .stop(stop), .R(R),.sclk(sclk),.sdata(sdata),.dec(dec_n[i]));
	 endgenerate
	 
	 always @(*)
	 begin
		dec = 0;
		for ( k = 1; k <=  nrTDC; k = k + 1) 
			dec= dec_n[k] + dec;
		dec = dec >> 1;
	 end
     
endmodule	

module delayCell
	#( parameter gatesInDelayCell = 6,
	   parameter gateDelay = 40 )
  ( input sin, 
    input [0: gatesInDelayCell - 1] en,
	output sout);
	
	genvar i;
	generate
		for( i = 0; i < gatesInDelayCell ; i = i + 1) begin
			//bufif1(sout, sin, en[i]);
			assign #gateDelay sout = en[i] ? sin : 1'bZ;
		end
	endgenerate
	

endmodule

module tdc_delay_cell_single
  # ( parameter nrDelayCells = 3,
      parameter gatesInDelayCell = 6,
	  parameter gateDelay = 40)
  ( input wire start, stop, R,
     input sclk, sdata,
     output reg [$clog2(nrDelayCells) :0 ] dec);

	reg  [0 : nrDelayCells * gatesInDelayCell - 1] delay_control ;
	wire [0 : nrDelayCells] delay_line;
	reg  latches [0:nrDelayCells];
	
	integer k;
	
	always @(posedge sclk)
		begin
			delay_control[0] <= sdata;
			delay_control[1:nrDelayCells*gatesInDelayCell-1] <= delay_control[0:nrDelayCells*gatesInDelayCell - 2];
		end
		
    genvar i;
	generate
		for ( i = 0; i < nrDelayCells ; i = i + 1) 
			delayCell #(gatesInDelayCell,gateDelay)
				delayCell_i (.sin(delay_line[i]),.en(delay_control[i*gatesInDelayCell:i*gatesInDelayCell+gatesInDelayCell - 1]),.sout(delay_line[i+1]));
      //for( i = 0; i <= nrDelayCells*gatesInDelayCell ; i = i + 1) 
        //generate
        //for( i = 0; i < nrDelayCells * gatesInDelayCell ; i = i + 1) 
			//assign #gateDelay delay_line[(i / gatesInDelayCell) + 1] = (delay_control[i]) ? (delay_line[ (i / gatesInDelayCell)]) : 1'bZ; 
			//assign #gateDelay delay_line[i] = (delay_control[(i-1) * j + j]) ? (delay_line[i - 1]) : 1'bZ; 
			//assign #gateDelay delay_line[i] = (delay_line[i-1] | delay_control[i-1]); 
	endgenerate
  
    assign #gateDelay delay_line[0] = start;
    
 
    always @(posedge stop or negedge R) 
      if (!R) 
		for( k = 0; k <= nrDelayCells ; k = k + 1)
			latches[k] <= {1'b0};
      else 
		for( k = 0; k <= nrDelayCells ; k = k + 1)
			latches[k] <= delay_line[k];      
			//latches[k] <= delay_line[k*gatesInDelayCell];      
		 
  
	always @(*) 
	begin
	  dec = 0;
	  for (k = 0 ; k <= nrDelayCells; k = k + 1)
		if (latches[k]) 
			dec = dec + 1;
	end
	
endmodule
