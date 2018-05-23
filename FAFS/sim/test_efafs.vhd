library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_efafs is 
end entity;

architecture behavioral of test_efafs is
	component efafs is
		generic ( P : natural := 256);
		port (FW : in std_logic_vector (7 downto 0);
		      en : in std_logic;
			clk : out std_logic);      
	end component efafs;

signal FWtst : std_logic_vector (7 downto 0) := "00000011"; --2
signal FWtst1 : std_logic_vector (7 downto 0) := "00000100"; --h'5
signal entst : std_logic;
signal clk1, clk2 : std_logic;

begin
uut : efafs generic map (P => 256) port map (FW => FWtst, en => entst, clk => clk1);
uut1 : efafs generic map (P => 256) port map (FW => FWtst1, en => entst, clk => clk2);

entst <= '0', '1' after 300 ns;

end architecture;