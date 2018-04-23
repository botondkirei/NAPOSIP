library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity efafs is
	generic ( P : natural :=256);
	port (FW : in std_logic_vector (7 downto 0):=(others => '0');
	      en : in std_logic;
		clk : out std_logic);      
end efafs;

architecture behavioral of efafs is

signal c : std_logic_vector (P-1 downto 0);
signal m : std_logic;
signal FW_int : integer:=0;

begin
	chain: for i in 1 to P-1 generate
		c(i) <= not c(i-1) after 1 ns;
	end generate chain;

process (FW_int, en, m)
begin
	if FW(0) = '0' then
		c(0) <= en nand m after 1 ns;
	else 
		c(0) <= en and m after 1 ns;
	end if;
end process;

FW_int <= to_integer(unsigned(FW));
--m <= c(FW_int) after 1 ns;
process (FW_int, c)
	begin 
		m <= c(FW_int);
end process;
--m <= c(to_integer(FW)) after 1 ns;
clk <= m;

end architecture;