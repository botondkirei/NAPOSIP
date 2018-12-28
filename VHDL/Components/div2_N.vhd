library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
entity div2N is 
	generic ( N : natural := 0;
			  delay : time := 1 ns);
	port ( fin : in std_logic;
			fout : out std_logic);
end entity;

architecture behavioral of div2N is

	signal div : std_logic_vector( N downto 0) := (others => '0');
	
begin
	
	div(0) <= fin;
	fout <= div(N) after delay;
	
    stage: for I in 0 to N-1  generate
        bistabil: process (div(I))
		begin
			if rising_edge(div(I)) then
				div(I+1) <= not div(I+1) after delay;
			end if;
		end process;
    end generate stage;

end architecture;

	
