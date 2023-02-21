----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:25:00 05/05/2022 
-- Design Name: 
-- Module Name:    sloupec - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.newspaper_pack.ALL;

entity column is
	Generic ( N : integer := 8);
    Port ( 
			  CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           STATE : inout  STD_LOGIC_VECTOR (N-1 downto 0);
           INIT_STATE : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  NEIGH_LEFT : inout STD_LOGIC_VECTOR (N-1 downto 0);
			  NEIGH_RIGHT : in STD_LOGIC_VECTOR (N-1 downto 0);
			  DIRECTION : in DIRECTION_T;
           EN : in  STD_LOGIC
			);
end column ;

architecture Behavioral of column is
	signal STATE_TEMP : std_logic_vector(N-1 downto 0);
begin

	process(CLK, RESET, DIRECTION)
	begin
		if (rising_edge(CLK)) then
			if (RESET = '1') then
				STATE <= (others => '0');
			else
				if (EN = '1') then
					STATE <= INIT_STATE(6 downto 0) & INIT_STATE(7);
				end if;
			end if;
		end if;
	end process;

end Behavioral;

