library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    Port ( clk_i : in STD_LOGIC;
           RXD_i : in STD_LOGIC;
           digits_out : out STD_LOGIC_VECTOR (15 downto 0));
end memory;

architecture Behavioral of memory is
signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_code : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal clk_div : STD_LOGIC  := '0';
signal digits : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal bits_counter: integer := 0;
signal body_message: std_logic_vector(7 downto 0) := "00000000";

signal clk_new_bit : STD_LOGIC  := '0';
signal time_counter: integer := 0;
signal transmission_started : STD_LOGIC  := '0';

begin

-- check transmission state (started, stopped)
process(RXD_i, bits_counter)
variable counter: integer:= 0;
    begin   -- czy tak można wykryć zmiane z '1' na '0'?
        if (RXD_i = '0' and bits_counter = 0) then 
            -- wykrylismy poczatkowy bit nadawania sygnalu '0'
            transmission_started <= '1';
        elsif bits_counter = 9 then
            transmission_started <= '0';                      
        end if;
end process;

-- count time for one bit
process(clk_i, time_counter)
constant frequency: integer := 10416; 
    begin
        if bits_counter = 9 then
                bits_counter <= 0;
        end if;
        if (transmission_started = '1') then
                if (rising_edge(clk_i)) then
                    if(time_counter = frequency/2) then
                        bits_counter <= bits_counter + 1;
                        time_counter <= time_counter + 1;
                        clk_new_bit <= '1';
                    elsif time_counter = frequency then
                           clk_new_bit <= '0';
                           time_counter <= 0;
                    else
                        time_counter <= time_counter + 1;
                        clk_new_bit <= '0';   
                    end if;                                   
                end if;
        end if;
end process;
    
-- compose message from RXD_i signal
process(RXD_i, bits_counter)

variable counter: integer:= 0;
    begin  -- mayby sequential ?
        if (transmission_started = '1') then
            if (clk_new_bit = '1' and bits_counter /=  9) then
                body_message(bits_counter - 1) <= RXD_i;                                   
            end if;
        end if;
end process;

with body_message(3 downto 0) select
    digits(7 downto 0) <= "00000011" when "0000",
                "10011111" when "0001",
                "00100101" when "0010",
                "00001101" when "0011",
                "10011001" when "0100",
                "01001001" when "0101",
                "01000001" when "0110",
                "00011111" when "0111",
                "00000001" when "1000",
                "00001001" when "1001",
                "00010001" when "1010",
                "11000001" when "1011",
                "01100011" when "1100",
                "10000101" when "1101",
                "01100001" when "1110",
                "01110001" when "1111",
                "00000001" when others;
                
with body_message(7 downto 4) select
    digits(15 downto 8) <= "00000011" when "0000",
                "10011111" when "0001",
                "00100101" when "0010",
                "00001101" when "0011",
                "10011001" when "0100",
                "01001001" when "0101",
                "01000001" when "0110",
                "00011111" when "0111",
                "00000001" when "1000",
                "00001001" when "1001",
                "00010001" when "1010",
                "11000001" when "1011",
                "01100011" when "1100",
                "10000101" when "1101",
                "01100001" when "1110",
                "01110001" when "1111",
                "00000001" when others;
                         
 digits_out <= digits;   
 

end Behavioral;
