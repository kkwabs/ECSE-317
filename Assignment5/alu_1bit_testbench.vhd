LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity alu_1bit_tb is
end alu_1bit_tb;

architecture alu_1bit_tb_arch of alu_1bit_tb is
signal x: std_logic;
signal y: std_logic;
signal cin: std_logic;
signal F: std_logic_vector(2 downto 0);
signal s: std_logic;
signal cout: std_logic;


component alu_1bit is
	PORT(
		x, y, cin: in std_logic;
		F: IN std_logic_vector(2 downto 0);
		s, cout: out std_logic
	);
end component;

begin

uut: alu_1bit port map(x, y, cin, F, s, cout);
stimulus:
process is
    begin
        
		x <= '1';
		y <= '0';
		
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
		x <= '1';
		y <= '0';
        cin <= '0';
		wait for 5ns;
		x <= '0';
		y <= '0';
		cin <= '1';
		wait for 5ns;
		
		x <= '1';
		y <= '0'; --reset
		
		F  <= "101"; -- X AND Y
        cin <= '0';
        x <= '1';
		y <= '0';
		wait for 5ns;
		cin <= '1';
		x <= '1';
		y <= '1';
		wait for 5ns;
		
		x <= '1';
		y <= '0'; --reset
		
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

end alu_1bit_tb_arch;

configuration alu_1bit_tb_cfg of alu_1bit_tb IS FOR alu_1bit_tb_arch END FOR;
end configuration;
