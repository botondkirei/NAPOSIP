library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
entity div2N_2N_1 is 
	generic ( N : natural := 1	;
			  delay : time := 1 ns);
	port ( fin, mc  : in std_logic;
			fout : out std_logic);
end entity;

architecture behavioral of div2N_2N_1 is

	component div2N is 
		generic ( N : natural := 3;
				  delay : time := 1 ns);
		port ( fin: in std_logic;
				fout : out std_logic);
	end component;
	
	signal D1, D0 : std_logic := '0';
	signal f2N, mux : std_logic;
	
begin
	divider_2N : div2N generic map (N=>N) port map (fin => fin, fout => f2N);
	process (fin)
	begin
		if rising_edge(fin) then
			D1 <= not D0 after delay;
			D0 <= (D1 or mc) and (not D0) after delay;
		end if;
	end process;
	
	fout <= D0;
	
end architecture;

	
