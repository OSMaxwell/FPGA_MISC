----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:12:39 10/07/2021 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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
use work.cpu_macros.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
	port( I_clk : in STD_LOGIC;
				I_reset: in STD_LOGIC;
				I_aluop: in STD_LOGIC_VECTOR(4 downto 0);
				--mem controller
				I_ready: in STD_LOGIC;
				O_execute: out STD_LOGIC;
				I_dataReady: in STD_LOGIC;
				
				O_state: out STD_LOGIC_VECTOR ( 6 downto 0)
				);
end control_unit;

architecture Behavioral of control_unit is
	type T_STATE is
		(s_FETCH, s_READ, s_DECODE, s_EXECUTE, s_MEMORY, s_WB, s_STALL);
		
	signal s_state: s_FETCH;
	signal mem_ready: STD_LOGIC;
	signal mem_execute: STD_LOGIC;
	signal mem_dataReady: STD_LOGIC;
	
	signal mem_cycles: integer := 0;
	
	signal next_s_state: T_STATE := s_FETCH;
	
	signal set_idata: STD_LOGIC := '0';
	signal set_ipc: STD_LOGIC := '0';
	
begin
	-- GET INPUTS
	O_execute <= mem_execute;
	mem_ready <= I_ready;
	mem_dataReady <= I_dataReady;
	process(I_clk)
	begin
		if rising_edge(I_clk) then 
			if I_reset = '1' then -- RESET
				s_state <= s_FETCH;
				mem_cycles <= 0;
				set_ipc <=  '0';
				set_idata <= X"0000";
			else
				--TODO: INTERRUPT
				case s_state is 
					when s_FETCH => --FETCH
						if mem_cycles = 0 and mem_ready = '1' then  -- READY? then START
							mem_execute <= '1';
							mem_cycles <= 1;
						elsif mem_cycles = 1 then
							mem_execute <= '0';
							if mem_dataReady = '1' then
								mem_cycles <= 0;
								s_state <= s_READ;
							end if;
						end if;
						
					when s_READ => -- READ 
						s_state <= s_DECODE; 
						
					when s_DECODE => -- DECODE 
						s_state <= s_EXECUTE;
						
					when s_EXECUTE =>  --EXECUTE
						--MEM/WB
						if (( I_aluop(4 downto 1) = OPCODE_READ) or ( I_aluop(4 downto 1) = OPCODE_WRITE)) then 
							s_state = s_MEMORY; -- GET FROM MEMORY
							if mem_cycles = 0 and mem_ready = '1' then --READY? then START
								mem_execute <= '1';
								mem_cycles <= 1;
							end if;
						else 
							s_state <= s_WB;
						end if;
						
					when s_MEMORY --MEMORY 
						if mem_cycles = 0 and mem_ready '1' then 
							mem_execute <= '1';
							mem_cycles <= '1';
						elsif mem_cycles = 1 then
							mem_execute <= '0';
							-- IS IT A WRITE?--> WB
							if I_aluop(4 downto 1) = OPCODE_WRITE then
								mem_cycles <= 0;
								s_state <= s_WB;
							elsif mem_dataReady = '1' then 
								-- wait for data 
								mem_cycles <= 0;
								s_state <= s_WB;
							end if;
						end if;
					when s_WB =>  --WRITEBACK
						-- TODO: interrupt 
						s_state  <= s_FETCH;
					when s_STALL =>  -- STALLING
						-- TODO: interrupt
					when others  => 
					s_state <= s_FETCH;
					end case;
			end if;
		end if;
	end process;
	O_state <= s_state;	
end Behavioral;

