library ieee;
use ieee.std_logic_1164.all;

entity FIR is
	generic (p: integer:=16;
		N : integer := 16);
port (
  	clk        : in  std_logic;
 	x_in, s_in : in  std_logic_vector( p-1 downto 0);
	x_out, s_out : out  std_logic_vector( p-1 downto 0));
end entity;

architecture cell of FIR is
	component FIR_cell is
		port (clk : in std+x_in, s_in: in std_logic_vector( p-1 downto 0);
		      x_out, s_out : out  std_logic_vector( p-1 downto 0));
	end component;

	type matrice is array (P-1 downto 0) of std_logic_vector (N-1 downto 0);
	signal x, s : matrice;

	signal coef : matrice := ( others => (others=> '0'));
begin
	Gen_cell:	
for I in 0 to p generate
	cellx: Fir_cell generic map ( N=>N, coef => coef(p) )port map
		(clk => clk, x_in=>x(I), s_in=>s(I), x_out=>x(I + 1), s_out=>s(I+1));
	end generate;

end architecture;