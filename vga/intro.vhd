LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY display_intro IS
	PORT
		( 
				clock				: 	IN STD_LOGIC ;
				pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
				state : in std_logic_vector(1 downto 0);
				rom_mux_output		:	OUT STD_LOGIC
		  );		
END display_intro;

architecture behavior of display_intro is

	COMPONENT char_rom IS
	PORT
	(
		character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock				: 	IN STD_LOGIC ;
		rom_mux_output		:	OUT STD_LOGIC
	);
	END COMPONENT;
	signal address_a, address_b: std_LOGIC_VECTOR(5 downto 0);
	signal temp_a, temp_b : std_logic;
	
	
	
	begin
	
a:  char_rom port map (character_address => address_a, font_row => pixel_row(5 downto 3), 
	font_col => pixel_column(5 downto 3), clock=> clock, rom_mux_output =>TEMP_A);
	
B:  char_rom port map (character_address => address_b, font_row => pixel_row(3 downto 1), 
	font_col => pixel_column(3 downto 1), clock=> clock, rom_mux_output =>TEMP_B);
	

	
	--address <= "110000"  when (pixel_row(9 downto 5) = 0 and pixel_column(8 downto 4) = 240) else ("100000");
	Score: process(pixel_row, pixel_column)
	begin
	if state = "00" then
		if (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 48) then
			address_a <= "000110";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 49) then
			address_a <= "001100";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 50) then
			address_a <= "000001";
		elsif (pixel_row(9 downto 6) = 48 and ((pixel_column(9 downto 6) = 51) or (pixel_column(9 downto 6) = 52))) then
			address_a <= "010000";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 53) then
			address_a <= "011001";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 54) then
			address_a <= "000010";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 55) then
			address_a <= "001001";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 56) then
			address_a <= "010010";
		elsif (pixel_row(9 downto 6) = 48 and pixel_column(9 downto 6) = 57) then
			address_a <= "000100";
		else 
			address_a <= "100000";
			end if;
			
			--instructions
			--line 1
		
		if (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 106) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 107) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 108) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 109) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 110) then
			address_b <= "001011";
		
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 112) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 113) then
			address_b <= "001111";
		
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 115) then
			address_b <= "000110";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 116) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 117) then
			address_b <= "011001";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 118) then
			address_b <= "101100";
		
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 120) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 121) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 122) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 123) then
			address_b <= "001110";
		elsif (pixel_row(8 downto 4) = 108 and pixel_column(8 downto 4) = 124) then
			address_b <= "000111";
	
			
			
			--line 2
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 106) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 107) then
			address_b <= "001000";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 108) then
			address_b <= "010010";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 109) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 110) then
			address_b <= "010101";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 111) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 112) then
			address_b <= "001000";
		
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 114) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 115) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 116) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 117) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 118) then
			address_b <= "010011";
		
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 120) then
			address_b <= "010111";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 121) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 122) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 109 and pixel_column(8 downto 4) = 123) then
			address_b <= "001100";

		
		--line 3
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 106) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 107) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 108) then
			address_b <= "010110";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 109) then
			address_b <= "000101";
		
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 111) then
			address_b <= "110001";
		
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 113) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 114) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 115) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 116) then
			address_b <= "001110";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 117) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 118) then
			address_b <= "101100";
		
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 120) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 121) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 122) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 123) then
			address_b <= "001110";
		elsif (pixel_row(8 downto 4) = 110 and pixel_column(8 downto 4) = 124) then
			address_b <= "000111";
			
		--line 4
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 106) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 107) then
			address_b <= "001000";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 108) then
			address_b <= "010010";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 109) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 110) then
			address_b <= "010101";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 111) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 112) then
			address_b <= "001000";
		
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 114) then
			address_b <= "000001";
		
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 116) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 117) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 118) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 119) then
			address_b <= "001110";
		
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 121) then
			address_b <= "010111";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 122) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 123) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 111 and pixel_column(8 downto 4) = 124) then
			address_b <= "001100";
			
		--line 5
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 106) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 107) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 108) then
			address_b <= "010110";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 109) then
			address_b <= "000101";
		
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 111) then
			address_b <= "110001";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 112) then
			address_b <= "110000";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 113) then
			address_b <= "100001";
		
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 115) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 116) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 117) then
			address_b <= "010101";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 118) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 119) then
			address_b <= "001000";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 120) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 121) then
			address_b <= "001110";
		elsif (pixel_row(8 downto 4) = 112 and pixel_column(8 downto 4) = 122) then
			address_b <= "000111";

		
		--line 6
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 106) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 107) then
			address_b <= "001000";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 108) then
			address_b <= "000101";
		
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 110) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 111) then
			address_b <= "010010";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 112) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 113) then
			address_b <= "010101";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 114) then
			address_b <= "001110";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 115) then
			address_b <= "000100";
		
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 117) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 118) then
			address_b <= "010010";
		
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 120) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 121) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 122) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 123) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 113 and pixel_column(8 downto 4) = 124) then
			address_b <= "010011";

			
		--line 7
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 106) then
			address_b <= "010111";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 107) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 108) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 109) then
			address_b <= "001100";
		
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 111) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 112) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 113) then
			address_b <= "010011";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 114) then
			address_b <= "000101";
		
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 116) then
			address_b <= "011001";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 117) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 118) then
			address_b <= "010101";
		
		elsif (pixel_row(8 downto 4) = 114 and pixel_column(8 downto 4) = 120) then
			address_b <= "000001";

		--line 8
		
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 106) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 107) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 108) then
			address_b <= "000110";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 109) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 110) then
			address_b <= "101110";
		
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 112) then
			address_b <= "010011";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 113) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 114) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 115) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 116) then
			address_b <= "000100";
		
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 118) then
			address_b <= "010111";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 119) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 120) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 115 and pixel_column(8 downto 4) = 121) then
			address_b <= "001100";

		--line 9
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 106) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 107) then
			address_b <= "001110";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 108) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 109) then
			address_b <= "010010";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 110) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 111) then
			address_b <= "000001";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 112) then
			address_b <= "010011";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 113) then
			address_b <= "000101";
		
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 115) then
			address_b <= "001111";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 116) then
			address_b <= "010110";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 117) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 118) then
			address_b <= "010010";
		
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 120) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 121) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 122) then
			address_b <= "001101";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 123) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 116 and pixel_column(8 downto 4) = 124) then
			address_b <= "101110";
			
			--line 10
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 107) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 108) then
			address_b <= "110000";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 109) then
			address_b <= "011111";
			
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 110) then
			address_b <= "010010";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 111) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 112) then
			address_b <= "010011";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 113) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 114) then
			address_b <= "010100";
		
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 116) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 117) then
			address_b <= "110010";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 118) then
			address_b <= "011111";
			
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 119) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 120) then
			address_b <= "000001";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 121) then
			address_b <= "010101";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 122) then
			address_b <= "010011";
		elsif (pixel_row(8 downto 4) = 118 and pixel_column(8 downto 4) = 123) then
			address_b <= "000101";

		
			

			--how to begin
		elsif (pixel_row(8 downto 4) = 119 and ((pixel_column(8 downto 4) = 107) OR (pixel_column(8 downto 4) = 113))) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 108) then
			address_b <= "000101";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 109) then
			address_b <= "000110";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 110) then
			address_b <= "010100";
		
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 106) then
			address_b <= "010011";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 107) then
			address_b <= "010111";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 108) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 109) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 110) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 111) then
			address_b <= "001000";
			
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 111) then
			address_b <= "101101";
		
		
		
		elsif ((pixel_row(8 downto 4) = 119) and ((pixel_column(8 downto 4) = 112) OR (pixel_column(8 downto 4) = 115))) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 114) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 116) then
			address_b <= "001011";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 117) then
			address_b <= "011111";
			
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 118) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 119) then
			address_b <= "001100";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 120) then
			address_b <= "000001";
		elsif (pixel_row(8 downto 4) = 119 and pixel_column(8 downto 4) = 121) then
			address_b <= "011001";
			
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 112) then
			address_b <= "011111";
			
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 121) then
			address_b <= "101111";
			
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 122) then
			address_b <= "000111";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 123) then
			address_b <= "000001";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 124) then
			address_b <= "001101";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 125) then
			address_b <= "000101";

		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 113) then
			address_b <= "010000";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 114) then
			address_b <= "010010";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 115) then
			address_b <= "000001";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 116) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 117) then
			address_b <= "010100";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 118) then
			address_b <= "001001";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 119) then
			address_b <= "000011";
		elsif (pixel_row(8 downto 4) = 120 and pixel_column(8 downto 4) = 120) then
			address_b <= "000101";
			
		else
			address_b <= "100000";
		end if;

		if state = "00" then 
		rom_mux_output <= (temp_a or temp_b);
		else 
		rom_mux_output <= '0';
		end if;
	end if;
		
	end process Score;


	
END behavior;

