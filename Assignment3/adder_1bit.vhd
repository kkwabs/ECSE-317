LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity adder_1bit is
	port(
		a,b,cin: in std_logic;
		sum, cout: out std_logic
	);
end adder_1bit;

architecture adder_1bit_arch of adder_1bit is
begin
	Sum  <= (a XOR b) XOR cin;
	Cout <= (a AND b) OR (cin AND (a XOR b));
end adder_1bit_arch;

CONFIGURATION adder_1bit_cfg OF adder_1bit IS
  FOR adder_1bit_arch
  END FOR;
END CONFIGURATION;
