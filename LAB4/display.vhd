----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2022 01:38:14 PM
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is
    Port ( clk_i : in STD_LOGIC;
           
           rst_i : in STD_LOGIC;
           
           digits_in : in STD_LOGIC_VECTOR (15 downto 0);
           
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);

           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end display;

architecture Behavioral of display is
signal dot_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal clk_div : STD_LOGIC  := '0';
signal anoda_selector: std_logic_vector(1 downto 0) := "00";
begin

process(clk_i)
    variable counter: integer := 0;
    begin
    if (rising_edge(clk_i)) then
        counter := counter + 1;
        if counter = 50000 then
            counter := 0;
            --odœwie¿anie wyœwietlacza
            anoda_selector <= anoda_selector + 1;
        end if;
    end if;
end process;


led7_seg_o <=  digits_in(15 downto 8) when (anoda_selector = "10" and rst_i = '0') else
						digits_in(7 downto 0) when (anoda_selector = "11" and rst_i = '0') else
						"00000000";
						
led7_an_o <= "1101" when (anoda_selector = "10" and rst_i = '0') else
                    "1110" when (anoda_selector = "11" and rst_i = '0') else
                    "0000";
end Behavioral;