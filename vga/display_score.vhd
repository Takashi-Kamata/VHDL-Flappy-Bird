LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY display_score IS
	PORT
		( 
			clock, reset				: 	IN STD_LOGIC ;
			scored						: 	IN STD_LOGIC ;
			pixel_row, pixel_column	:	IN std_logic_vector(9 DOWNTO 0);
			coin							:	IN std_logic;
			speed							:  IN integer;
			display_out					:	OUT STD_LOGIC;
			score							:	OUT integer;
			endscore						: 	OUT std_logic_vector(11 downto 0)
		  );		
END display_score;

architecture behavior of display_score is

	COMPONENT char_rom IS
	PORT
	(
		character_address		:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock						: 	IN STD_LOGIC ;
		rom_mux_output			:	OUT STD_LOGIC
	);
	END COMPONENT;
	
	signal address: std_LOGIC_VECTOR(5 downto 0);
	signal score_q: integer:= 0;
	signal score_count: integer:= 0;
	signal tens: integer:= 0;
	signal hunds: integer:= 0;
	signal coin_sample: std_LOGIC;
	signal score_sample: std_LOGIC;
	signal endscore_v : std_logic_vector(11 downto 0);

	
	begin
	
	a:  char_rom port map (character_address => address, font_row => pixel_row(4 downto 2), 
	font_col => pixel_column(4 downto 2), clock=> clock, rom_mux_output =>display_out);

			
	score <= score_q;
	endscore <= endscore_v;
	
	--address <= "110000"  when (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 240) else ("100000");

	Score_Calculate: process(pixel_row, pixel_column)
	begin
		if (reset = '1') then
			address <= "100000";
		elsif (reset = '0') then
			if (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 240) then
				address <= conv_std_logic_vector(48 + hunds , 6);
				endscore_v(11 downto 8) <= conv_std_logic_vector(hunds, 4); 
			elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 241) then
				address <= conv_std_logic_vector(48 + tens , 6);
				endscore_v (7 downto 4) <= conv_std_logic_vector(tens, 4);
			elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 242) then
				address <=  conv_std_logic_vector(48 + score_count , 6);
				endscore_v (3 downto 0) <= conv_std_logic_vector(score_count, 4);
			elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 235) then
				address <= conv_std_logic_vector(48 + (speed/2) , 6);

			elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 234) then
				address <= "010110";

			elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 233) then
				address <=  "001100";
			else
				address <= "100000";
			end if;

		end if;
	end process Score_Calculate;
	
	Count: process(clock, scored, reset, coin)
	begin
		if (reset = '1') then
			score_count <= 0;
			score_q <= 0;
			tens <= 0;
			hunds <= 0;
		elsif (rising_edge(clock)) then
			if (scored = '1' and score_sample = '0') then
				score_sample <= '1';
				if (score_count < 9) then
					score_count <= score_count + 1;
					score_q <= score_q + 1;
				end if;
				if (score_count >= 9) then
					tens <= tens + 1;
					score_count <= 0;
				elsif (tens = 10) then
					hunds <= hunds + 1;
					tens <= 0;
				end if;
			elsif (scored = '0' and score_sample = '1') then
				score_sample <= '0';
			end if;
			if (coin = '1' and coin_sample = '0') then
				coin_sample <= '1';
				tens <= tens + 1;
				if (tens = 10) then 
					hunds <= hunds + 1;
					tens <= 0;
				end if;
			elsif (coin = '0' and coin_sample = '1') then
				coin_sample <= '0';
			end if;
		end if;

	end process Count;

END behavior;

