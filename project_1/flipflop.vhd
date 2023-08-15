library IEEE;
use IEEE.std_logic_1164.all;

entity BitwiseXor is
    port(
        a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (3 downto 0)
    );
end entity;

architecture BitwiseXorArch of BitwiseXor is
begin
    result(0) <= ((a(0) and not(b(0))) or (b(0) and not(a(0))));
    result(1) <= ((a(1) and not(b(1))) or (b(1) and not(a(1))));
    result(2) <= ((a(2) and not(b(2))) or (b(2) and not(a(2))));
    result(3) <= ((a(3) and not(b(3))) or (b(3) and not(a(3))));
end architecture;