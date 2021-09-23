LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.NUMERIC_STD.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY bird_rom IS
	PORT
	(
		vert_sync_out					: 	IN STD_LOGIC ;
		pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		character_address	:	IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		bird_x : IN  std_logic_vector(10 DOWNTO 0);
		bird_y	:	IN std_logic_vector(9 DOWNTO 0);
		sw1, sw2 : in std_logic;
		clock: in std_logic;
		rom_mux_output: 	OUT std_logic_vector(11 downto 0)
	);
END bird_rom;


ARCHITECTURE SYN OF bird_rom IS

	SIGNAL rom_data		: STD_LOGIC_VECTOR (11 DOWNTO 0);
	SIGNAL rom_address	: STD_LOGIC_VECTOR (11 DOWNTO 0);

	COMPONENT altsyncram
	GENERIC (
		address_aclr_a			: STRING;
		clock_enable_input_a	: STRING;
		clock_enable_output_a	: STRING;
		init_file				: STRING;
		intended_device_family	: STRING;
		lpm_hint				: STRING;
		lpm_type				: STRING;
		numwords_a				: NATURAL;
		operation_mode			: STRING;
		outdata_aclr_a			: STRING;
		outdata_reg_a			: STRING;
		widthad_a				: NATURAL;
		width_a					: NATURAL;
		width_byteena_a			: NATURAL
	);
	PORT (
		clock0		: IN STD_LOGIC ;
		address_a	: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		q_a			: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
	END COMPONENT;
	
	signal num : integer := 1;
	signal counter : std_logic_vector(9 downto 0) := "0000000000";
	signal size : integer := 32;
	signal x : integer := 100;
	signal y : integer := 100;
	
BEGIN

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_aclr_a => "NONE",
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => "all.mif",
		intended_device_family => "Cyclone III",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => 4096, -- num of entry
		operation_mode => "ROM",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		widthad_a => 12, -- length of address in bits
		width_a => 12,  -- length of data in bits
		width_byteena_a => 1
	)
	PORT MAP (
		clock0 => clock,
		address_a => rom_address,
		q_a => rom_data
	);
	
	num <= 0 when (sw1 = '1' and sw2 = '0') else
			1 when (sw1 = '0' and sw2 = '1') else
			6 when (sw1 = '1' and sw2 = '1') else
			3 when (sw1 = '0' and sw2 = '0');
	rom_address <=  conv_std_logic_vector((size * CONV_INTEGER(pixel_row - bird_y - 16 + 1)) + 
													CONV_INTEGER(pixel_column + 1 - bird_x - 16) + (num * 1024),12);
	rom_mux_output <= rom_data when ((pixel_row >= bird_y-16) 
										and (pixel_row < (bird_y-16+size)) 
										and (pixel_column >= bird_x-16) 
										and (pixel_column <(bird_x-16+size))) 
										else "000000000000";
	counter <= (counter + 1) when (counter <= "001111111110") and ((pixel_row >= bird_y-16) 
										and (pixel_row < (bird_y-16+size)) 
										and (pixel_column >= bird_x-16) 
										and (pixel_column <(bird_x-16+size))) 
							else "0000000000";
	

END SYN;