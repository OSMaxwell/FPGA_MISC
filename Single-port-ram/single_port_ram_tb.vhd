--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:18:25 08/19/2021
-- Design Name:   
-- Module Name:   /home/osm/Documents/fpga_projects/single-port RAM/single-port-ram/single_port_ram_tb.vhd
-- Project Name:  single-port-ram
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: single_port_ram
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY single_port_ram_tb IS
END single_port_ram_tb;
 
ARCHITECTURE behavior OF single_port_ram_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT single_port_ram
    PORT(
         RAM_ADDR : IN  std_logic_vector(6 downto 0);
         RAM_DATA_IN : IN  std_logic_vector(7 downto 0);
         RAM_WR : IN  std_logic;
         RAM_CLOCK : IN  std_logic;
         RAM_DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RAM_ADDR : std_logic_vector(6 downto 0) := (others => '0');
   signal RAM_DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal RAM_WR : std_logic := '0';
   signal RAM_CLOCK : std_logic := '0';

 	--Outputs
   signal RAM_DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant RAM_CLOCK_period : time := 5 ns;
	
	type test_ram_array is array (0 to 127) of std_logic_vector (7 downto 0);
	constant test_ram : test_ram_array :=(
		x"11",x"22",x"33",x"44",-- 0x00
		x"55",x"66",x"31",x"44",-- 0x04 
		x"00",x"00",x"00",x"00",-- 0x08 
		x"00",x"00",x"00",x"00",-- 0x0C 
		x"00",x"00",x"00",x"00",-- 0x10 
		x"00",x"00",x"00",x"00",-- 0x14 
		x"00",x"00",x"00",x"00",-- 0x18 
		x"00",x"00",x"00",x"00",-- 0x1C 
		x"00",x"00",x"00",x"00",-- 0x20 
		x"00",x"00",x"00",x"00",-- 0x24 
		x"00",x"00",x"00",x"00",-- 0x28 
		x"00",x"00",x"00",x"00",-- 0x2C 
		x"00",x"00",x"00",x"00",-- 0x30 
		x"00",x"00",x"00",x"00",-- 0x34 
		x"00",x"00",x"00",x"00",-- 0x38 
		x"00",x"00",x"00",x"00",-- 0x3C 
		x"00",x"00",x"00",x"00",-- 0x40 
		x"00",x"00",x"00",x"00",-- 0x44 
		x"00",x"00",x"00",x"00",-- 0x48 
		x"00",x"00",x"00",x"00",-- 0x4C 
		x"00",x"00",x"00",x"00",-- 0x50 
		x"00",x"00",x"00",x"00",-- 0x54 
		x"00",x"00",x"00",x"00",-- 0x58 
		x"00",x"00",x"00",x"00",-- 0x5C 
		x"00",x"00",x"00",x"00",-- 0x60
		x"00",x"00",x"00",x"00",-- 0x64
		x"00",x"00",x"00",x"00",-- 0x68
		x"00",x"00",x"00",x"00",-- 0x6C
		x"00",x"00",x"00",x"00",-- 0x70
		x"00",x"00",x"00",x"00",-- 0x74
		x"00",x"00",x"00",x"00",-- 0x78
		x"00",x"00",x"00",x"00" -- 0x7C
   ); 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: single_port_ram PORT MAP (
          RAM_ADDR => RAM_ADDR,
          RAM_DATA_IN => RAM_DATA_IN,
          RAM_WR => RAM_WR,
          RAM_CLOCK => RAM_CLOCK,
          RAM_DATA_OUT => RAM_DATA_OUT
        );

   -- Clock process definitions
   RAM_CLOCK_process :process
   begin
		RAM_CLOCK <= '0';
		wait for RAM_CLOCK_period/2;
		RAM_CLOCK <= '1';
		wait for RAM_CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		--read 
		RAM_WR <= '0';
		RAM_ADDR <= "0000000";
		RAM_DATA_IN <= x"1F";
		wait for RAM_CLOCK_period;
		for i in 0 to 5 loop
			RAM_ADDR <= RAM_ADDR + "0000001"; 
			wait for RAM_CLOCK_period;
			assert ( RAM_DATA_OUT = test_ram(i))
			report "test failed at cell" & integer'image(i) severity error;
		end loop;
		--write 
		RAM_WR <= '1';
		RAM_ADDR <= "0001000";
      wait;
   end process;

END;
