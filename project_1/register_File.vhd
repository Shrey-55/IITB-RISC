library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;
architecture Behave of Testbench is

  constant number_of_inputs  : integer := 8;  -- # input bits to your design.
  constant number_of_outputs : integer := 8;  -- # output bits from your design.

  component RunLengthEncoder is
	  port(clk, rst: in std_logic;
	  input: in std_logic_vector(7 downto 0);
	  data_valid: out std_logic;
	  output: out std_logic_vector(7 downto 0));
  end component;
  signal clk, rst, data_valid : std_logic;
  signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
  signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);
  -- bit-vector to std-logic-vector and vice-versa
  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
     alias lx: bit_vector(1 to x'length) is x;
     variable ret_val: std_logic_vector(1 to x'length);	
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_std_logic_vector;
  function to_bit_vector(x: std_logic_vector) return bit_vector is
     alias lx: std_logic_vector(1 to x'length) is x;
     variable ret_val: bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_bit_vector;

begin
	
	dut_Instance: RunLengthEncoder
		port map (clk, rst, input_vector, data_valid, output_vector);
	
	clock_process :process
		 variable INPUT_COUNT: integer := 0;
	begin
		while INPUT_COUNT < 512 loop
			clk <= '0';
			wait for 50 ps;
			clk <= '1';
			wait for 50 ps;
			INPUT_COUNT := INPUT_COUNT + 1;
		end loop;
		wait;
	end process;
	reset_process :process
	begin
		rst <= '1';
		wait for 100 ps;
		rst <= '0';
		wait;
	end process;

	rle_process :process 
		 File INFILE: text open read_mode is 		"../../input.txt"; -- Same directory as vhdl file
		 FILE OUTFILE: text  open write_mode is 	"../../output.txt";-- Same directory as vhdl file

		 -- bit-vectors are read from the file.
		 variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);
		 variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);

		 -- for read/write.
		 variable INPUT_LINE: Line;
		 variable OUTPUT_LINE: Line;
		 variable LINE_COUNT: integer := 0;

	 
	begin
		input_vector <= "00011011";
		wait for 100 ps;
		while LINE_COUNT < 64 loop
			readLine (INFILE, INPUT_LINE);
			read(INPUT_LINE, input_vector_var);
			input_vector <= to_std_logic_vector(input_vector_var);
			wait for 60 ps;
			if(data_valid = '1') then
				write(OUTPUT_LINE, to_bit_vector(output_vector));
				writeline(OUTFILE, OUTPUT_LINE);		
			end if; 
			wait for 40 ps;
			LINE_COUNT := LINE_COUNT + 1;
		end loop;
		while LINE_COUNT < 512 loop
			input_vector <= "00011011";
			wait for 60 ps;
			if(data_valid='1') then
				write(OUTPUT_LINE, to_bit_vector(output_vector));
				writeline(OUTFILE, OUTPUT_LINE);	
			end if;
			wait for 40 ps;
			LINE_COUNT := LINE_COUNT + 1;
		end loop;
		wait;
	end process;

  
end Behave;
