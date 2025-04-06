LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY coke_machine IS
	PORT(
		nickel, dime, quarter: IN std_logic;
		reset, try_buy_coke, clk: IN std_logic;
		coke_dropper: OUT std_logic;
		current_money, change: OUT std_logic_vector(7 downto 0)
		
	);
END coke_machine;

ARCHITECTURE coke_machine_arch OF coke_machine IS
	COMPONENT alu_n_bit IS
		GENERIC(n : INTEGER := 8);
		PORT(
			BCin: IN STD_LOGIC;
			a, b: IN STD_LOGIC_VECTOR(n-1 downto 0);
			global_f: IN STD_LOGIC_VECTOR(2 downto 0);
			s : OUT STD_LOGIC_VECTOR(n-1 downto 0);
			BCout: OUT STD_LOGIC
		);
	END COMPONENT;
	TYPE coke_states IS (get_money, drop_money, drop_coke);
	SIGNAL money_reg: std_logic_vector(7 downto 0) := "00000000";
	SIGNAL alu_out: std_logic_vector(7 downto 0);
	SIGNAL alu_input: std_logic_vector(7 downto 0);
	SIGNAL alu_f: std_logic_vector(2 downto 0);
	SIGNAL state: coke_states;
	SIGNAL zero : std_logic := '0';
	SIGNAL bcout: std_logic;
	SIGNAL coins_inserted: std_logic;

	
	BEGIN
		ALU: alu_n_bit GENERIC MAP(8) PORT MAP(zero, money_reg, alu_input, alu_f, alu_out, bcout);
		process(clk)
		begin
			zero <= '0';
			if rising_edge(clk) then
				if reset = '1' then
					state <= drop_money;
				end if;
				coins_inserted <= nickel or dime or quarter;
				case state is
					when get_money =>
						change <= "00000000";
						coke_dropper <= '0';
						alu_f <= "110";
						alu_input <= "00000000";

						if nickel = '1' then
							alu_input <= "00000101";
						elsif dime = '1' then
							alu_input <= "00001010";
						elsif quarter = '1' then
							alu_input <= "00011001";
						end if;
						if reset = '0' and try_buy_coke = '0'  then
							money_reg <= alu_out;
						elsif reset = '1' and try_buy_coke = '0' and coins_inserted = '0' then
							state <= drop_money;
						elsif reset = '0' and try_buy_coke = '1' and to_unsigned(75, 8) <= unsigned(money_reg) and coins_inserted = '0' then
							alu_f <= "111";
							alu_input <= "01001011";
							
							state <= drop_coke;
						end if;
					when drop_money =>
						change <= money_reg;
						money_reg <= "00000000";
						alu_input <= "00000000";
						state <= get_money;
					when drop_coke => 
						money_reg <= alu_out;
						coke_dropper <= '1';
						state <= drop_money;
					when others =>
						state <= get_money;
			end case;
			
			end if;
			
			
		end process;
		
		current_money <= money_reg;
END coke_machine_arch;

configuration coke_machine_cfg of coke_machine IS FOR coke_machine_arch END FOR;
end configuration;
