library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_FFA is 
	generic (N : natural := 8);
end entity;

architecture bhv of test_FFA is 
	component FFA 
	generic (N : natural := 8; P : integer := 3);
	port (FW : in std_logic_vector (N-1 downto 0);
	      en : in std_logic;
	      ffa : inout std_logic);
	end component;


signal FWt : std_logic_vector (N-1 downto 0) := "00000011";
signal FWt1 : std_logic_vector (N-1 downto 0) := "00000010";
signal FWt2 : std_logic_vector (N-1 downto 0) := "00000100";
signal ent, ffat, ffat1, ffat2 : std_logic;

begin
uut : FFA generic map (N => N, P => 2) port map (FW => FWt, en => ent, ffa => ffat);
uut1: FFA generic map (N => N, P => 3) port map (FW => FWt1, en => ent, ffa => ffat1);
uut2: FFA generic map (N => N, P => 4) port map (FW => FWt2, en => ent, ffa => ffat2);

ent <= '0', '1' after 50 ns;

end architecture;
