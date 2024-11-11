----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:24:58 09/29/2024 
-- Design Name: 
-- Module Name:    SDRAMController - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity SDRAMController is
    Port ( clk   : in  STD_LOGIC;
           Addr  : in  STD_LOGIC_VECTOR (15 downto 0);
           WRRD  : in  STD_LOGIC;  -- 1: Write, 0: Read
           MSTRB : in  STD_LOGIC;  -- Strobe signal for memory access
           DIn   : in  STD_LOGIC_VECTOR (7 downto 0);
           DOut  : out  STD_LOGIC_VECTOR (7 downto 0));
end SDRAMController;

architecture Behavioral of SDRAMController is

    -- SDRAM Array of 8-bit vectors, 8 for index 32 for offset
    Type SDRAM_Type is Array (7 downto 0, 31 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
    Signal SDRAM : SDRAM_Type;  -- Memory array

    -- Internal signals for block-level operation
	 Signal Tag : integer; 
	 Signal Index: integer;
	 Signal Offset: integer;
	 
	 signal counter: integer := 0;
	 
begin
    -- SDRAM controller process
    process (clk, MSTRB)
    begin
        if rising_edge(clk) then
            if counter = 0 then
					for i in 0 to 7 loop
						for j in 0 to 31 loop
							SDRAM(i,j) <= "10101010";
						end loop;
					end loop;
					counter <= 1;	
				end if;

            -- Memory operations based on strobe and read/write signals
            if MSTRB = '1' then
					 
                Tag <= to_integer(unsigned(Addr(15 downto 8)));
					 Index <= to_integer(unsigned(Addr(7 downto 5)));  
                Offset <= to_integer(unsigned(Addr(4 downto 0)));  

                if WRRD = '1' then
                    -- Write Operation
						  SDRAM(to_integer(unsigned(Addr(7 downto 5))), to_integer(unsigned(Addr(4 downto 0)))) <= DIn;
                else
                    -- Read Operation
                    DOut <= SDRAM(to_integer(unsigned(Addr(7 downto 5))), to_integer(unsigned(Addr(4 downto 0))));
                end if;
            end if;
        end if;
    end process;

end Behavioral;


