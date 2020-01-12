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
use Work.Axi4.all;

entity Top is
	port (
		Led	: out Std_Logic_Vector (3 downto 0)
	);
end Top;

architecture RTL of Top is

	component Zynq_PS7 is
	   port (
	      Clk0		: out Std_Logic;
	      GP0_Clk	: in  Std_Logic := '0';
	      GP0_Reset: out Std_Logic;
	      GP0_Out	: out Axi4_Full_Master_Out;
	      GP0_In	: in  Axi4_Full_Master_In := Axi4_Full_Slave_To_Master_NC
	   );
	end component;

	signal Global_Clk : Std_Logic;
	signal Status		: Std_Logic:= '0';

begin

	Led <= (0 => Status, others => '0');

	process (Global_Clk) is
	begin
		if Rising_Edge (Global_Clk) then
			Status <= not Status;
		end if;
	end process;

	my_PS : Zynq_PS7 port map (
		Clk0 => Global_Clk
	);

end architecture;
