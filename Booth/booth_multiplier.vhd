LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL;
USE work.array32.ALL;

ENTITY booth_multiplier IS
PORT(
		MD, MR: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		s: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);

END booth_multiplier;

ARCHITECTURE behavior OF booth_multiplier IS
SIGNAL sel: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL s_encoder: reg_array;
SIGNAL result: reg_array;

COMPONENT boothEncoder IS
PORT(
		MD: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s: OUT STD_LOGIC_VECTOR(32 DOWNTO 0)
);

END COMPONENT;

COMPONENT sum IS
PORT(
	a, b: IN STD_LOGIC_VECTOR(32 DOWNTO 0);
	cin: IN STD_LOGIC;
	outPart: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	s: OUT STD_LOGIC_VECTOR(32 DOWNTO 0);
	cout: OUT STD_LOGIC
);
END COMPONENT;

BEGIN

sel <= MR(1 DOWNTO 0) & '0';
encoder0: boothEncoder PORT MAP(MD, sel, s_encoder(0));

Encoder_loop: FOR i IN 0 TO 14 GENERATE
	encoder: boothEncoder PORT MAP(MD, MR( ((i * 2) + 3) DOWNTO ( (i * 2) + 1) ), s_encoder(i+1));
END GENERATE;

adder0: sum PORT MAP( a => (others => '0'), b => s_encoder(0), cin => '0', s => result(0), outPart => s(1 DOWNTO 0));

Adder_loop: FOR i IN 0 TO 14 GENERATE
	adder: sum PORT MAP(a => result(i), b => s_encoder(i+1), cin => '0', s => result(i+1), outPart => s( ((i * 2) + 3) DOWNTO ( (i * 2) +2) ));
END GENERATE;

s(63 DOWNTO 32) <= result(15)(31 DOWNTO 0);

END behavior;

