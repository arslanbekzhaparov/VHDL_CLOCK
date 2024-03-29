LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY BCDCOUNT IS
	port(
	KEY0, KEY1, SW9, CLK_50 :IN STD_LOGIC;
	LEDR9 : OUT STD_LOGIC;
	MSD0, LSD0, MSD1, LSD1, MSD2, LSD2 :OUT STD_LOGIC_VECTOR (0 to 6)
	);
END BCDCOUNT;

ARCHITECTURE a of BCDCOUNT is
	SIGNAL ClkFlag: STD_LOGIC;
	SIGNAL Internal_Count: STD_LOGIC_VECTOR(28 downto 0);
	SIGNAL HighDigit0, LowDigit0, HighDigit1, LowDigit1, HighDigit2, LowDigit2: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL MSD_7SEG0, LSD_7SEG0, MSD_7SEG1, LSD_7SEG1, MSD_7SEG2, LSD_7SEG2: STD_LOGIC_VECTOR(0 to 6);
BEGIN
		
		LSD0<=LSD_7SEG0;
		MSD0<=MSD_7SEG0;
		LSD1<=LSD_7SEG1;
		MSD1<=MSD_7SEG1;
		LSD2<=LSD_7SEG2;
		MSD2<=MSD_7SEG2;

PROCESS(CLK_50)
BEGIN
	if(CLK_50'event and CLK_50='1') then
		if Internal_Count<25000000 then
			Internal_Count<=Internal_Count+1;
		else Internal_Count<=(others=>'0');
			ClkFlag<=not ClkFlag;
		end if;
	end if;
END PROCESS;

PROCESS(ClkFlag, KEY0, KEY1)
BEGIN
		
	if(KEY0='0')then--reset
		LowDigit0<="0000";
		HighDigit0<="0000";
		LowDigit1<="0000";
		HighDigit1<="0000";
		LowDigit2<="0000";
		HighDigit2<="0000";
	elsif(KEY1='0')then
		LowDigit2<="0010";
		HighDigit2<="0001";
		
		
		elsif(ClkFlag'event and ClkFlag='1') then
		
		if (LowDigit0=9) then --seconds
			
			LowDigit0<="0000";
			
			if (HighDigit0=5) then
				
				HighDigit0<="0000";
				
			else HighDigit0<=HighDigit0+'1';
			
			end if;
			
			else
				
				LowDigit0<=LowDigit0+'1';
			
			end if;
			
			if(LowDigit0=9 and HighDigit0=5) then --minutes
				
				if (LowDigit1=9) then
					
					LowDigit1<="0000";
				
					if (HighDigit1=5) then
						
						HighDigit1<="0000";
					
					else HighDigit1<=HighDigit1+'1';
					
					end if;
				
				else
				
				LowDigit1<=LowDigit1+'1';
				
				end if;
			
			end if;
		
		if(LowDigit1=9 and HighDigit1=5) then --hours
			
			if (LowDigit2=9) then
				
				LowDigit2<="0000";
				
				if (HighDigit2=1 and LowDigit2=3) then
					
					HighDigit2<="0000";
					
					LowDigit2<="0001";
				
				else 
					
					HighDigit2<=HighDigit2+'1';
				
				end if;
			
			else
				
				LowDigit2<=LowDigit2+'1';
			
			end if;
		
		end if;
			
		
		end if;
	END PROCESS;

PROCESS(LowDigit0, HighDigit0)
BEGIN
	
	if (SW9='0') then
		LEDR9 <='1';
		
		
	case LowDigit0 is
		when "0000" => LSD_7SEG0<="0000001";
		when "0001" => LSD_7SEG0<="1001111";
		when "0010" => LSD_7SEG0<="0010010";
		when "0011" => LSD_7SEG0<="0000110";
		when "0100" => LSD_7SEG0<="1001100";
		when "0101" => LSD_7SEG0<="0100100";
		when "0110" => LSD_7SEG0<="0100000";
		when "0111" => LSD_7SEG0<="0001111";
		when "1000" => LSD_7SEG0<="0000000";
		when "1001" => LSD_7SEG0<="0000100";
		when others => LSD_7SEG0<="1111111";
	end case;
	case HighDigit0 is
		when "0000" => MSD_7SEG0<="0000001";
		when "0001" => MSD_7SEG0<="1001111";
		when "0010" => MSD_7SEG0<="0010010";
		when "0011" => MSD_7SEG0<="0000110";
		when "0100" => MSD_7SEG0<="1001100";
		when "0101" => MSD_7SEG0<="0100100";
		when "0110" => MSD_7SEG0<="0100000";
		when "0111" => MSD_7SEG0<="0001111";
		when "1000" => MSD_7SEG0<="0000000";
		when "1001" => MSD_7SEG0<="0000100";
		when others => MSD_7SEG0<="1111111";
	end case;


	case LowDigit1 is
		when "0000" => LSD_7SEG1<="0000001";
		when "0001" => LSD_7SEG1<="1001111";
		when "0010" => LSD_7SEG1<="0010010";
		when "0011" => LSD_7SEG1<="0000110";
		when "0100" => LSD_7SEG1<="1001100";
		when "0101" => LSD_7SEG1<="0100100";
		when "0110" => LSD_7SEG1<="0100000";
		when "0111" => LSD_7SEG1<="0001111";
		when "1000" => LSD_7SEG1<="0000000";
		when "1001" => LSD_7SEG1<="0000100";
		when others => LSD_7SEG1<="1111111";
	end case;
	case HighDigit1 is
		when "0000" => MSD_7SEG1<="0000001";
		when "0001" => MSD_7SEG1<="1001111";
		when "0010" => MSD_7SEG1<="0010010";
		when "0011" => MSD_7SEG1<="0000110";
		when "0100" => MSD_7SEG1<="1001100";
		when "0101" => MSD_7SEG1<="0100100";
		when "0110" => MSD_7SEG1<="0100000";
		when "0111" => MSD_7SEG1<="0001111";
		when "1000" => MSD_7SEG1<="0000000";
		when "1001" => MSD_7SEG1<="0000100";
		when others => MSD_7SEG1<="1111111";
	end case;


	case LowDigit2 is
		when "0000" => LSD_7SEG2<="0000001";
		when "0001" => LSD_7SEG2<="1001111";
		when "0010" => LSD_7SEG2<="0010010";
		when "0011" => LSD_7SEG2<="0000110";
		when "0100" => LSD_7SEG2<="1001100";
		when "0101" => LSD_7SEG2<="0100100";
		when "0110" => LSD_7SEG2<="0100000";
		when "0111" => LSD_7SEG2<="0001111";
		when "1000" => LSD_7SEG2<="0000000";
		when "1001" => LSD_7SEG2<="0000100";
		when others => LSD_7SEG2<="1111111";
	end case;
	case HighDigit2 is
		when "0000" => MSD_7SEG2<="0000001";
		when "0001" => MSD_7SEG2<="1001111";
		when "0010" => MSD_7SEG2<="0010010";
		when "0011" => MSD_7SEG2<="0000110";
		when others => MSD_7SEG2<="1111111";
	end case;
	else
		LEDR9 <='0';
		case LowDigit0 is
				when "0000" => LSD_7SEG0 <= "0011000";
				when "0001" => LSD_7SEG0 <= "0011000";
				when "0010" => LSD_7SEG0 <= "0011000";
				when "0011" => LSD_7SEG0 <= "0011000";
				when "0100" => LSD_7SEG0 <= "0011000";
				when "0101" => LSD_7SEG0 <= "0011000";
				when "0110" => LSD_7SEG0 <= "0011000";
				when "0111" => LSD_7SEG0 <= "0011000";
				when "1000" => LSD_7SEG0 <= "0011000";
				when "1001" => LSD_7SEG0 <= "0011000";
				when others => LSD_7SEG0 <= "0011000";
			end case;
			
			case HighDigit0 is
				when "0000" => MSD_7SEG0 <= "1111111";
				when "0001" => MSD_7SEG0 <= "1111111";
				when "0010" => MSD_7SEG0 <= "1111111";
				when "0011" => MSD_7SEG0 <= "1111111";
				when "0100" => MSD_7SEG0 <= "1111111";
				when "0101" => MSD_7SEG0 <= "1111111";
				when "0110" => MSD_7SEG0 <= "1111111";
				when "0111" => MSD_7SEG0 <= "1111111";
				when "1000" => MSD_7SEG0 <= "1111111";
				when "1001" => MSD_7SEG0 <= "1111111";
				when others => MSD_7SEG0 <= "1111111";
			end case;
		end if;
END PROCESS;


end a;