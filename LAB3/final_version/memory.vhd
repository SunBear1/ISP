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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    Port ( clk_i : in STD_LOGIC;

           btn_i : in STD_LOGIC_VECTOR (3 downto 0);
           
           rst_i : in STD_LOGIC;
          
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);
           
           digits_out : out STD_LOGIC_VECTOR (31 downto 0));
end memory;

architecture Behavioral of memory is
signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_code : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal clk_div : STD_LOGIC  := '0';
begin
process(clk_i,rst_i)
    begin
            if btn_i(0) = '1' then 
                digits_out(7 downto 1) <= led_code;  
            end if;
            if btn_i(1) = '1' then 
                digits_out(15 downto 9) <= led_code; 
            end if;
            if btn_i(2) = '1' then 
               digits_out(23 downto 17) <= led_code; 
            end if;
            if btn_i(3) = '1' then 
                digits_out(31 downto 25) <= led_code;   
            end if;
            
            if sw_i(4) = '1' then
                digits_out(0) <= '0';
            else
                digits_out(0) <= '1';
            end if;
            if sw_i(5) = '1' then
                digits_out(8) <= '0';
            else
                digits_out(8) <= '1';
            end if;
            if sw_i(6) = '1' then
                digits_out(16) <= '0';
            else
                digits_out(16) <= '1';
            end if;
            if sw_i(7) = '1' then
                digits_out(24) <= '0';
            else
                digits_out(24) <= '1';
            end if;
            
            if rst_i = '1' then 
               digits_out(31 downto 0) <= "11111101111111011111110111111101";
            end if;

end process;

hex_values <= sw_i(3 downto 0);

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

--digits_out(7 downto 0) <= led_code when btn_i(0) = '1';                                  
--digits_out(15 downto 8) <= led_code when btn_i(1) = '1';                                  
--digits_out(23 downto 16) <= led_code when btn_i(2) = '1';                                  
--digits_out(31 downto 24) <= led_code when btn_i(3) = '1';                                  

--digits_out(0) <= '0' when sw_i(4) = '1' else 
--              '1';
--digits_out(8) <= '0' when sw_i(5) = '1' else 
--              '1';
--digits_out(16) <= '0' when sw_i(6) = '1' else 
--              '1';
--digits_out(24) <= '0' when sw_i(7) = '1' else 
 --             '1';

end Behavioral;
