LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY controller_tb IS
END controller_tb;
 
ARCHITECTURE behavior OF controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         A : OUT  std_logic_vector(3 downto 0);
         R : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal A : std_logic_vector(3 downto 0);
   signal R : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          CLK => CLK,
          RESET => RESET,
          A => A,
          R => R
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      RESET <= '1';
      wait for 100 ns;	
		RESET <= '0';
		
		RESET <= '1';
      wait for 100 ns;	
		RESET <= '0';
		
		RESET <= '1';
      wait for 100 ns;	
		RESET <= '0';
		
		RESET <= '1';
      wait for 100 ns;	
		RESET <= '0';

		RESET <= '1';
      wait for 100 ns;	
		RESET <= '0';	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
