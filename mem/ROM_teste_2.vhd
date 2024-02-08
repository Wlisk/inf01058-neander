LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ROM2 IS
	PORT(
		entrada : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		saida	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ROM2;

ARCHITECTURE arch OF ROM2 IS
BEGIN

	WITH entrada SELECT
	--  saida <=    "DADO_MEM" WHEN "ADDR_MEM",
		saida <= 	
					-- PROGRAMA: compara posições 0x80 e 0x82. Carrega 1 no AC se são iguais e 0 c.c.
					x"20" when x"00",    -- LDA
					x"80" when x"01",    -- 0x80 : A
					x"60" when x"02",    -- NOT : F5
					x"30" when x"03",    -- ADD
					x"81" when x"04",    -- 0x81 : 1+F5 = F6
					x"60" when x"05",    -- NOT : 09
					x"50" when x"06",  	-- AND 
					x"0F" when x"0F",	   -- 0x0F : 09
					x"30" when x"08", 	-- ADD 
					x"80" when x"09",	   -- 0x80 : 09+0A = 13
					x"90" when x"0A", 	-- JN 
					x"0E" when x"0B", 	-- 0x0E : N load 0
					x"A0" when x"0C",    -- JZ 
					x"12" when x"0D",    -- 0x12 : Z load 1
					x"20" when x"0E",    -- LDA
					x"83" when x"0F",    -- 0x83 : load 0
					x"80" when x"10",    -- JMP : jmp hlt
					x"0F" when x"11",    -- 0x14
					x"20" when x"12",    -- LDA
					x"84" when x"13",    -- 0x84 : load 1
					x"F0" when x"14",    -- HLT
					-- DADOS  --------------
					x"0A" when x"80",	   -- 0x0A = 10
					x"01" when x"81",	   -- 0x01 = 1
					x"0A" when x"82",	   -- 0x0A = 10
					x"00" when x"83",	   -- 0x00 = 0 (negative)
					x"01" when x"84",	   -- 0x01 = 1 (zero)

					"00000000" WHEN OTHERS;
END arch; 