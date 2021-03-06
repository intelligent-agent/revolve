EESchema Schematic File Version 4
LIBS:Revolve_SPICE-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1600 3150 1900 3150
Wire Wire Line
	1900 3650 1900 3150
Connection ~ 1900 3150
Wire Wire Line
	1900 4250 1900 4650
$Comp
L power:GND #PWR01
U 1 1 5D59AE01
P 1900 4650
F 0 "#PWR01" H 1900 4400 50  0001 C CNN
F 1 "GND" H 1905 4477 50  0000 C CNN
F 2 "" H 1900 4650 50  0001 C CNN
F 3 "" H 1900 4650 50  0001 C CNN
	1    1900 4650
	1    0    0    -1  
$EndComp
Text GLabel 1600 3150 0    50   Input ~ 0
vin
Text GLabel 6750 3150 2    50   Input ~ 0
vout
Wire Wire Line
	6150 3150 6150 3450
Connection ~ 6150 3150
Wire Wire Line
	6150 3150 6750 3150
$Comp
L power:GND #PWR03
U 1 1 5E4EBDEE
P 6150 4650
F 0 "#PWR03" H 6150 4400 50  0001 C CNN
F 1 "GND" H 6155 4477 50  0000 C CNN
F 2 "" H 6150 4650 50  0001 C CNN
F 3 "" H 6150 4650 50  0001 C CNN
	1    6150 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 3150 6150 3150
Wire Wire Line
	4900 4000 4900 3450
Wire Wire Line
	3500 3450 3500 4000
Wire Wire Line
	1900 3150 2950 3150
Text GLabel 4000 4000 1    50   Input ~ 0
Vgate
Text GLabel 4000 3150 1    50   Input ~ 0
SS
$Comp
L pspice:VSOURCE Vct
U 1 1 5DB222F3
P 2950 2650
F 0 "Vct" H 3178 2696 50  0000 L CNN
F 1 "PULSE (0 6 10u 1u 1u 1 1)" H 3178 2605 50  0000 L CNN
F 2 "" H 2950 2650 50  0001 C CNN
F 3 "~" H 2950 2650 50  0001 C CNN
F 4 "V" H 2950 2650 50  0001 C CNN "Spice_Primitive"
F 5 "Y" H 2950 2650 50  0001 C CNN "Spice_Netlist_Enabled"
	1    2950 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 2950 2950 3150
Connection ~ 2950 3150
Wire Wire Line
	2950 2350 2950 2100
Wire Wire Line
	2950 2100 3800 2100
$Comp
L Device:Q_NMOS_DGS Q6
U 1 1 5DB5B5C4
P 3500 3250
F 0 "Q6" V 3843 3250 50  0000 C CNN
F 1 "Q_NMOS_DGS" V 3752 3250 50  0000 C CNN
F 2 "" H 3700 3350 50  0001 C CNN
F 3 "~" H 3500 3250 50  0001 C CNN
F 4 "X" H 3500 3250 50  0001 C CNN "Spice_Primitive"
F 5 "BSC020N03LS_L0" H 3500 3250 50  0001 C CNN "Spice_Model"
F 6 "Y" H 3500 3250 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "Infineon-SimulationModel_OptiMOS_PowerMOSFET_PSpice_30V_N-Channel-SM-v01_00-EN/03_OptiMOS3/OptiMOS3_30V.lib" H 3500 3250 50  0001 C CNN "Spice_Lib_File"
	1    3500 3250
	0    -1   -1   0   
$EndComp
$Comp
L Device:Q_NMOS_DGS Q7
U 1 1 5DB63888
P 4900 3250
F 0 "Q7" V 5243 3250 50  0000 C CNN
F 1 "Q_NMOS_DGS" V 5152 3250 50  0000 C CNN
F 2 "" H 5100 3350 50  0001 C CNN
F 3 "~" H 4900 3250 50  0001 C CNN
F 4 "X" H 4900 3250 50  0001 C CNN "Spice_Primitive"
F 5 "BSC020N03LS_L0" H 4900 3250 50  0001 C CNN "Spice_Model"
F 6 "Y" H 4900 3250 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "Infineon-SimulationModel_OptiMOS_PowerMOSFET_PSpice_30V_N-Channel-SM-v01_00-EN/03_OptiMOS3/OptiMOS3_30V.lib" H 4900 3250 50  0001 C CNN "Spice_Lib_File"
	1    4900 3250
	0    1    -1   0   
$EndComp
$Comp
L Device:Q_PMOS_DGS Q?
U 1 1 5EB08D35
P 4250 3650
F 0 "Q?" H 4456 3604 50  0000 L CNN
F 1 "Q_PMOS_DGS" H 4456 3695 50  0000 L CNN
F 2 "" H 4450 3750 50  0001 C CNN
F 3 "~" H 4250 3650 50  0001 C CNN
F 4 "X" H 4250 3650 50  0001 C CNN "Spice_Primitive"
F 5 "SiSS27DN" H 4250 3650 50  0001 C CNN "Spice_Model"
F 6 "Y" H 4250 3650 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "siss27dn/SiSS27DN_PS Rev A.LIB" H 4250 3650 50  0001 C CNN "Spice_Lib_File"
	1    4250 3650
	-1   0    0    -1  
$EndComp
$Comp
L pspice:VSOURCE Vct2
U 1 1 5EB1B060
P 5450 4200
F 0 "Vct2" H 5678 4246 50  0000 L CNN
F 1 "PULSE (0 24 5u 1u 1u 1 1)" H 5678 4155 50  0000 L CNN
F 2 "" H 5450 4200 50  0001 C CNN
F 3 "~" H 5450 4200 50  0001 C CNN
F 4 "V" H 5450 4200 50  0001 C CNN "Spice_Primitive"
F 5 "Y" H 5450 4200 50  0001 C CNN "Spice_Netlist_Enabled"
	1    5450 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EB240A1
P 5450 4650
F 0 "#PWR?" H 5450 4400 50  0001 C CNN
F 1 "GND" H 5455 4477 50  0000 C CNN
F 2 "" H 5450 4650 50  0001 C CNN
F 3 "" H 5450 4650 50  0001 C CNN
	1    5450 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 4500 5450 4650
Wire Wire Line
	5450 3900 5450 3650
Wire Wire Line
	5450 3650 4450 3650
Text GLabel 5450 3650 2    50   Input ~ 0
src
Wire Wire Line
	4150 4000 4900 4000
Connection ~ 4150 4000
Wire Wire Line
	4150 3850 4150 4000
Wire Wire Line
	4150 3150 4700 3150
Wire Wire Line
	3700 3150 4150 3150
Connection ~ 4150 3150
Wire Wire Line
	4150 3150 4150 3450
Wire Wire Line
	6150 3750 6150 4650
Wire Wire Line
	3800 4000 4150 4000
Wire Wire Line
	3500 4000 3800 4000
Connection ~ 3800 4000
$Comp
L Device:R R1
U 1 1 5E4EB923
P 6150 3600
F 0 "R1" H 6220 3646 50  0000 L CNN
F 1 "1K" H 6220 3555 50  0000 L CNN
F 2 "" V 6080 3600 50  0001 C CNN
F 3 "~" H 6150 3600 50  0001 C CNN
	1    6150 3600
	1    0    0    -1  
$EndComp
$Comp
L pspice:VSOURCE Vinput
U 1 1 5D599E1E
P 1900 3950
F 0 "Vinput" H 2128 3996 50  0000 L CNN
F 1 "PULSE (0 24 1n 1u 1u 1 1)" H 2128 3905 50  0000 L CNN
F 2 "" H 1900 3950 50  0001 C CNN
F 3 "~" H 1900 3950 50  0001 C CNN
F 4 "V" H 1900 3950 50  0001 C CNN "Spice_Primitive"
F 5 "Y" H 1900 3950 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1900 3950
	1    0    0    -1  
$EndComp
Text Notes 1250 4550 0    50   ~ 0
.tran 10n 10u
Wire Wire Line
	3800 2600 3800 4000
Wire Wire Line
	3800 2100 3800 2200
$Comp
L Device:Q_PMOS_DGS Q3
U 1 1 5DB2EED0
P 3700 2400
F 0 "Q3" H 3906 2354 50  0000 L CNN
F 1 "Q_PMOS_DGS" H 3906 2445 50  0000 L CNN
F 2 "" H 3900 2500 50  0001 C CNN
F 3 "~" H 3700 2400 50  0001 C CNN
F 4 "X" H 3700 2400 50  0001 C CNN "Spice_Primitive"
F 5 "SiSS27DN" H 3700 2400 50  0001 C CNN "Spice_Model"
F 6 "Y" H 3700 2400 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "siss27dn/SiSS27DN_PS Rev A.LIB" H 3700 2400 50  0001 C CNN "Spice_Lib_File"
	1    3700 2400
	1    0    0    1   
$EndComp
Wire Wire Line
	3500 2400 3250 2400
Wire Wire Line
	3250 3150 3300 3150
Wire Wire Line
	2950 3150 3250 3150
Connection ~ 3250 3150
Wire Wire Line
	3250 2400 3250 3150
$EndSCHEMATC
