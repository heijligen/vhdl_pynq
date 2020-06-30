library IEEE;
use IEEE.Std_Logic_1164.all;
use Work.Axi4.all;

entity Axi2Led is
	port (
		Clk		: in  Std_Logic;
		S_Axi_In	: in  Axi4_Lite_Slave_In;
		S_Axi_Out: out Axi4_Lite_Slave_Out;
		Led		: out Std_Logic_Vector (3 downto 0)
	);
end Axi2Led;

architecture rtl of Axi2Led is
	signal Status : Std_Logic_Vector (31 downto 0) := (others => '0');
begin

	-- Led
	Led <= Status (3 downto 0);

	-- Axi
	S_Axi_Out.AwReady	<= '1';
	S_Axi_Out.WReady	<= '1';
	S_Axi_Out.BResp <= (others => '0');

	process (Clk, S_Axi_In, S_Axi_Out) is
	begin
		if Rising_Edge (Clk) then
			if S_Axi_In.WValid = '1' then
				Status <= S_Axi_In.WData;
				S_Axi_Out.BValid <= '1';
			else
				S_Axi_Out.BValid <= '0';
			end if;
		end if;
	end process;
end architecture;
