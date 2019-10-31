LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY full_adder IS
PORT(
	a, b, cin: IN std_logic;
	s, cout: OUT std_logic
);
END full_adder;

ARCHITECTURE behavior OF full_adder IS
BEGIN
	s <= a XOR b XOR cin;
	cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END behavior;