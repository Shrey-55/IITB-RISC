library IEEE;
use IEEE.std_logic_1164.all;

entity Multiplier is
    port(
        a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (7 downto 0)
    );
end entity;

architecture MultiplierArch of Multiplier is
    signal pp1, pp2, pp3, pp4, c2, c3, c4, c5: std_logic_vector (3 downto 0);
    component MultiplierUnit is 
    port(
        x, y, ppk, cin: in std_logic;
        ppk_1, cout: out std_logic
    );
    end component;
    component FullAdder is
        port(
            a, b, cin: in std_logic;
            s, cout:  out std_logic
        );
    end component;
begin
    pp1(0) <= a(0) and b(0);
    pp1(1) <= a(0) and b(1);
    pp1(2) <= a(0) and b(2);
    pp1(3) <= a(0) and b(3);
    MultiplierUnit_inst21: MultiplierUnit
        port map(x=>a(1), y=>b(0), ppk=>pp1(1), cin=>'0', ppk_1=>pp2(0), cout=>c2(0));
    MultiplierUnit_inst22: MultiplierUnit
        port map(x=>a(1), y=>b(1), ppk=>pp1(2), cin=>'0', ppk_1=>pp2(1), cout=>c2(1));
    MultiplierUnit_inst23: MultiplierUnit
        port map(x=>a(1), y=>b(2), ppk=>pp1(3), cin=>'0', ppk_1=>pp2(2), cout=>c2(2));
    MultiplierUnit_inst24: MultiplierUnit
        port map(x=>a(1), y=>b(3), ppk=>'0', cin=>'0', ppk_1=>pp2(3), cout=>c2(3));
    
    MultiplierUnit_inst31: MultiplierUnit
        port map(x=>a(2), y=>b(0), ppk=>pp2(1), cin=>c2(0), ppk_1=>pp3(0), cout=>c3(0));
    MultiplierUnit_inst32: MultiplierUnit
        port map(x=>a(2), y=>b(1), ppk=>pp2(2), cin=>c2(1), ppk_1=>pp3(1), cout=>c3(1));
    MultiplierUnit_inst33: MultiplierUnit
        port map(x=>a(2), y=>b(2), ppk=>pp2(3), cin=>c2(2), ppk_1=>pp3(2), cout=>c3(2));
    MultiplierUnit_inst34: MultiplierUnit
        port map(x=>a(2), y=>b(3), ppk=>'0', cin=>c2(3), ppk_1=>pp3(3), cout=>c3(3));

    MultiplierUnit_inst41: MultiplierUnit
        port map(x=>a(3), y=>b(0), ppk=>pp3(1), cin=>c3(0), ppk_1=>pp4(0), cout=>c4(0));
    MultiplierUnit_inst42: MultiplierUnit
        port map(x=>a(3), y=>b(1), ppk=>pp3(2), cin=>c3(1), ppk_1=>pp4(1), cout=>c4(1));
    MultiplierUnit_inst43: MultiplierUnit
        port map(x=>a(3), y=>b(2), ppk=>pp3(3), cin=>c3(2), ppk_1=>pp4(2), cout=>c4(2));
    MultiplierUnit_inst44: MultiplierUnit
        port map(x=>a(3), y=>b(3), ppk=>'0', cin=>c3(3), ppk_1=>pp4(3), cout=>c4(3));

    result(0) <= pp1(0);
    result(1) <= pp2(0);
    result(2) <= pp3(0);
    result(3) <= pp4(0);
    
    FullAdder_inst1: FullAdder
        port map(a=>pp4(1), b=>c4(0), cin=>'0', s=>result(4), cout=>c5(0));
    FullAdder_inst2: FullAdder
        port map(a=>pp4(2), b=>c4(1), cin=>c5(0), s=>result(5), cout=>c5(1));
    FullAdder_inst3: FullAdder
        port map(a=>pp4(3), b=>c4(2), cin=>c5(1), s=>result(6), cout=>c5(2));
    FullAdder_inst4: FullAdder
        port map(a=>'0', b=>c4(3), cin=>c5(2), s=>result(7), cout=>c5(3));
end architecture;