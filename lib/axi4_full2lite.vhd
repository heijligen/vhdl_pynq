library IEEE;
use IEEE.Std_Logic_1164.all;
use Work.Axi4.all;

entity Axi4_Full2Lite is
	port (
		S_Axi_Out: out Axi4_Full_Slave_Out;
		S_Axi_In	: in  Axi4_Full_Slave_In;
		M_Axi_Out: out Axi4_Lite_Master_Out;
		M_Axi_In	: in  Axi4_Lite_Master_In
);
end Axi4_Full2Lite;

architecture rtl of Axi4_Full2Lite is
	signal Clk : Std_Logic;
	signal BId : Std_Logic_Vector (11 downto 0) := (others => '0');
	signal RId : Std_Logic_Vector (11 downto 0) := (others => '0');
	signal AwId, ArId : Std_Logic_Vector (11 downto 0);
begin

--  .----------------------.
--  +S_Axi_Out <-- M_Axi_In+
--  +S_Axi_In --> M_Axi_Out+
--  '----------------------'

	process (Clk, S_Axi_In.AwValid, S_Axi_In.ArValid) is
	begin
		if Rising_Edge (Clk) then
			if S_Axi_In.AwValid = '1' then
				AwId <= S_Axi_In.AwId;
			end if;
			if S_Axi_In.ArValid = '1' then
				ArId <= S_Axi_In.ArId;
			end if;
		end if;
	end process;

	Clk 					<= M_Axi_In.AClk;
	S_Axi_Out.AClk 	<= Clk;
	S_Axi_Out.AwReady	<= M_Axi_In.AwReady;
	S_Axi_Out.WReady	<= M_Axi_In.WReady;
  	S_Axi_Out.BId		<= BId;
  	S_Axi_Out.BResp	<= M_Axi_In.BResp;
  	S_Axi_Out.BValid	<= M_Axi_In.BValid;
  	S_Axi_Out.ArReady	<= M_Axi_In.ArReady;
  	S_Axi_Out.RId		<= RId;
  	S_Axi_Out.RData	<= M_Axi_In.RData;
  	S_Axi_Out.RResp	<= M_Axi_In.RResp;
  	S_Axi_Out.RLast	<= '1';
  	S_Axi_Out.RValid	<= M_Axi_In.RValid;
--
	M_Axi_Out.AResetN	<= S_Axi_In.AResetN;
	--AwId					<= S_Axi_In.AwId;
   M_Axi_Out.AwAddr	<= S_Axi_In.AwAddr;
   --						<= S_Axi_In.AwLen;
   --						<= S_Axi_In.AwSize;
   --						<= S_Axi_In.AwBurst;
   --						<= S_Axi_In.AWLock;
   --						<= S_Axi_In.AWCache;
   M_Axi_Out.AwProt	<= S_Axi_In.AwProt;
   --						<= S_Axi_In.AWQos;
   M_Axi_Out.AwValid	<= S_Axi_In.AwValid;
   M_Axi_Out.WData	<= S_Axi_In.WData;
   M_Axi_Out.WStrb	<= S_Axi_In.WStrb;
   --						<=	S_Axi_In.WLast;
   M_Axi_Out.WValid	<= S_Axi_In.WValid;
   M_Axi_Out.BReady	<= S_Axi_In.BReady;
   --ArId					<= S_Axi_In.ArId;
   M_Axi_Out.ArAddr	<= S_Axi_In.ArAddr;
   --						<= S_Axi_In.ArLen;
   --						<= S_Axi_In.ArSize;
   --						<= S_Axi_In.ArBurst;
   --						<= S_Axi_In.ArLock;
   --						<= S_Axi_In.Cache;
   M_Axi_Out.ArProt	<= S_Axi_In.ArProt;
   --						<= S_Axi_In.Qos;
   M_Axi_Out.ArValid	<= S_Axi_In.ArValid;
   M_Axi_Out.RReady	<= S_Axi_In.RReady;
end architecture;
