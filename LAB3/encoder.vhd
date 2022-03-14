----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 11:02:05 AM
-- Design Name: 
-- Module Name: encoder - Behavioral
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

entity encoder is
    
    Port ( clk_i : in STD_LOGIC;           
           btn_i : in STD_LOGIC_VECTOR (4 downto 0);       
           sw_i : in STD_LOGIC_VECTOR (7 downto 0)
           );
    
end encoder;

architecture Behavioral of encoder is
signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_digits : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal digit_o : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
begin


hex_values <= sw_i(3 downto 0);

with hex_values select
    led_digits <= "00000011" when "0000",
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
                "00000000" when others;
    
    
digit_o(7 downto 0) <= led_digits when btn_i(0) = '1';                                  
digit_o(15 downto 8) <= led_digits when btn_i(1) = '1';                                  
digit_o(23 downto 16) <= led_digits when btn_i(2) = '1';                                  
digit_o(31 downto 24) <= led_digits when btn_i(3) = '1';      
                            -- kontrolnie !!!                            
digit_o(31 downto 0) <= "00000011000000110000001100000011" when btn_i(4) = '1';

digit_o(7) <= '1' when sw_i(4) = '1' 
                    else '0';
digit_o(15) <= '1' when sw_i(5) = '1' 
                    else '0';
digit_o(23) <= '1' when sw_i(6) = '1' 
                    else '0';
digit_o(31) <= '1' when sw_i(7) = '1' 
                    else '0';                              
    
end Behavioral;
