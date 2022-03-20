----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2022 12:42:58 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
component top is
     Port ( clk_i : in STD_LOGIC;

           btn_i : in STD_LOGIC_VECTOR (4 downto 0);
           
           rst_i : in STD_LOGIC;
           
           sw_i : in STD_LOGIC_VECTOR (7 downto 0);

           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);

           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component top;
signal clk : STD_LOGIC := '0';
signal btn : STD_LOGIC_VECTOR (4 downto 0) := "00000";
signal sw :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal rst : STD_LOGIC := '0';
signal led7_an : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led7_seg : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
constant PERIOD : time := 10 ns;
constant DUTY_CYCLE : real := 0.25;

begin
dut: top port map(
rst_i => rst,
clk_i => clk,
btn_i => btn,
sw_i => sw,
led7_an_o => led7_an,
led7_seg_o => led7_seg
);
--sw <= "00100011";
--btn(1) <= '1';
clk <= not clk after 10ns;
--clk <= '1' after (PERIOD - (PERIOD * DUTY_CYCLE)) when clk = '0'
--    else '0' after (PERIOD * DUTY_CYCLE);
butons: process
begin
    sw(7 downto 4) <= "0110";
    sw(3 downto 0) <= "0001";
    btn(0) <= '1';
    wait for 1ms;
    btn(0) <= '0';
    wait for 2ms;
    
    --sw(7 downto 4) <= "1001";
    sw(3 downto 0) <= "0010";
    btn(1) <= '1';
    wait for 1ms;
    btn(1) <= '0';
    wait for 2ms;
    
    --sw(7 downto 4) <= "0110";
    sw(3 downto 0) <= "0011";
    btn(2) <= '1';
    wait for 1ms;
    btn(2) <= '0';
    wait for 2ms;
    
    --sw(7 downto 4) <= "1001";
    sw(3 downto 0) <= "0100";
    btn(3) <= '1';
    wait for 1ms;
    btn(3) <= '0';
    wait for 2ms;
    
    
    --btn(1) <= '1';
    --wait for 1ms;
    --btn(2) <= '1';
    --wait for 1ms;
    --btn(3) <= '1';
    --wait for 1ms;
    --btn(0) <= '0';
    

end process;
--btn(0) <= '1';
--sw(7 downto 4) <= "1100";
--sw(3 downto 0) <= "0001";
end Behavioral;
