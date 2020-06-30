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
		Led : out Std_Logic_Vector (3 downto 0)
	);
end Top;

architecture rtl of Top is
		
	component Zynq_PS7 is
		port (
			Clk0				: out Std_Logic;
			M_Axi_GP0_Out	: out Axi4_Full_Master_Out;
			M_Axi_GP0_In	: in  Axi4_Full_Master_In
		);
	end component;

	component Axi4_Full2Lite is
		port (
			M_Axi_Out: out Axi4_Lite_Master_Out;
			M_Axi_In : in  Axi4_Lite_Master_In;
         S_Axi_Out: out Axi4_Full_Slave_Out;
         S_Axi_In : in  Axi4_Full_Slave_In
		);
	end component;

	component Axi2Led is
		port (
			Clk		: in  Std_Logic;
			S_Axi_In	: in  Axi4_Lite_Slave_In;
			S_Axi_Out: out Axi4_Lite_Slave_Out;
			Led		: out Std_Logic_Vector (3 downto 0)
		);
	end component;

	signal Clk	 : Std_Logic;
	signal ax_m0 : Axi4_Full_Master_To_Slave;
	signal ax_m1 : Axi4_Full_Slave_To_Master;
	signal ax_l0 : Axi4_Lite_Master_To_Slave;
	signal ax_l1 : Axi4_Lite_Slave_To_Master;
begin

	aa : Zynq_PS7 port map (
		Clk0 				=> Clk,
		M_Axi_GP0_Out	=> ax_m0,
		M_Axi_GP0_In	=> ax_m1
	);
	
	bb : Axi4_Full2Lite port map (
		M_Axi_Out	=> ax_l0,
		M_Axi_In		=> ax_l1,
		S_Axi_Out	=> ax_m1,
		S_Axi_In		=> ax_m0
	);
	
	cc : Axi2Led port map (
		Clk			=> Clk,
		S_Axi_In		=> ax_l0,
		S_Axi_Out	=> ax_l1,
		Led			=> Led
	);

end architecture;
