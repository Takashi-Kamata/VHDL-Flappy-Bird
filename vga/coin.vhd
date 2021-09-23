LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY coin IS
	PORT
		( 	Clk								: IN std_logic;
			reset,  coin 						: IN std_logic;
			enable							: IN std_logic;
			score, speed_on							:	IN integer;
			pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			coin_enable, red_coin, green_coin, blue_coin	: OUT std_logic;
			coin_x, coin_y, coin_h, coin_v: OUT std_logic_vector(10 DOWNTO 0)
		 );		
END coin;

architecture behavior of coin is

SIGNAL coin_on					: std_logic;
SIGNAL size_h 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size_v 					: std_logic_vector(10 DOWNTO 0);  

SIGNAL coin_y_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(200,11) ;
SIGNAL coin_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11) + 200;
SIGNAL coin_x_motion			: std_logic_vector(10 DOWNTO 0);

SIGNAL random1_y			: std_logic_vector(10 DOWNTO 0);
SIGNAL random2_y			: std_logic_vector(10 DOWNTO 0);
SIGNAL Currstate1 		: std_logic_vector (5 DOWNTO 0) := (0 => '1', OTHERS =>'0');
SIGNAL Currstate2 		: std_logic_vector (5 DOWNTO 0) := (3 => '1', OTHERS =>'0');

SIGNAL Nextstate1: std_logic_vector (5 DOWNTO 0);
SIGNAL feedback1: std_logic;
SIGNAL Nextstate2: std_logic_vector (5 DOWNTO 0);
SIGNAL feedback2: std_logic;
SIGNAL count: std_logic_vector (2 DOWNTO 0);
signal coin_hit: std_logic;

BEGIN      

size_h <= CONV_STD_LOGIC_VECTOR(10,11);
size_v <= CONV_STD_LOGIC_VECTOR(10,11);

coin_on <= '1' when (('0' & coin_x_pos <= '0' & pixel_column + size_h) and ('0' & pixel_column <= '0' & coin_x_pos + size_h) 
					and ('0' & coin_y_pos <= pixel_row + size_v ) and ('0' & pixel_row <= coin_y_pos + size_v ) ) and coin = '0'
					else	
					'0';

-- Colour
red_coin <=  coin_on;
green_coin <= coin_on;
blue_coin <=  '0';

-- For collision
coin_x <= coin_x_pos;
coin_y <= coin_y_pos;

coin_h <= size_h;
coin_v <= size_v;

Move_coin: process (Clk)  
begin
	if (rising_edge(Clk)) then
		if (reset = '1') then
			-- Reset position
			 coin_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + 200;
		elsif (reset = '0'and enable = '1') then
			if (coin_x_pos + size_h >=  0 ) then
				coin_enable <= '0';
				coin_x_motion <= - CONV_STD_LOGIC_VECTOR(1 + speed_on, 11) ;
				coin_x_pos <= coin_x_pos + coin_x_motion;				
			elsif (coin_x_pos + size_h <= 0) then 
				coin_x_pos 	<= CONV_STD_LOGIC_VECTOR(639,11) + 50;
				coin_enable <= '1';
			end if;
					
		end if;
	end if;
end process Move_coin;



END behavior;
--
--@@ -0,0 +1,104 @@
--LIBRARY IEEE;
--USE IEEE.STD_LOGIC_1164.all;
--USE IEEE.STD_LOGIC_ARITH.all;
--USE IEEE.STD_LOGIC_SIGNED.all;
--
--
--ENTITY coin IS
--	PORT
--		( 	Clk								: IN std_logic;
--			reset							: IN std_logic;
--			enable							: IN std_logic;
--			score							:	IN integer;
--			pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
--			red_coin, green_coin, blue_coin 			: OUT std_logic;
--			coin_x, coin_y, coin_h, coin_v: OUT std_logic_vector(10 DOWNTO 0)
--		 );		
--END coin;
--
--architecture behavior of coin is
--
--SIGNAL coin_on					: std_logic;
--SIGNAL size_h 					: std_logic_vector(10 DOWNTO 0);  
--SIGNAL size_v 					: std_logic_vector(10 DOWNTO 0);  
--
--SIGNAL coin_y_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(200,11) ;
--SIGNAL coin_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11) + 150;
--SIGNAL coin_x_motion			: std_logic_vector(10 DOWNTO 0);
--
--SIGNAL random1_y			: std_logic_vector(10 DOWNTO 0);
--SIGNAL random2_y			: std_logic_vector(10 DOWNTO 0);
--SIGNAL Currstate1 		: std_logic_vector (5 DOWNTO 0) := (0 => '1', OTHERS =>'0');
--SIGNAL Currstate2 		: std_logic_vector (5 DOWNTO 0) := (3 => '1', OTHERS =>'0');
--
--SIGNAL Nextstate1: std_logic_vector (5 DOWNTO 0);
--SIGNAL feedback1: std_logic;
--SIGNAL Nextstate2: std_logic_vector (5 DOWNTO 0);
--SIGNAL feedback2: std_logic;
--
--
--BEGIN      
--
--size_h <= CONV_STD_LOGIC_VECTOR(15,11);
--size_v <= CONV_STD_LOGIC_VECTOR(20,11);
--
--coin_on <= '1' when (('0' & coin_x_pos <= '0' & pixel_column + size_h) and ('0' & pixel_column <= '0' & coin_x_pos + size_h) 
--					and ('0' & coin_y_pos <= pixel_row + size_v ) and ('0' & pixel_row <= coin_y_pos + size_v ) )
--					else	
--					'0';
--
---- Colour
--red_coin <=  coin_on;
--green_coin <= (not coin_on);
--blue_coin <=  not coin_on;
--
---- For collision
--coin_x <= coin_x_pos;
--coin_y <= coin_y_pos;
--
--coin_h <= size_h;
--coin_v <= size_v;
--
--
--Move_coin: process (Clk)  
--begin
--	if (rising_edge(Clk) and enable = '1') then		
--		if (reset = '1') then
--			-- Reset seed 
--			Currstate1 <= (0 => '1', OTHERS =>'0');
--			Currstate2 <= (3 => '1', OTHERS =>'0');
--			feedback1 <= '0';
--			Nextstate1 <= feedback1 & "00000";
--			feedback2 <= '0';
--			Nextstate2 <= feedback2 & "00000";
--			random1_y <= B"0000" & (Currstate1) &B"0";
--			random2_y <= B"0000" & (Currstate2) &B"0";
--			
--			-- Reset position
--			coin_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + size_h + 150;
--			
--		elsif (reset = '0') then
--			  
--			feedback1 <= Currstate1(3) XOR Currstate1(2) XOR Currstate1(0);
--			Nextstate1 <= feedback1 & Currstate1(5 DOWNTO 1);
--			feedback2 <= Currstate2(3) XOR Currstate2(2) XOR Currstate2(0);
--			Nextstate2 <= feedback2 & Currstate2(5 DOWNTO 1);
--			random1_y <= B"0000" & (Currstate1) &B"0";
--			random2_y <= B"0000" & (Currstate2) &B"0";
--		
--			if (coin_x_pos + size_h >=  0 ) then
--				coin_x_motion <= - CONV_STD_LOGIC_VECTOR(1,11);
--				coin_x_pos <= coin_x_pos + coin_x_motion;
--				
--			elsif (coin_x_pos + size_h <= 0) then 
--				coin_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + size_h;
--				Currstate1 <= Nextstate1;
--			end if;
--		end if;
--	end if;
--end process Move_coin;
--
--
--
--END behavior;
