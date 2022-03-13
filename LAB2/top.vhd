----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2022 02:07:39 PM
-- Design Name: 
-- Module Name: top - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (2 downto 0));
end top;

architecture Behavioral of top is

signal counter : std_logic_vector(2 downto 0);


begin
 process(rst_i,clk_i)
    begin
      if (rst_i = '1') then 
            counter <= "000";
        elsif (clk_i'event and clk_i = '1') then 
            counter <= counter + 1;
      end if;
      if (counter = "000") then
        led_o <= "000";
      elsif (counter = "001") then
        led_o <= "001";
      elsif (counter = "010") then
        led_o <= "011";
      elsif (counter = "011") then
        led_o <= "010";
      elsif (counter = "100") then
        led_o <= "110";
      elsif (counter = "101") then
        led_o <= "111";
      elsif (counter = "110") then
        led_o <= "101";
      elsif (counter = "111") then
        led_o <= "100";
      end if;
     
    end process;

end Behavioral;
