library ieee;
use ieee.std_logic_1164.all;
entity FIR_cell is
	generic (N: integer:=16;
		--coef: std_logic_vector (N-1 downto 0));
		coef: std_logic_vector);
port (
  	clk        : in  std_logic;
 	x_in, s_in : in  std_logic_vector( N-1 downto 0);
	x_out, s_out : out  std_logic_vector( N-1 downto 0));
 end entity;
architecture cell of FIR_cell is

	component adder_Nbit is
		generic (N:integer:=4);
		port (A,B: std_logic_vector (N-1 downto 0);
			S: out std_logic_vector (N-1 downto 0);
			Cin: in std_logic;
			Cout: out std_logic);
	end component;
	component reg is
		generic ( N : integer := 16);
		port (
			clk, en : in std_logic;
			d : in std_logic_vector(N-1 downto 0);
			q : out std_logic_vector(N-1 downto 0));
		end component;
	component multip is
		generic ( N : integer := 16);
		port (
			clk : in std_logic;
			ma, mb : in std_logic_vector(N-1 downto 0);
			mtp : out std_logic_vector(N-1 downto 0)
			done : std_logic);
		end component;
	signal mm: std_logic_vector (N-1 downto 0);
begin
---	Gen_cell:	
--for I in 0 to N generate
--	cellx: cell port map
--		(x_in=>x_in(I), s_in=>s_in(I), x_out=>x_out(I), s_out=>s_out(I), coef=>coef(N+1));
--	end generate;

registru: reg generic map ( N => N) port map (clk => clk, en => done, d => x_in, q => x_out)
multiplicator : multip generic map (width => N) port map (clk => clk, ma => coef, mb => x_out, mtp => mm, done => done);
sumator : adder_Nbit generic map (N => N) port map (a => mm, b => s_in, s => s_out, cin => '0', cout => open);

end architecture; 
