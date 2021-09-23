LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;


ENTITY display_lives IS
	PORT
		( 
			clock, reset				: 	IN STD_LOGIC ;
			lives_init			: 	IN integer ;
			hit							: IN STD_LOGIC;
			pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
			lives_out					:	OUT STD_LOGIC;
			gameover							:	OUT std_LOGIC
		  );		
END display_lives;

architecture behavior of display_lives is

	COMPONENT heart_rom IS
	PORT
	(
		character_address		:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		font_row, font_col	:	IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock						: 	IN STD_LOGIC ;
		rom_mux_output			:	OUT STD_LOGIC
	);
	END COMPONENT;
	
	signal address: std_LOGIC_VECTOR(5 downto 0);
	signal lives_left: integer := lives_init;
	
	begin
	
	a:  heart_rom port map (character_address => address, font_row => pixel_row(4 downto 2), 
	font_col => pixel_column(4 downto 2), clock=> clock, rom_mux_output =>lives_out);
	
	--address <= "110000"  when (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 240) else ("100000");

	Lives_Calculate: process(pixel_row, pixel_column)
	begin
		if (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 225) then
			if (lives_left > 0 and reset = '0') then
				address <= "000001";
			else 
				address <= "000000";
			end if;
			
		elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 226) then
			if (lives_left > 1 and reset = '0') then
				address <= "000001";
			else 
				address <= "000000";
			end if;
		elsif (pixel_row(9 downto 5) = 0 and pixel_column(9 downto 5) = 227) then
			if (lives_left > 2 and reset = '0') then
				address <= "000001";
			else 
				address <= "000000";
			end if;
		else
			address <= "000000";
		end if;
	end process Lives_Calculate;
	
	--lives <= lives_left;
	
	Death: process(hit)
	begin
		if (reset = '1') then
			lives_left <= lives_init;
			gameover <= '0';
		elsif (reset = '0') then
			if (rising_edge(hit) and (lives_left > 0)) then
				if (lives_left = 1) then
					lives_left <= lives_left - 1;
					gameover <= '1';
				else 
					gameover <= '0';
					lives_left <= lives_left - 1;
				end if;
				
				
			end if;
		end if;
	end process Death;
END behavior;

