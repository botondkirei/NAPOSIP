library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
entity vco is 
	generic ( Fo_period : real := 0.5e9;
			  kv : time := 1 ns);
	port ( vctrl : in real ;
		   osc : inout std_logic := '0');
end entity;

architecture behavioral of vco is

	signal period : time := time(1/Fo_period) * 1 ns;
	
begin
	
	process (vctrl)
	begin
		period <= Fo_period + kv*vctrl;
	end process;

	osc <= transport (not osc) after period;

end architecture;

	
----------------------------Source cod in Verilog-------------------------		  
-- module vco #(parameter real fo=0.5e9, parameter real kv = 0.4e9) 
-- (input [63:0] vctrl, output reg osc = 1'b0);

	-- real period = 1/fo;
	-- time ticks = 0;
	-- always @(vctrl) 
		-- begin
			-- //$display("Vctrl: %f" ,$bitstoreal(vctrl));
			-- period = 1e15/ (fo+kv*$bitstoreal(vctrl))/2;
			-- ticks = period;
			-- //$display("Period: %f, Ticks: %t" ,period,ticks);
		-- end
	-- always #(ticks) osc <= ~osc; 

-- endmodule