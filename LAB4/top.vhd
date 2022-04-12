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

           rst_i : in STD_LOGIC;

           RXD_i : in STD_LOGIC;

           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);

           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));

end top;

architecture Behavioral of top is
    component memory is
            Port ( clk_i : in STD_LOGIC;
                   RXD_i : in STD_LOGIC;
                   rst_i : in STD_LOGIC;
                   digits_out : out STD_LOGIC_VECTOR (15 downto 0));
    end component memory;
    component display is
        Port ( clk_i : in STD_LOGIC;
               digits_in : in STD_LOGIC_VECTOR (15 downto 0);
               rst_i : in STD_LOGIC;
               led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
               led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component display;
    signal digits : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); 
begin

memory_component: memory port map(rst_i => rst_i, clk_i => clk_i, digits_out => digits,RXD_i => RXD_i);
display_component: display port map(rst_i => rst_i,clk_i => clk_i, digits_in => digits, led7_an_o => led7_an_o, led7_seg_o => led7_seg_o);

end Behavioral;