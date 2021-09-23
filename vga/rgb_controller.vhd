LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY rgb_controller IS
	PORT
		( 	
			Clk												: IN std_logic;
			pixel_row, pixel_column						: IN std_logic_vector(9 DOWNTO 0);
			red_bird, green_bird, blue_bird	 		: IN std_logic_vector(3 downto 0);
			red_pipe, green_pipe, blue_pipe 			: IN std_logic;
			red_coin, green_coin, blue_coin 			: IN std_logic;
			score_out										: IN STD_LOGIC;
			lives_out										: IN STD_LOGIC;
			gameover_out									: IN STD_LOGIC;
			intro_out										: IN STD_LOGIC;
			state												: IN std_logic_vector(1 downto 0);
			red, green	,blue											: OUT std_logic_vector(3 downto 0)
 );		
END rgb_controller;

architecture behavior of rgb_controller is

signal q_red 	: std_logic;
signal q_green : std_logic;
signal q_blue 	: std_logic;


begin

red <= 	'1' &  "000"  when (gameover_out = '1') else
			'1' &  "000"  when (intro_out = '1') else
			'1' & "000" when (red_coin = '1' and (state =  "10")) 	else
			red_bird  when ((red_bird(0) = '1' or red_bird(1) = '1' or red_bird(2) = '1' or red_bird(3) = '1') 
			and (state =  "01" or state =  "10") and (green_pipe = '0')) 	else
			'1' &  "000"  when (lives_out = '1') else
         '1' &  "000"  when (score_out = '1' and (state =  "01" or state =  "10")) 				
			else "0000";
			
green <= '0' &  "000"  when (gameover_out = '1') else
			'1' &  "000"  when (intro_out = '1') else
			'1' & "000"  when (green_coin = '1' and (state =  "10")) 	else
			green_bird  when ((green_bird(0) = '1' or green_bird(1) = '1' or green_bird(2) = '1' or green_bird(3) = '1') 
			and (state =  "01" or state =  "10")) 	else
			'0' &  "000" when (lives_out = '1') 	else
         '1' &  "000"  when (green_pipe = '1' and (state =  "01" or state =  "10")) 	else
         '1' &  "000"  when (score_out = '1' and (state =  "01" or state =  "10"))					
			else "0000";
			
blue <= 	'0' &  "000"  when (gameover_out = '1') else
			'0' &  "000"  when (intro_out = '1') else
			'1' & "000" when (blue_coin = '1' and (state =  "10")) 	else
			blue_bird  when ((blue_bird(0) = '1' or blue_bird(1) = '1' or blue_bird(2) = '1' or blue_bird(3) = '1') 
			and (state =  "01" or state =  "10")) else
			'0' &  "000" when (lives_out = '1') else
         '1' &  "000"  when (score_out = '1'  and (state =  "01" or state =  "10")) 
			else "0000";

END behavior;

