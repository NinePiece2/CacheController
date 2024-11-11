library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CacheController is
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
           Ready : out  STD_LOGIC := '0';
			  OutState : out STD_LOGIC_VECTOR(3 downto 0));
end CacheController;

architecture Behavioral of CacheController is

    -- Cache Controller Signals
    Signal InputTag: STD_LOGIC_VECTOR (7 downto 0);
    Signal InputIndex: STD_LOGIC_VECTOR (2 downto 0);
    Signal InputOffset: STD_LOGIC_VECTOR (4 downto 0);
    
    Type CurrentSRAMTagArray_Type is Array (7 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
    Type ValidDirtytype is Array (7 downto 0) of STD_LOGIC;

    Signal CurrentSRAMTagArray : CurrentSRAMTagArray_Type := (others => (others => '0'));
    Signal DirtyBits : ValidDirtytype := (others => '0');
    Signal validBits : ValidDirtytype := (others => '0');

    Signal state : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    Signal cacheHit : STD_LOGIC;
    Signal dirtyBit : STD_LOGIC;
    Signal validBit : STD_LOGIC;

    -- State encoding
    type state_type is (IDLE, EVALUATE, CACHE_HIT_READ, CACHE_HIT_WRITE, 
                        CACHE_MISS_CLEAN, CACHE_MISS_DIRTY);
    signal current_state : state_type := IDLE;
	 signal next_state : state_type;
	 
	 -- For iterations
	 signal counter : integer := 0;
	 signal i : integer := 0;

begin
    -- Decode Address
    process(AddrIn)
    begin
        InputTag <= AddrIn(15 downto 8);
        InputIndex <= AddrIn(7 downto 5);
        InputOffset <= AddrIn(4 downto 0);
    end process;

    -- Cache Controller State Machine
    process(clk)
    begin
        if rising_edge(clk) then
            --if CS = '1' then
                case current_state is
                    when IDLE =>
								Ready <= '1';
								WRRDOut <= '0';
								WEN <= '0';
								if CS = '1' then
									WRRDOut <= '0';
									WEN <= '0';
									 -- Move to the next state to evaluate hit/miss
									 current_state <= EVALUATE;
								end if;		
                        
                    when EVALUATE =>
                        -- Check if the cache block is valid and the tags match
								Ready <= '0';
                        if (validBits(to_integer(unsigned(InputIndex))) = '1') and
                           (CurrentSRAMTagArray(to_integer(unsigned(InputIndex))) = InputTag) then
                            -- Cache hit
                            cacheHit <= '1';
                            dirtyBit <= DirtyBits(to_integer(unsigned(InputIndex)));
                            validBit <= validBits(to_integer(unsigned(InputIndex)));
                            
                            if WRRDIn = '1' then -- Write request
                                current_state <= CACHE_HIT_WRITE;
                            else -- read request
                                current_state <= CACHE_HIT_READ;
                            end if;
                        else
                            -- Cache miss, check dirty bit
                            cacheHit <= '0';
                            dirtyBit <= DirtyBits(to_integer(unsigned(InputIndex)));
                            if (DirtyBits(to_integer(unsigned(InputIndex))) = '0') then
                                current_state <= CACHE_MISS_CLEAN;
                            else
                                current_state <= CACHE_MISS_DIRTY;
                            end if;
                        end if;
                        
                    -- Handle cache hit read 
                    when CACHE_HIT_READ =>
                        -- Send the index and offset to SRAM for reading
                        SramAddr <= InputIndex & InputOffset;
                        WRRDOut <= '0'; -- Read signal
                        --Ready <= '1';
								DinControl <= '0';
								DoutControl <= '1';
								WEN <= '0';
                        current_state <= IDLE;

                    -- Handle cache hit write
                    when CACHE_HIT_WRITE =>
                        -- Send the index and offset to SRAM for writing
                        SramAddr <= InputIndex & InputOffset;
                        WRRDOut <= '0'; 
                        WEN <= '1'; -- Enable write
                        DirtyBits(to_integer(unsigned(InputIndex))) <= '1'; -- Set dirty bit
                        validBits(to_integer(unsigned(InputIndex))) <= '1'; -- Set valid bit
								DinControl <= '0';
								DoutControl <= '0';
                        --Ready <= '1';
								--if counter = 1 then -- Wait Delay
								--	counter <= 0;
								--	WEN <= '0';
									current_state <= IDLE;
								--else 
									--counter <= counter + 1;
								--end if;

                    -- Handle cache miss with clean block (dirty bit = 0)
                    when CACHE_MISS_CLEAN =>
								DinControl <= '1';
								DoutControl <= '0';
								
								if (counter = 64) then
									counter <= 0;
									i <= 0;
									CurrentSRAMTagArray(to_integer(unsigned(InputIndex))) <= InputTag;
									validBits(to_integer(unsigned(InputIndex))) <= '1'; -- Set valid bit
									
									current_state <= EVALUATE;

								else
									if (counter mod 2 = 0) then
										MSTRB <= '0';
									else
										AddrOut <= InputTag & InputIndex & STD_LOGIC_VECTOR(to_unsigned(i, 5));
										SramAddr <= InputIndex & STD_LOGIC_VECTOR(to_unsigned(i, 5));
										WEN <= '1'; -- Write SRAM
										WRRDOut <= '0'; -- Read SDRAM
										MSTRB <= '1'; -- SDRAM read signal
										i <= i + 1;
									end if;
									counter <= counter + 1;
								end if;

                    -- Handle cache miss with dirty block (dirty bit = 1)
                    when CACHE_MISS_DIRTY =>
								DinControl <= '0';
								DoutControl <= '1';
								
								if (counter = 64) then
									counter <= 0;
									i <= 0;
									DirtyBits(to_integer(unsigned(InputIndex))) <= '0'; -- Reset dirty bit
									
									current_state <= CACHE_MISS_CLEAN;

								else
									if (counter mod 2 = 0) then
										MSTRB <= '0';
									else
										AddrOut <= CurrentSRAMTagArray(to_integer(unsigned(InputIndex))) & InputIndex & STD_LOGIC_VECTOR(to_unsigned(i, 5));
										SramAddr <= InputIndex & STD_LOGIC_VECTOR(to_unsigned(i, 5));
										WRRDOut <= '1'; -- Write to SDRAM
										WEN <= '0'; -- Read SRAM
										MSTRB <= '1';
										i <= i + 1;
									end if;
									counter <= counter + 1;
								end if;
								
                        
                end case;
            --end if;
        end if;
		  
    end process;
	 
	 process(current_state)
	 begin
		case current_state is
			when IDLE =>
				OutState <= "0000";
			when EVALUATE =>
				OutState <= "0001";
			when CACHE_HIT_READ =>
				OutState <= "0010";
			when CACHE_HIT_WRITE =>
				OutState <= "0011";
			when CACHE_MISS_CLEAN =>
				OutState <= "0100";
			when CACHE_MISS_DIRTY =>
				OutState <= "0101";
		end case;
	 end process;

    
end Behavioral;