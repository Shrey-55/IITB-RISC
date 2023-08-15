library IEEE;
use IEEE.std_logic_1164.all;

entity CarryLookAheadAdder is
    port(
        a, b: in std_logic_vector (3 downto 0);
        cin: in std_logic;
        result: out std_logic_vector (4 downto 0)
    );
end entity;

architecture CarryLookAheadAdderArch of CarryLookAheadAdder is
    signal g, p: std_logic_vector (3 downto 0);
    signal carry: std_logic_vector (3 downto 1); --Note downto 1 not 0!
    component BitwiseXor is
        port( a, b: in std_logic_vector (3 downto 0);
        result: out std_logic_vector (3 downto 0)
        );
    end component;
    component BitwiseAnd is
        port(
            a, b: in std_logic_vector (3 downto 0);
            result: out std_logic_vector (3 downto 0)
        );
    end component;
begin
    BitwiseXor_inst: BitwiseXor
        port map (a=>a, b=>b, result=>p);
    BitwiseAnd_inst: BitwiseAnd
        port map (a=>a, b=>b, result=>g);
    
    result(0) <= ((p(0) and not(cin)) or (cin and not(p(0))));
    carry(1) <= g(0) or (p(0) and cin);
    carry(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
    carry(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and cin);
    result(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and cin);
    result(1) <= ((p(1) and not(carry(1))) or (carry(1) and not(p(1))));
    result(2) <= ((p(2) and not(carry(2))) or (carry(2) and not(p(2))));
    result(3) <= ((p(3) and not(carry(3))) or (carry(3) and not(p(3))));

end architecture;