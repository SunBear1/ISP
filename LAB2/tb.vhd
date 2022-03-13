----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2022 02:08:22 PM
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
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (2 downto 0));
end component top;
signal clk : STD_LOGIC := '0';
signal rst : STD_LOGIC := '1';
signal led : STD_LOGIC_VECTOR (2 downto 0) := "000";
constant PERIOD : time := 10 ns;
constant DUTY_CYCLE : real := 0.25;
begin
dut: top port map(
clk_i => clk,
rst_i => rst,
led_o => led
);

rst <= '0' after 15ns;
clk <= '1' after (PERIOD - (PERIOD * DUTY_CYCLE)) when clk = '0'
    else '0' after (PERIOD * DUTY_CYCLE);
end Behavioral;
