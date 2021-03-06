-- blink/zynq_ps7.vhd
-- VHDL wrapper around Zynq PS7 hardcore to use with yosys
--
-------------------------------------------------------------------------------
-- "THE BEER-WARE LICENSE" (Revision 42):
-- <src@posteo.de> wrote this file.  As long as you retain this notice you
-- can do whatever you want with this stuff. If we meet some day, and you think
-- this stuff is worth it, you can buy me a beer in return.    Thomas Heijligen
-------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use Work.Axi4.all;

entity Zynq_PS7 is
	port (
		Clk0				: out Std_Logic;
		M_Axi_GP0_Out	: out Axi4_Full_Master_Out;
		M_Axi_GP0_In	: in  Axi4_Full_Master_In := Axi4_Full_Slave_To_Master_NC
		);
end Zynq_PS7;


architecture rtl of Zynq_PS7 is

	component PS7 is
		port (
			FCLKCLK			: out Std_Logic_Vector (3 downto 0);
			MAXIGP0ARESETN	: out Std_Logic;
			MAXIGP0ARVALID	: out Std_Logic;
			MAXIGP0AWVALID	: out Std_Logic;
			MAXIGP0BREADY	: out Std_Logic;
			MAXIGP0RREADY	: out Std_Logic;
			MAXIGP0WLAST	: out Std_Logic;
			MAXIGP0WVALID	: out Std_Logic;
			MAXIGP0ARID		: out Std_Logic_Vector (11 downto 0);
			MAXIGP0AWID		: out Std_Logic_Vector (11 downto 0);
			MAXIGP0ARBURST	: out Std_Logic_Vector ( 1 downto 0);
			MAXIGP0ARLOCK	: out Std_Logic_Vector ( 1 downto 0);
			MAXIGP0ARSIZE	: out Std_Logic_Vector ( 1 downto 0);
			MAXIGP0AWBURST	: out Std_Logic_Vector ( 1 downto 0);
			MAXIGP0AWLOCK	: out Std_Logic_Vector ( 1 downto 0);
			MAXIGP0AWSIZE	: out Std_Logic_Vector ( 1 downto 0);
			MAXIGP0ARPROT	: out Std_Logic_Vector ( 2 downto 0);
			MAXIGP0AWPROT	: out Std_Logic_Vector ( 2 downto 0);
			MAXIGP0ARADDR	: out Std_Logic_Vector (31 downto 0);
			MAXIGP0AWADDR	: out Std_Logic_Vector (31 downto 0);
			MAXIGP0WDATA	: out Std_Logic_Vector (31 downto 0);
			MAXIGP0ARCACHE	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0ARLEN	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0ARQOS	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0AWCACHE	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0AWLEN	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0AWQOS	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0WSTRB	: out Std_Logic_Vector ( 3 downto 0);
			MAXIGP0ACLK		: in  Std_Logic;
			MAXIGP0ARREADY	: in  Std_Logic;
			MAXIGP0AWREADY	: in  Std_Logic;
			MAXIGP0BVALID	: in  Std_Logic;
			MAXIGP0RLAST	: in  Std_Logic;
			MAXIGP0RVALID	: in  Std_Logic;
			MAXIGP0WREADY	: in  Std_Logic;
			MAXIGP0BID		: in  Std_Logic_Vector (11 downto 0);
			MAXIGP0RID		: in  Std_Logic_Vector (11 downto 0);
			MAXIGP0BRESP	: in  Std_Logic_Vector ( 1 downto 0);
			MAXIGP0RRESP	: in  Std_Logic_Vector ( 1 downto 0);
			MAXIGP0RDATA	: in  Std_Logic_Vector (31 downto 0)
		);
	end component;

	signal PS7_FClKClk : Std_Logic_Vector (3 downto 0);

begin

	the_PS7: PS7 port map (
		FCLKCLK			=> PS7_FClkClk,
		MAXIGP0ARESETN	=> M_Axi_GP0_Out.AResetN,
		MAXIGP0ARVALID	=> M_Axi_GP0_Out.ArValid,
		MAXIGP0AWVALID	=> M_Axi_GP0_Out.AwValid,
		MAXIGP0BREADY	=> M_Axi_GP0_Out.BReady,
		MAXIGP0RREADY	=> M_Axi_GP0_Out.RReady,
		MAXIGP0WLAST	=> M_Axi_GP0_Out.WLast,
		MAXIGP0WVALID	=> M_Axi_GP0_Out.WValid,
		MAXIGP0ARID		=> M_Axi_GP0_Out.ArId,
		MAXIGP0AWID		=> M_Axi_GP0_Out.AwId,
		MAXIGP0ARBURST	=> M_Axi_GP0_Out.ArBurst,
		MAXIGP0ARLOCK	=> M_Axi_GP0_Out.ArLock,
		MAXIGP0ARSIZE	=> M_Axi_GP0_Out.ArSize,
		MAXIGP0AWBURST	=> M_Axi_GP0_Out.AwBurst,
		MAXIGP0AWLOCK	=> M_Axi_GP0_Out.AwLock,
		MAXIGP0AWSIZE	=> M_Axi_GP0_Out.AwSize,
		MAXIGP0ARPROT	=> M_Axi_GP0_Out.ArProt,
		MAXIGP0AWPROT	=> M_Axi_GP0_Out.AwProt,
		MAXIGP0ARADDR	=> M_Axi_GP0_Out.ArAddr,
		MAXIGP0AWADDR	=> M_Axi_GP0_Out.AwAddr,
		MAXIGP0WDATA	=> M_Axi_GP0_Out.WData,
		MAXIGP0ARCACHE	=> M_Axi_GP0_Out.ArCache,
		MAXIGP0ARLEN	=> M_Axi_GP0_Out.ArLen,
		MAXIGP0ARQOS	=> M_Axi_GP0_Out.ArQos,
		MAXIGP0AWCACHE	=> M_Axi_GP0_Out.AwCache,
		MAXIGP0AWLEN	=> M_Axi_GP0_Out.AwLen,
		MAXIGP0AWQOS	=> M_Axi_GP0_Out.AwQos,
		MAXIGP0WSTRB	=> M_Axi_GP0_Out.WStrb,
		MAXIGP0ACLK		=> M_Axi_GP0_In.AClk,
		MAXIGP0ARREADY	=> M_Axi_GP0_In.ArReady,
		MAXIGP0AWREADY	=> M_Axi_GP0_In.AwReady,
		MAXIGP0BVALID	=> M_Axi_GP0_In.BValid,
		MAXIGP0RLAST	=> M_Axi_GP0_In.RLast,
		MAXIGP0RVALID	=> M_Axi_GP0_In.RValid,
		MAXIGP0WREADY	=> M_Axi_GP0_In.WReady,
		MAXIGP0BID		=> M_Axi_GP0_In.BId,
		MAXIGP0RID		=> M_Axi_GP0_In.RId,
		MAXIGP0BRESP	=> M_Axi_GP0_In.BResp,
		MAXIGP0RRESP	=> M_Axi_GP0_In.RResp,
		MAXIGP0RDATA	=> M_Axi_GP0_In.RData
	);

	Clk0 <= PS7_FClkClk (0);

end architecture;
