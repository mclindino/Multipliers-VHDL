LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY sum IS
PORT(
	a, b: IN std_logic_vector(31 DOWNTO 0);
	cin: IN std_logic;
	cout: OUT std_logic;
	s: OUT std_logic_vector(31 DOWNTO 0)
);
END sum;

ARCHITECTURE behavior OF sum IS
SIGNAL cout_extend: std_logic_vector(31 DOWNTO 0);


COMPONENT full_adder IS
PORT(
	a, b, cin: IN std_logic;
	s, cout: OUT std_logic
);
END COMPONENT;

BEGIN

First_Adder: FULL_ADDER PORT MAP(a(0), b(0), cin, s(0), cout_extend(0));
		
loop_generator: FOR i IN 1 TO 31 GENERATE
	Adders: FULL_ADDER PORT MAP(a(i), b(i), cout_extend(i-1), s(i), cout_extend(i));
END GENERATE loop_generator;

cout <= cout_extend(31);

END behavior;