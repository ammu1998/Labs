--------------------------------------------------------------------------------
--
-- LAB #6 - Processor Elements
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BusMux2to1 is
	Port(	selector: in std_logic;
			In0, In1: in std_logic_vector(31 downto 0);
			Result: out std_logic_vector(31 downto 0) );
end entity BusMux2to1;

architecture selection of BusMux2to1 is
begin



	with selector select
		Result <= In1 when '1', 
			  In0 when others;

end architecture selection;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control is
      Port(clk : in  STD_LOGIC;
           opcode : in  STD_LOGIC_VECTOR (6 downto 0);
           funct3  : in  STD_LOGIC_VECTOR (2 downto 0);
           funct7  : in  STD_LOGIC_VECTOR (6 downto 0);
           Branch : out  STD_LOGIC_VECTOR(1 downto 0);
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           ALUCtrl : out  STD_LOGIC_VECTOR(4 downto 0);
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ImmGen : out STD_LOGIC_VECTOR(1 downto 0));
end Control;

architecture Boss of Control is
begin

	with funct3&opcode select Branch <= 
		"00" when "0011100011", 
		"01" when "1001100011",
		"11" when others;
	with funct3&opcode select 
		MemtoReg <= '1' when "0100000011", 
			    '0' when others; 

	
	ALUCtrl <= "00000" when funct7 = "0000000" and funct3 = "000" and opcode = "0110011" else  
		   "00001" when funct7 = "0100000" and funct3 = "000" and opcode = "0110011" else  
		   "00111" when funct7 = "0000000" and funct3 = "001" and opcode = "0110011" else 
 		   "10111" when funct7 = "0000000" and funct3 = "101" and opcode = "0110011" else 
		   "00101" when funct7 = "0000000" and funct3 = "110" and opcode = "0110011" else 
		   "00011" when funct7 = "0000000" and funct3 = "111" and opcode = "0110011" else 
		   "00111" when funct3 = "001" and opcode = "0010011" else 
 		   "10111" when funct3 = "101" and opcode = "0010011" else 
 		   "00110" when funct3 = "111" and opcode = "0010011" else 
 		   "01110" when funct3 = "110" and opcode = "0010011" else 
 		   "00100" when funct3 = "000" and opcode = "0010011" else 
		   "00000" when funct3 = "010" and opcode = "0100011" else 
		   "00000" when funct3 = "010" and opcode = "0000011" else 
		   "00001" when funct3 = "000" and opcode = "1100011" else 
		   "00001" when funct3 = "001" and opcode = "1100011" else 
		   "00000" when opcode = "0110111" else 
		   "10101"; 

	with funct3&opcode select 
	MemWrite <= '1' when "0100100011", 
		    '0' when others;	 
with opcode & funct3 select
	MemRead <= '0' when "0000011010",
		   '1' when others; 
	AlUSrc <= '1' when funct3 = "111" and opcode = "0010011" else 
		  '1' when funct3 = "110" and opcode = "0010011" else 
		  '1' when funct3 = "000" and opcode = "0010011" else 
		  '1' when funct3 = "010" and opcode = "0100011" else
		  '1' when funct3 = "010" and opcode = "0000011" else 
		  '1' when funct7 = "0000000" and funct3 = "001" and opcode = "0110011" else 
		  '1' when funct7 = "0000000" and funct3 = "101" and opcode = "0110011" else
		  '1' when funct3 = "001" and opcode = "0010011" else 
		  '1' when funct3 = "101" and opcode = "0010011" else 
		  '1' when opcode = "0110111" else 
		  '0';
	RegWrite <= '0' when funct3 = "010" and opcode = "0100011" else
		    '0' when funct3 = "001" and opcode = "1100011" else
		    '0' when funct3 = "100" and opcode = "1100011" else
		not(clk);







ImmGen <= "01" when funct3 = "010" and opcode = "0100011" else 
		  "10" when funct3 = "001" and opcode = "1100011" else 
		  "10" when funct3 = "100" and opcode = "1100011" else 
		  "11" when opcode = "0110111" else 
		  "00" when funct3 = "111" and opcode = "0010011" else 
		  "00" when funct3 = "110" and opcode = "0010011" else 
		  "00" when funct3 = "000" and opcode = "0010011" else
		  "00" when funct3 = "010" and opcode = "0000011" else 
		  "00" when opcode = "0010011" and funct3 = "001" and funct7 = "0000000"else
		  "00" when opcode = "0010011" and funct3 = "101" and funct7 = "0100000" else
		  "XX"; 
end Boss;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter is
    Port(Reset: in std_logic;
	 Clock: in std_logic;
	 PCin: in std_logic_vector(31 downto 0);
	 PCout: out std_logic_vector(31 downto 0));
end entity ProgramCounter;

architecture executive of ProgramCounter is
begin
	Process(Reset,Clock)
	begin	
 		if Reset = '1' then
			PCout <= X"003FFFFC"; 
		elsif rising_edge(Clock) then 
			PCout <= PCin;
		end if;
	end process; 
end executive;
--------------------------------------------------------------------------------
