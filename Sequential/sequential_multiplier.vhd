LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sequential_multiplier IS
PORT(
		MR, MD: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		clk: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		s: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

end sequential_multiplier;

ARCHITECTURE behavior OF sequential_multiplier IS
	
SIGNAL sel_state : std_logic_vector(1 DOWNTO 0);
SIGNAL PP : std_logic_vector(31 DOWNTO 0);
SIGNAL adder_out : std_logic_vector(31 DOWNTO 0);
SIGNAL carry : std_logic;
SIGNAL result : std_logic_vector(63 DOWNTO 0);
	
COMPONENT PO IS
PORT(
	clk : IN STD_LOGIC;
   reset : IN STD_LOGIC := '0';
   out_state : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
);
END COMPONENT;

COMPONENT sum IS
PORT(
	a, b: IN std_logic_vector(31 DOWNTO 0);
	cin: IN std_logic;
	cout: OUT std_logic;
	s: OUT std_logic_vector(31 DOWNTO 0)
);
END COMPONENT;
	
COMPONENT PR IS
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
END COMPONENT;
	
COMPONENT generate_parcial IS
PORT(
	a: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	b: IN STD_LOGIC;
	s: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END COMPONENT;

BEGIN

	stateMachine: PO PORT MAP(clk, reset, sel_state);
	
	gen: generate_parcial PORT MAP(MD, result(0), PP);
	
	regPR: PR PORT MAP(adder_out, result, MR, carry, sel_state, clk, reset, result);
		
	adder: sum PORT MAP(PP, result(63 DOWNTO 32), '0', carry, adder_out);
	
	s <= result;

END behavior;