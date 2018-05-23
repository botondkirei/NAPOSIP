library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity efafs is
	generic ( W: natural := 8; -- FW signal Width
			N : natural :=8; -- number of phases
			D : integer := 10); -- division factor phases
	port (FW : in std_logic_vector (W-1 downto 0):=(others => '0');
	      en : in std_logic; -- enable oscillation
		efafs : out std_logic;
		  en_led, div : out std_logic);      
end efafs;

architecture behavioral of efafs is

signal clks : std_logic_vector (N-1 downto 0);
signal mout : std_logic;
signal FW_int : integer:=0;
signal i : integer := 0;

begin
	chain: for i in 1 to N-1 generate
		--clks(i) <= not clks(i-1) after 1 ns;
		clks(i) <= clks(i-1) and en after 1 ns;
	end generate chain;

    --clks(0) <= en nand mout after 1 ns when FW(0) = '1' else en and mout after 1 ns;
    clks(0) <= not mout after 1 ns ;

FW_int <= to_integer(unsigned(FW))-1;
mout <= clks(FW_int);
efafs <= mout;
en_led <= en;

process (mout)

begin
    if rising_edge(mout) then
        if i=D then
            i <= 0;
        else 
            i <= i + 1;
        end if;
    end if;
end process;
div <= '0' when i < D/2 else '1';
end architecture;