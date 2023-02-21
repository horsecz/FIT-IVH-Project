library IEEE;
use IEEE.STD_LOGIC_1164.all;

package newspaper_pack is
	type DIRECTION_T is (DIR_LEFT, DIR_RIGHT, DIR_NULL); -- vyctovy typ se smery
	function GETCOLUMN(signal DATA: in std_logic_vector; COLID: in integer; ROWS: in integer) return std_logic_vector; -- deklarace funkce
end newspaper_pack;

package body newspaper_pack is

function GETCOLUMN(signal DATA: in std_logic_vector; COLID: in integer; ROWS: in integer) return std_logic_vector is
	variable COLS: integer;
	variable result: std_logic_vector(ROWS-1 downto 0);
	begin
		COLS := DATA'length / ROWS;
		
		if (COLID >= COLS) then -- ID > pocet sloupcu => vraci 0. sloupec
			result := DATA(ROWS-1 downto 0);
		elsif (COLID < 0) then -- ID < 0 => vraci posledni sloupec
			result := DATA((ROWS*(COLS-1))+ROWS-1 downto ROWS*(COLS-1));
		else
			result := DATA((ROWS*COLID)+ROWS-1 downto ROWS*COLID );
		end if;
		
		return result;
	end GETCOLUMN;
	
end newspaper_pack;
