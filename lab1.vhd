----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2022 06:31:46 PM
-- Design Name: 
-- Module Name: Parzystosc - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab1 is
Port ( sw_i : in  STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o : out  STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out  STD_LOGIC_VECTOR (7 downto 0));
end lab1;

architecture Behavioral of lab1 is
    signal wynik : Natural := 0;
    signal number: Natural := 0;
begin


--led7_an_o <= "1110";
tb: process
begin 
    number <= 0;
    for I in 0 to 7 loop
        if sw_i(I) = '1' then 
            number <= number + 1;
        end if;
    end loop;

wynik <= number mod 2;

end process;

with wynik select 
    led7_seg_o    <=   "01100001" when 0,  --0 
              "00000011" when 1,  --1 
              "11111100"   when others;     -- inne 

end Behavioral;
