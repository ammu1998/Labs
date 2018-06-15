Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity CONTROL is
	port(AluControl: in std_logic_vector(4 downto 0);
		add_sub_l_r: out std_logic;
		CtrOut: out std_logic_vector(2 downto 0));
end entity CONTROL;

architecture logics of CONTROL is
	begin
	with AluControl select
		CtrOut <= "000" when "00010",
				"000" when "00110",
				"000" when "10010",
				"010" when "00000",
				"010" when "10000",
				"011" when "00001",
				"011" when "10001",
				"001" when "01000",
				"001" when "11000",
				"001" when "01100",
				"001" when "11100",
				"100" when OTHERS;
	add_sub_l_r <= AluControl(2);
	


--0 is add/left 1 is sub/right

--	Operations:	AluCtr:
--	add			00010
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




end architecture logics;

-------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity MUX is
	port(Choose: in std_logic_vector(2 downto 0);
		In1,In2,In3,In4,In5: in std_logic_vector(31 downto 0);
		MuxOut: out std_logic_vector(31 downto 0));
end entity MUX;

architecture pick of MUX is
begin
with Choose select
	MuxOut <= In1 when "000",
		  In2 when "001",
		  In3 when "010",
		  In4 when "011",
		  In5 when OTHERS;

end architecture pick;

-------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;


entity ALU is
	Port(	DataIn1:   in std_logic_vector(31 downto 0);
DataIn2:   in std_logic_vector(31 downto 0);
		ALUCtrl:   in std_logic_vector(4 downto 0);
		Zero:      out std_logic;
		ALUResult: out std_logic_vector(31 downto 0));
end entity ALU;

architecture execution of ALU is
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component;
	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic;
			shamt:	in std_logic_vector(4 downto 0);
			dataout: out std_logic_vector(31 downto 0));
	end component;
	component MUX
		port(Choose: in std_logic_vector(2 downto 0);
			In1,In2,In3,In4,In5: in std_logic_vector(31 downto 0);
			MuxOut: out std_logic_vector(31 downto 0));
	end component;
	component CONTROL
		port(AluControl: in std_logic_vector(4 downto 0);
			add_sub_l_r: out std_logic;
			CtrOut: out std_logic_vector(2 downto 0));
	end component;

	signal ADDSUBLR: std_logic;
	signal CarryOut: std_logic;
	signal MuxIn: std_logic_vector(2 downto 0);
	signal temp1: std_logic_vector(31 downto 0);
	signal temp2: std_logic_vector(31 downto 0);
	signal temp3: std_logic_vector(31 downto 0);
	signal temp4: std_logic_vector(31 downto 0);
	signal temp5: std_logic_vector(31 downto 0);
	signal shift: std_logic_vector(4 downto 0);
	signal OutTemp: std_logic_vector(31 downto 0);

begin
shift <= "000" & DataIn2(1 downto 0);
controlMap: CONTROL
	port map(ALUCtrl,ADDSUBLR,MuxIn);
add_subMap: adder_subtracter
	port map(DataIn1,DataIn2,ADDSUBLR,temp1,CarryOut);
shiftMap: shift_register
	port map(DataIn1,ADDSUBLR,shift,temp2);
temp3 <= DataIn1 AND DataIn2;
temp4 <= DataIn1 OR DataIn2;
temp5 <= DataIn2;

MuxMap: MUX
	port map(MuxIn,temp1,temp2,temp3,temp4,temp5,OutTemp);

Zero <= NOT(OutTemp(0) OR OutTemp(1) OR OutTemp(2) OR OutTemp(3) OR OutTemp(4) OR OutTemp(5) OR OutTemp(6) OR OutTemp(7) OR OutTemp(8) OR OutTemp(9) OR OutTemp(10) OR OutTemp(11) OR OutTemp(12) OR OutTemp(13) OR OutTemp(14) OR OutTemp(15) OR OutTemp(16) OR OutTemp(17) OR OutTemp(18) OR OutTemp(19) OR OutTemp(20) OR OutTemp(21) OR OutTemp(22) OR OutTemp(23) OR OutTemp(24) OR OutTemp(25) OR OutTemp(26) OR OutTemp(27) OR OutTemp(28) OR OutTemp(29) OR OutTemp(30) OR OutTemp(31));

ALUResult <= OutTemp;

end architecture execution;












Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	d0: bitstorage
		port map(datain(0),enout,writein,dataout(0));
	d1: bitstorage
		port map(datain(1),enout,writein,dataout(1));
	d2: bitstorage
		port map(datain(2),enout,writein,dataout(2));
	d3: bitstorage
		port map(datain(3),enout,writein,dataout(3));
	d4: bitstorage
		port map(datain(4),enout,writein,dataout(4));
	d5: bitstorage
		port map(datain(5),enout,writein,dataout(5));
	d6: bitstorage
		port map(datain(6),enout,writein,dataout(6));
	d7: bitstorage
		port map(datain(7),enout,writein,dataout(7));
end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
	   	  	enout:  in std_logic;
	  	  	 writein: in std_logic;
	 	    dataout: out std_logic_vector(7 downto 0));
	end component;
	signal w0,w1: std_logic;
	signal e0,e1: std_logic;
begin
	w0 <= writein8 or writein16 or writein32;
	w1 <= writein16 or writein32; 
	e0 <= enout8 and enout16 and enout32;
	e1 <= enout16 and enout32; 
	r0: register8
		port map(datain(7 downto 0),e0,w0,dataout(7 downto 0));
	r1: register8
		port map(datain(15 downto 8),e1,w1,dataout(15 downto 8));
	r2: register8
		port map(datain(23 downto 16),enout32,writein32,dataout(23 downto 16));
	r3: register8
		port map(datain(31 downto 24),enout32,writein32,dataout(31 downto 24));

end architecture biggermem;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic; --0 is add, 1 is subract
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
component fulladder
     port(a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
	end component;
	signal c: std_logic_vector(32 downto 0):= (others=>'0');
	signal m: std_logic;
	signal second: std_logic_vector(31 downto 0);
begin

	with add_sub select
		second <= not(datain_b) when '1',
			datain_b when OTHERS;
	c(0)<=add_sub;


 	f0: fulladder
		port map(datain_a(0),second(0),c(0),dataout(0),(c(1)));
	f1: fulladder
		port map(datain_a(1),second(1),c(1),dataout(1),(c(2)));
	f2: fulladder
		port map(datain_a(2),second(2),c(2),dataout(2),(c(3)));
	f3: fulladder
		port map(datain_a(3),second(3),c(3),dataout(3),(c(4)));
	f4: fulladder
		port map(datain_a(4),second(4),c(4),dataout(4),(c(5)));
	f5: fulladder
		port map(datain_a(5),second(5),c(5),dataout(5),(c(6)));
	f6: fulladder
		port map(datain_a(6),second(6),c(6),dataout(6),(c(7)));
	f7: fulladder
		port map(datain_a(7),second(7),c(7),dataout(7),(c(8)));
	f8: fulladder
		port map(datain_a(8),second(8),c(8),dataout(8),(c(9)));
	f9: fulladder
		port map(datain_a(9),second(9),c(9),dataout(9),(c(10)));
	f10: fulladder
		port map(datain_a(10),second(10),c(10),dataout(10),(c(11)));
	f11: fulladder
		port map(datain_a(11),second(11),c(11),dataout(11),(c(12)));
	f12: fulladder
		port map(datain_a(12),second(12),c(12),dataout(12),(c(13)));
	f13: fulladder
		port map(datain_a(13),second(13),c(13),dataout(13),(c(14)));
	f14: fulladder
		port map(datain_a(14),second(14),c(14),dataout(14),(c(15)));
	f15: fulladder
		port map(datain_a(15),second(15),c(15),dataout(15),(c(16)));
	f16: fulladder
		port map(datain_a(16),second(16),c(16),dataout(16),(c(17)));
	f17: fulladder
		port map(datain_a(17),second(17),c(17),dataout(17),(c(18)));
	f18: fulladder
		port map(datain_a(18),second(18),c(18),dataout(18),(c(19)));
	f19: fulladder
		port map(datain_a(19),second(19),c(19),dataout(19),(c(20)));
	f20: fulladder
		port map(datain_a(20),second(20),c(20),dataout(20),(c(21)));
	f21: fulladder
		port map(datain_a(21),second(21),c(21),dataout(21),(c(22)));
	f22: fulladder
		port map(datain_a(22),second(22),c(22),dataout(22),(c(23)));
	f23: fulladder
		port map(datain_a(23),second(23),c(23),dataout(23),(c(24)));
	f24: fulladder
		port map(datain_a(24),second(24),c(24),dataout(24),(c(25)));
	f25: fulladder
		port map(datain_a(25),second(25),c(25),dataout(25),(c(26)));
	f26: fulladder
		port map(datain_a(26),second(26),c(26),dataout(26),(c(27)));
	f27: fulladder
		port map(datain_a(27),second(27),c(27),dataout(27),(c(28)));
	f28: fulladder
		port map(datain_a(28),second(28),c(28),dataout(28),(c(29)));
	f29: fulladder
		port map(datain_a(29),second(29),c(29),dataout(29),(c(30)));
	f30: fulladder
		port map(datain_a(30),second(30),c(30),dataout(30),(c(31)));
	f31: fulladder
		port map(datain_a(31),second(31),c(31),dataout(31),(c(32)));
	
	 	
	co<=c(32);
	end architecture calc;
	
--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic; --0 is left, 1 is right
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	
begin
			with dir & shamt select
				dataout <= datain(30 downto 0) & "0" when "000001",
					datain(29 downto 0) & "00" when "000010",
					datain(28 downto 0) & "000" when "000011",
					"0" & datain(31 downto 1) when "100001",
					"00" & datain(31 downto 2) when "100010",
					"000" & datain(31 downto 3) when "100011",
					datain(31 downto 0) when OTHERS;
end architecture shifter;

