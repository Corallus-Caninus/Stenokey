EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 1 1
Title "Stenokey"
Date "2017-11-07"
Rev "1.0"
Comp ""
Comment1 "Copyright © 2017, Mike Ady"
Comment2 "The Stenokey circuit board is open source.  It is licensed under the GNU GPL V3.0."
Comment3 "The Stenokey circuit board is based on the Stenoboard by Emanuele Caruso."
Comment4 ""
$EndDescr
$Comp
L Stenokey-rescue:SW_Push SW1
U 1 1 59C04B51
P 1250 1700
F 0 "SW1" H 1000 1800 50  0000 L CNN
F 1 "KEY_R1C1" H 1250 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1250 1900 50  0001 C CNN
F 3 "" H 1250 1900 50  0001 C CNN
	1    1250 1700
	0    -1   -1   0   
$EndComp
Text Label 1250 1000 1    60   ~ 0
COL0
Text Label 1000 2100 2    60   ~ 0
ROW0
$Comp
L Stenokey-rescue:SW_Push SW2
U 1 1 59C04DE6
P 1650 1700
F 0 "SW2" H 1400 1800 50  0000 L CNN
F 1 "KEY_R1C2" H 1650 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1650 1900 50  0001 C CNN
F 3 "" H 1650 1900 50  0001 C CNN
	1    1650 1700
	0    -1   -1   0   
$EndComp
Text Label 1650 1000 1    60   ~ 0
COL1
Wire Wire Line
	1650 2100 1650 1900
$Comp
L Stenokey-rescue:SW_Push SW3
U 1 1 59C04E84
P 2050 1700
F 0 "SW3" H 1800 1800 50  0000 L CNN
F 1 "KEY_R1C3" H 2050 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2050 1900 50  0001 C CNN
F 3 "" H 2050 1900 50  0001 C CNN
	1    2050 1700
	0    -1   -1   0   
$EndComp
Text Label 2050 1000 1    60   ~ 0
COL2
Wire Wire Line
	2050 2100 2050 1900
$Comp
L Stenokey-rescue:SW_Push SW4
U 1 1 59C04E94
P 2450 1700
F 0 "SW4" H 2200 1800 50  0000 L CNN
F 1 "KEY_R1C4" H 2450 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2450 1900 50  0001 C CNN
F 3 "" H 2450 1900 50  0001 C CNN
	1    2450 1700
	0    -1   -1   0   
$EndComp
Text Label 2450 1000 1    60   ~ 0
COL3
Wire Wire Line
	2450 2100 2450 1900
$Comp
L Stenokey-rescue:SW_Push SW5
U 1 1 59C04FDE
P 2850 1700
F 0 "SW5" H 2600 1800 50  0000 L CNN
F 1 "KEY_R1C5" H 2850 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2850 1900 50  0001 C CNN
F 3 "" H 2850 1900 50  0001 C CNN
	1    2850 1700
	0    -1   -1   0   
$EndComp
Text Label 2850 1000 1    60   ~ 0
COL4
Wire Wire Line
	2850 2100 2850 1900
Wire Wire Line
	1250 1900 1250 2100
Connection ~ 1250 2100
Connection ~ 1650 2100
Connection ~ 2050 2100
Connection ~ 2450 2100
Wire Wire Line
	1000 2100 1250 2100
$Comp
L Stenokey-rescue:SW_Push SW11
U 1 1 59C058A7
P 1250 3150
F 0 "SW11" H 1000 3250 50  0000 L CNN
F 1 "KEY_R2C1" H 1250 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1250 3350 50  0001 C CNN
F 3 "" H 1250 3350 50  0001 C CNN
	1    1250 3150
	0    -1   -1   0   
$EndComp
Text Label 1250 2450 1    60   ~ 0
COL0
Text Label 1000 3550 2    60   ~ 0
ROW1
$Comp
L Stenokey-rescue:SW_Push SW12
U 1 1 59C058B7
P 1650 3150
F 0 "SW12" H 1400 3250 50  0000 L CNN
F 1 "KEY_R2C2" H 1650 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1650 3350 50  0001 C CNN
F 3 "" H 1650 3350 50  0001 C CNN
	1    1650 3150
	0    -1   -1   0   
$EndComp
Text Label 1650 2450 1    60   ~ 0
COL1
Wire Wire Line
	1650 3550 1650 3350
$Comp
L Stenokey-rescue:SW_Push SW13
U 1 1 59C058C7
P 2050 3150
F 0 "SW13" H 1800 3250 50  0000 L CNN
F 1 "KEY_R2C3" H 2050 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2050 3350 50  0001 C CNN
F 3 "" H 2050 3350 50  0001 C CNN
	1    2050 3150
	0    -1   -1   0   
$EndComp
Text Label 2050 2450 1    60   ~ 0
COL2
Wire Wire Line
	2050 3550 2050 3350
$Comp
L Stenokey-rescue:SW_Push SW14
U 1 1 59C058D7
P 2450 3150
F 0 "SW14" H 2200 3250 50  0000 L CNN
F 1 "KEY_R2C4" H 2450 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2450 3350 50  0001 C CNN
F 3 "" H 2450 3350 50  0001 C CNN
	1    2450 3150
	0    -1   -1   0   
$EndComp
Text Label 2450 2450 1    60   ~ 0
COL3
Wire Wire Line
	2450 3550 2450 3350
$Comp
L Stenokey-rescue:SW_Push SW15
U 1 1 59C058E7
P 2850 3150
F 0 "SW15" H 2600 3250 50  0000 L CNN
F 1 "KEY_R2C5" H 2850 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2850 3350 50  0001 C CNN
F 3 "" H 2850 3350 50  0001 C CNN
	1    2850 3150
	0    -1   -1   0   
$EndComp
Text Label 2850 2450 1    60   ~ 0
COL4
Wire Wire Line
	2850 3550 2850 3350
Wire Wire Line
	1250 3350 1250 3550
Connection ~ 1250 3550
Connection ~ 1650 3550
Connection ~ 2050 3550
Connection ~ 2450 3550
Wire Wire Line
	1000 3550 1250 3550
$Comp
L Stenokey-rescue:SW_Push SW21
U 1 1 59C05F2B
P 1250 4600
F 0 "SW21" H 1000 4700 50  0000 L CNN
F 1 "KEY_R3C1" H 1250 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1250 4800 50  0001 C CNN
F 3 "" H 1250 4800 50  0001 C CNN
	1    1250 4600
	0    -1   -1   0   
$EndComp
Text Label 1250 3900 1    60   ~ 0
COL0
Text Label 1000 5000 2    60   ~ 0
ROW2
$Comp
L Stenokey-rescue:SW_Push SW22
U 1 1 59C05F3B
P 1650 4600
F 0 "SW22" H 1400 4700 50  0000 L CNN
F 1 "KEY_R3C2" H 1650 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1650 4800 50  0001 C CNN
F 3 "" H 1650 4800 50  0001 C CNN
	1    1650 4600
	0    -1   -1   0   
$EndComp
Text Label 1650 3900 1    60   ~ 0
COL1
Wire Wire Line
	1650 5000 1650 4800
$Comp
L Stenokey-rescue:SW_Push SW23
U 1 1 59C05F4B
P 2050 4600
F 0 "SW23" H 1800 4700 50  0000 L CNN
F 1 "KEY_R3C3" H 2050 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2050 4800 50  0001 C CNN
F 3 "" H 2050 4800 50  0001 C CNN
	1    2050 4600
	0    -1   -1   0   
$EndComp
Text Label 2050 3900 1    60   ~ 0
COL2
Wire Wire Line
	2050 5000 2050 4800
$Comp
L Stenokey-rescue:SW_Push SW24
U 1 1 59C05F5B
P 2450 4600
F 0 "SW24" H 2200 4700 50  0000 L CNN
F 1 "KEY_R3C4" H 2450 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2450 4800 50  0001 C CNN
F 3 "" H 2450 4800 50  0001 C CNN
	1    2450 4600
	0    -1   -1   0   
$EndComp
Text Label 2450 3900 1    60   ~ 0
COL3
Wire Wire Line
	2450 5000 2450 4800
$Comp
L Stenokey-rescue:SW_Push SW25
U 1 1 59C05F6B
P 2850 4600
F 0 "SW25" H 2600 4700 50  0000 L CNN
F 1 "KEY_R3C5" H 2850 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 2850 4800 50  0001 C CNN
F 3 "" H 2850 4800 50  0001 C CNN
	1    2850 4600
	0    -1   -1   0   
$EndComp
Text Label 2850 3900 1    60   ~ 0
COL4
Wire Wire Line
	2850 5000 2850 4800
Wire Wire Line
	1250 4800 1250 5000
Connection ~ 1250 5000
Connection ~ 1650 5000
Connection ~ 2050 5000
Connection ~ 2450 5000
Wire Wire Line
	1000 5000 1250 5000
$Comp
L Stenokey-rescue:SW_Push SW31
U 1 1 59C05F82
P 1250 6050
F 0 "SW31" H 1000 6150 50  0000 L CNN
F 1 "KEY_R4C1" H 1250 5950 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1250 6250 50  0001 C CNN
F 3 "" H 1250 6250 50  0001 C CNN
	1    1250 6050
	0    -1   -1   0   
$EndComp
Text Label 1250 5350 1    60   ~ 0
COL0
Text Label 1000 6450 2    60   ~ 0
ROW3
$Comp
L Stenokey-rescue:SW_Push SW32
U 1 1 59C05F92
P 1650 6050
F 0 "SW32" H 1400 6150 50  0000 L CNN
F 1 "KEY_R4C2" H 1650 5950 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 1650 6250 50  0001 C CNN
F 3 "" H 1650 6250 50  0001 C CNN
	1    1650 6050
	0    -1   -1   0   
$EndComp
Text Label 1650 5350 1    60   ~ 0
COL1
Wire Wire Line
	1250 6250 1250 6450
Connection ~ 1250 6450
$Comp
L Stenokey-rescue:SW_Push SW6
U 1 1 59C0792B
P 3950 1700
F 0 "SW6" H 3700 1800 50  0000 L CNN
F 1 "KEY_R1C6" H 3950 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 3950 1900 50  0001 C CNN
F 3 "" H 3950 1900 50  0001 C CNN
	1    3950 1700
	0    -1   -1   0   
$EndComp
Text Label 3950 1000 1    60   ~ 0
COL5
$Comp
L Stenokey-rescue:SW_Push SW7
U 1 1 59C0793B
P 4350 1700
F 0 "SW7" H 4100 1800 50  0000 L CNN
F 1 "KEY_R1C7" H 4350 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4350 1900 50  0001 C CNN
F 3 "" H 4350 1900 50  0001 C CNN
	1    4350 1700
	0    -1   -1   0   
$EndComp
Text Label 4350 1000 1    60   ~ 0
COL6
Wire Wire Line
	4350 2100 4350 1900
$Comp
L Stenokey-rescue:SW_Push SW8
U 1 1 59C0794B
P 4750 1700
F 0 "SW8" H 4500 1800 50  0000 L CNN
F 1 "KEY_R1C8" H 4750 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4750 1900 50  0001 C CNN
F 3 "" H 4750 1900 50  0001 C CNN
	1    4750 1700
	0    -1   -1   0   
$EndComp
Text Label 4750 1000 1    60   ~ 0
COL7
Wire Wire Line
	4750 2100 4750 1900
$Comp
L Stenokey-rescue:SW_Push SW9
U 1 1 59C0795B
P 5150 1700
F 0 "SW9" H 4900 1800 50  0000 L CNN
F 1 "KEY_R1C9" H 5150 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 5150 1900 50  0001 C CNN
F 3 "" H 5150 1900 50  0001 C CNN
	1    5150 1700
	0    -1   -1   0   
$EndComp
Text Label 5150 1000 1    60   ~ 0
COL8
Wire Wire Line
	5150 2100 5150 1900
$Comp
L Stenokey-rescue:SW_Push SW10
U 1 1 59C0796B
P 5550 1700
F 0 "SW10" H 5300 1800 50  0000 L CNN
F 1 "KEY_R1C10" H 5550 1600 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 5550 1900 50  0001 C CNN
F 3 "" H 5550 1900 50  0001 C CNN
	1    5550 1700
	0    -1   -1   0   
$EndComp
Text Label 5550 1000 1    60   ~ 0
COL9
Wire Wire Line
	5550 2100 5550 1900
Wire Wire Line
	3950 2100 3950 1900
Connection ~ 3950 2100
Connection ~ 4350 2100
Connection ~ 4750 2100
Connection ~ 5150 2100
$Comp
L Stenokey-rescue:SW_Push SW16
U 1 1 59C07982
P 3950 3150
F 0 "SW16" H 3700 3250 50  0000 L CNN
F 1 "KEY_R2C6" H 3950 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 3950 3350 50  0001 C CNN
F 3 "" H 3950 3350 50  0001 C CNN
	1    3950 3150
	0    -1   -1   0   
$EndComp
$Comp
L Stenokey-rescue:SW_Push SW17
U 1 1 59C07992
P 4350 3150
F 0 "SW17" H 4100 3250 50  0000 L CNN
F 1 "KEY_R2C7" H 4350 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4350 3350 50  0001 C CNN
F 3 "" H 4350 3350 50  0001 C CNN
	1    4350 3150
	0    -1   -1   0   
$EndComp
Text Label 4350 2450 1    60   ~ 0
COL6
Wire Wire Line
	4350 3550 4350 3350
$Comp
L Stenokey-rescue:SW_Push SW18
U 1 1 59C079A2
P 4750 3150
F 0 "SW18" H 4500 3250 50  0000 L CNN
F 1 "KEY_R2C8" H 4750 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4750 3350 50  0001 C CNN
F 3 "" H 4750 3350 50  0001 C CNN
	1    4750 3150
	0    -1   -1   0   
$EndComp
Text Label 4750 2450 1    60   ~ 0
COL7
Wire Wire Line
	4750 3550 4750 3350
$Comp
L Stenokey-rescue:SW_Push SW19
U 1 1 59C079B2
P 5150 3150
F 0 "SW19" H 4900 3250 50  0000 L CNN
F 1 "KEY_R2C9" H 5150 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 5150 3350 50  0001 C CNN
F 3 "" H 5150 3350 50  0001 C CNN
	1    5150 3150
	0    -1   -1   0   
$EndComp
Text Label 5150 2450 1    60   ~ 0
COL8
Wire Wire Line
	5150 3550 5150 3350
$Comp
L Stenokey-rescue:SW_Push SW20
U 1 1 59C079C2
P 5550 3150
F 0 "SW20" H 5300 3250 50  0000 L CNN
F 1 "KEY_R2C10" H 5550 3050 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 5550 3350 50  0001 C CNN
F 3 "" H 5550 3350 50  0001 C CNN
	1    5550 3150
	0    -1   -1   0   
$EndComp
Text Label 5550 2450 1    60   ~ 0
COL9
Wire Wire Line
	5550 3550 5550 3350
Wire Wire Line
	3950 3550 3950 3350
Connection ~ 3950 3550
Connection ~ 4350 3550
Connection ~ 4750 3550
Connection ~ 5150 3550
$Comp
L Stenokey-rescue:SW_Push SW26
U 1 1 59C079D8
P 3950 4600
F 0 "SW26" H 3700 4700 50  0000 L CNN
F 1 "KEY_R3C6" H 3950 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 3950 4800 50  0001 C CNN
F 3 "" H 3950 4800 50  0001 C CNN
	1    3950 4600
	0    -1   -1   0   
$EndComp
Text Label 3950 3900 1    60   ~ 0
COL5
$Comp
L Stenokey-rescue:SW_Push SW27
U 1 1 59C079E8
P 4350 4600
F 0 "SW27" H 4100 4700 50  0000 L CNN
F 1 "KEY_R3C7" H 4350 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4350 4800 50  0001 C CNN
F 3 "" H 4350 4800 50  0001 C CNN
	1    4350 4600
	0    -1   -1   0   
$EndComp
Text Label 4350 3900 1    60   ~ 0
COL6
Wire Wire Line
	4350 5000 4350 4800
$Comp
L Stenokey-rescue:SW_Push SW28
U 1 1 59C079F8
P 4750 4600
F 0 "SW28" H 4500 4700 50  0000 L CNN
F 1 "KEY_R3C8" H 4750 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4750 4800 50  0001 C CNN
F 3 "" H 4750 4800 50  0001 C CNN
	1    4750 4600
	0    -1   -1   0   
$EndComp
Text Label 4750 3900 1    60   ~ 0
COL7
Wire Wire Line
	4750 5000 4750 4800
$Comp
L Stenokey-rescue:SW_Push SW29
U 1 1 59C07A08
P 5150 4600
F 0 "SW29" H 4900 4700 50  0000 L CNN
F 1 "KEY_R3C9" H 5150 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 5150 4800 50  0001 C CNN
F 3 "" H 5150 4800 50  0001 C CNN
	1    5150 4600
	0    -1   -1   0   
$EndComp
Text Label 5150 3900 1    60   ~ 0
COL8
Wire Wire Line
	5150 5000 5150 4800
$Comp
L Stenokey-rescue:SW_Push SW30
U 1 1 59C07A18
P 5550 4600
F 0 "SW30" H 5300 4700 50  0000 L CNN
F 1 "KEY_R3C10" H 5550 4500 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 5550 4800 50  0001 C CNN
F 3 "" H 5550 4800 50  0001 C CNN
	1    5550 4600
	0    -1   -1   0   
$EndComp
Text Label 5550 3900 1    60   ~ 0
COL9
Wire Wire Line
	5550 5000 5550 4800
Wire Wire Line
	3950 5000 3950 4800
Connection ~ 3950 5000
Connection ~ 4350 5000
Connection ~ 4750 5000
Connection ~ 5150 5000
$Comp
L Stenokey-rescue:SW_Push SW33
U 1 1 59C07A2E
P 3950 6050
F 0 "SW33" H 3700 6150 50  0000 L CNN
F 1 "KEY_R4C6" H 3950 5950 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 3950 6250 50  0001 C CNN
F 3 "" H 3950 6250 50  0001 C CNN
	1    3950 6050
	0    -1   -1   0   
$EndComp
Text Label 3950 5350 1    60   ~ 0
COL5
$Comp
L Stenokey-rescue:SW_Push SW34
U 1 1 59C07A3E
P 4350 6050
F 0 "SW34" H 4100 6150 50  0000 L CNN
F 1 "KEY_R4C7" H 4350 5950 50  0000 C CNN
F 2 "Stenokey:SW_Matias_Quiet" H 4350 6250 50  0001 C CNN
F 3 "" H 4350 6250 50  0001 C CNN
	1    4350 6050
	0    -1   -1   0   
$EndComp
Text Label 4350 5350 1    60   ~ 0
COL6
Text Notes 1550 700  0    120  ~ 0
Left Hand
Text Notes 4250 700  0    120  ~ 0
Right Hand
Text Notes 7800 6200 0    60   ~ 0
Note:  R2, D42, SW37, SW38 and U2 are redundant\nto allow the USB cable and interface components \nto be placed on either side of the board.  That is, \nonly one component in each of the following pairs \nis populated at the same time:  \n\nR1/R2,\nD41/D42,\nSW35/SW37,\nSW36/SW38,\nU1/U2.
Connection ~ 2850 5000
Connection ~ 2850 3550
Connection ~ 2850 2100
Wire Wire Line
	1650 6250 1650 6450
Wire Wire Line
	1000 6450 1250 6450
$Comp
L Stenokey-rescue:Hole Z9
U 1 1 59CA7DEF
P 6250 3950
F 0 "Z9" H 6400 3950 60  0000 C CNN
F 1 "Hole" H 6600 3950 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3950 60  0001 C CNN
F 3 "" H 6250 3950 60  0000 C CNN
	1    6250 3950
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z10
U 1 1 59CA8023
P 6250 4100
F 0 "Z10" H 6400 4100 60  0000 C CNN
F 1 "Hole" H 6600 4100 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 4100 60  0001 C CNN
F 3 "" H 6250 4100 60  0000 C CNN
	1    6250 4100
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z11
U 1 1 59CA80FB
P 6250 4250
F 0 "Z11" H 6400 4250 60  0000 C CNN
F 1 "Hole" H 6600 4250 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 4250 60  0001 C CNN
F 3 "" H 6250 4250 60  0000 C CNN
	1    6250 4250
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z12
U 1 1 59CA8101
P 6250 4400
F 0 "Z12" H 6400 4400 60  0000 C CNN
F 1 "Hole" H 6600 4400 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 4400 60  0001 C CNN
F 3 "" H 6250 4400 60  0000 C CNN
	1    6250 4400
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z13
U 1 1 59CA826B
P 6250 4550
F 0 "Z13" H 6400 4550 60  0000 C CNN
F 1 "Hole" H 6600 4550 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 4550 60  0001 C CNN
F 3 "" H 6250 4550 60  0000 C CNN
	1    6250 4550
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z14
U 1 1 59CA8271
P 6250 4700
F 0 "Z14" H 6400 4700 60  0000 C CNN
F 1 "Hole" H 6600 4700 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 4700 60  0001 C CNN
F 3 "" H 6250 4700 60  0000 C CNN
	1    6250 4700
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z15
U 1 1 59CA8277
P 6250 4850
F 0 "Z15" H 6400 4850 60  0000 C CNN
F 1 "Hole" H 6600 4850 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 4850 60  0001 C CNN
F 3 "" H 6250 4850 60  0000 C CNN
	1    6250 4850
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z16
U 1 1 59CA827D
P 6250 5000
F 0 "Z16" H 6400 5000 60  0000 C CNN
F 1 "Hole" H 6600 5000 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 5000 60  0001 C CNN
F 3 "" H 6250 5000 60  0000 C CNN
	1    6250 5000
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z1
U 1 1 59CA8D9F
P 6250 2750
F 0 "Z1" H 6400 2750 60  0000 C CNN
F 1 "Hole" H 6600 2750 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 2750 60  0001 C CNN
F 3 "" H 6250 2750 60  0000 C CNN
	1    6250 2750
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z2
U 1 1 59CA8DA5
P 6250 2900
F 0 "Z2" H 6400 2900 60  0000 C CNN
F 1 "Hole" H 6600 2900 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 2900 60  0001 C CNN
F 3 "" H 6250 2900 60  0000 C CNN
	1    6250 2900
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z3
U 1 1 59CA8DAB
P 6250 3050
F 0 "Z3" H 6400 3050 60  0000 C CNN
F 1 "Hole" H 6600 3050 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3050 60  0001 C CNN
F 3 "" H 6250 3050 60  0000 C CNN
	1    6250 3050
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z4
U 1 1 59CA8DB1
P 6250 3200
F 0 "Z4" H 6400 3200 60  0000 C CNN
F 1 "Hole" H 6600 3200 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3200 60  0001 C CNN
F 3 "" H 6250 3200 60  0000 C CNN
	1    6250 3200
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z5
U 1 1 59CA8DB7
P 6250 3350
F 0 "Z5" H 6400 3350 60  0000 C CNN
F 1 "Hole" H 6600 3350 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3350 60  0001 C CNN
F 3 "" H 6250 3350 60  0000 C CNN
	1    6250 3350
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z6
U 1 1 59CA8DBD
P 6250 3500
F 0 "Z6" H 6400 3500 60  0000 C CNN
F 1 "Hole" H 6600 3500 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3500 60  0001 C CNN
F 3 "" H 6250 3500 60  0000 C CNN
	1    6250 3500
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z7
U 1 1 59CA8DC3
P 6250 3650
F 0 "Z7" H 6400 3650 60  0000 C CNN
F 1 "Hole" H 6600 3650 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3650 60  0001 C CNN
F 3 "" H 6250 3650 60  0000 C CNN
	1    6250 3650
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Hole Z8
U 1 1 59CA8DC9
P 6250 3800
F 0 "Z8" H 6400 3800 60  0000 C CNN
F 1 "Hole" H 6600 3800 60  0000 C CNN
F 2 "Stenokey:HOLE_600800" H 6250 3800 60  0001 C CNN
F 3 "" H 6250 3800 60  0000 C CNN
	1    6250 3800
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Logo Z18
U 1 1 5A01F85C
P 6250 5500
F 0 "Z18" H 6300 5500 60  0000 C CNN
F 1 "Logo" H 6625 5500 60  0000 C CNN
F 2 "Stenokey:StenoKeyLogo" H 6250 5500 60  0001 C CNN
F 3 "" H 6250 5500 60  0000 C CNN
	1    6250 5500
	1    0    0    -1  
$EndComp
$Comp
L Stenokey-rescue:Copyright Z17
U 1 1 5A01FCAE
P 6250 5250
F 0 "Z17" H 6300 5250 60  0000 C CNN
F 1 "Copyright" H 6625 5250 60  0000 C CNN
F 2 "Stenokey:Copyright" H 6250 5250 60  0001 C CNN
F 3 "" H 6250 5250 60  0000 C CNN
	1    6250 5250
	1    0    0    -1  
$EndComp
Text Notes 6200 2500 0    120  ~ 0
Extra
Wire Wire Line
	1250 2100 1650 2100
Wire Wire Line
	1650 2100 2050 2100
Wire Wire Line
	2050 2100 2450 2100
Wire Wire Line
	2450 2100 2850 2100
Wire Wire Line
	1250 3550 1650 3550
Wire Wire Line
	1650 3550 2050 3550
Wire Wire Line
	2050 3550 2450 3550
Wire Wire Line
	2450 3550 2850 3550
Wire Wire Line
	1250 5000 1650 5000
Wire Wire Line
	1650 5000 2050 5000
Wire Wire Line
	2050 5000 2450 5000
Wire Wire Line
	2450 5000 2850 5000
Wire Wire Line
	1250 6450 1650 6450
Wire Wire Line
	3950 2100 4350 2100
Wire Wire Line
	4350 2100 4750 2100
Wire Wire Line
	4750 2100 5150 2100
Wire Wire Line
	5150 2100 5550 2100
Wire Wire Line
	3950 3550 4350 3550
Wire Wire Line
	4350 3550 4750 3550
Wire Wire Line
	4750 3550 5150 3550
Wire Wire Line
	5150 3550 5550 3550
Wire Wire Line
	3950 5000 4350 5000
Wire Wire Line
	4350 5000 4750 5000
Wire Wire Line
	4750 5000 5150 5000
Wire Wire Line
	5150 5000 5550 5000
Wire Wire Line
	2850 5000 3950 5000
Wire Wire Line
	2850 3550 3950 3550
Wire Wire Line
	2850 2100 3950 2100
Text Label 4000 2450 1    60   ~ 0
COL5
Wire Wire Line
	1250 1000 1250 1500
Wire Wire Line
	1650 1000 1650 1500
Wire Wire Line
	2050 1000 2050 1500
Wire Wire Line
	2450 1000 2450 1500
Wire Wire Line
	2850 1000 2850 1500
Wire Wire Line
	3950 1000 3950 1500
Wire Wire Line
	4350 1000 4350 1500
Wire Wire Line
	4750 1000 4750 1500
Wire Wire Line
	5150 1000 5150 1500
Wire Wire Line
	5550 1000 5550 1500
Wire Wire Line
	1250 2450 1250 2950
Wire Wire Line
	1650 2950 1650 2450
Wire Wire Line
	2050 2450 2050 2950
Wire Wire Line
	2450 2950 2450 2450
Wire Wire Line
	2850 2450 2850 2950
Wire Wire Line
	4350 2450 4350 2950
Wire Wire Line
	4750 2950 4750 2450
Wire Wire Line
	5150 2450 5150 2950
Wire Wire Line
	5550 2950 5550 2450
Wire Wire Line
	1250 3900 1250 4400
Wire Wire Line
	1650 3900 1650 4400
Wire Wire Line
	2050 3900 2050 4400
Wire Wire Line
	2450 3900 2450 4400
Wire Wire Line
	2850 3900 2850 4400
Wire Wire Line
	3950 3900 3950 4400
Wire Wire Line
	4350 3900 4350 4400
Wire Wire Line
	4750 3900 4750 4400
Wire Wire Line
	5150 3900 5150 4400
Wire Wire Line
	5550 3900 5550 4400
Wire Wire Line
	1250 5350 1250 5850
Wire Wire Line
	1650 5350 1650 5850
Wire Wire Line
	3950 5350 3950 5850
Wire Wire Line
	4350 5350 4350 5850
$Comp
L Stenokey-rescue:Pico-MCU_RaspberryPi_and_Boards U1
U 1 1 60B57F26
P 8650 1700
F 0 "U1" H 8650 2915 50  0000 C CNN
F 1 "Pico" H 8650 2824 50  0000 C CNN
F 2 "MCU_RaspberryPi_and_Boards:RPi_Pico_SMD_TH" V 8650 1700 50  0001 C CNN
F 3 "" H 8650 1700 50  0001 C CNN
	1    8650 1700
	1    0    0    -1  
$EndComp
Text Label 7450 1850 2    60   ~ 0
COL9
Text Label 7500 750  2    60   ~ 0
COL0
Text Label 7500 850  2    60   ~ 0
COL1
Text Label 7450 1150 2    60   ~ 0
COL3
Text Label 7450 1250 2    60   ~ 0
COL4
Wire Wire Line
	7450 1150 7950 1150
Wire Wire Line
	7450 1250 7950 1250
Wire Wire Line
	7450 1350 7950 1350
Wire Wire Line
	7450 1550 7950 1550
Wire Wire Line
	7450 1650 7950 1650
Wire Wire Line
	7450 1750 7950 1750
Text Label 7450 1050 2    60   ~ 0
COL2
Wire Wire Line
	7500 850  7950 850 
Wire Wire Line
	7500 750  7950 750 
Wire Wire Line
	7450 1050 7950 1050
Wire Wire Line
	4000 2450 4000 2950
Wire Wire Line
	4000 2950 3950 2950
Text Label 7450 1750 2    60   ~ 0
COL8
Text Label 7450 1650 2    60   ~ 0
COL7
Text Label 7450 1550 2    60   ~ 0
COL6
Text Label 7450 1350 2    60   ~ 0
COL5
Text Label 7700 2150 2    60   ~ 0
ROW1
Wire Wire Line
	7700 2150 7950 2150
Text Label 7700 2250 2    60   ~ 0
ROW2
Wire Wire Line
	7700 2250 7950 2250
Text Label 7700 2350 2    60   ~ 0
ROW3
Wire Wire Line
	7700 2350 7950 2350
Wire Wire Line
	7700 2050 7950 2050
Text Label 7700 2050 2    60   ~ 0
ROW0
Wire Wire Line
	7450 1850 7950 1850
Wire Wire Line
	3950 6450 1650 6450
Wire Wire Line
	3950 6250 3950 6450
Connection ~ 1650 6450
Wire Wire Line
	4350 6250 4350 6450
Wire Wire Line
	4350 6450 3950 6450
Connection ~ 3950 6450
$EndSCHEMATC
