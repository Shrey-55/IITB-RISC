library IEEE;
use IEEE.std_logic_1164.all;

entity FourbitALU is
    port ( 
        a, b: in std_logic_vector (3 downto 0);
        sel: in std_logic_vector (2 downto 0);
        result: out std_logic_vector (7 downto 0)
        );
end entity;

architecture ALUarch of FourbitALU is
    signal notB: std_logic_vector (3 downto 0);
    signal X_1, X_2: std_logic_vector (4 downto 0);
    signal X_4: std_logic_vector (2 downto 0);
    signal X_5, X_6, X_7, X_8: std_logic_vector (3 downto 0);
    signal R_1, R_2, R_3, R_4, R_5, R_6, R_7, R_8: std_logic_vector (7 downto 0);
    component Eightbit8x1Mux
        port(
            R_1, R_2, R_3, R_4, R_5, R_6, R_7, R_8: in std_logic_vector (7 downto 0);
            S: in std_logic_vector (2 downto 0);
            R: out std_logic_vector (7 downto 0)
        );
    end component;
    component CarryLookAheadAdder is
        port(
            a, b: in std_logic_vector (3 downto 0);
            cin: in std_logic;
            result: out std_logic_vector (4 downto 0)
        );
    end component;
    component Multiplier is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (7 downto 0)
        );
    end component;
    component Comparator is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (2 downto 0)
        );
    end component;
    component BitwiseNand is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0)
        );
    end component;
    component BitwiseNor is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0)
        );
    end component;
    component BitwiseXor is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0)
        );
    end component;
    component BitwiseXnor is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0) 
        );
    end component;
    component BitwiseNot is
        port(
            a: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0)
        );
    end component;

begin

    --Adder
    CarryLookAheadAdder_inst: CarryLookAheadAdder
        port map(a=>a, b=>b, cin=>'0', result=>X_1);
        R_1(0) <= X_1(0);
        R_1(1) <= X_1(1);
        R_1(2) <= X_1(2);
        R_1(3) <= X_1(3);
        R_1(4) <= X_1(4);
        R_1(5) <= '0';
        R_1(6) <= '0';
        R_1(7) <= '0';
    
    --Subtractor
    BitwiseNot_inst: BitwiseNot
        port map(a=>b, result=>notB);

    CarryLookAheadAdder_sub_inst: CarryLookAheadAdder
        port map(a=>a, b=>notB, cin=>'1', result=>X_2);
        R_2(0) <= X_2(0);
        R_2(1) <= X_2(1);
        R_2(2) <= X_2(2);
        R_2(3) <= X_2(3);
        R_2(4) <= X_2(4);
        R_2(5) <= '0';
        R_2(6) <= '0';
        R_2(7) <= '0';

    --Multiplier
    Multiplier_inst: Multiplier
        port map(a=>a, b=>b, result=>R_3);
    
    --Comparator
    Comparator_inst: Comparator
        port map(a=>a, b=>b, result=>X_4);
        R_4(0) <= X_4(0);
        R_4(1) <= X_4(1);
        R_4(2) <= X_4(2);
        R_4(3) <= '0';
        R_4(4) <= '0';
        R_4(5) <= '0';
        R_4(6) <= '0';
        R_4(7) <= '0';

    --Bitwise operations
    BitwiseNand_inst: BitwiseNand
        port map(a=>a,b=>b,result=>X_5);
    BitwiseNor_inst: BitwiseNor
        port map(a=>a,b=>b,result=>X_6);
    BitwiseXor_inst: BitwiseXor
        port map(a=>a,b=>b,result=>X_7);
    BitwiseXnor_inst: BitwiseXnor
        port map(a=>a,b=>b,result=>X_8);
    
    R_5(0) <= X_5(0);
    R_5(1) <= X_5(1);
    R_5(2) <= X_5(2);
    R_5(3) <= X_5(3);
    R_5(4) <= '0';
    R_5(5) <= '0';
    R_5(6) <= '0';
    R_5(7) <= '0';

    R_6(0) <= X_6(0);
    R_6(1) <= X_6(1);
    R_6(2) <= X_6(2);
    R_6(3) <= X_6(3);
    R_6(4) <= '0';
    R_6(5) <= '0';
    R_6(6) <= '0';
    R_6(7) <= '0';

    R_7(0) <= X_7(0);
    R_7(1) <= X_7(1);
    R_7(2) <= X_7(2);
    R_7(3) <= X_7(3);
    R_7(4) <= '0';
    R_7(5) <= '0';
    R_7(6) <= '0';
    R_7(7) <= '0';

    R_8(0) <= X_8(0);
    R_8(1) <= X_8(1);
    R_8(2) <= X_8(2);
    R_8(3) <= X_8(3);
    R_8(4) <= '0';
    R_8(5) <= '0';
    R_8(6) <= '0';
    R_8(7) <= '0';

    --Finally
    Eightbit8x1Mux_inst: Eightbit8x1Mux
        port map(R_1, R_2, R_3, R_4, R_5, R_6, R_7, R_8,sel,result);
    
end architecture;