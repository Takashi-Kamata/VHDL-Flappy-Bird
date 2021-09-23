library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


ENTITY statemachine IS
	PORT
		(left_click, right_click, vert_sync_out, gameover, mode	: IN std_logic;
		  state : OUT std_logic_vector(1 DOWNTO 0);
		  lives : OUT integer
		  );		
END statemachine;

architecture behavior of statemachine is

SIGNAL state_v : std_logic_vector(1 downto 0) := "00";
SIGNAL prev_state : std_logic_vector(1 downto 0) := "00";

begin

process(vert_sync_out)
begin
	if (rising_edge(vert_sync_out)) then
		-- intro
		if state_v = "00" then
			if left_click = '1' and mode = '0' and (prev_state = "00") then
				lives <= 1;
				state_v <= "10";
				prev_state <= "00";
			elsif left_click = '1' and mode = '1' and (prev_state = "00") then
				lives <= 3;
				state_v <= "01";
				prev_state <= "00";
			else
				state_v <= "00";
			end if;

			
			if (prev_state = "11" and left_click = '0') then
				prev_state <= "00";
			end if;
		end if;
		
		-- competitive game
		if state_v = "10" then
			if gameover = '1' then
				state_v <= "11";
				prev_state <= "01";
			else
				state_v <= "10";
			end if;
		end if;
		
		-- training game
		if state_v = "01" then
			if gameover = '1' then
				state_v <= "11";
				prev_state <= "01";
			else
				state_v <= "01";
			end if;
		end if;
		
		-- game 
		if state_v = "11" then
			if (left_click = '1' and prev_state = "11") then
				state_v <= "00";
				prev_state <= "11";
			else
				state_v <= "11";
			end if;
			if ((prev_state = "01" or prev_state="10") and left_click = '0') then
				prev_state <= "11";
			end if;
		end if;

	end if;

state <= state_v;
	
end process;
end architecture behavior;
	
