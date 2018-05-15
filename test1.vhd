--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			ALUCtrl: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

	--Inputs
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		ALUCtrl => control,
		Zero => zeroOut,
		ALUResult => result
	);
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Start testing the ALU
		datain_a <= X"01234567";	-- DataIn in hex
		datain_b <= X"11223344";
		control  <= "00000";
		wait for 20 ns;

		-- Add test cases here to drive the ALU implementation
--      add                     00010
--	sub			00110
--	addi			10010
--	and			00000
--	andi			10000
--	or			00001
--	ori			10001
--	sll			01000
--	slli			11000
--	srl			01100
--	srli			11100
--	Pass Data2	11111
		datain_a <= X"01234567";	
		datain_b <= X"11223344";
		control  <= "00010";		
		wait for 20 ns; 	

		datain_a <= X"01234567";	
		datain_b <= X"11223344";
		control  <= "00110";		
		wait for 20 ns; 			

		datain_a <= X"01234567";	
		datain_b <= X"00000344";
		control  <= "10010";		
		wait for 20 ns;

		datain_a <= X"01234567";	
		datain_b <= X"00000344";
		control  <= "10000";		
		wait for 20 ns;

		datain_a <= X"01234567";	
		datain_b <= X"11223344";
		control  <= "00001";		
		wait for 20 ns;

		datain_a <= X"01234567";	
		datain_b <= X"00000344";
		control  <= "10001";		
		wait for 20 ns;

		datain_a <= X"10010001";	
		datain_b <= X"01000001";
		control  <= "01000";		
		wait for 20 ns;

		datain_a <= X"10010001";	
		datain_b <= X"11223346";
		control  <= "11000";	
	
		wait for 20 ns;
		datain_a <= X"10010001";	
		datain_b <= X"11223346";
		control  <= "01100";		
		wait for 20 ns;

		datain_a <= X"10010001";	
		datain_b <= X"11223344";
		control  <= "11100";		
		wait for 20 ns;

		datain_a <= X"01234567";	
		datain_b <= X"11223344";
		control  <= "11111";		
		wait for 20 ns;


		wait; -- will wait forever
	END PROCESS;

END;
