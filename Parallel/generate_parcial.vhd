LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY generate_parcial IS
PORT(
	a: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	b: IN STD_LOGIC;
	s: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
);
END generate_parcial;

ARCHITECTURE behavior OF generate_parcial IS
BEGIN

s <= "000000000" when b = '0' else 
		('0' & a) when b = '1';
	 
--	PROCESS(b)
--		BEGIN
--		IF b = '1' THEN
--			s <= a;
--		ELSE
--			s <= "00000000";
--		END IF;
--	END PROCESS;

END behavior;