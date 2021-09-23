LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY controller IS
	PORT
		( 	
			game_state					: IN std_logic_vector(1 downto 0);
			reset_button					: IN std_logic;
			stop_button						: IN std_logic;
			mode_switch						: IN std_logic;
			reset								: OUT std_logic;
			enable							: OUT std_logic;
			mode								: OUT std_logic
 );		
END controller;

architecture behavior of controller is

signal q_enable : std_logic := '1';
signal q_reset : std_logic;
signal state : std_logic := '0';
BEGIN     
mode <= mode_switch;

Enable_calculation: process(stop_button)
	
begin
	if (rising_edge(stop_button) and state = '0') then 
		q_enable <= '1';
		state <= '1';
	elsif (rising_edge(stop_button) and state = '1') then
		q_enable <= '0';
		state <= '0';
	end if;


end process Enable_calculation; 

enable <= 	'1' when game_state = "01" and q_enable = '1' else
				'1' when game_state = "10" and q_enable = '1' else
				'0';
reset <= '1' when reset_button = '0' else 
			'1' when game_state = "11" else
			'1' when game_state = "00" else
			'0';

END behavior;

