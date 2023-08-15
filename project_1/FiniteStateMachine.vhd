library IEEE;
use IEEE.std_logic_1164.all;

entity BitwiseXnor is
    port(
        a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (3 downto 0)
    );
end entity;

architecture BitwiseXnorArch of BitwiseXnor is
begin
    result(0) <= ((a(0) and b(0)) or (not(b(0)) and not(a(0))));
    result(1) <= ((a(1) and b(1)) or (not(b(1)) and not(a(1))));
    result(2) <= ((a(2) and b(2)) or (not(b(2)) and not(a(2))));
    result(3) <= ((a(3) and b(3)) or (not(b(3)) and not(a(3))));
end architecture;