LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY shift_multiplier IS
PORT(
	x: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	s: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
);
END shift_multiplier;

ARCHITECTURE behavior OF shift_multiplier IS
SIGNAL a1, a2: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL aux_x: UNSIGNED(11 DOWNTO 0);

BEGIN
	aux_x <= "0000" & unsigned(x);
	a1 <= std_logic_vector(aux_x sll 3);
	a2 <= std_logic_vector(aux_x sll 1);
	
	s <= a1 + a2;
	
END behavior;