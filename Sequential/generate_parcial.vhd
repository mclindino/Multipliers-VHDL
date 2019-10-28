library ieee;
use ieee.std_logic_1164.all;

ENTITY generate_parcial IS
PORT(
	a: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	b: IN STD_LOGIC;
	s: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END generate_parcial;

ARCHITECTURE behavior OF generate_parcial IS
BEGIN

s <= a when b = '1' else "00000000000000000000000000000000";

END behavior;