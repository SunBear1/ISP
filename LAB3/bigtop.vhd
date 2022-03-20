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
use IEEE.STD_LOGIC_ARITH.all;
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

           btn_i : in STD_LOGIC_VECTOR (4 downto 0);
           
           rst_i : in STD_LOGIC;
           
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);

           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);

           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));

end top;

architecture Behavioral of top is

signal reset_btn : STD_LOGIC := '0';
signal lightem_up : STD_LOGIC_VECTOR := sw_i(7 downto 0);
signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_digits : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal digits : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
signal active_an: std_logic_vector(1 downto 0) := "00";

begin

process(rst_i,clk_i)
    constant N: integer := 100000; -- 100 MHz / 1 KHz
    variable counter: integer := 0;
    begin
    --zegar
    if (rst_i = '1') then 
        counter := 0;
      elsif (rising_edge(clk_i)) then 
        if(counter < N) then 
            counter := counter + 1;
        else
            counter := 0;
            active_an <= active_an + 1;
        end if;    
      end if;
end process;

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
    

--wybór wyświetlacza
digits(7 downto 0) <= led_digits when btn_i(0) = '1';                                  
digits(15 downto 8) <= led_digits when btn_i(1) = '1';                                  
digits(23 downto 16) <= led_digits when btn_i(2) = '1';                                  
digits(31 downto 24) <= led_digits when btn_i(3) = '1';      
     
--przycisk resetowy                    
digits(31 downto 0) <= "00000011000000110000001100000011" when btn_i(4) = '1';

--kropki
digits(7) <= '1' when sw_i(4) = '1' 
                    else '0';
digits(15) <= '1' when sw_i(5) = '1' 
                    else '0';
digits(23) <= '1' when sw_i(6) = '1' 
                    else '0';
digits(31) <= '1' when sw_i(7) = '1' 
                    else '0';           

--zapalanie wyświetlaczy
led7_seg_o <=  digits(31 downto 24) when (active_an = "00" and rst_i = '0') else
						digits(23 downto 16) when (active_an = "01" and rst_i = '0') else
						digits(15 downto 8) when (active_an = "10" and rst_i = '0') else
						digits(7 downto 0) when (active_an = "11" and rst_i = '0') else
						"00000000";
						
led7_an_o <=   "0111" when (active_an = "00" and rst_i = '0') else 
						"1011" when (active_an = "01" and rst_i = '0') else
						"1101" when (active_an = "10" and rst_i = '0') else
						"1110" when (active_an = "11" and rst_i = '0') else
						"0000"; 


end Behavioral;
