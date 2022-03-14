----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 10:28:49 AM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is

    Port ( clk_i : in STD_LOGIC;

           btn_i : in STD_LOGIC_VECTOR (4 downto 0);

           sw_i : in STD_LOGIC_VECTOR (7 downto 0);

           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);

           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));

end top;

architecture Behavioral of top is

signal reset_btn : STD_LOGIC := '0';
signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal lightem_up : STD_LOGIC_VECTOR := sw_i(7 downto 0);

signal digit_o : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";

begin

process(rst_i,clk_i)
    begin
    --case dla resetu
    --zapal konkretne czesci segmentu
      if (digit_o(31 downto 24) /= "00000000") then 
            led7_an_o <= "1110";
      if (digit_o(23 downto 16) /= "00000000") then 
            led7_an_o <= "1101";
      if (digit_o(15 downto 8) /= "00000000") then 
            led7_an_o <= "1011";
      if (digit_o(7 downto 0) /= "00000000") then 
            led7_an_o <= "0111";
            
      elsif (rising_edge(clk_i)) then 

     
    end process;



end Behavioral;
