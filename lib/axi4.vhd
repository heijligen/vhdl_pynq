-- lib/axi4.vhd
-- Abstraction of AXI4 Signals
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

package Axi4 is
	--Global signals
	-- ACLK : 
	-- ARESETn
type Axi4_Full_Master_To_Slave is record
	-- Write address channel signals
	AwId		: Std_Logic_Vector (11 downto 0);
	AwAddr	: Std_Logic_Vector (31 downto 0);
	AwLen		: Std_Logic_Vector ( 3 downto 0);
	AwSize	: Std_Logic_Vector ( 1 downto 0);
	AwBurst	: Std_Logic_Vector ( 1 downto 0);
	AwLock	: Std_Logic_Vector ( 1 downto 0);
	AwCache	: Std_Logic_Vector ( 3 downto 0);
	AwProt	: Std_Logic_Vector ( 2 downto 0);
	AwQos		: Std_Logic_Vector ( 3 downto 0);
	AwValid	: Std_Logic;
	AwReady	: Std_Logic;
	-- Write data channel signals
	WId		: Std_Logic_Vector (11 downto 0);
	WData		: Std_Logic_Vector (31 downto 0);
	WStrb		: Std_Logic_Vector ( 3  downto 0);
	WLast		: Std_Logic;
	WValid	: Std_Logic;
	-- Write response channel signals
	BReady	: Std_Logic;
	-- Read address channel signals
	ArId		: Std_Logic_Vector (11 downto 0);
	ArAddr	: Std_Logic_Vector (31 downto 0);
	ArLen		: Std_Logic_Vector ( 3 downto 0);
	ArSize	: Std_Logic_Vector ( 1 downto 0);
	ArBurst	: Std_Logic_Vector ( 1 downto 0);
	ArLock	: Std_Logic_Vector ( 1 downto 0);
	ArCache	: Std_Logic_Vector ( 3 downto 0);
	ArProt	: Std_Logic_Vector ( 2 downto 0);
	ArQos		: Std_Logic_Vector ( 3 downto 0);
	ArValid	: Std_Logic;
	-- Read data channel signals
	RReady	: Std_Logic;
end record;
alias Axi4_Full_Master_Out is Axi4_Full_Master_To_Slave;
alias Axi4_Full_Slave_In   is Axi4_Full_Master_To_Slave;

type Axi4_Full_Slave_To_Master is record
	-- Write address channel signals
	AwReady	: Std_Logic;
	-- Write data channel signals
	WReady	: Std_Logic;
	-- Write response channel signals
	BId		: Std_Logic_Vector (11 downto 0);
	BResp		: Std_Logic_Vector ( 1 downto 0);
	BValid	: Std_Logic;
	-- Read address channel signals
	ArReady	: Std_Logic;
	-- Read data channel signals
	RId		: Std_Logic_Vector (11 downto 0);
	RData		: Std_Logic_Vector (31 downto 0);
	RResp		: Std_Logic_Vector ( 1 downto 0);
	RLast		: Std_Logic;
	RValid	: Std_Logic;
end record;
alias Axi4_Full_Master_In is Axi4_Full_Slave_To_Master;
alias Axi4_Full_Slave_Out is Axi4_Full_Slave_To_Master;

constant Axi4_Full_Slave_To_Master_NC : Axi4_Full_Slave_To_Master := (
	AwReady	=> '0',
	WReady	=> '0',
	BId		=> (others => '0'),
	BResp		=> (others => '0'),
	BValid	=> '0',
	ArReady	=> '0',
	RId		=> (others => '0'),
	RData		=> (others => '0'),
	RResp		=> (others => '0'),
	RLast		=> '0',
	RValid	=> '0'
);

end Axi4;
