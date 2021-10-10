----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:59 10/03/2021 
-- Design Name: 
-- Module Name:    pc_unit - Behavioral 
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
library work;
use work.cpu_macros.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity pc_unit is
    Port ( I_clk : in  STD_LOGIC;
           I_nPC : in  STD_LOGIC_VECTOR (15 downto 0);
           I_nPCop : in  STD_LOGIC_VECTOR (1 downto 0);
           O_PC : out  STD_LOGIC_VECTOR (15 downto 0));
end pc_unit;

architecture Behavioral of pc_unit is
	signal current_pc: std_logic_vector(15 downto 0) := X"0000";
begin
	process (I_clk)
	begin
	if rising_edge(I_clk) then
		case I_nPCop is
			when PCU_OP_NOP => -- NOP
				--Nothing
			when PCU_OP_INC => -- ++
				current_pc <= std_logic_vector(unsigned(current_pc) +1);
			when PCU_OP_ASSIGN => --Set from external source
 				current_pc_ <= I_nPC;
			when PCU_OP_RESET => -- Reset
				current_pc <= X"0000";
			when others => -- ERROR
				current_pc <= X"DEAD";				
		end case;
	end if; 
end process;

end Behavioral;

