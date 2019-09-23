
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cuenta : in STD_LOGIC;
           salida : out STD_LOGIC_VECTOR (3 downto 0));
end contador;

architecture struct of contador is
    component divisor
        port (
            rst: in STD_LOGIC;
            clk_entrada: in STD_LOGIC; -- reloj de entrada de la entity superior
            clk_salida: out STD_LOGIC -- reloj que se utiliza en los process del programa principal
        );
    end component;
    component registro
      Port (
        rst  : IN  std_logic;
        clk  : IN  std_logic;
        load : IN  std_logic;
        E    : IN  std_logic_vector(3 downto 0);
        S    : OUT std_logic_vector(3 downto 0)   
      );
    end component;
    component sumador
      Port (
        A : IN   std_logic_vector(3 downto 0);
        B : IN   std_logic_vector(3 downto 0);
        C : OUT  std_logic_vector(3 downto 0)   
      );
    end component;
    signal cdiv: std_logic;
    signal rout: std_logic_vector(3 downto 0);
    signal sout: std_logic_vector(3 downto 0);
begin
mod_divisor: divisor port map(rst,clk, cdiv);
mod_sumador: sumador port map("0001", rout, sout);
mod_registro: registro port map(rst,cdiv,cuenta,sout, rout);
salida <= rout;

end struct;
