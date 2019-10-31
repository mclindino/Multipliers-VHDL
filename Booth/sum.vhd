LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY sum IS
PORT(
	a, b: IN std_logic_vector(32 DOWNTO 0);
	cin: IN std_logic;
	outPart: OUT std_logic_vector(1 DOWNTO 0);
	s: OUT std_logic_vector(32 DOWNTO 0);
	cout: OUT STD_LOGIC
);
END sum;

ARCHITECTURE behavior OF sum IS
SIGNAL cout_extend: std_logic_vector(31 DOWNTO 0);
SIGNAL result: std_logic_vector(32 DOWNTO 0);

COMPONENT full_adder IS
PORT(
	a, b, cin: IN std_logic;
	s, cout: OUT std_logic
);
END COMPONENT;

BEGIN

First_Adder: FULL_ADDER PORT MAP(a(0), b(0), cin, result(0), cout_extend(0));
		
loop_generator: FOR i IN 1 TO 31 GENERATE
	Adders: FULL_ADDER PORT MAP(a(i), b(i), cout_extend(i-1), result(i), cout_extend(i));
END GENERATE loop_generator;

Final_Adder: FULL_ADDER PORT MAP(a(32), b(32), cout_extend(31), result(32), cout);

s <= "00" & result(32 DOWNTO 2) when result(32) = '0' else
	  "11" & result(32 DOWNTO 2) when result(32) = '1';

outPart <= result(1 DOWNTO 0); 

END behavior;