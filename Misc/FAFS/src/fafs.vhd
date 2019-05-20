library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fafs is 
	generic (W : natural := 8; -- FW input width
			T : integer := 3); -- Truncatenated signal width
			-- the number of phases N = 2**T
	port (FW : in std_logic_vector (W-1 downto 0); -- frequency control word
	      en : in std_logic; -- enable 
	      fafs : inout std_logic); -- fafs output
end entity;

architecture behavioral of fafs is

signal sel : std_logic_vector (T-1 downto 0);
signal clks : std_logic_vector (2**T - 1 downto 0);
signal rin, rout : std_logic_vector (W-1 downto 0);
signal mout : std_logic;
constant period : time := 1 ns * (2**T);

begin
	-- clock generation
	process begin
		clks(0) <= '0';
		wait for period/2;
		clks(0) <= '1';
		wait for period/2;
	end process;
	-- phase generation
	S: for i in 1 to 2**T - 1 generate
		clks(i) <= clks(i-1) after 1ns;
	end generate S;
	-- multiplexer output
	mout <= clks(to_integer(unsigned(sel))) after 1 ns;
	-- adder
	rout <= rin  + FW;
	-- register
	process (mout, en)
		begin
			if en <= '0' then
				rin <= (others => '1');
			elsif rising_edge(mout) then
				rin <= rout;
			end if; 	
	end process;
	-- trucation 
	sel <= rin(T-1 downto 0);
	-- Toggle flip flop
	process (mout, en)
		begin
			if en = '0' then
				fafs <= '0';
			elsif rising_edge(mout) then
				fafs <= not fafs;
			end if;
	end process;
end architecture;