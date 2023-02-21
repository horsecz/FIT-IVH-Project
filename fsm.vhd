----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:27:43 05/05/2022 
-- Design Name: 
-- Module Name:    fsm - Behavioral 
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

entity fsm is
    Port ( 
			  CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           DIR : out  DIRECTION_T;
           CNT : in  STD_LOGIC_VECTOR (3 downto 0);
			  ADDR : in integer range 0 to 1000
			);
end fsm;

architecture Behavioral of fsm is -- Moore-state machine
   type state_type is (START, ANIMATION); 
   signal state, next_state : state_type; 
  
   signal DIR_i : DIRECTION_T; 
begin
   SYNC_PROC: process (CLK, RESET) is
   begin
      if (rising_edge(CLK)) then
         if (RESET = '1') then
            state <= START;
            DIR <= DIR_NULL;
         else
            state <= next_state;
            DIR <= DIR_i;
         end if;        
      end if;
   end process;
 
   OUTPUT_DECODE: process (state, DIR_i)
   begin
		case state is
			when START =>
				DIR_i <= DIR_NULL;
			when ANIMATION =>
				DIR_i <= DIR_NULL;
		end case;
   end process;
 
   NEXT_STATE_DECODE: process (state, ADDR)
   begin
      next_state <= state; 
      case (state) is
         when START =>
				next_state <= ANIMATION;
         when ANIMATION =>
				next_state <= ANIMATION;
      end case;   
   end process;

end Behavioral;

