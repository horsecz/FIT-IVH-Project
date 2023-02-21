library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.newspaper_pack.ALL;


entity newspaper_pack_tb is
end newspaper_pack_tb;

architecture Behavioral of newspaper_pack_tb is
	signal DATA: std_logic_vector(0 to 11) := "101001100111";
	signal TEST: std_logic_vector(0 to 5) := "110010";
	--signal tmp: std_logic_vector(0 to 2);
begin
	--tmp <= GETCOLUMN(DATA, 4, 3);
	assert(GETCOLUMN(DATA, 0, 3) = DATA(0 to 2));	-- 101
	assert(GETCOLUMN(DATA, 1, 3) = DATA(3 to 5));	-- 001
	assert(GETCOLUMN(DATA, 0, 3) = DATA(0 to 2));	-- 101
	assert(GETCOLUMN(DATA, 4, 3) = DATA(0 to 2));	-- 101

	assert(GETCOLUMN(TEST, 0, 2) = TEST(0 to 1));	-- 11
	assert(GETCOLUMN(TEST, 1, 2) = TEST(2 to 3));	-- 00
	assert(GETCOLUMN(TEST, 2, 2) = TEST(4 to 5));	-- 10
	assert(GETCOLUMN(TEST, -1, 2) = TEST(4 to 5));	-- 10
	assert(GETCOLUMN(TEST, 420, 2) = TEST(0 to 1));	-- 11
end Behavioral;

