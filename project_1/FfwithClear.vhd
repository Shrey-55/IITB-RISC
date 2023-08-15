library IEEE;
use IEEE.std_logic_1164.all;

entity BitwiseNot is
    port(
        a: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (3 downto 0)
    );
end entity;

architecture BitwiseNotArch of BitwiseNot is
begin
    result(0) <= not(a(0));
    result(1) <= not(a(1));
    result(2) <= not(a(2));
    result(3) <= not(a(3));
end architecture;