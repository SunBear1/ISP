----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2022 01:38:36 PM
-- Design Name: 
-- Module Name: memory - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
           rst_i : in STD_LOGIC;
           RXD_i : in STD_LOGIC;
           digits_out : out STD_LOGIC_VECTOR (15 downto 0));
end memory;

architecture Behavioral of memory is
signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_code : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal clk_div : STD_LOGIC  := '0';
signal digits : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
signal bits_counter: integer := 0;
signal begin_message: STD_LOGIC := '0';
signal end_message: STD_LOGIC := '0';
signal body_message: std_logic_vector(7 downto 0) := "00000000";

begin
process(clk_i)
    variable counter: integer := 0;
    variable frequency: integer := 5208;
    begin
    if (rising_edge(clk_i)) then
        -- u¿ywaj równoœci zamiast nierównoœci!!
        counter := counter + 1;
        
        if counter = frequency then -- czy przerwano serie '1' ?
            counter := 0;
            bits_counter <= bits_counter + 1;
            
            if bits_counter = 1 then
            
                if RXD_i = '0' then
                    begin_message <= '1';
                end if;
                
            elsif bits_counter > 1 and bits_counter < 10 and begin_message = '1' then
                body_message(bits_counter - 2) <= RXD_i;
                
            elsif bits_counter = 10 and begin_message = '1' then
                end_message <= '1';
                begin_message <= '0';
                bits_counter <= 0;
            end if;
            
            clk_div <= not clk_div;
            
        end if;
    end if;
end process;

process(clk_div, rst_i)
variable bits_received: integer := 0;
    begin
            if clk_div = '1' then
                                                         
            end if;

end process;


with hex_values select
    led_code <= "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0000100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "0000000" when others;
                
 digits_out <= digits;               

end Behavioral;