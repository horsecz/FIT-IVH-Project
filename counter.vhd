library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
	Generic (
				CLK_PERIOD : integer := 1000;	-- integer, ale jednotky jsou v ns
				OUT_PERIOD : integer := 100	-- take v ns
				);
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           EN : out  STD_LOGIC := '0');
end counter;

architecture Behavioral of counter is
	function log2(A: integer) return integer is
		variable bits : integer := 0;
		variable b : integer := 1;
	begin
		while (b <= a) loop
			b := b * 2;
			bits := bits + 1;
		end loop;
		return bits;
	end function;
	
	signal cnt : std_logic_vector(log2(OUT_PERIOD/CLK_PERIOD) downto 0);
begin

	process(CLK, RESET) is
	begin
		if (RESET = '1') then
			cnt <= (others => '0');
		else
			if (rising_edge(CLK)) then
				cnt <= cnt + 1;
			end if;
		end if;
		
		if (cnt = 0) then
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;
end Behavioral;

