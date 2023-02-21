----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:29 05/05/2022 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.column;
use work.newspaper_pack.ALL;

entity controller is
    Port ( 
			  CLK : 	 in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           A : out  STD_LOGIC_VECTOR (3 downto 0);
           R : out  STD_LOGIC_VECTOR (7 downto 0)
			);
			  
end controller;

architecture Behavioral of controller is
	signal led_change_en : std_logic;
	signal column_change_en : std_logic;
	
	signal current_data : std_logic_vector(127 downto 0);
	signal ROM_data : std_logic_vector(127 downto 0);
	
	signal current_col : integer range 0 to 15;
	signal counter : std_logic_vector(3 downto 0) := "0000";
	
	signal current_address : integer range 0 to 1000 := 0;
	signal direction : DIRECTION_T;
begin
	led_change : entity work.counter
		generic map (
						CLK_PERIOD => 40,			--fpga.vhd:104 dcm_freq = 25MHz (ve frekvenci) <=> 1 / 25 000 000 sekund v case = 40 ns
						OUT_PERIOD => 17362		--OUT_PERIOD: 25 000 000 (dcm_freq) / 16 (sloupcu) = 1 562 500 / 90 (display refresh-rate, Hz) = 17362 ns
						)
		port map (
					CLK => CLK, 
					RESET => RESET, 
					EN => led_change_en
					);

	column_change : entity work.counter
		generic map (
						CLK_PERIOD => 40,			--stejne jako u led_change
						OUT_PERIOD => 5078125	--OUT_PERIOD: 3 250 000 000 (zmeny sloupcu, v ns) / 16 (pocet sloupcu) = 203 125 000 / 40 (CLK_period) = 5 078 125 ns
						)
		port map (
					CLK => CLK, 
					RESET => RESET, 
					EN => column_change_en
					);
	
	fsm : entity work.fsm
		port map (
					CLK => CLK, 
					RESET => RESET, 
					DIR => direction, 
					CNT => counter,
					ADDR => current_address
					);
	
	rom : entity work.ROM
		port map (
					ADDRESS => current_address, 
					DATA => ROM_data,
					CLK => CLK
					);

	gen_sloupec: for i in 0 to 15 generate
		signal state : std_logic_vector(7 downto 0);
		signal state_in : std_logic_vector(7 downto 0);
		signal state_right : std_logic_vector(7 downto 0);
		signal state_left : std_logic_vector(7 downto 0);
		signal i_mod : integer range 0 to 15;
	begin				
		current_data(i*8+7 downto i*8) <= state;
		
		state_in <= GETCOLUMN(ROM_data, i, 8);
		state_left <= GETCOLUMN(ROM_data, i+1, 8);
		state_right <= GETCOLUMN(ROM_data, i-1, 8);
	
		column_entity : entity work.column  
			generic map (N => 8)
			port map (
						CLK => CLK, 
						RESET => RESET, 
						STATE => state, 
						INIT_STATE => state_in, 
						NEIGH_LEFT => state_left, 
						NEIGH_RIGHT => state_right,
						EN => column_change_en, 
						DIRECTION => direction
						);
	end generate;

	process (CLK, RESET, led_change_en, column_change_en, direction) is
	begin
		if rising_edge(CLK) then
			if (RESET = '1') then
				current_col <= 0;
				counter <= (others => '0');
			end if;
			if (column_change_en = '1') then
				counter <= counter + 1;
			end if;
			if (led_change_en = '1') then
				current_col <= current_col + 1;
				if current_col = 15 then
					current_col <= 0;
				end if;
			end if;
			if (counter = "1111") then
				current_address <= current_address + 1;
				if (current_address >= 56) then
					current_address <= 0;
				end if;
			end if;
		end if;
	end process;

	A <= std_logic_vector(to_unsigned(current_col, A'length));
	R <= GETCOLUMN(current_data, current_col, 8);
end Behavioral;

