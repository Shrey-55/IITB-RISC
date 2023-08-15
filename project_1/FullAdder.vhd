library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
    port(
        a, b, cin: in std_logic;
        s, cout:  out std_logic
    );
end entity;

architecture FullAdderArch of FullAdder is
    signal g, p: std_logic;
begin
        g <= a and b;
        p <= (a and not(b)) or (not(a) and b);
        s <= (p and not(cin)) or (not(p) and cin);
        cout <= g or (p and cin);
end architecture;