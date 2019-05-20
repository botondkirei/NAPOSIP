library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_ro is 
	generic (N : natural := 8);
end entity;

architecture bhv of test_ro is 
	component ro 
	generic (N : natural := 8;
		 period : time := 10 ns); -- Number of clock phases
	port ( phases : out std_logic_vector(N-1 downto 0));
	end component;

	signal phases : std_logic_vector (N-1 downto 0);
	signal ent : std_logic;

begin
uut : ro generic map (N => N, period => 8 ns) port map (phases => phases);

ent <= '0', '1' after 300 ns;

end architecture;
