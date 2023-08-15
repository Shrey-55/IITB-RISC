library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity TrafficLightsController is
	port ( clk, rst, tr1, tr4 : in std_logic;
			r, g, y: out std_logic_vector (4 downto 0) );
end entity;

architecture arc_TrafficLightsController of TrafficLightsController is
	constant YELLOW: integer :=5;
	constant LONG_GREEN: integer :=60;
	constant SHORT_GREEN: integer :=30;
	signal state: integer:=4;
	signal on_time: integer:=0;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(rst='1') then
				state<=4;
				on_time<=0;
			else
				if(state=0) then
					if(on_time=LONG_GREEN) then
						state<=1;
						on_time<=1;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=1) then
					if(on_time=YELLOW) then
						on_time<=1;
						if(tr1='1') then
							state<=2;
						else
							state<=4;
						end if;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=2) then
					if(on_time=SHORT_GREEN) then
						on_time<=1;
						state<=3;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=3) then
					if(on_time=YELLOW) then
						on_time<=1;
						state<=4;
					else 
						on_time<=on_time+1;
					end if;
				elsif(state=4) then
					if(on_time=LONG_GREEN) then
						on_time<=1;
						state<=5;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=5) then
					if(on_time=YELLOW) then
						on_time<=1;
						state<=6;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=6) then
					if(on_time=LONG_GREEN) then
						on_time<=1;
						state<=7;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=7) then
					if(on_time=YELLOW) then
						on_time<=1;
						if(tr4='1') then
							state<=8;
						else
							state<=0;
						end if;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=8) then
					if(on_time=SHORT_GREEN) then
						on_time<=1;
						state<=9;
					else
						on_time<=on_time+1;
					end if;
				elsif(state=9) then
					if(on_time=YELLOW) then
						on_time<=1;
						state<=0;
					else
						on_time<=on_time+1;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	
	process(rst,state)
	begin
	if(rst='1') then
		r<="11111";
		g<="00000";
		y<="00000";
	else
		if(state=0) then
			r<="11110";
			g<="00001";
			y<="00000";
		elsif(state=1) then
			r<="11110";
			g<="00000";
			y<="00001";	
		elsif(state=2) then
			r<="11101";
			g<="00010";
			y<="00000";	
		elsif(state=3) then
			r<="11101";
			g<="00000";
			y<="00010";	
		elsif(state=4) then
			r<="11011";
			g<="00100";
			y<="00000";	
		elsif(state=5) then
			r<="11011";
			g<="00000";
			y<="00100";	
		elsif(state=6) then
			r<="10111";
			g<="01000";
			y<="00000";	
		elsif(state=7) then
			r<="10111";
			g<="00000";
			y<="01000";	
		elsif(state=8) then
			r<="01111";
			g<="10000";
			y<="00000";
		elsif(state=9) then
			r<="01111";
			g<="00000";
			y<="10000";	
		else
			r<="11111";
			g<="00000";
			y<="00000";
		end if;
	end if;
	end process;
end architecture;
