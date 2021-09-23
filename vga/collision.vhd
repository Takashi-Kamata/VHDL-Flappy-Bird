LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY collision IS
	PORT
		(bird_y, bird_size : IN std_logic_vector(9 DOWNTO 0);
		pipe1_y, pipe2_y, pipe3_y, pipe4_y, pipe_h, pipe1_v, pipe2_v , pipe3_v, pipe4_v : IN std_logic_vector(10 DOWNTO 0);
		 bird_x, pipe1_x, pipe2_x, pipe3_x, pipe4_x: IN std_logic_vector(10 DOWNTO 0);
		 coin_x, coin_y, coin_v, coin_h: IN std_logic_vector(10 downto 0);
		vert_sync, coin_enable	: IN std_logic;
		speed_on		: IN integer;
		  gameover, point, coin,hit		: OUT std_logic);		
END collision;

Architecture behaviour of collision is

signal count : std_logic_vector(9 DOWNTO 0);
signal coin_t : std_logic;
signal coinappear_v : std_logic;

begin

							
Game_Point:process(vert_sync)
begin
	if (rising_edge(vert_sync)) then
	

						
		if ((((bird_x + bird_size) > (pipe1_x - pipe_h)) and ((bird_x - bird_size) < (pipe1_x + pipe_h)))	or (((bird_x + bird_size) > (pipe3_x - pipe_h)) and ((bird_x - bird_size) < (pipe3_x + pipe_h)))) then
			point <= '1';
		elsif ((((bird_y + bird_size) > (coin_y - coin_v)) and ((bird_y - bird_size) < (coin_y + coin_v))) and (((bird_x + bird_size) > (coin_x - coin_h)) and ((bird_x - bird_size) < (coin_x + coin_h)))) then
			coin <= '1';
		else
			point <= '0';
		end if;
		
		if (coin_enable = '1') then
			coin <= '0';
		end if;

		
		
		if (((bird_x + bird_size) >= (pipe1_x - pipe_h) and (bird_x + bird_size) <= (pipe1_x + pipe_h) and -- pipe 1 & 2 x
			((bird_y - bird_size) <= (pipe1_y + pipe1_v) or (bird_y + bird_size) >= (pipe2_y - pipe2_v)))	 -- pipe 1 & 2 y
			or ((bird_x + bird_size) >= (pipe3_x - pipe_h) and (bird_x + bird_size) <= (pipe3_x + pipe_h) and -- pipe 3 & 4 x
			((bird_y - bird_size) <= (pipe3_y + pipe3_v)	 or (bird_y + bird_size) >= (pipe4_y - pipe4_v))))	 then -- pipe 3 & 4 y
			hit <= '1' ;
		else
			hit <= '0' ;
		
		if ((bird_y + bird_size) >= (479 - bird_size)) then
			gameover <= '1';
		else 
			gameover <= '0';
		end if;
		end if;
		
	end if;

end process Game_Point;
end architecture behaviour;