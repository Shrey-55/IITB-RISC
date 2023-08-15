library IEEE;
use IEEE.std_logic_1164.all;

entity BitwiseAnd is
    port(
        a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (3 downto 0)
    );
end entity;

architecture BitwiseAndArch of BitwiseAnd is
begin
    result(0) <= a(0) and b(0);
    result(1) <= a(1) and b(1);
    result(2) <= a(2) and b(2);
    result(3) <= a(3) and b(3);
end architecture;