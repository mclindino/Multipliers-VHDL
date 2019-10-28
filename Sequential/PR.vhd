library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY PR IS
PORT(
		pp: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		input: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		mr: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		carry: IN STD_LOGIC;
		enable: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		clk: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		s: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);

END PR;

ARCHITECTURE behavior OF PR IS
SIGNAL temp: std_logic_vector(63 DOWNTO 0);
BEGIN

PROCESS(enable, clk, reset)
BEGIN
	IF reset = '1' THEN 
		temp <= "0000000000000000000000000000000000000000000000000000000000000000";
	ELSIF clk='1' and clk'EVENT THEN
		temp <= input;
		
		IF enable = "00" THEN
			temp <= input;
		ELSIF enable = "01" THEN
			temp(31 DOWNTO 0) <= mr;
		ELSIF enable = "10" THEN
			temp(63 DOWNTO 32) <= pp;
		ELSIF enable = "11" THEN
			temp <= carry & input(63 DOWNTO 1);
		end IF;
	end IF;		
END PROCESS;

s <= temp;
END behavior;