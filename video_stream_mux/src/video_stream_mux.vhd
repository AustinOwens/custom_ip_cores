----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Austin Owens
-- 
-- Create Date: 11/30/2019 02:12:32 AM
-- Design Name: 
-- Module Name: video_stream_mux - Behavioral
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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY video_stream_mux IS
	PORT(s_axis1_aclk       : IN  STD_LOGIC;
	     s_axis1_tdata      : IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
	     s_axis1_tkeep      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	     s_axis1_tlast      : IN  STD_LOGIC;
	     s_axis1_tready     : OUT STD_LOGIC;
	     s_axis1_tuser      : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
	     s_axis1_tvalid     : IN  STD_LOGIC;
	     s_axis2_aclk       : IN  STD_LOGIC;
	     s_axis2_tdata      : IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
	     s_axis2_tkeep      : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	     s_axis2_tlast      : IN  STD_LOGIC;
	     s_axis2_tready     : OUT STD_LOGIC;
	     s_axis2_tuser      : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
	     s_axis2_tvalid     : IN  STD_LOGIC;
	     m_axis_s2mm_aclk   : OUT STD_LOGIC;
	     m_axis_s2mm_tdata  : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
	     m_axis_s2mm_tkeep  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	     m_axis_s2mm_tuser  : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
	     m_axis_s2mm_tvalid : OUT STD_LOGIC;
	     m_axis_s2mm_tready : IN  STD_LOGIC;
	     m_axis_s2mm_tlast  : OUT STD_LOGIC;
	     ctl                : IN  STD_LOGIC);
END video_stream_mux;

ARCHITECTURE Behavioral OF video_stream_mux IS

BEGIN
	WITH ctl SELECT m_axis_s2mm_aclk <=
		s_axis1_aclk WHEN '0',
		s_axis2_aclk WHEN OTHERS;
		
	WITH ctl SELECT m_axis_s2mm_tdata <=
		s_axis1_tdata WHEN '0',
		s_axis2_tdata WHEN OTHERS;

	WITH ctl SELECT m_axis_s2mm_tkeep <=
		s_axis1_tkeep WHEN '0',
		s_axis2_tkeep WHEN OTHERS;

	WITH ctl SELECT m_axis_s2mm_tlast <=
		s_axis1_tlast WHEN '0',
		s_axis2_tlast WHEN OTHERS;

	WITH ctl SELECT s_axis1_tready <=
		m_axis_s2mm_tready WHEN '0',
		'0' WHEN OTHERS;

	WITH ctl SELECT s_axis2_tready <=
		'0' WHEN '0',
		m_axis_s2mm_tready WHEN OTHERS;

	WITH ctl SELECT m_axis_s2mm_tuser <=
		s_axis1_tuser WHEN '0',
		s_axis2_tuser WHEN OTHERS;

	WITH ctl SELECT m_axis_s2mm_tvalid <=
		s_axis1_tvalid WHEN '0',
		s_axis2_tvalid WHEN OTHERS;

END Behavioral;
