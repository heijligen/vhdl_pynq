-- blink/top.vhd
-- Take the clock from the PS7 hardcore and blink LED 0 to 4 on clockspeed.
-- The four LEDs should light waek.
--
-------------------------------------------------------------------------------
-- "THE BEER-WARE LICENSE" (Revision 42):
-- <src@posteo.de> wrote this file.  As long as you retain this notice you
-- can do whatever you want with this stuff. If we meet some day, and you think
-- this stuff is worth it, you can buy me a beer in return.    Thomas Heijligen
-------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity Top is
	port (
		Led : out Std_Logic_Vector (3 downto 0)
	);
end Top;

architecture RTL of Top is
	signal Clk : Std_Logic_Vector (3 downto 0);
	signal Status : Std_Logic:= '0';

	component PS7 is
		port (
			FCLKCLK : out Std_Logic_Vector (3 downto 0)
		);
	end component;
begin

	process (Clk (0)) is
	begin
		if Rising_Edge (Clk (0)) then
				Status <= not Status;
		end if;
	end process;

	the_PS : PS7 port map (FCLKCLK => Clk);

	Led <= (0 => Status, others => '0');

end architecture;
