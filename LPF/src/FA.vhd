library IEEE;
use IEEE.std_logic_1164.all;
entity FA is
	port(A,B: in std_logic;
	     Cin: in std_logic;
	     S, Cout: out std_logic);
end entity;
architecture behavior of FA is
begin
	S<=A xor B xor Cin;
	Cout<=(A and B) or (Cin and A) or (Cin and B);
end architecture;
