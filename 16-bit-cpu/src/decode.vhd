----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:00 08/23/2021 
-- Design Name: 
-- Module Name:    decode - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
library work;
use work.cpu_macros.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decode is
    Port ( I_clk : in  STD_LOGIC;
           I_dataInst : in  STD_LOGIC_VECTOR (15 downto 0);
           I_en : in  STD_LOGIC;
           O_selA : out  STD_LOGIC_VECTOR (2 downto 0);
           O_selB : out  STD_LOGIC_VECTOR (2 downto 0);
           O_selD : out  STD_LOGIC_VECTOR (2 downto 0);
           O_dataIMM : out  STD_LOGIC_VECTOR (15 downto 0);
           O_regDwe : out  STD_LOGIC;
           O_aluop : out  STD_LOGIC_VECTOR (4 downto 0));
end decode;

architecture Behavioral of decode is

-- Opcode | OP | W?
-- 0000 	ADD    Y (USING FLAG: SIGNED/UNSIGNED)
-- 0001 	SUB    Y
-- 0010 	OR     Y 
-- 0011 	XOR    Y
-- 0100 	AND    Y
-- 0101 	NOT    Y
-- 0110 	READ   Y
-- 0111 	WRITE  N
-- 1000 	LOAD 	 Y (USING FLAG: HIGH /LOW)
-- 1001 	CMP 	 Y (USING FLAG: BT/ST/BE)
-- 1010 	SHL	 Y
-- 1011 	SHR	 Y
-- 1100 	JUMP	 N (USING FLAG: TO_REG/IMME_JUMP)
-- 1101 	JUMPEQ N 
-- 1110 	RESERVED
-- 1111 	RESERVED

begin
	process (I_clk)
	begin
		if rising_edge(I_clk) and I_en ='1' then
			--decode INPUT
			O_selA <= I_dataInst(7 downto 5);
			O_selB <= I_dataInst(4 downto 2);
			O_selD <= I_dataInst(11 downto 9);
			O_dataIMM <= I_dataInst(7 downto 0) & I_dataInst(7 downto 0); -- concate with self to use directly by ALU
			O_aluop <= I_dataInst(15 downto 12) & I_dataInst(8); -- Include FLAG
			
			--Write control
			case I_dataInst(15 downto 12) is
				when OPCODE_WRITE =>
					O_regDwe <= '0';
				when OPCODE_JUMP =>
					O_regDwe <= '0';
				when OPCODE_JUMPEQ => 
					O_regDwe <= '0';
				when others => 
					O_regDwe <= '1';
			end case;
		end if;
	end process;

end Behavioral;

