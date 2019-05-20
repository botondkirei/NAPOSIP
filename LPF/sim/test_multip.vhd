library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity test_multip is
	generic (width:integer:=32);
end entity;

architecture test of test_multip is
	
	component multip
		port (ma,mb : in std_logic_vector (width-1 downto 0);--4/8/16/32
	     	      clk, rst : in std_logic;
		      mp : out std_logic_vector (2*width-1 downto 0);--8/16/32/64
		      done : out std_logic);
	end component;

signal mat : std_logic_vector (width-1 downto 0) :="00000000000000000000000000000000";--4/8/16/32
signal mbt : std_logic_vector (width-1 downto 0) :="00000000000000000000000000000000";
signal clkt, rstt, tdone : std_logic;
signal mpt : std_logic_vector (2*width-1 downto 0);--8/16/32/64
signal count : std_logic_vector (width-1 downto 0);

begin
uut : multip port map (ma => mat, mb => mbt, clk => clkt, rst => rstt, mp => mpt, done => tdone);

rstt <='0', '1' after 10 ns;

process
	begin
	clkt <= '0';
	wait for 10 ns;
	clkt <= '1';
	wait for 10 ns;
end process;

process (clkt, rstt)
	begin 
	if rstt='0' then count <="00000000000000000000000000000000";
	elsif (rising_edge(clkt)) then
		if count ="00000000000000000000000001100001" then --13 pt 4 biti/25 pt 8 biti/97 pt 32 biti (N*3+1)
		   count <="00000000000000000000000000000000";
		mat <= mat + '1';
		mbt <= mbt + '1';
		else 
		   count <= count + 1;
		end if;
	end if;
end process;

end architecture;