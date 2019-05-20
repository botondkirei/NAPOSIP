library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_comp_FFA_EFAFS is 
	generic (N : natural := 8);
end entity;

architecture bhv of test_comp_FFA_EFAFS is 
	component FFA 
	--generic (N : natural := 8; P : integer := 3; period : time := 1000 ns);
	generic (N : natural := 8; P : integer := 3);
	port (FW : in std_logic_vector (N-1 downto 0);
	      en : in std_logic;
	      ffa : inout std_logic);
	end component;

	component efafs is
		port (FW : in std_logic_vector (7 downto 0);
		      en : in std_logic;
			efafs, div: out std_logic);      
	end component efafs;



signal FWt : std_logic_vector (N-1 downto 0) := std_logic_vector(to_unsigned(2,N));
signal FWt1 : std_logic_vector (N-1 downto 0) := std_logic_vector(to_unsigned(3,N));
signal FWt2 : std_logic_vector (N-1 downto 0) := std_logic_vector(to_unsigned(4,N));
signal FWt3 : std_logic_vector (N-1 downto 0) := std_logic_vector(to_unsigned(5,N));
signal ent, ffa_clk1, ffa_clk2, ffat2, ffat3 : std_logic;
signal clk1, clk2 : std_logic;
signal div_clk1, div_clk2 : std_logic;

begin
--uut : FFA generic map (N => N, P => 3) port map (FW => FWt, en => ent, ffa => ffa_clk1);
--uut1: FFA generic map (N => N, P => 3) port map (FW => FWt1, en => ent, ffa => ffa_clk2);
--uut2: FFA generic map (N => N, P => 3) port map (FW => FWt2, en => ent, ffa => ffat2);
--uut3: FFA generic map (N => N, P => 3) port map (FW => FWt3, en => ent, ffa => ffat3);

ent <= '0', '1' after 300 ns;

uut2 : efafs port map (FW => FWt, en => ent, efafs => clk1, div => div_clk1);
uut3 : efafs port map (FW => FWt1, en => ent, efafs => clk2, div => div_clk2);



end architecture;