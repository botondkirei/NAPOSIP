library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_cell is
	generic (N: integer:=16;
		--coef: std_logic_vector (N-1 downto 0));
		coef: integer := 0);
port (
  	clk        : in  std_logic;
 	x_in, s_in : in  std_logic_vector( N-1 downto 0);
	x_out, s_out : inout  std_logic_vector( N-1 downto 0));
 end entity;
 
architecture cell of FIR_cell is

	component adder_Nbit is
		generic (N:integer:=4);
		port (A,B: in std_logic_vector (N-1 downto 0);
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
	generic (width:integer:=32);
    
    port (ma,mb : in std_logic_vector (width-1 downto 0); --4/8/16/32
          clk, rst : in std_logic;
          mp : out std_logic_vector (2*width-1 downto 0);--8/16/32/64
          done : out std_logic);
		end component;
	
	signal mm: std_logic_vector (2*N-1 downto 0);
	signal done : std_logic;
	signal coef_vector: std_logic_vector(N-1 downto 0);
begin
---	Gen_cell:	
--for I in 0 to N generate
--	cellx: cell port map
--		(x_in=>x_in(I), s_in=>s_in(I), x_out=>x_out(I), s_out=>s_out(I), coef=>coef(N+1));
--	end generate;
coef_vector <= std_logic_vector(to_unsigned(coef, N));
registru: reg generic map ( N => N) port map (clk => clk, en => done, d => x_in, q => x_out);
multiplicator : multip generic map (width => N) port map (clk => clk, rst => '1', ma => coef_vector, mb => x_out, mp => mm, done => done);
sumator : adder_Nbit generic map (N => N) port map (a => mm(2*N-1 downto N), b => s_in, s => s_out, cin => '0', cout => open);

end architecture; 
