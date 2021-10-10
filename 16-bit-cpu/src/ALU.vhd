----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:56 08/23/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library work;
use work.cpu_macros.ALL;

entity ALU is
    Port ( I_clk : in  STD_LOGIC;
           I_en : in  STD_LOGIC;
           I_dataA : in  STD_LOGIC_VECTOR (15 downto 0);
           I_dataB : in  STD_LOGIC_VECTOR (15 downto 0);
           I_dataDwe : in  STD_LOGIC;
           I_aluop : in  STD_LOGIC;
           I_PC : in  STD_LOGIC_VECTOR (4 downto 0);
           I_dataIMM : in  STD_LOGIC_VECTOR (15 downto 0);
           O_dataResult : in  STD_LOGIC_VECTOR (15 downto 0);
           O_dataWriteReg : out  STD_LOGIC_VECTOR (15 downto 0);
           O_Branch : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	-- internal temp reg to store res
	signal s_res : std_logic_vector(17 downto 0) := (others => '0');
	signal s_Branch :std_logic := '0';
begin
	process(I_clk, I_en)
	begin
		if rising_edhe(I_clk) and I_en = '1' then 
			O_dataWriteReg <= I_dataDwe;
			case I_aluop(4 downto 1) is 
				when OPCODE_ADD =>
					if I_aluop(0) = '0' then 
						s_res(16 downto 0) <= std_logic_vector(unsigned('0' & I_dataA) + unsigned('0' & I_dataB));
					else 
						s_res(16 downto 0) <= std_logic_vector(signed(I_dataA(15) & I_dataA) + signed(I_dataB(15) & I_dataB));
					end if;
					s_Branch <= '0';
					--TODO: MISSING OVERFLOW HANDLE
				when OPCODE_SUB => 
					if I_aluop(0) = '0' then 
						s_res(16 downto 0) <= std_logic_vector(unsigned('0' & I_dataA) - unsigned('0' & I_dataB));
					else 
						s_res(16 downto 0) <= std_logic_vector(signed(I_dataA(15) & I_dataA) - signed(I_dataB(15) & I_dataB));
					end if;
					s_Branch <= '0';
					--TODO: MISSING OVERFLOW HANDLE 2
					
				when OPCODE_OR => 
					s_res(15 downto 0 ) <= I_dataA or I_dataB;
					s_Branch <= '0';
				when OPCODE_AND =>
					s_res(15 downto 0) <= I_data and I_dataB;
					s_Branch <= '0';
				when OPCODE_XOR =>
					s_res(15 downto 0) <= I_data xor I_dataB;
					s_Branch <= '0';
				when OPCODE_NOT =>
					s_res(15 downto 0) <= not I_data;
					s_Branch <= '0';
									
				when OPCODE_LOAD => 
					if I_aluop(0) = '0' then -- flag: HIGH HALF
						s_res(15 downto 0) <= I_dataIMM(7 downto 0 ) & X"00";
					else  -- flag: OW HALF
						s_res(15 downto 0) <= X"00" & I_dataIMM(7 downto 0);
					end if;
					s_Branch <= '0';
					
				when OPCODE_CMP => 
					if I_dataA = IdataB then
						s_res(CMP_BIT_EQ) <= '1';
					else 
						s_res(CMP_BIT_EQ) <= '0';
					end if;
					if I_dataA = X"0000" then
						 s_result(CMP_BIT_AZ) <= '1';
					else
						 s_result(CMP_BIT_AZ) <= '0';
					end if;
					if I_dataB = X"0000" then
						 s_result(CMP_BIT_BZ) <= '1';
					else
						 s_result(CMP_BIT_BZ) <= '0';
					end if;					
					--sign dependency
					if I_aluop(0) = '0' then
					  if unsigned(I_dataA) > unsigned(I_dataB) then
						 s_result(CMP_BIT_AGB) <= '1';
					  else
						 s_result(CMP_BIT_AGB) <= '0';
					  end if;
					  if unsigned(I_dataA) < unsigned(I_dataB) then
						 s_result(CMP_BIT_ALB) <= '1';
					  else
						 s_result(CMP_BIT_ALB) <= '0';
					  end if;
					else
					  if signed(I_dataA) > signed(I_dataB) then
						 s_result(CMP_BIT_AGB) <= '1';
					  else
						 s_result(CMP_BIT_AGB) <= '0';
					  end if;
					  if signed(I_dataA) < signed(I_dataB) then
						 s_result(CMP_BIT_ALB) <= '1';
					  else
						 s_result(CMP_BIT_ALB) <= '0';
					  end if;
					end if;
					s_res(15) <= '0'; -- NC
					s_res(9 downto 0) <= "0000000000"; -- NC
					s_Breach <= '0';
				
				when OPCODE_SHL => 
					s_res(15 downto 0) <= std_logic_vector(shift_left(unsigned(I_dataA),unsigned(I_dataB)));
					s_Breach <= '0';
				
				when OPCODE_SHR => 
					s_res(15 downto 0) <= std_logic_vector(shift_right(unsigned(I_dataA),unsigned(I_dataB)));
					s_Breach <= '0';
					
				when OPCODE_JUMPEQ =>
				  s_result(15 downto 0) <= I_dataB;

				  case (I_aluop(0) & I_dataIMM(1 downto 0)) is
					 when CJF_EQ =>
						s_shouldBranch <= I_dataA(CMP_BIT_EQ);
					 when CJF_AZ =>
						s_shouldBranch <= I_dataA(CMP_BIT_Az);
					 when CJF_BZ =>
						s_shouldBranch <= I_dataA(CMP_BIT_Bz);
					 when CJF_ANZ =>
						s_shouldBranch <= not I_dataA(CMP_BIT_AZ);
					 when CJF_BNZ =>
						s_shouldBranch <= not I_dataA(CMP_BIT_Bz);
					 when CJF_AGB =>
						s_shouldBranch <= I_dataA(CMP_BIT_AGB);
					 when CJF_ALB =>
						s_shouldBranch <= I_dataA(CMP_BIT_ALB);
					 when others =>
						  s_shouldBranch <= '0';
				  end case;
					
				when others => s_res <= "00" & X"FEFE";
			end case;
		end if;
	end process;


end Behavioral;

