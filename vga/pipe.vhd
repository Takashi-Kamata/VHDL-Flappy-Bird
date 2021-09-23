LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY pipe IS
	PORT
		( 	Clk							: IN std_logic;
			reset							: IN std_logic;
			enable						: IN std_logic;
			state							: IN std_logic_vector(1 downto 0);
			score							: IN integer;
			pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			red_pipe, green_pipe, 
			blue_pipe 					: OUT std_logic;
			speed_on						: OUT integer;
			pipe1_x, pipe1_y, pipe2_x, 
			pipe2_y, pipe3_x, pipe3_y, 
			pipe4_x, pipe4_y, pipe_h, 
			pipe1_v, pipe2_v, pipe3_v, 
			pipe4_v						: OUT std_logic_vector(10 DOWNTO 0)
		 );		
END pipe;

architecture behavior of pipe is

SIGNAL pipes_on					: std_logic;
SIGNAL size1_h 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size1_v 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size2_h 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size2_v 					: std_logic_vector(10 DOWNTO 0);  

SIGNAL pipe1_y_pos				: std_logic_vector(10 DOWNTO 0) := size1_v;
SIGNAL pipe1_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11) ;
SIGNAL pipe1_x_motion			: std_logic_vector(10 DOWNTO 0);

SIGNAL pipe2_y_pos				: std_logic_vector(10 DOWNTO 0) := 479 - size2_v;
SIGNAL pipe2_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11) ;
SIGNAL pipe2_x_motion			: std_logic_vector(10 DOWNTO 0);

SIGNAL size3_h 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size3_v 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size4_h 					: std_logic_vector(10 DOWNTO 0);  
SIGNAL size4_v 					: std_logic_vector(10 DOWNTO 0);  

SIGNAL pipe3_y_pos				: std_logic_vector(10 DOWNTO 0) := size3_v;
SIGNAL pipe3_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11) + 300 ;
SIGNAL pipe3_x_motion			: std_logic_vector(10 DOWNTO 0);

SIGNAL pipe4_y_pos				: std_logic_vector(10 DOWNTO 0) := 479 - size4_v;
SIGNAL pipe4_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(639,11) + 300 ;
SIGNAL pipe4_x_motion			: std_logic_vector(10 DOWNTO 0);

SIGNAL random1_y			: std_logic_vector(10 DOWNTO 0);
SIGNAL random2_y			: std_logic_vector(10 DOWNTO 0);
SIGNAL Currstate1 		: std_logic_vector (5 DOWNTO 0) := (0 => '1', OTHERS =>'0');
SIGNAL Currstate2 		: std_logic_vector (5 DOWNTO 0) := (3 => '1', OTHERS =>'0');

SIGNAL Nextstate1: std_logic_vector (5 DOWNTO 0);
SIGNAL feedback1: std_logic;
SIGNAL Nextstate2: std_logic_vector (5 DOWNTO 0);
SIGNAL feedback2: std_logic;

SIGNAL speed_on_v: integer;


BEGIN      


size1_h <= CONV_STD_LOGIC_VECTOR(30,11);
size1_v <= CONV_STD_LOGIC_VECTOR(20,11) + random1_y;
size2_h <= CONV_STD_LOGIC_VECTOR(30,11);
size2_v <= CONV_STD_LOGIC_VECTOR(124,11) - random1_y;
size3_h <= CONV_STD_LOGIC_VECTOR(30,11);
size3_v <= CONV_STD_LOGIC_VECTOR(20,11) + random2_y;
size4_h <= CONV_STD_LOGIC_VECTOR(30,11);
size4_v <= CONV_STD_LOGIC_VECTOR(124,11) - random2_y;



pipes_on <= '1' when (('0' & pipe1_x_pos <= '0' & pixel_column + size1_h) and ('0' & pixel_column <= '0' & pipe1_x_pos + size1_h) 
					and ('0' & pipe1_y_pos <= pixel_row + size1_v ) and ('0' & pixel_row <= pipe1_y_pos + size1_v ) )
					or ( ('0' & pipe2_x_pos <= '0' & pixel_column + size2_h) and ('0' & pixel_column <= '0' & pipe2_x_pos + size2_h) 
					and ('0' & pipe2_y_pos <= pixel_row + size2_v ) and ('0' & pixel_row <= pipe2_y_pos + size2_v ) )
					
					or (('0' & pipe3_x_pos <= '0' & pixel_column + size3_h) and ('0' & pixel_column <= '0' & pipe3_x_pos + size3_h) 
					and ('0' & pipe3_y_pos <= pixel_row + size3_v ) and ('0' & pixel_row <= pipe3_y_pos + size3_v ) )
					or ( ('0' & pipe4_x_pos <= '0' & pixel_column + size4_h) and ('0' & pixel_column <= '0' & pipe4_x_pos + size4_h) 
					and ('0' & pipe4_y_pos <= pixel_row + size4_v ) and ('0' & pixel_row <= pipe4_y_pos + size4_v ) )
					else	
					'0';

-- Colour
red_pipe <= '0';	
green_pipe <= pipes_on;
blue_pipe <=  '0';		
				
-- For collision
pipe1_x <= pipe1_x_pos;
pipe1_y <= pipe1_y_pos;

pipe2_x <= pipe2_x_pos;  
pipe2_y <= pipe2_y_pos;

pipe3_x <= pipe3_x_pos;
pipe3_y <= pipe3_y_pos;

pipe4_x <= pipe4_x_pos;  
pipe4_y <= pipe4_y_pos;

pipe_h <= size1_h;
pipe1_v <= size1_v;
pipe2_v <= size2_v;
pipe3_v <= size3_v;
pipe4_v <= size4_v;

speed_on_v <= 2 when (state = "10" and score < 6) else
				4 when (state = "10" and score >= 6 and score < 18) else
				6 when (state = "10" and score >= 18 and score < 30) else
				8 when (state = "10" and score >= 30) else 0;
Move_pipe: process (Clk)  
begin
	if (rising_edge(Clk)) then		
		if (reset = '1') then
			-- Reset seed 
			Currstate1 <= (0 => '1', OTHERS =>'0');
			Currstate2 <= (3 => '1', OTHERS =>'0');
			feedback1 <= '0';
			Nextstate1 <= feedback1 & "00000";
			feedback2 <= '0';
			Nextstate2 <= feedback2 & "00000";
			random1_y <= B"0000" & (Currstate1) &B"0";
			random2_y <= B"0000" & (Currstate2) &B"0";
			
			-- Reset position
			pipe1_x_pos <= CONV_STD_LOGIC_VECTOR(639,11);
			pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(639,11);
			pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + 300;
			pipe4_x_pos	<= CONV_STD_LOGIC_VECTOR(639,11) + 300;
			
		elsif (reset = '0' and enable = '1') then
			  
			feedback1 <= Currstate1(3) XOR Currstate1(2) XOR Currstate1(0);
			Nextstate1 <= feedback1 & Currstate1(5 DOWNTO 1);
			feedback2 <= Currstate2(3) XOR Currstate2(2) XOR Currstate2(0);
			Nextstate2 <= feedback2 & Currstate2(5 DOWNTO 1);
			random1_y <= B"0000" & (Currstate1) &B"0";
			random2_y <= B"0000" & (Currstate2) &B"0";
		
			if (pipe1_x_pos  >=  0 ) then
				pipe1_x_motion <= - CONV_STD_LOGIC_VECTOR(1 + speed_on_v,11) ;
				pipe1_x_pos <= pipe1_x_pos + pipe1_x_motion;

				pipe2_x_motion <= - CONV_STD_LOGIC_VECTOR(1 + speed_on_v,11);
				pipe2_x_pos <= pipe2_x_pos + pipe2_x_motion;
				
			elsif (pipe1_x_pos <= 0) then 
				pipe1_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + size1_h;
				pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + size2_h;
				Currstate1 <= Nextstate1;
			end if;
			
			if (pipe3_x_pos + size3_h >=  0 ) then
				
				pipe3_x_motion <= - CONV_STD_LOGIC_VECTOR(1 + speed_on_v,11);
				pipe3_x_pos <= pipe3_x_pos + pipe3_x_motion;

				pipe4_x_motion <= - CONV_STD_LOGIC_VECTOR(1  + speed_on_v,11);
				pipe4_x_pos <= pipe4_x_pos + pipe4_x_motion;
				
			elsif (pipe3_x_pos + size3_h <= 0) then 
				pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + size3_h;
				pipe4_x_pos <= CONV_STD_LOGIC_VECTOR(639,11) + size4_h;
				Currstate2 <= Nextstate2;
			end if;
		end if;
	speed_on <= speed_on_v;
	end if;

end process Move_pipe;




END behavior;

