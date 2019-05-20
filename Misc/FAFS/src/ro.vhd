library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RO is 
	generic (N : natural := 8;
		 period : time := 10 ns); -- Number of clock phases
	port ( phases : out std_logic_vector(N-1 downto 0));
end entity;

architecture behavioral of RO is

	signal clks : std_logic_vector (N-1 downto 0) := (others => '0');

begin
	process begin
		clks(0) <= '0';
		wait for period/2;
		clks(0) <= '1';
		wait for period/2;
	end process;
	S: for i in 1 to N-1 generate
		clks(i) <= clks(i-1) after period/N;
	end generate S;

phases <= clks;

end architecture;

