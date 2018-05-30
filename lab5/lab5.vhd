--------------------------------------------------------------------------------
--
-- LAB #5 - Memory and Register Bank
--
--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   signal i_ram : ram_type;

begin

  RamProc: process(Clock, Reset, OE, WE, Address) is

  begin
    
    
    if Reset = '1' then
      for i in 0 to 127 loop   
          i_ram(i) <= X"00000000";
      end loop;
    end if;

	
    if falling_edge(Clock) then
	
	if to_integer(unsigned(Address)) < 128 and WE = '1' then 
		i_ram(to_integer(unsigned(Address))) <= DataIn;
	end if;
    end if;
	if to_integer(unsigned(Address)) < 128 and OE = '0' then 
		DataOut <= i_ram(to_integer(unsigned(Address)));
	else
		DataOut <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	end if;

  end process RamProc;

end staticRAM;	


--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture lab5 of Registers is
	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;
	
	signal a0, a1, a2, a3, a4, a5, a6, a7, x0: std_logic_vector(31 downto 0);
	signal values: std_logic_vector(7 downto 0);
begin

	X0 <= (others => '0');

	
	reg0: register32 port map (WriteData, '0', '1', '1', values(0), '0', '0', a0);
	reg1: register32 port map (WriteData, '0', '1', '1', values(1), '0', '0', a1);
	reg2: register32 port map (WriteData, '0', '1', '1', values(2), '0', '0', a2);
	reg3: register32 port map (WriteData, '0', '1', '1', values(3), '0', '0', a3);
	reg4: register32 port map (WriteData, '0', '1', '1', values(4), '0', '0', a4);
	reg5: register32 port map (WriteData, '0', '1', '1', values(5), '0', '0', a5);
	reg6: register32 port map (WriteData, '0', '1', '1', values(6), '0', '0', a6);
	reg7: register32 port map (WriteData, '0', '1', '1', values(7), '0', '0', a7);
	

	with WriteCmd & WriteReg select values <= "00000001" when "101010",
						"00000010" when "101011",
						"00000100" when "101100",
						"00001000" when "101101",
						"00010000" when "101110",
						"00100000" when "101111",
						"01000000" when "110000",
						"10000000" when "110001",
						"00000000" when others;	

	with ReadReg1 select ReadData1 <=
		a0 when "01010",
		a1 when "01011",
		a2 when "01100",
		a3 when "01101",
		a4 when "01110",
		a5 when "01111",
		a6 when "10000",
		a7 when "10001",
		x0 when others;
 	
	with ReadReg2 select ReadData2 <=
		a0 when "01010",
		a1 when "01011",
		a2 when "01100",
		a3 when "01101",
		a4 when "01110",
		a5 when "01111",
		a6 when "10000",
		a7 when "10001",
		x0 when others;


	

end lab5;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
