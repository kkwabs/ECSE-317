LIBRARY IEEE;
use IEEE.std_logic_1164.all;

ENTITY alu_n_bit IS
	GENERIC(n : INTEGER := 8);
	PORT(
		BCin: IN STD_LOGIC;
		a, b: IN STD_LOGIC_VECTOR(n-1 downto 0);
		global_f: IN STD_LOGIC_VECTOR(2 downto 0);
		s : OUT STD_LOGIC_VECTOR(n-1 downto 0);
		BCout: OUT STD_LOGIC
	);
END alu_n_bit;

ARCHITECTURE alu_n_bit_arch OF alu_n_bit IS
	COMPONENT alu_1bit
		PORT(
			x, y, cin: in std_logic;
			F: IN std_logic_vector(2 downto 0);
			s, cout: out std_logic
		);
	END COMPONENT alu_1bit;
	SIGNAL bc: std_logic_vector(n downto 0);
	BEGIN
		bc(0) <= BCin;
		BCout <= bc(n);
		ALU: FOR i in 0 to n-1 GENERATE 
			ALU_i: alu_1bit PORT MAP(a(i), b(i), bc(i), global_f, s(i), bc(i+1));
		END GENERATE;
END alu_n_bit_arch;

configuration alu_nbit_cfg of alu_n_bit IS FOR alu_n_bit_arch END FOR;
end configuration;
