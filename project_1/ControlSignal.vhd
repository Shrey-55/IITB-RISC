library IEEE;
use IEEE.std_logic_1164.all;

entity BitwiseNand is
    port(library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity control_signal is
	port(X: in std_logic_vector(26 downto 0);
	alu: out std_logic_vector(6 downto 0);
	rf_en: out std_logic;
	r7_wr_mux: out std_logic_vector( 1 downto 0);
	rf: out std_logic_vector( 6 downto 0 );
	mem_write_bar: out std_logic;
	mem_a_mux: out std_logic_vector( 1 downto 0);
	mem_d_mux: out std_logic;
	en_t: std_logic_vector(3 downto 0);
	pc_en: out std_logic;
	ir_en: out std_logic;
	temp_z_en: out std_logic;
	flagc_en:out std_logic;
	flagz_en: out std_logic;
	t_mux: out std_logic_vector( 5 downto 0);
	pc_mux: out std_logic_vector(2 downto 0));
end entity;

architecture Behave of control_signal is
begin
process(X)
begin
alu(6 downto 5)<="00";
alu(4 downto 3)<="00";
alu(2 downto 0)<="000";
rf_en<='0';
r7_wr_mux<="00";
rf( 6 downto 5)<= "00";
rf( 4 downto 3)<= "000";
rf( 2 downto 0)<= "00";
mem_write_bar<='0';
mem_a_mux<="00";
mem_d_mux<='0';
en_t(3)<= '0';
en_t(2)<= '0';
en_t(1)<= '0';
en_t(0)<= '0';
pc_en<= '0';
ir_en<= '0';
flagc_en<='0';
flagz_en<= '0';
t_mux(5 downto 4) <= "00";
t_mux(3 downto 2) <= "00";
t_mux(1 downto 0) <='0';
pc_mux<= "000";
temp_z_en<='0';
case X(22 downto 18) is
	when "00001" =>
   alu(2 downto 0)<="001";
   mem_write_bar<='1';
	mem_d_mux<='1';
	pc_en<= '1';
	ir_en<= '1';
	temp_z_en<='1';
--------------------------------------------------------------------------------------State 2
when "00010" =>
	temp_z_en<='1';
	alu(2 downto 0)<="001";
	r7_wr_mux<="01";
	rf( 4 downto 3)<= "010";
	mem_write_bar<='1';
	mem_d_mux<='1';
	en_t(3)<= '1';
	en_t(2)<= '1';
	if((X(17 downto 14)="0000" or X(17 downto 14)="0010" ) and X(3 downto 1)="100" ) then
		rf_en<='1';
	elsif((X(17 downto 14)="0000" or X(17 downto 14)="0010" ) and X(3 downto 2)="01" and X(0) = '0') then
		rf_en<='1';
	else
		rf_en<='0';
	end if;
-------------------------------------------------------------------------------------- State 3
when "00011" =>
	temp_z_en<='1';
	mem_write_bar<='1';
	mem_d_mux<='1';
	r7_wr_mux<="01";
	rf( 4 downto 3)<= "010";
	if (X(17 downto 14) = "0000" or X(17 downto 14) = "0010") then
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="010";
		en_t(3)<= '1';
		en_t(2)<= '0';
		t_mux(5 downto 4) <= "01";
		if(X(17 downto 14) = "0000") then
			alu(6 downto 5)<="00";
		else
			alu(6 downto 5)<="10";
		end if;
		if(X(17 downto 14) = "0000") then
			flagc_en<='1';
			flagz_en<= '1';
		else
			flagc_en<='0';
			flagz_en<= '1';
		end if;
	elsif(X(17 downto 14) = "0001") then
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="100";
		en_t(3)<= '1';
		flagc_en<='1';
		flagz_en<= '1';
		t_mux(5 downto 4) <= "01";
	
	elsif(X(17 downto 14) = "0100") then
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		en_t(3)<= '1';
		t_mux(5 downto 4) <= "01";
		
	elsif(X(17 downto 14)="0101") then
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		en_t(2)<= '1';
		t_mux(3 downto 2) <= "01";

	else
		alu(6 downto 5)<="11";
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		t_mux(3 downto 2) <= "01";
	end if;
---------------------------------------------------------------------------------- State 4
when "00100" =>
	temp_z_en<='1';
	|alu(4 downto 3)<="10";
	alu(2 downto 0)<="100";
	mem_write_bar<='1';
	mem_d_mux<='1';
	t_mux(3 downto 2) <= "01";
	
	if (X(17 downto 14) = "0000" or X(17 downto 14) = "0010") then
		rf_en<='1';
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "001";
		rf( 2 downto 0)<= "00";
		pc_mux<= "010";
		if(X(7 downto 5)="111") then
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		if(X(7 downto 5) = "111") then
		pc_en<= '1';
		else
		pc_en<= '0';
		end if;
	elsif(X(17 downto 14)="0001") then
		rf_en<='1';
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "011";
		rf( 2 downto 0)<= "00";
		pc_mux<= "010";
		if(X(10 downto 8)="111") then
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		if(X(10 downto 8) = "111") then
		pc_en<= '1';
		else
		pc_en<= '0';
		end if;
	elsif(X(17 downto 14)="0011") then
		rf_en<='1';
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "100";
		rf( 2 downto 0)<= "01";
		pc_mux<= "101";
		if(X(13 downto 11)="111") then
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		if(X(13 downto 11) = "111") then
		pc_en<= '1';
		else
		pc_en<= '0';
		end if;
	else
		rf_en<='0';
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "100";
		rf( 2 downto 0)<= "01";
		pc_mux<= "101";
		r7_wr_mux<="00";
		pc_en<= '0';
	end if;

------------------------------------------------------------------------------- State 6
when "00110" =>
		temp_z_en<='1';
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		r7_wr_mux<="01";
		rf( 4 downto 3)<= "010";
		mem_write_bar<='1';
		mem_d_mux<='1';
		en_t(2)<= '1';
		t_mux(5 downto 4) <= "00";
		t_mux(3 downto 2) <= "10";
------------------------------------------------------------------------------- State 7
when "00111" =>
		temp_z_en<='1';
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		r7_wr_mux<="01";
		rf( 4 downto 3)<= "010";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t(3)<= '1';
		t_mux(5 downto 4) <= "10";
		t_mux(3 downto 2) <= "10";
-------------------------------------------------------------------------------State 8
when "01000" =>
		temp_z_en<='1';
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="000";
		rf_en<='1';
		if(X(13 downto 11)="111") then
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf( 4 downto 3)<= "100";
		mem_write_bar<='1';
		mem_d_mux<='1';
		flagz_en<= '1';
		t_mux(5 downto 4) <= "00";
		t_mux(3 downto 2) <= "01";
		pc_mux<= "010";
		if(X(13 downto 11) = "111") then
		pc_en<= '1';
		else
		pc_en<= '0';
		end if;
-----------------------------------------------------------------State 9
when "01001" =>
		temp_z_en<='1';
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		rf_en<='1';
		r7_wr_mux<="01";
		rf( 4 downto 3)<= "010";
		mem_a_mux<="10";
		t_mux(5 downto 4) <= "10";
		t_mux(3 downto 2) <= "10";
		pc_mux<= "000";
-----------------------------------------------------------------State 10
when "01010" =>
		temp_z_en<='1';
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		r7_wr_mux<="01";
		rf( 4 downto 3)<= "010";
		mem_write_bar<='1';
		mem_a_mux<="01";
		en_t(2)<= '1';
		en_t(1)<= '1';
		en_t(0)<= '1';
		t_mux(5 downto 4) <= "10";
		t_mux(3 downto 2) <= "11";
		
---------------------------------------------------------------State 11
when "01011" =>
		temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="001";
		rf_en<='1';
		if(X(25 downto 23)="111") then
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "101";
		rf( 2 downto 0)<= "10";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t(3)<= '1';
		en_t(2)<= '0';
		en_t(1)<= '0';
		en_t(0)<= '0';
		if(X(25 downto 23) = "111") then
		pc_en<= '1';
		else
		pc_en<='0';
		end if;
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "11";
		t_mux(1 downto 0) <='0';
		pc_mux<= "100";
-----------------------------------------------------------------State 12
when  "01100" =>
		temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "010";
		rf( 2 downto 0)<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t(3)<= '0';
		en_t(2)<= '1';
		en_t(1)<= '0';
		en_t(0)<= '1';
		t_mux(5 downto 4) <= "10";
		t_mux(3 downto 2) <= "11";
-----------------------------------------------------------------State 13
when "01101" =>
	    temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf( 6 downto 5)<= "10";
		rf( 4 downto 3)<= "010";
		rf( 2 downto 0)<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		en_t(1)<= '1';
		t_mux(5 downto 4) <= "10";
		t_mux(3 downto 2) <= "11";
		t_mux(1 downto 0) <='1';
-----------------------------------------------------------------State 14
when "01110" =>
		temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="001";
		rf_en<='1';
		r7_wr_mux<="01";
		rf( 6 downto 5)<= "00";
		rf( 4 downto 3)<= "010";
		rf( 2 downto 0)<= "00";
		mem_write_bar<='0';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t(3)<= '1';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "11";
-----------------------------------------------------------------State 15
when "01111"  =>
		temp_z_en<='1';
		alu(6 downto 5)<="01";
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="010";
		rf_en<='0';
		r7_wr_mux<="01";
		rf( 6 downto 5)<= "01";
		rf( 4 downto 3)<= "010";
		rf( 2 downto 0)<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t(3)<= '1';
		t_mux(3 downto 2) <= "11";
----------------------------------------------------------------State 16
when "10000" =>
		temp_z_en<='0';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="101";
		rf_en<='1';
		if(X(26) = '0')then
		r7_wr_mux<="01";
		pc_en<= '0';
		else
		pc_en<= '1';
		r7_wr_mux<="11";
		end if;
		rf( 6 downto 5)<= "01";
		rf( 4 downto 3)<= "010";
		mem_write_bar<='1';
		mem_a_mux<="01";
		t_mux(3 downto 2) <= "11";
--------------------------------------------------------------STate 17
when "10001" =>
	    temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="001";
		rf_en<='0';
		r7_wr_mux<="01";
		rf( 6 downto 5)<= "01";
		rf( 4 downto 3)<= "010";
		rf( 2 downto 0)<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t(1)<= '1';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "11";
		t_mux(1 downto 0) <='1';
		pc_mux<= "000";
--------------------------------------------------------------STate 18
when "10010" =>
	    temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="11";
		alu(2 downto 0)<="011";
		rf_en<='1';
		r7_wr_mux<="11";
		rf( 6 downto 5)<= "01";
		rf( 4 downto 3)<= "100";
		rf( 2 downto 0)<= "10";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		pc_en<= '1';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "11";
		t_mux(1 downto 0) <='1';
		pc_mux<= "000";
--------------------------------------------------------------STate 19
when "10011" =>
	    temp_z_en<='1';
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="11";
		alu(2 downto 0)<="011";
		rf_en<='1';
		r7_wr_mux<="10";
		rf( 6 downto 5)<= "01";
		rf( 4 downto 3)<= "100";
		rf( 2 downto 0)<= "10";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		pc_en<= '1';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "11";
		t_mux(1 downto 0) <='1';
		pc_mux<= "011";
--------------------------------------------------------------STate 20	
when "10100" =>
	    temp_z_en<='1';
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="101";
		rf_en<='1';
		r7_wr_mux<="10";
		rf( 6 downto 5)<= "01";
		rf( 4 downto 3)<= "010";
		mem_write_bar<='1';
		mem_a_mux<="11";
		mem_d_mux<='1';
		pc_en<= '1';
		t_mux(5 downto 4) <= "11";
		t_mux(3 downto 2) <= "11";
		t_mux(1 downto 0) <='1';
		pc_mux<= "000";
--------------------------------------------------------------STate 5	

when "00101" =>
	temp_z_en<='1';
	mem_write_bar<='1';
	mem_a_mux<="00";
	mem_d_mux<='1';
	r7_wr_mux<="01";
	rf( 6 downto 5)<= "00";
	rf( 4 downto 3)<= "010";
	rf( 2 downto 0)<= "00";
	if (X(17 downto 14) = "0000" or X(17 downto 14) = "0010") then
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="010";
		en_t(3)<= '1';
		en_t(2)<= '0';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "00";
		if(X(17 downto 14) = "0000") then
			alu(6 downto 5)<="00";
		else
			alu(6 downto 5)<="10";
		end if;
		if(X(17 downto 14) = "0000") then
			flagc_en<='1';
			flagz_en<= '1';
		else
			flagc_en<='0';
			flagz_en<= '1';
		end if;
	elsif(X(17 downto 14) = "0001") then
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="01";
		alu(2 downto 0)<="100";
		en_t(3)<= '1';
		en_t(2)<= '0';
		flagc_en<='1';
		flagz_en<= '1';
		t_mux(5 downto 4) <= "01";
		t_mux(3 downto 2) <= "00";

	elsif(X(17 downto 14) = "0100") then
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		en_t(3)<= '1';
		t_mux(5 downto 4) <= "01";

	elsif(X(17 downto 14)="0101") then
		alu(6 downto 5)<="00";
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		en_t(2)<= '1';
		t_mux(3 downto 2) <= "01";

	else
		alu(6 downto 5)<="11";
		alu(4 downto 3)<="10";
		alu(2 downto 0)<="100";
		t_mux(3 downto 2) <= "01";
	end if;
else
	temp_z_en<='1';
	alu(4 downto 3)<="11";
	alu(2 downto 0)<="011";
	rf_en<='1';
	r7_wr_mux<="10";
	rf( 6 downto 5)<= "01";
	rf( 4 downto 3)<= "100";
	rf( 2 downto 0)<= "10";
	mem_write_bar<='1';
	mem_a_mux<="01";
	mem_d_mux<='1';
	t_mux(5 downto 4) <= "01";
	t_mux(3 downto 2) <= "11";
	t_mux(1 downto 0) <='1';
	pc_mux<= "011";
end if;

end process;

end Behave;

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