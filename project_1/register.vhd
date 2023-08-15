library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RunLengthEncoder is
	port(clk, rst: in std_logic;
	input: in std_logic_vector(7 downto 0);
	data_valid: out std_logic;
	output: out std_logic_vector(7 downto 0));
end entity;

architecture RunLengthEncoder_arc of RunLengthEncoder is
	constant esc : std_logic_vector(7 downto 0) := "00011011";
	signal inp_count, iter_count, state : integer := 0;
	signal current_char, current_count: std_logic_vector(7 downto 0);
	type in_buffer is array(63 downto 0) of std_logic_vector(7 downto 0);
	signal input_buffer : in_buffer;
	
begin
	input_buffering_process: process (clk)
	begin
	if(rising_edge(clk)) then
		if(rst = '1') then
		else
			if(inp_count < 64) then
				input_buffer(inp_count) <= input;
				inp_count <= inp_count + 1;
			end if;
		end if;
	end if;
	end process;
	
	output_generation_process: process (clk)
	begin
	if(rising_edge(clk)) then
		if (rst = '1') then
			current_count <= "00000000";
			data_valid <= '0';
			output <= esc;
			current_char <= esc;
		else
			if(state = 0) then
				data_valid <= '0';
				if(iter_count + 1 < inp_count ) then 
					current_char <= input_buffer(iter_count);
					current_count <= current_count + "00000001";
					iter_count <= iter_count + 1;
					if(input_buffer(iter_count) /= input_buffer(iter_count + 1)) then
						if(input_buffer(iter_count) /= esc) then	
							if(current_count = "00000000") then
								state <= 1; 
							elsif(current_count = "00000001") then
								state <= 2; 
							else
								state <= 3; 
							end if;
						else
							state <= 3; 
						end if;
					elsif(input_buffer(iter_count) /= esc and current_count =  "00000100") then
						state <= 3; 
					elsif(input_buffer(iter_count) = esc and current_count =  "00000101") then
						state <= 3; 
					end if;
				elsif(iter_count = 63 and inp_count = 64) then
					current_char <= input_buffer(iter_count);
					current_count <= current_count + "00000001";
					iter_count <= iter_count + 1;
					if(input_buffer(iter_count) /= esc) then	
						if(current_count = "00000000") then
							state <= 1; 
						elsif(current_count = "00000001") then
							state <= 2; 
						else
							state <= 3; 
						end if;
					else
						state <= 3; 
					end if;
				end if;
			elsif(state = 1) then
				data_valid <= '1';
				output <= current_char;
				state <= 0; 
				current_count <= "00000000";
			elsif(state = 2) then
				data_valid <= '1';
				output <= current_char;
				state <= 1; 
			elsif(state = 3) then
				data_valid <= '1';
				output <= esc;
				state <= 4; 
			elsif(state = 4) then
				data_valid <= '1';
				output <= current_count;
				state <= 1; 
			end if;
		end if;
	end if;
	end process;
	
end architecture;