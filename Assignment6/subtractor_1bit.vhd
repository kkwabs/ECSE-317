LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity subtractor_1bit is
        port(
             	a,b,cin: in std_logic;
                sum, cout: out std_logic
        );
end subtractor_1bit;

architecture subtractor_1bit_arch of subtractor_1bit is
begin
     	Sum  <= (a XOR b) XOR cin;
        Cout <= ((not a) AND (b or cin)) OR (b and cin);
end subtractor_1bit_arch;

CONFIGURATION subtractor_1bit_cfg OF subtractor_1bit IS
  FOR subtractor_1bit_arch
  END FOR;
END CONFIGURATION;

