library IEEE;
use IEEE.std_logic_1164.all;	-- std_logic, rising_edge
use IEEE.numeric_std.all;		-- numeric conversion, math operations
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;
				-- reading external files and manipulation

entity RAM256x8 is 
generic (
	-- SIZE_WORD: number of bits per word (SIZEOF WORD) 
	-- ADRESS_LINE: number of bits to find data positio(SIZEOF ADRESS = LN(SIZEOF NUM ADRESSES))
	SIZE_WORD: integer:=8; 
	ADRESS_LINES: integer:=8
	--INITFILENAME: string:= "ramdata.txt"
); 
port(
	data_in: in std_logic_vector(SIZE_WORD-1 downto 0);
	addr: in std_logic_vector(ADRESS_LINES-1 downto 0);
	enable_w: in std_logic;
	clk: in std_logic;
	data_out: out std_logic_vector(SIZE_WORD-1 downto 0)
);
end RAM256x8;

architecture RAMHARDWARE of RAM256x8 is 
	constant RAM_DEPTH : natural := 2**ADRESS_LINES;
	constant RAM_WIDTH : natural := ADRESS_LINES;
	
	-- define the new type for the RAM 
	type MEMType is array(0 to RAM_DEPTH-1) of std_logic_vector(RAM_WIDTH-1 downto 0);
	
	--function to initialize ram with data from text with hexadecimal values
	--file text_file: text open read_mode is INITFILENAME;
		--variable text_line: line;
		--variable ram_content: MEMType;
		--begin
			--for i in 0 to RAM_DEPTH - 1 loop
				--readline(text_file, text_line);
				--hread(text_line, ram_content(i));
			--end loop;
		--return ram_content;
	--end function;
	
	-- define the ram
	--signal MEM: MEMType := initram_hex;
	signal MEM: MEMType := (
	-- prefix on the right, sufix above
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"10", x"80", x"20" ,x"80" ,x"81" ,x"30" ,x"82" ,x"A0", -- 0
		x"0D", x"20", x"83", x"80", x"0F", x"20", x"84", x"F0", -- 0
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 1 
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 1
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 2
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 2
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 3
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 3
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 4
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 4
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 5
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 5
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 6
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 6
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 7
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 7
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"0A", x"01", x"0A", x"00", x"01", x"00", x"00", x"00", -- 8
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 8
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 9
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- 9
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- A
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- A
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- B
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- B
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- C
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- C
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- D
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- D
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- E
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- E
	--   0      1      2      3      4      5      6      7
	--   8      9      A      B      C      D      E      F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- F
		x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00"  -- F
);
begin
process(clk)
	begin
	if(rising_edge(clk)) then
		if(enable_w = '1') then
			MEM( to_integer(unsigned(addr)) ) <= data_in;
		end if;
		data_out <= MEM( to_integer(unsigned(addr)) );
	end if;
end process;
end RAMHARDWARE;
