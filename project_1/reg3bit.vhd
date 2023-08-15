library IEEE;
use IEEE.std_logic_1164.all;

entity EightBitMux is
    port(
        a, b: in std_logic_vector (7 downto 0);
        sel: in std_logic;
        result: out std_logic_vector (7 downto 0)
    );
end entity;

architecture EightBitMuxArch of EightBitMux is
    component Mux
        port(A,B,S : in std_logic; R : out std_logic);
    end component;
begin
    Mux_inst1: Mux
        port map(A=>a(0), B=>b(0), S=>sel, R=> result(0));
    Mux_inst2: Mux
        port map(A=>a(1), B=>b(1), S=>sel, R=> result(1));
    Mux_inst3: Mux
        port map(A=>a(2), B=>b(2), S=>sel, R=> result(2));
    Mux_inst4: Mux
        port map(A=>a(3), B=>b(3), S=>sel, R=> result(3));
    Mux_inst5: Mux
        port map(A=>a(4), B=>b(4), S=>sel, R=> result(4));
    Mux_inst6: Mux
        port map(A=>a(5), B=>b(5), S=>sel, R=> result(5));
    Mux_inst7: Mux
        port map(A=>a(6), B=>b(6), S=>sel, R=> result(6));
    Mux_inst8: Mux
        port map(A=>a(7), B=>b(7), S=>sel, R=> result(7));
end architecture;