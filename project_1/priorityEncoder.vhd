library IEEE;
use IEEE.std_logic_1164.all;

entity Eightbit8x1Mux is
    port(
        R_1, R_2, R_3, R_4, R_5, R_6, R_7, R_8: in std_logic_vector (7 downto 0);
        S: in std_logic_vector (2 downto 0);
        R: out std_logic_vector (7 downto 0)
    );
end entity;

architecture Eightbit8x1MuxArch of Eightbit8x1Mux is
    signal X_1, X_2, X_3, X_4, X_5, X_6: std_logic_vector(7 downto 0);
    component EightBitMux 
        port( a, b: in std_logic_vector (7 downto 0);
            sel: in std_logic;
            result: out std_logic_vector (7 downto 0)
        );
    end component;
begin
    EightBitMux_inst1: EightBitMux
            port map(A=>R_1, B=>R_2, sel=>S(0), result=>X_1);
    EightBitMux_inst2: EightBitMux
            port map(A=>R_3, B=>R_4, sel=>S(0), result=>X_2);
    EightBitMux_inst3: EightBitMux
            port map(A=>R_5, B=>R_6, sel=>S(0), result=>X_3);
    EightBitMux_inst4: EightBitMux
            port map(A=>R_7, B=>R_8, sel=>S(0), result=>X_4);

    EightBitMux_inst5: EightBitMux
            port map(A=>X_1, B=>X_2, sel=>S(1), result=>X_5);
    EightBitMux_inst6: EightBitMux
            port map(A=>X_3, B=>X_4, sel=>S(1), result=>X_6);

    EightBitMux_inst7: EightBitMux
            port map(A=>X_5, B=>X_6, sel=>S(2), result=>R);
end architecture;