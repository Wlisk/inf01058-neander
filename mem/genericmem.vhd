library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- from: https://www.eng.auburn.edu/~nelson/courses/elec4200/Slides/VHDL%205%20Memory%20Models.pdf
-- N x K RAM is 2-dimensional array of N K-bit words

entity RAM is
	-- K: number of bits per word
	-- A: number of address bits; N = 2^A
	generic (K: integer:=8; A: integer:=8); 
	port (
		ENABLE_W: 	in std_logic; -- active high write enable
		ADDR: 		in std_logic_vector (A-1 downto 0); -- RAM address
		DATA_IN: 	in std_logic_vector (K-1 downto 0); -- write data
		DATA_OUT: 	out std_logic_vector (K-1 downto 0) -- read data
	); 
end entity RAM;

architecture RAMBEHAVIOR of RAM is
	subtype WORD is std_logic_vector (K-1 downto 0); 	-- define size of WORD
	type MEMORY is array (0 to 2**A-1) of WORD; 			-- define size of MEMORY
	signal RAM256: MEMORY; 										-- RAM256 as signal of type MEMORY
begin 
	process (ENABLE_W, DATA_IN, ADDR)
		variable RAM_ADDR_IN: natural range 0 to 2**A-1; 	-- translate address to integer
		begin
			RAM_ADDR_IN := to_integer(UNSIGNED(ADDR)); 		-- convert address to integer
			if (ENABLE_W='1') then 									-- write operation to RAM
				RAM256 (RAM_ADDR_IN) <= DATA_IN ;
			end if;
			DATA_OUT <= RAM256 (RAM_ADDR_IN); 					-- continuous read operation
	end process;
end architecture RAMBEHAVIOR;