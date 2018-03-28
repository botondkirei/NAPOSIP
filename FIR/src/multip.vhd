library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multip is 
	generic (width:integer:=32);
	
	port (ma,mb : in std_logic_vector (width-1 downto 0); --4/8/16/32
	      clk, rst : in std_logic;
	      mp : out std_logic_vector (2*width-1 downto 0);--8/16/32/64
	      done : out std_logic);
end entity;

architecture behavioral of multip is 

signal my, lo, hi : std_logic_vector (width-1 downto 0);--4/8/16/32
signal sum : std_logic_vector (width-1 downto 0);--4/8/16/32
signal rn, a1 : std_logic;
type state_t is (start, adunare, deplasare, gata, nimic);
signal current_state, next_state : state_t;
signal loadHI, loadLO, loadM, shft, rsthi : std_logic;

component auto is 
	generic(width:integer:=8);--4/8/16/32
	port(clk,rn : in std_logic;
	     a : in std_logic;
	     loadLO : inout std_logic;
	     loadHI, loadM, shft, rsthi, done : out std_logic);
end component;

component reg_dep is
	generic (width : natural :=32); 
	port (pin : in std_logic_vector (width-1 downto 0);
	      clk, shft, ld, rst, sin : in std_logic;
	      y : inout std_logic_vector (width-1 downto 0));
end component;

begin
a1 <= lo(0);
--b1 <= '1' when out1=31 else '0';
uut : auto generic map (width=> width) port map (clk => clk, rn => rn, a => a1, loadHI => loadHI, loadLO => loadLO, loadM => loadM, shft => shft, rsthi => rsthi, done => done);
M_i : reg_dep generic map (width => width) port map (ma, clk, '0', loadM, rst, '0', my);
LO_i: reg_dep generic map (width => width) port map (mb, clk, shft, loadLO, rst, hi(0), lo);
HI_i: reg_dep generic map (width => width) port map (sum, clk, shft, loadHI, rsthi, '0', hi);

mp <= hi&lo;
sum <= my+hi;

end architecture;