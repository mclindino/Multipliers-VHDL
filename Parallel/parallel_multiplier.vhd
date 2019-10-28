LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY parallel_multiplier IS
PORT(
	a: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	s: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
);
END parallel_multiplier;

ARCHITECTURE behavior OF parallel_multiplier IS

SIGNAL pp0: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp1: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp2: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp3: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp4: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp5: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp6: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL pp7: STD_LOGIC_VECTOR(8 DOWNTO 0);

SIGNAL ss0: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss1: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss2: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss3: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss4: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss5: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss6: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL ss7: STD_LOGIC_VECTOR(8 DOWNTO 0);


COMPONENT generate_parcial IS
PORT(
	a: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	b: IN STD_LOGIC;
	s: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
);
END COMPONENT;


BEGIN
	gen0: generate_parcial PORT MAP(a, '0', pp0);
	s(0) <= pp0(0);
	ss0 <= '0' & pp0(8 DOWNTO 1);
	
	gen1: generate_parcial PORT MAP(a, '1', pp1);
	ss1 <= ss0 + ('0' & pp1(7 DOWNTO 0));
	s(1) <= ss1(0);
	
	gen2: generate_parcial PORT MAP(a, '0', pp2);
	ss2 <= ('0' & ss1(8 DOWNTO 1)) + ('0' & pp2(7 DOWNTO 0));
	s(2) <= ss2(0);
	
	gen3: generate_parcial PORT MAP(a, '1', pp3);
	ss3 <= ('0' & ss2(8 DOWNTO 1)) + ('0' & pp3(7 DOWNTO 0));

	s(11 DOWNTO 3) <= ss3;
	
END behavior;
