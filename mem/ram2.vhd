LIBRARY IEEE;
USE IEEE.numeric_bit.all;

ENTITY RAM2 IS
	-- SIZE_WORD: number of bits per word
	-- N_ADDRESS: number of address bits; N = 2^N_ADDRESS
	generic (SIZE_WORD: integer:=8; N_ADDRESS: integer:=8); 
	
	PORT(
		addr: IN UNSIGNED(N_ADDRESS-1 DOWNTO 0);
		data_in: IN UNSIGNED(SIZE_WORD-1 DOWNTO 0);
		data_out: OUT UNSIGNED(SIZE_WORD-1 DOWNTO 0);
		enable_wr,clk: IN BIT
	);
END RAM2;

ARCHITECTURE RAM2BEHAVIOR OF RAM2 IS
TYPE RAM IS ARRAY (0 TO 256) OF UNSIGNED(SIZE_WORD-1 DOWNTO 0);
SIGNAL data_mem: RAM; 
BEGIN
	PROCESS(clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF enable_wr = '1' THEN 
				data_mem(TO_INTEGER(addr)) <= data_in; -- synchronous write
			END IF;
			data_out <= data_mem(TO_INTEGER(addr));   -- synchronous read
		END IF;
	END PROCESS;
END RAM2BEHAVIOR;