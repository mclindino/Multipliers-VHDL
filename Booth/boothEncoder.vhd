LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY boothEncoder IS
PORT(
		MD: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s: OUT STD_LOGIC_VECTOR(32 DOWNTO 0)
);

END boothEncoder;

ARCHITECTURE behavior OF boothEncoder IS
--SIGNAL MD_2, not_MD_2: STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL not_MD: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

not_MD <= (not MD) + '1';
--MD_2 <= MD & '0';
--not_MD_2 <= not_MD & '0';

PROCESS(sel)
BEGIN
	IF sel = "000" or sel = "111" THEN
		s <= (others => '0');
	ELSIF (sel = "001" or sel = "010") and MD(31) = '1' THEN
		s <= '1' & MD;
	ELSIF (sel = "001" or sel = "010") and MD(31) = '0' THEN
		s <= '0' & MD;
	ELSIF sel = "011" THEN
		s <= MD & '0';
	ELSIF sel = "100" THEN
		s <= not_MD & '0';
	ELSIF (sel = "101" or sel = "110") and not_MD(31) = '1' THEN
		s <= '1' & not_MD;
	ELSIF (sel = "101" or sel = "110") and not_MD(31) = '0' THEN
		s <= '0' & not_MD;
	END IF;
END PROCESS;
END behavior;


