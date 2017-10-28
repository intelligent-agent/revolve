
```
    _/_/_/                                    _/                       
   _/    _/    _/_/    _/      _/    _/_/    _/  _/      _/    _/_/    
  _/_/_/    _/_/_/_/  _/      _/  _/    _/  _/  _/      _/  _/_/_/_/   
 _/    _/  _/          _/  _/    _/    _/  _/    _/  _/    _/          
_/    _/    _/_/_/      _/        _/_/    _/      _/        _/_/_/     
                                                                       
```                                                                      

## Main features
- 1GHz Single board solution using Octavo OSB3358 SIP
- 6 TMC2130 stepper drivers, stall detection, over current/temp
- 4 Thermistor or Thermocouple inputs (runtime configurable)
- 4 high power heater outputs 
- 4 GB fast eMMC
- Optionally 2 external drivers
- Direct coupled PRU lines to all drivers
- Flexible PWM on all 8 MOSFET outputs for flexible EMC passing
- 4 USB host ports, 1 USB device port
- 10/100Mbit Ethernet
- 1080p HDMI
- Smart power controls
 - Input voltage and current measurement
 - Power removed detection
 - Software defined over current protecion 
- Quad encoder input for filament sensor
- Buffered end stop inputs, ESD protected connectors
- 2 Servo outputs
- Inductive sensor input
- Two Grove connectors, I2C and UART


![Revolve_A0.png](attachment:Revolve_A0.png)

## Power management
Here is an overview of the power distribution
![Revolve%20power%20diagram.svg](attachment:Revolve%20power%20diagram.svg)

## 5V step down TPS54202 calculations



```python
import math
Vout = 5.1 # Output voltage
Vin = 24 # Input voltage
Iout = 2 # Output current 
Kind = 0.3 # ? 
Fsw = 500000 # Switching frequency
Cbulk = 10 *10**-6 
u = 10**6 # micro

```


```python
L=(Vout*(Vin-Vout))/(Vin*Kind*Iout*Fsw)
print "Inductor selection:"
print "Minimum inductor size: "+str(L*10**6)+" uH"

Lout = 15*10**-6
Ilmax = math.sqrt(Iout**2 + (1/12) + ((Vout*(Vin-Vout))/(Vin*Lout*Fsw*0.8))**2)
print "RMS Inductor current "+str(Ilmax)
Ipeak = Iout + (Vout * (Vin - Vout))/(1.6*Vin*Lout*Fsw)
print "Max inductor current "+str(Ipeak)
print "Choosing NR8040T330M"

```

    Inductor selection:
    Minimum inductor size: 13.3875 uH
    RMS Inductor current 2.10904312204
    Max inductor current 2.3346875
    Choosing NR8040T330M



```python
dIout = 0.7
dVout = 0.2 # Delta voltage with dI
Vr = 0.03 # Ripple Voltage
Ir = Iout*0.3
CO1 = (2*dIout)/(Fsw*dVout)
CO2 = (1.0/(8.0*Fsw))*(1.0/(Vr/Ir))
#CO3 = 
print "Input Capacitor Selection:"
print "CO1: "+str(CO1*u) + " uF"
print "CO2: "+str(CO2*u) + " uF"

#print "Minimum capacitance: "+str(CO*u)+" uF"
print "Choosing 20uF"
```

    Input Capacitor Selection:
    CO1: 14.0 uF
    CO2: 5.0 uF
    Choosing 20uF



```python
R2 = 100.0*10**3
R3 = 13.3*10**3
Vref = 0.596
Vout = Vref*((R2/R3)+1)
print "Calculation of output resitance: "
print "Vout = "+str(Vout)
```

    Calculation of output resitance: 
    Vout = 5.07720300752


## Stepper drivers

Current sense resistor: 


```python
R = 0.1
I = 1
U = R*I
P = U*I
print "Power dissipation: "+str(P)
```

    Power dissipation: 0.1


**Diagnostics:**  
$2*8 = 16$  
Connect together to form a single interrupt? 
No, it's good to have individual pins for stallguard. 

## Capacitor selection
100uF electrolytic capacitor is recommended. No mention of ESR or ripple current in the TMC2130 data sheet. 
What is the frequency at which the largest current draw is expected? 
There are 10uF capacitors in line to handle high frequency current draws, so it is expected that teh electrolytic capacitors will handle lower frequecy draws. It depends on Cable length, ESR in PSU as well. 


**SPI and enable**  
* Enable pins, can it be done using SPI?
* SPI CS pins, need 8 pins at least. 
    * Use Mux? 
        * Increased cost. How much?
        * 
    * Daisy chain? 
        * What is the required time? 
        * Not good for Stepper A/B. Use CN1? 
        * Each transaction takes 60 us
    * Individual pins. 
        * Requiers 8 pins. 
* 


```python
print "Stepper readout time: "
a = 6.0*40/(4*10**6)
print "it takes "+str(a*u)+" us for each transaction"
```

    Stepper readout time: 
    it takes 60.0 us for each transaction


## PWM calculations

**Current setting**
* Use PWM chip?
    * Costly > $1
    * board space
* Use internal reference
    * 5 bit precicion


```python
print "Number of current steps on TMC2130: "+str(2**5)
```

    Number of current steps on TMC2130: 32


# Smart input current monitor circuit.
Fuses have slow responses, so they do not protect against short circuits
and only asymptotically approach their rating with time. They are temperature dependent, difficult to 
repalace and physically large. They also increase manfacting tie and cost due to almost universally being 
through hole components. 
 - Measure input voltage
 - Measure input current. 
 - Choosing PMOS to also implement power lost detection.
 - Reverse polarity protection


```python
R = 0.001
A = 30
adc_vals = 2**12
v_adc = 1.8
v_res = R*A
Gain = 50
resolution =(v_adc/adc_vals)/R/Gain

print "Over current calculations:"
print "Max current: "+str(A)+" A"
print "Resistor value: "+str(R*1000)+" mOhm"
print "Voltage drop across resistor: "+str(v_res*1000)+" mV"
print "Voltage measured: "+str(v_res*Gain)
print "Power dissipation in Rsense: "+str(R*A*A)+" W"
print "resolution: "+str(resolution*1000)+" mA"
```

    Over current calculations:
    Max current: 30 A
    Resistor value: 1.0 mOhm
    Voltage drop across resistor: 30.0 mV
    Voltage measured: 1.5
    Power dissipation in Rsense: 0.9 W
    resolution: 8.7890625 mA



```python
v_max = 24
R1 = 100*10**3
R2 = 4.7*10**3
print "Input voltage calculations: "
print "Voltage divider max output: "+str(v_max*R2/(R1+R2))
print "Input voltage resolution: ??"
```

    Input voltage calculations: 
    Voltage divider max output: 1.07736389685
    Input voltage resolution: ??



```python
Imax = 30
RDS = 5.6*10**-3
Ploss = RDS*Imax*Imax
print "Input P-mos power calculations:"
print "Power expenditure: "+str(Ploss)+ " W"
```

    Input P-mos power calculations:
    Power expenditure: 5.04 W


## ESD considerations
 - EN 55024/EN 61000-4-2: ±4kV Contact, ±8kV Air
### Board
 - Ground shield, having 0.1R to ground. 
### USB 
 - Using TPD4S012 having Contact: ±10kV, Air: ±10kV
### HDMI
 - Using TPD12S016
### Ethernet 
 - Isolated using magnetics. 
### Endstops
 - Input buffer CD4050BD with HBD: ±1500, CDM: ±1000
### Analog 
 - Series resistance
### Steppers
 - TMC2130 HBM: ±4 kV
### Heater MOSFETs
 - 4.7nF protection 
### Fan MOSFETS
 - No protection

## Layout considerations
Using en562748 as reference for PHY layout. 
 - Using 100R resistors in series to reduce EMI. 
 - Placing PHY chip close to SIP since differential lines radiate less than 3.3V single ended lines. 
 - Removing ground plane under magnetics. 
 - 100 Ohm differential impedance
 - Plce 49.9ohm pullups close to PHY chip. 
 - OSH park uses FR408 lainate  


```python
Er = 3.67 # Relative dielectric costant
H = 0.17018 # prepreg height in mm
T = 0.035 # Copper thickness (mm)
F = 125 # Frequency MHz
print "0.15/0.15 track and gap gives 98.4 differential and 65.3 single ended"
```

    0.15/0.15 track and gap gives 98.4 differential and 65.3 single ended



```python
Vf = 2.8 # Diode forward voltage drop (V)
Vin = 3.3 # Input voltage (V)
Vres = Vin-Vf
If = 0.0001 # Diode current, 1mA
R = Vres/If
print "LED power calculations: "
print "Resistor for {}, {}mA: {}".format(Vin, If*1000,R)
```

    LED power calculations: 
    Resistor for 3.3, 0.1mA: 5000.0


# Sysboot config
Two Boot modes: MMC1 or USB device  
 - SYSBOOT[15-14] = 10b = 25MHz  
 - SYSBOOT[13:12] = 00b = reserved  
 - SYSBOOT[11:10] = xx
 - SYSBOOT[9] = xx
 - SYSBOOT[8] = xx
 - SYSBOOT[7-6] = xx
 - SYSBOOT[5] = 0b = Disable CLKOUT1
 - SYSBOOT[4:0] = 11100b = MMC1, MMC0, UART0, USB0
 
 To boot from USB: 
 - SYSBOOT[4:0] = 11000b = SPI0, MMCO0, USB0, UART0



```python
Imax = 1.5 # Maximum output current on all 4 USB ports
Rmeas = 0.01 # Current measurement resistor on low side. 
RDSon = 0.065 #P-mos RDSon
Vin = 5.1
Vdrop = Vin - (Rmeas + RDSon)*Imax
print "Voltage drop across R: {}".format(Rmeas*Imax)
print "Resulting voltage to USB: {}".format(Vdrop)
```

    Voltage drop across R: 0.015
    Resulting voltage to USB: 4.9875



```python
Imax = 1.5 # Maximum output current on all 4 USB ports
Rmeas = 0.01 # Current measurement resistor on low side. 
RDSon = 0.065 #P-mos RDSon
Vin = 5.1
Vdrop = Vin - (Rmeas + RDSon)*Imax
print "Voltage drop across R: {}".format(Rmeas*Imax)
print "Resulting voltage to USB: {}".format(Vdrop)
```

    Voltage drop across R: 0.015
    Resulting voltage to USB: 4.9875


### Review 
 - Changed vias to tented
 - Moved pin 1 indicator on U2 
 - Moved all test points to top side
 - 
 


```python
from IPython.display import display, Markdown, Latex
```

## Calculation of power dissipation of P-MOS
* $R_{ds(on)max} = 45 m\Omega$ @ $-10 V$
* Thermal Resistance, Junction to Ambient @ $TA=+25 ^{\circ}C$ is $R_{\theta JA}=26 ^{\circ}C/W$


```python
Von=6
Ta=25
Imax=30
#Imax=2
Rdson=0.0045
TR=26

# P=I^2*R
P=Imax*Imax*Rdson

Trise=TR*P
T=Ta+Trise

display(Markdown("""
$P={P:0.3f} W$\n
$T_{{rise}} = {Trise} ^{{\circ}}C$\n
$T = T_A + T_{{rise}} = {T:0.3f} ^{{\circ}}C$ when $I={I:.0f} A$

""".format(P=P, Trise=Trise, T=T, I=Imax)))
```



$P=4.050 W$

$T_{rise} = 105.3 ^{\circ}C$

$T = T_A + T_{rise} = 130.300 ^{\circ}C$ when $I=30 A$



