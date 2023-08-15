library IEEE;
use IEEE.std_logic_1164.all;

entity Comparator is
    port(
        a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (2 downto 0)
    );
end entity;

architecture ComparatorArch of Comparator is
    signal notB: std_logic_vector(3 downto 0);
    signal diff: std_logic_vector(4 downto 0);
    component CarryLookAheadAdder is
        port(
            a, b: in std_logic_vector (3 downto 0);
            cin: in std_logic;
            result: out std_logic_vector (4 downto 0)
        );
    end component;
    component BitwiseNot is
        port(
            a: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0)
        );
    end component;
begin
    BitwiseNot_inst: BitwiseNot
        port map(a=>b, result=>notB);
    CarryLookAheadAdder_inst: CarryLookAheadAdder --Subtraction
        port map(a=>a, b=>notB, cin=>'1', result=>diff);
    result(0) <= not(diff(4));
    result(1) <= diff(4) and (not(diff(0) or diff(1) or diff(2) or diff(3)));
    result(2) <= diff(4) and (diff(0) or diff(1) or diff(2) or diff(3));
end architecture;