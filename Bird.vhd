library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity bird is
  port (CLK, click: in std_logic;
	pixel_row, pixel_column: in std_logic_vector(9 downto 0);
	red, green, blue, g_o: out std_logic);
end entity bird;

architecture behavior of bird is
   signal size: std_logic_vector(9 downto 0);
   signal bird_x: std_logic_vector(9 downto 0);
   signal bird_y: std_logic_vector(9 downto 0);
   signal bird_on : std_logic;

begin

   size <= conv_std_logic_vector(20, 10);
   bird_x <= conv_std_logic_vector(274, 10);
   bird_y <= conv_std_logic_vector(240, 10);

	process(clk)
	   variable count: std_logic_vector(5 downto 0);
	   variable up: std_logic;
	
	begin
	  
	   if rising_edge(clk) then
		if (click = '0') and (up = '0') and (bird_y - size = 0) then
	   	  g_o <= '0';
		elsif (click = '0') and (up = '0') and (bird_y - size /= 0) then
		  bird_y <= bird_y - 1;
		elsif (click = '1') then
	   	  up := '1';
		end if;
	
		if (up = '1') then
	   	  bird_y <= bird_y + 1;
	   	  count := count + "000001";
			if (bird_y + size) = "111100000" then
			g_o  <= '1';

			elsif count = "101000" then
	   	   	  count := "000000";
		   	  up := '0';
			end if;
		end if;
	   end if;

	end process;

	bird_on <= '1' when (('0' & bird_x <= pixel_column + size) and ('0' & pixel_column <= bird_x + size)
		    	and ('0' & bird_y <= pixel_row + size) and ('0' & pixel_row <= bird_y + size)) else
		    '0';
	
	red <= '1';
	green <= not bird_on;
	blue <= not bird_on;
	
end architecture behavior;

   	