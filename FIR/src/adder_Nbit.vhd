library IEEE;
use IEEE.std_logic_1164.all;
entity adder_Nbit is
	generic (N:integer:=4);
	port (A,B: std_logic_vector (N-1 downto 0);
		S: out std_logic_vector (N-1 downto 0);
		Cin: in std_logic;
		Cout: out std_logic);
end entity;
architecture generare of adder_Nbit is
	component FA is
		port (A,B: in std_logic;
			Cin: in std_logic;
			S,Cout: out std_logic);
	end component;
	signal C: std_logic_vector (N downto 0);
begin
	Gen_FA:	
for I in 0 to N-1 generate
	FAx: FA port map
		(B=>B(I), A=>A(I), S=>S(I), Cin=>C(I), Cout=>C(I+1));
	end generate;
C(0)<=Cin;
Cout<=C(N);
end architecture; 
