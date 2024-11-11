----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:36:19 09/30/2024 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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

entity Control is
 Port ( clk : in  STD_LOGIC);
end Control;

architecture Behavioral of Control is
	Component SRAM is
		Port ( clk : in  STD_LOGIC;
				  wen : in  STD_LOGIC;
				  AddrIn : in  STD_LOGIC_VECTOR (7 downto 0);
				  CPU_Din : in  STD_LOGIC_VECTOR (7 downto 0);
				  SDRAM_Din : in  STD_LOGIC_VECTOR (7 downto 0);
				  CPU_Dout : out  STD_LOGIC_VECTOR (7 downto 0);
				  SDRAM_Dout : out  STD_LOGIC_VECTOR (7 downto 0);
				  DinControl : in  STD_LOGIC;
				  DoutControl : in  STD_LOGIC);
	end Component;
	
	Component CacheController is
		Port ( clk : in STD_LOGIC;
				  AddrIn : in  STD_LOGIC_VECTOR (15 downto 0); -- CPU Instruction
				  WRRDIn : in  STD_LOGIC;
				  CS : in  STD_LOGIC;
				  AddrOut : out  STD_LOGIC_VECTOR (15 downto 0); --> To SDRAMController
				  WRRDOut : out  STD_LOGIC; --> To SDRAMController
				  MSTRB : out  STD_LOGIC; --> To SDRAMController
				  DinControl : out  STD_LOGIC;
				  DoutControl : out  STD_LOGIC;
				  WEN : out  STD_LOGIC;
				  SramAddr : out  STD_LOGIC_VECTOR (7 downto 0);
				  Ready : out  STD_LOGIC;
				  OutState : out STD_LOGIC_VECTOR(3 downto 0));
	end Component;
	
	Component CPU_gen is
		Port ( 
			clk 		: in  STD_LOGIC;
			rst 		: in  STD_LOGIC;
			trig 		: in  STD_LOGIC;
			-- Interface to the Cache Controller.
			Address 	: out  STD_LOGIC_VECTOR (15 downto 0);
			wr_rd 	: out  STD_LOGIC;
			cs 		: out  STD_LOGIC;
			DOut 		: out  STD_LOGIC_VECTOR (7 downto 0)
		);
	end Component;
	
	Component SDRAMController is
		Port ( clk : in  STD_LOGIC;
			  Addr : in  STD_LOGIC_VECTOR (15 downto 0);
           WRRD : in  STD_LOGIC;
           MSTRB : in  STD_LOGIC;
           DIn : in  STD_LOGIC_VECTOR (7 downto 0);
           DOut : out  STD_LOGIC_VECTOR (7 downto 0));
	end Component;
	
	-- Scope Components
	component icon
	  PORT (
		 CONTROL0 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
		 CONTROL1 : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0));
	end component;
	
	component ila
	  PORT (
		 CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
		 CLK : IN STD_LOGIC;
		 DATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 TRIG0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;
	
	component vio
	  PORT (
		 CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
		 ASYNC_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
	
	-- Clock signal:
	signal counter : INTEGER := 0;
	
	-- Signals that attach components
	SIGNAL Address_CPU_to_CacheController, Address_CacheContoller_to_SDRAM : STD_LOGIC_VECTOR (15 downto 0);
	SIGNAL CPU_rst, CPU_trig, CPU_wr_rd, CPU_cs, CacheController_wr_rd, CacheController_MSTRB, CacheController_ready: STD_LOGIC;
	SIGNAL DinControl, DoutControl, CacheController_wen : STD_LOGIC;
	SIGNAL DOut_CPU_to_Cache, CacheController_SRAM_Address, SDRAMController_to_SRAM_Din, SRAM_CPU_Dout : STD_LOGIC_VECTOR (7 downto 0);
	SIGNAL SRAM_to_SDRAM_Dout: STD_LOGIC_VECTOR (7 downto 0);
	Signal OutStateLine : STD_LOGIC_VECTOR(3 downto 0);
	
	-- ILA, VIO and ICON signals	
	signal control0 : std_logic_vector(35 downto 0);
	signal control1 : std_logic_vector(35 downto 0);
	signal ila_data : std_logic_vector(127 downto 0);
	signal trig0 : std_logic_vector(7 downto 0);
	signal vio_out : std_logic_vector(31 downto 0);
	
begin
	 
	sys_icon : icon
	  port map (
		 CONTROL0 => CONTROL0,
		 CONTROL1 => CONTROL1);
	
	sys_ila : ila
	  port map (
		 CONTROL => CONTROL0,
		 CLK => clk,
		 DATA => ila_data,
		 TRIG0 => trig0);
		 
	sys_vio : vio
	  port map (
		 CONTROL => CONTROL1,
		 ASYNC_OUT => vio_out);
	
	cpu : CPU_gen
	PORT MAP(
		clk => clk,
		rst => '0', -- set 0
		trig => CacheController_ready, -- ready
		Address => Address_CPU_to_CacheController,
		wr_rd => CPU_wr_rd,
		cs => CPU_cs,
		DOut => DOut_CPU_to_Cache
	);
	
	cache_controller : CacheController
	PORT MAP(
		clk => clk,
		AddrIn => Address_CPU_to_CacheController,
		WRRDIn => CPU_wr_rd,
		CS => CPU_cs,
		AddrOut => Address_CacheContoller_to_SDRAM,
		WRRDOut => CacheController_wr_rd,
		MSTRB => CacheController_MSTRB,
		DinControl => DinControl,
		DoutControl => DoutControl,
		WEN => CacheController_wen,
		SramAddr => CacheController_SRAM_Address,
		Ready => CacheController_ready,
		OutState => OutStateLine
	);
	
	sram_element : SRAM
	PORT MAP(
		clk => clk,
		wen => CacheController_wen,
		AddrIn => CacheController_SRAM_Address,
		CPU_Din => DOut_CPU_to_Cache,
		SDRAM_Din => SDRAMController_to_SRAM_Din,
		CPU_Dout => SRAM_CPU_Dout,
		SDRAM_Dout => SRAM_to_SDRAM_Dout,
		DinControl => DinControl,
		DoutControl => DoutControl
	);
	
	sdram_controller : SDRAMController
	PORT MAP(
		clk => clk,
		Addr => Address_CacheContoller_to_SDRAM,
		WRRD => CacheController_wr_rd,
		MSTRB => CacheController_MSTRB,
		DIn => SRAM_to_SDRAM_Dout,
		Dout => SDRAMController_to_SRAM_Din
	);
	
	

	
	-- Clk
	ila_data(127) <= clk; 
		
	-- Cache Controller Connections
	ila_data(15 downto 0) <= Address_CPU_to_CacheController; 
	ila_data(16) <= CPU_wr_rd;
	ila_data(17) <= CPU_cs;
	ila_data(33 downto 18) <= Address_CacheContoller_to_SDRAM;
	ila_data(34) <= CacheController_wr_rd;
	ila_data(35) <= CacheController_MSTRB;
	ila_data(36) <= DinControl;
	ila_data(37) <= DoutControl;
	ila_data(38) <= CacheController_wen;
	ila_data(46 downto 39) <= CacheController_SRAM_Address;
	ila_data(47) <= CacheController_ready;
	
	-- SRAM Connections
	ila_data(55 downto 48) <= DOut_CPU_to_Cache;
	ila_data(63 downto 56) <= SDRAMController_to_SRAM_Din;
	ila_data(71 downto 64) <= SRAM_CPU_Dout;
	ila_data(79 downto 72) <= SRAM_to_SDRAM_Dout;
	ila_data(103 downto 100) <= OutStateLine;
	
	
end Behavioral;

