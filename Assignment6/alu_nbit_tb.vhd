LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity alu_n_bit_tb is
end alu_n_bit_tb;

architecture alu_n_bit_tb_arch of alu_n_bit_tb is
signal x: std_logic_vector(7 downto 0);
signal y: std_logic_vector(7 downto 0);
signal cin: std_logic;
signal F: std_logic_vector(2 downto 0);
signal s: std_logic_vector(7 downto 0);
signal cout: std_logic;


component alu_n_bit is
	PORT(
		BCin: IN STD_LOGIC;
		a, b: IN STD_LOGIC_VECTOR(7 downto 0);
		global_f: IN STD_LOGIC_VECTOR(2 downto 0);
		s : OUT STD_LOGIC_VECTOR(7 downto 0);
		BCout: OUT STD_LOGIC
	);
end component;

begin

uut: alu_n_bit port map(cin, x, y, F, s, cout);
stimulus:
process is
    begin
        
		x <= "11111111";
		y <= "00000000";
		
        F  <= "000";
        cin <= '0';
		wait for 5ns;
		cin <= '1';
		wait for 5ns;
		
		F  <= "001";
        cin <= '0';
		wait for 5ns;
		cin <= '1';
		wait for 5ns;
		
		F  <= "010";
        cin <= '0';
		wait for 5ns;
		cin <= '1';
		wait for 5ns;
		
		F  <= "011";
        cin <= '0';
		wait for 5ns;
		cin <= '1';
		wait for 5ns;
		
		F  <= "100"; -- X OR Y
		x <= "11111111";
		y <= "00000000";
        cin <= '0';
		wait for 5ns;
		x <= "00000001";
		y <= "00001000";
		cin <= '1';
		wait for 5ns;
		
		x <= "11111111";
		y <= "00000000"; -- reset
		
		F  <= "101"; -- X AND Y
        cin <= '0';
        x <= "11111111";
		y <= "00000000";
		wait for 5ns;
		cin <= '1';
		x <= "11111111";
		y <= "10101010";
		wait for 5ns;
		
		x <= "11111111";
		y <= "00000000"; -- reset
		
		F  <= "110";
        cin <= '0';
		wait for 5ns;
		cin <= '1';
		wait for 5ns;
		
		F  <= "111";
        cin <= '0';
		wait for 5ns;
		cin <= '1';
		wait for 5ns;
		
end process stimulus;

end alu_n_bit_tb_arch;

configuration alu_n_bit_tb_cfg of alu_n_bit_tb IS FOR alu_n_bit_tb_arch END FOR;
end configuration;
