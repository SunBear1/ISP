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

           btn_i : in STD_LOGIC_VECTOR (3 downto 0);
           
           rst_i : in STD_LOGIC;
           
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);

           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);

           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));

end top;

architecture Behavioral of top is

signal hex_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal dot_values : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_digits : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal digits : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
signal clk_div : STD_LOGIC  := '0';
begin

process(clk_i)
    variable counter: integer := 0;
    begin
    if (rising_edge(clk_i)) then
        counter := counter + 1;
        if counter = 50000 then
            counter := 0;
            clk_div <= not clk_div;
        end if;
    end if;
end process;



process(rst_i,clk_div,btn_i,led_digits,sw_i,digits)
    variable seg_setter: integer := 0;
    begin
        if clk_div = '1' then
            seg_setter := seg_setter + 1;
            
            if seg_setter = 4 then
                seg_setter := 0;
            end if;
            
            if btn_i(0) = '1' then 
                digits(7 downto 1) <= led_digits;
                led7_seg_o <= digits(7 downto 0);    
            end if;
            if btn_i(1) = '1' then 
                digits(15 downto 9) <= led_digits;
                led7_seg_o <= digits(15 downto 8); 
            end if;
            if btn_i(2) = '1' then 
                digits(23 downto 17) <= led_digits;
                led7_seg_o <= digits(23 downto 16);
            end if;
            if btn_i(3) = '1' then 
                digits(31 downto 25) <= led_digits;
                led7_seg_o <= digits(31 downto 24);
            end if;
            if rst_i = '1' then 
               digits(31 downto 0) <= "00000011000000110000001100000011";
            end if;
            
            if seg_setter = 0 then
                led7_an_o <= "0111";
            elsif seg_setter = 1 then
                led7_an_o <= "1011";
            elsif seg_setter = 2 then
                led7_an_o <= "1101";
            elsif seg_setter = 3 then
                led7_an_o <= "1110";
            end if;
                            
            if sw_i(4) = '1' then
                digits(0) <= '0';
            end if;
            if sw_i(5) = '1' then
                digits(8) <= '0';
            end if;
            if sw_i(6) = '1' then
                digits(16) <= '0';
            end if;
            if sw_i(7) = '1' then
                digits(24) <= '0';
            end if;  
        end if;
end process;

hex_values <= sw_i(3 downto 0);

with hex_values select
    led_digits <= "0000001" when "0000",
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
   
--dot_values <= sw_i(7 downto 4);

--with dot_values select
--    led_digits(7) <= '1' when "0000",
--                '0' when others;
                      
--kropki
--digits(0) <= '0' when sw_i(4) = '1' else 
--              '1';
--digits(8) <= '0' when sw_i(5) = '1' else 
--              '1';
--digits(16) <= '0' when sw_i(6) = '1' else 
--              '1';
--digits(24) <= '0' when sw_i(7) = '1' else 
--              '1';

--wybór wyświetlacza
--digits(7 downto 1) <= led_digits when btn_i(0) = '1';                                  
--digits(15 downto 9) <= led_digits when btn_i(1) = '1';                                  
--digits(23 downto 17) <= led_digits when btn_i(2) = '1';                                  
--digits(31 downto 25) <= led_digits when btn_i(3) = '1';   
     
--przycisk resetowy                    
--digits(31 downto 0) <= "00000011000000110000001100000011" when btn_i(4) = '1';

          

--zapalanie wyświetlaczy
            
            --led7_seg_o <=  digits(31 downto 24) when (btn_i(3) = '1' and rst_i = '0') else
					--	digits(23 downto 16) when (btn_i(2) = '1' and rst_i = '0') else
					--	digits(15 downto 8) when (btn_i(1) = '1' and rst_i = '0') else
					--	digits(7 downto 0) when (btn_i(0) = '1' and rst_i = '0');
						--else
						--"11111111";
						
--led7_an_o <=   "0111" when (btn_i(3) = '1' and rst_i = '0') else 
--						"1011" when (btn_i(2) = '1' and rst_i = '0') else
--						"1101" when (btn_i(1) = '1' and rst_i = '0') else
--						"1110" when (btn_i(0) = '1' and rst_i = '0') else
--						"1111"; 


end Behavioral;
