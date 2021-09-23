library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


ENTITY bird IS
	PORT
		(click, vert_sync_out, enable, reset	: IN std_logic;
        pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  speed_on						: IN integer;
		  red_bird, green_bird, blue_bird 			: OUT std_logic;
		  bird_y, bird_size: OUT std_logic_vector(9 DOWNTO 0);
		  bird_x : OUT std_logic_vector(10 DOWNTO 0)
		  );		
END bird;

architecture behavior of bird is

SIGNAL bird_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL bird_y_pos				: std_logic_vector(9 DOWNTO 0):= CONV_STD_LOGIC_VECTOR(240, 10);
SiGNAL bird_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL bird_y_motion			: std_logic_vector(9 DOWNTO 0);
SIGNAL prev_state 			: std_logic;
SIGNAL start, restart : std_logic;
SIGNAL count : std_logic_vector(9 DOWNTO 0);
SIGNAL drop : std_logic_vector(9 DOWNTO 0); 	

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(16,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
bird_x_pos <= CONV_STD_LOGIC_VECTOR(150,11);
bird_on <= '1' when ( ('0' & bird_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & bird_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & bird_y_pos <= pixel_row + size) and ('0' & pixel_row <= bird_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
--red_bird <=  not bird_on;
--green_bird <=	not bird_on;
--blue_bird <=  bird_on;

red_bird <= bird_on when speed_on = 2 else
				bird_on 	  when speed_on = 4 else 
				'0'			when speed_on = 6 else 
				bird_on		when speed_on = 8 else '1';		
				
green_bird <= bird_on when speed_on = 2 else
				bird_on 	  when speed_on = 4 else 
				bird_on when speed_on = 6 else 
				'0'	when speed_on = 8 else '0';

blue_bird <= bird_on when speed_on = 2 else
				'0' 	  when speed_on = 4 else 
				'1' 			when speed_on = 6 else
				bird_on	when speed_on = 8 else bird_on;


bird_x <= bird_x_pos;
bird_y <= bird_y_pos;
bird_size <= size;


Move_Bird: process (vert_sync_out) 

begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync_out)) then
		if (reset = '1') then
			bird_y_pos <= CONV_STD_LOGIC_VECTOR(240, 10);
			drop <= (others => '0'); 
			count <= (others => '0');
			bird_y_motion <= (others => '0');
			prev_state <= '0';
			start <= '0'; 
		elsif (reset = '0'  and enable = '1') then
			-- Bounce off top or bottom of the screen
			if (start <= '0') then
				if (bird_y_pos <= size) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(1,10);
				elsif ((click = '1' and (bird_y_pos > 35+size)) and (prev_state = '0')) then
					start <= '1';
				elsif ('0' & bird_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
				  drop <= CONV_STD_LOGIC_VECTOR(0,10);
				  elsif (drop <= CONV_STD_LOGIC_VECTOR(1,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
				  drop <= drop + 1;
				elsif (drop <= CONV_STD_LOGIC_VECTOR(2,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(1,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(3,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(4,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(3,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(5,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(4,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(6,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(5,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(7,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(6,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(8,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(7,10);
				  drop <= drop + 1;
				 elsif (drop <= CONV_STD_LOGIC_VECTOR(9,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(8,10);
				  drop <= drop + 1;
					elsif (drop <= CONV_STD_LOGIC_VECTOR(10,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(9,10);
				  drop <= drop + 1;
					elsif (drop <= CONV_STD_LOGIC_VECTOR(11,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(10,10);
				  drop <= drop + 1;
					elsif (drop <= CONV_STD_LOGIC_VECTOR(12,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(11,10);
				  drop <= drop + 1;
					elsif (drop <= CONV_STD_LOGIC_VECTOR(13,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(12,10);
				  drop <= drop + 1;
					elsif (drop <= CONV_STD_LOGIC_VECTOR(14,10)) then
				  bird_y_motion <= CONV_STD_LOGIC_VECTOR(13,10);
				  drop <= drop + 1;
				  else
						bird_y_motion <= CONV_STD_LOGIC_VECTOR(14,10);
				end if;
				  
			
			elsif (start <= '1') or restart <= '1' then
					restart <= '0';
					drop <= CONV_STD_LOGIC_VECTOR(0,10);
					if (bird_y_pos <= size + size) then
					start <= '0';
					elsif count <= CONV_STD_LOGIC_VECTOR(3,10) then
					bird_y_motion <=  CONV_STD_LOGIC_VECTOR(-6,10);
					count <= count + 1;
						if (click = '1')  and (prev_state = '0') then
							restart <= '1';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
					elsif count <= CONV_STD_LOGIC_VECTOR(6,10) then
						bird_y_motion <=  CONV_STD_LOGIC_VECTOR(-5,10);
						count <= count + 1;
							if (click = '1')  and (prev_state = '0') then
							restart <= '1';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
					elsif count <= CONV_STD_LOGIC_VECTOR(9,10) then
						bird_y_motion <=  CONV_STD_LOGIC_VECTOR(-4,10);
						count <= count + 1;
							if (click = '1')  and (prev_state = '0') then
							restart <= '1';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
					elsif count <= CONV_STD_LOGIC_VECTOR(12,10) then
						bird_y_motion <=  CONV_STD_LOGIC_VECTOR(-3,10);
						count <= count + 1;
						if (click = '1')  and (prev_state = '0') then
							restart <= '1';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
					elsif count <= CONV_STD_LOGIC_VECTOR(15,10) then
						bird_y_motion <=  CONV_STD_LOGIC_VECTOR(-2,10);
						count <= count + 1;
						if (click = '1')  and (prev_state = '0') then
							restart <= '1';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
					else
						bird_y_motion <=  CONV_STD_LOGIC_VECTOR(-1,10);
						count <= count + 1;
						if (click = '1')  and (prev_state = '0') then
							restart <= '1';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
						
						if count = CONV_STD_LOGIC_VECTOR(19,10) then
							start <= '0';
							count <= CONV_STD_LOGIC_VECTOR(0,10);
						end if;
					end if;
				end if;
		  
			-- Compute next bird Y position
			bird_y_pos <= bird_y_pos + bird_y_motion;
			prev_state <= click;
		end if;
	end if;
end process Move_Bird;

END behavior;

