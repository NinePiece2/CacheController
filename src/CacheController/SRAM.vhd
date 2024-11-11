----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:26 09/30/2024 
-- Design Name: 
-- Module Name:    SRAM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SRAM is
    Port ( clk : in  STD_LOGIC;
           wen : in  STD_LOGIC;
           AddrIn : in  STD_LOGIC_VECTOR (7 downto 0);
           CPU_Din : in  STD_LOGIC_VECTOR (7 downto 0);
           SDRAM_Din : in  STD_LOGIC_VECTOR (7 downto 0);
           CPU_Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           SDRAM_Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           DinControl : in  STD_LOGIC;
           DoutControl : in  STD_LOGIC);
end SRAM;

architecture Behavioral of SRAM is

	COMPONENT BRAM
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal bram_addr : std_logic_vector(7 downto 0);
	signal bram_din, bram_dout : std_logic_vector(7 downto 0);
	signal bram_wen : std_logic_vector(0 downto 0);
	
begin
	system_bram : bram
	PORT MAP (
		clka => clk,
		wea => bram_wen,
		addra => bram_addr,
		dina => bram_din,
		douta => bram_dout
	);
	
	process (wen)
	begin
		bram_wen(0) <= wen;
	end process;
	
	process (AddrIn)
	begin
		bram_addr <= AddrIn;
	end process;
	
	process (DinControl, DoutControl, SDRAM_Din, CPU_Din, bram_dout)
	begin
		if (DinControl = '1') then
			bram_din <= SDRAM_Din;
		else
			bram_din <= CPU_Din;
		end if;

		
		if (DoutControl = '1') then
			CPU_Dout <= bram_dout;
		else
			SDRAM_Dout <= bram_dout;
		end if;
		 
	end process;


end Behavioral;

