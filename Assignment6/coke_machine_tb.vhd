library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coke_machine_tb is
end coke_machine_tb;

architecture coke_machine_tb_arch of coke_machine_tb is
    signal quarter : std_logic;
    signal nickel : std_logic;
    signal dime : std_logic;
    signal reset : std_logic;
    signal try_buy_coke : std_logic;
    signal coke_dropper : std_logic;
    signal current_money : std_logic_vector(7 downto 0);
    signal change : std_logic_vector(7 downto 0);

    signal clk : std_logic := '0';
    component coke_machine IS
	    PORT(
		    nickel, dime, quarter: IN std_logic;
		    reset, try_buy_coke, clk: IN std_logic;
		    coke_dropper: OUT std_logic;
	    	current_money, change: OUT std_logic_vector(7 downto 0)
		
    	);
    end component;

begin

    clk <= not clk after 50 ps;
    uut: coke_machine port map(nickel, dime, quarter, reset, try_buy_coke, clk, coke_dropper, current_money, change);

    stimulus: process is
    begin
        quarter <= '0';
        nickel <= '0';
        dime <= '0';
        reset <= '0';
        try_buy_coke <= '0';

        wait for 100ps;

        quarter <= '1';

        wait for 400ps; -- insert 4 quarter

        quarter <= '0';

        wait for 200ps;

        try_buy_coke <= '1';

        wait for 300ps;

        quarter <= '0';
        nickel <= '0';
        dime <= '0';
        reset <= '0';
        try_buy_coke <= '0';

        wait for 100ps;

        quarter <= '1';

        wait for 400ps; -- insert 4 quarter

        quarter <= '0';

        wait for 200ps;

        reset <= '1';

        wait for 300ps;
        
    end process;


end architecture;

configuration coke_machine_tb_cfg of coke_machine_tb is for coke_machine_tb_arch end for;
end configuration;