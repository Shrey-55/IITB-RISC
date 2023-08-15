library IEEE;
use IEEE.std_logic_1164.all;

entity BitwiseNand is
    port(
        a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (3 downto 0)
    );
end entity;

architecture BitwiseNandArch of BitwiseNand is
begin
    result(0) <= not(a(0) and b(0));
    result(1) <= not(a(1) and b(1));
    result(2) <= not(a(2) and b(2));
    result(3) <= not(a(3) and b(3));
end architecture;