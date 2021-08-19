----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:05:24 08/19/2021 
-- Design Name: 
-- Module Name:    single_port_ram - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity single_port_ram is
    Port ( RAM_ADDR : in  STD_LOGIC_VECTOR (6 downto 0); -- write/read address
           RAM_DATA_IN : in  STD_LOGIC_VECTOR (7 downto 0); --data
           RAM_WR : in  STD_LOGIC; -- write enable	
           RAM_CLOCK : in  STD_LOGIC; --clock input 
           RAM_DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end single_port_ram;

architecture Behavioral of single_port_ram is
	-- RAM type
type RAM_ARRAY is array (0 to 127) of std_logic_vector (7 downto 0);
	-- RAM init
signal RAM: RAM_ARRAY :=(
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
begin
ram_write: process(RAM_CLOCK)
begin
	if (rising_edge(RAM_CLOCK)) then
	if (RAM_WR='1') then --only when Write enable 
	-- RAM_ADR logic_vec -> unsigned -> integer
	RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;
	end if;
	end if;
end process;
	RAM_DATA_OUT <= RAM(to_integer(unsigned(RAM_ADDR))); 
end Behavioral;

