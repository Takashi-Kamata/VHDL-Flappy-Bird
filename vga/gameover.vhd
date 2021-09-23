LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY gameover IS
	PORT
		( 
				clock				: 	IN STD_LOGIC ;
				endscore			: IN std_logic_vector(11 downto 0);
				pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
				state : in std_logic_vector(1 downto 0);
				rom_mux_output		:	OUT STD_LOGIC
		  );		
END gameover;

architecture behavior of gameover is

	COMPONENT char_rom IS
	PORT
	(
		character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock				: 	IN STD_LOGIC ;
		rom_mux_output		:	OUT STD_LOGIC
	);
	END COMPONENT;
	signal address_a, address_b, address_c: std_LOGIC_VECTOR(5 downto 0);
	signal temp_a, temp_b, temp_c : std_logic;
	signal highscore_v : std_logic_vector(11 downto 0) ;
	signal highscore_flag : std_logic;
	begin
	
a:  char_rom port map (character_address => address_a, font_row => pixel_row(4 downto 2), 
	font_col => pixel_column(4 downto 2), clock=> clock, rom_mux_output =>TEMP_A);
	
B:  char_rom port map (character_address => address_b, font_row => pixel_row(4 downto 2), 
	font_col => pixel_column(4 downto 2), clock=> clock, rom_mux_output =>TEMP_B);
	
C:  char_rom port map (character_address => address_C, font_row => pixel_row(6 downto 4), 
	font_col => pixel_column(6 downto 4), clock=> clock, rom_mux_output =>TEMP_C);
	
	
	Death: process(state)
	begin
		if (state = "11" and highscore_flag = '0') then
			highscore_flag <= '1';
			if (endscore > highscore_v) then
				highscore_v <= endscore;
			end if;
		elsif (highscore_flag = '1' and state="00") then
			highscore_flag <= '0';
		end if;
	
	end process Death;

	
	--address <= "110000"  when (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 240) else ("100000");
	Score: process(pixel_row, pixel_column)
	begin
		-- game over
		if (pixel_row(9 downto 7) = 48 and pixel_column(9 downto 7) = 48) then
			address_c <= "000111";
		elsif (pixel_row(9 downto 7) = 48 and pixel_column(9 downto 7) = 49) then
			address_c <= "000001";
		elsif (pixel_row(9 downto 7) = 48 and pixel_column(9 downto 7) = 50) then
			address_c <= "001101";
		elsif (pixel_row(9 downto 7) = 48 and pixel_column(9 downto 7) = 51) then
			address_c <= "000101";
	
		elsif (pixel_row(9 downto 7) = 49 and pixel_column(9 downto 7) = 48) then
			address_c <= "001111";
		elsif (pixel_row(9 downto 7) = 49 and pixel_column(9 downto 7) = 49) then
			address_c <= "010110";
		elsif (pixel_row(9 downto 7) = 49 and pixel_column(9 downto 7) = 50) then
			address_c <= "000101";
		elsif (pixel_row(9 downto 7) = 49 and pixel_column(9 downto 7) = 51) then
			address_c <= "010010";
		elsif (pixel_row(9 downto 7) = 49 and pixel_column(9 downto 7) = 52) then
			address_c <= "100001";
			
		else 
			address_c <= "100000";
		end if;

		-- high score
		if (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 100) then
			address_a <= "001000"; -- H
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 101) then
			address_a <= "001001"; -- I
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 102) then
			address_a <= "000111"; -- G
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 103) then
			address_a <= "001000"; -- H
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 104) then
			address_a <= "100000"; -- space
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 105) then
			address_a <= "010011"; -- S
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 106) then
			address_a <= "000011"; -- C
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 107) then
			address_a <= "001111"; -- O
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 108) then
			address_a <= "010010"; -- R
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 109) then
			address_a <= "000101"; -- E
		
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 111) then
			address_a <=  conv_std_logic_vector(48 + conv_integer(unsigned(highscore_v(11 downto 8))) , 6);
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 112) then
			address_a <= conv_std_logic_vector(48 + conv_integer(unsigned(highscore_v(7 downto 4))) , 6);
		elsif (pixel_row(9 downto 5) = 106 and pixel_column(9 downto 5) = 113) then
			address_a <= conv_std_logic_vector(48 + conv_integer(unsigned(highscore_v(3 downto 0))) , 6);
			
		-- death score
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 100) then
			address_a <= "010011";
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 101) then
			address_a <= "000011";
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 102) then
			address_a <= "001111";
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 103) then
			address_a <= "010010";
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 104) then
			address_a <= "000101";			
		
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 111) then
			address_a <=  conv_std_logic_vector(48 + conv_integer(unsigned(endscore(11 downto 8))) , 6);
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 112) then
			address_a <= conv_std_logic_vector(48 + conv_integer(unsigned(endscore(7 downto 4))) , 6);
		elsif (pixel_row(9 downto 5) = 107 and pixel_column(9 downto 5) = 113) then
			address_a <= conv_std_logic_vector(48 + conv_integer(unsigned(endscore(3 downto 0))) , 6);
		
		else 
			address_a <= "100000";
		end if;

		-- menu
		if (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 100) then
			address_b <= "000011";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 101) then
			address_b <= "001100";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 102) then
			address_b <= "001001";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 103) then
			address_b <= "000011";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 104) then
			address_b <= "001011";
		
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 105) then
			address_b <= "011111";
		
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 106) then
			address_b <= "001101";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 107) then
			address_b <= "000101";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 108) then
			address_b <= "001110";
		elsif (pixel_row(9 downto 5) = 109 and pixel_column(9 downto 5) = 109) then
			address_b <= "010101";
		else
			address_b <= "100000";
		end if;
		
		if state = "11" then 
			rom_mux_output <= (temp_a or temp_b or temp_c);
		else 
			rom_mux_output <= '0';
		end if;
		
	end process Score;


	
END behavior;
