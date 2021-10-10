--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package cpu_macros is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;

--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
-- Opcodes
	constant OPCODE_ADD:    std_logic_vector(3 downto 0) :=  "0000";	-- ADD
	constant OPCODE_SUB:    std_logic_vector(3 downto 0) :=  "0001";	-- SUB 
	constant OPCODE_OR:     std_logic_vector(3 downto 0) :=  "0010";	-- OR 
	constant OPCODE_XOR:    std_logic_vector(3 downto 0) :=  "0011";	-- XOR 
	constant OPCODE_AND:    std_logic_vector(3 downto 0) :=  "0100";	-- AND 
	constant OPCODE_NOT:    std_logic_vector(3 downto 0) :=  "0101";	-- NOT 
	constant OPCODE_READ:   std_logic_vector(3 downto 0) :=  "0110";	-- READ 
	constant OPCODE_WRITE:  std_logic_vector(3 downto 0) :=  "0111";	-- WRITE 
	constant OPCODE_LOAD:   std_logic_vector(3 downto 0) :=  "1000";	-- LOAD 
	constant OPCODE_CMP:    std_logic_vector(3 downto 0) :=  "1001";	-- CMP 
	constant OPCODE_SHL:    std_logic_vector(3 downto 0) :=  "1010";	-- SHL 
	constant OPCODE_SHR:    std_logic_vector(3 downto 0) :=  "1011";  -- SHR 
	constant OPCODE_JUMP:   std_logic_vector(3 downto 0) :=  "1100";	-- JUMP 
	constant OPCODE_JUMPEQ: std_logic_vector(3 downto 0) :=  "1101";	-- JUMPEQ 
	constant OPCODE_SPEC:   std_logic_vector(3 downto 0) :=  "1110";	-- SPECIAL
	constant OPCODE_RES2:   std_logic_vector(3 downto 0) :=  "1111";  -- RESERVED 
	
-- CMP OUTPUT FLAG
	constant CMP_BIT_EQ:  integer := 14;
	constant CMP_BIT_AGB: integer := 13;
	constant CMP_BIT_ALB: integer := 12;
	constant CMP_BIT_AZ:  integer := 11;
	constant CMP_BIT_BZ:  integer := 10;
	
-- Conditional jump flags
	constant CJF_EQ: std_logic_vector(2 downto 0):= "000";
	constant CJF_AZ: std_logic_vector(2 downto 0):= "001";
	constant CJF_BZ: std_logic_vector(2 downto 0):= "010";
	constant CJF_ANZ: std_logic_vector(2 downto 0):= "011";
	constant CJF_BNZ: std_logic_vector(2 downto 0):= "100";
	constant CJF_AGB: std_logic_vector(2 downto 0):= "101";
	constant CJF_ALB: std_logic_vector(2 downto 0):= "110";
	
-- PC unit opcodes
	constant PCU_OP_NOP: std_logic_vector(1 downto 0) := "00";
	constant PCU_OP_INC : std_logic_vector(1 downto 0) := "01";
	constant PCU_OP_ASSIGN : std_logic_vector(1 downto 0) := "10";
	constant PCU_OP_RESET : std_logic_vector(1 downto 0) := "11";
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end cpu_macros;

package body cpu_macros is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end cpu_macros;
