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
           RXD_i : in STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component top;
signal clk : STD_LOGIC := '0';
signal RXD : STD_LOGIC := '1';
signal btn : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal sw :  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
signal rst : STD_LOGIC := '0';
signal led7_an : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led7_seg : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
constant PERIOD : time := 10 ns;
constant DUTY_CYCLE : real := 0.25;

begin
dut: top port map(
clk_i => clk,
RXD_i => RXD,
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
    RXD <= '1';
    wait for 3ms;
    
    RXD <= '0';
    wait for 0.2ms;
    
    RXD <= '1';
    wait for 0.2ms;
    RXD <= '0';
    wait for 0.2ms;
    RXD <= '0';
    wait for 0.2ms;
    RXD <= '1';
    wait for 0.2ms;
    RXD <= '0';
    wait for 0.2ms;
    RXD <= '1';
    wait for 0.2ms;
    RXD <= '0';
    wait for 0.2ms;
    RXD <= '0';
    
    wait for 0.2ms;
    RXD <= '1';
    wait for 3ms;

end process;
end Behavioral;
