library ieee;
use ieee.std_logic_1164.all;

entity auto is
	generic (width:integer:=32);--4/8/16/32
	port(clk,rn : in std_logic;
	     a : in std_logic;
	     loadLO : inout std_logic;
	     loadHI, loadM, shft, rsthi, done : out std_logic);
end entity;

architecture behavioral of auto is
type state_t is (start, adunare, deplasare, gata, nimic);
signal current_state, next_state : state_t;
signal cnt : integer :=0;

begin
	process(clk)
	begin
		if rising_edge (clk) then --registru
			if rn = '0' then
				current_state <= gata;
			else
				current_state <= next_state;
			end if;
		end if;
	end process; ---------------------------------

	process (current_state, a, cnt, rn)
	begin
		if rn='0' then
			next_state <= gata;
		else
		case (current_state) is
		when start =>
			if (a = '1') then
				next_state <= adunare;
			else
				next_state <= nimic; --era deplas
			end if;

		when adunare =>
			next_state <= deplasare;

		when nimic =>
			next_state <= deplasare;

		when deplasare =>
			if (cnt = width) then
				next_state <= gata;
			else
				next_state <= start;
			end if;
		when gata =>
			next_state <= start;

		when others =>
			next_state <= gata;
		end case;
		end if;
	end process;

	process (clk)
	begin
		if rising_edge (clk) then
			if current_state = gata then
				cnt <= 0;
			else if current_state = start then
				cnt <= cnt+1;
				end if;
			end if;
		end if;
	end process;

loadHI <='1' when current_state = adunare else '0';
loadLO <='1' when current_state = gata 	else '0';
loadM <= loadLO;
shft <= '1' when current_state = deplasare else '0';
rsthi <='0' when current_state = gata else '1';
done <='1' when current_state = gata else '0';

end architecture;