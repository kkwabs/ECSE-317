LIBRARY IEEE;
use IEEE.std_logic_1164.all;

ENTITY ALU_1bit IS
	PORT(
		x, y, cin: in std_logic;
		F: IN std_logic_vector(2 downto 0);
		s, cout: out std_logic
	);
END ALU_1bit;

architecture alu_1bit_arch of ALU_1bit is
	component adder_1bit is
		port(
			a,b,cin: in std_logic;
			sum, cout: out std_logic
		);
	end component;
	component subtractor_1bit is
		port(
			a,b,cin: in std_logic;
			sum, cout: out std_logic
		);
	end component;
	signal adder_out: std_logic;
	signal subtractor_out: std_logic;
	signal adder_carryout: std_logic;
	signal subtractor_carryout: std_logic;
	
	BEGIN
	
	Adder: adder_1bit PORT MAP(x, y, cin, adder_out, adder_carryout);
	Subtractor: subtractor_1bit PORT MAP(x, y, cin, subtractor_out, subtractor_carryout);
	
	with F select
		S <= '0' when "000",
			 x when "001",
         	 y when "010",
         	 cin when "011",
         	 x OR y when "100",
			 x AND y when "101",
         	 adder_out when "110",
         	 subtractor_out when "111",
         	 '0' when others;
	 with F select 
		Cout <= '0' when "000",
			 '1' when "010",
         	 x when "011",
         	 x when "100",
			 x when "101",
         	 adder_carryout when "110",
         	 subtractor_carryout when "111",
         	 '0' when others;
	
	
end alu_1bit_arch;

		
configuration alu_1bit_cfg of alu_1bit IS FOR alu_1bit_arch END FOR;
end configuration;
