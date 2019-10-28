LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY PO IS
PORT(
	clk : IN STD_LOGIC;
   reset : IN STD_LOGIC := '0';
   out_state : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
);
END PO;

ARCHITECTURE behavior OF PO IS
TYPE type_fstate IS (s0,s1,s2,s3);
SIGNAL fstate : type_fstate;
SIGNAL reg_fstate : type_fstate;
signal counter : std_LOGIC_VECTOR (5 downto 0);

BEGIN

PROCESS (clk,reg_fstate)
BEGIN
	IF (clk='1' AND clk'event) THEN
		fstate <= reg_fstate;
   END IF;
END PROCESS;

PROCESS (fstate,reset)
	variable count : std_LOGIC_VECTOR (5 downto 0);
   BEGIN
   IF (reset='1') THEN
		reg_fstate <= s0;
      out_state <= "00";
		count := "000000";
   ELSE
		CASE fstate IS
			WHEN s0 =>
				reg_fstate <= s1;
				out_state <= "01";
			
			WHEN s1 =>
				out_state <= "00";					  						  
				IF (count < "100000") THEN
					count := count + "000001";
					reg_fstate <= s2;
				ELSE
					reg_fstate <= s1;
					count := count;
				END IF;
						  
			WHEN s2 =>
				reg_fstate <= s3;
				out_state <= "10";
				count := count;
				  
			WHEN s3 =>
				out_state <= "11";
				reg_fstate <= s1;
				count := count;
						  
			WHEN OTHERS => 
				out_state <= "00";
				count := count;
				report "Reach undefined state";
		
		END CASE;
	END IF;
	  
	counter <= count;
END PROCESS;

END behavior;
