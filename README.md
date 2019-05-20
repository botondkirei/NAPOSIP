# NAPOSIP
[NAPOSIP Project Homepage](http://naposip.utcluj.ro "NAPOSIP's Homepage")

The intention of NAPOSIP Project is to create a fully synthesizable All-Digital Phase/Frequency Locked Loop (FS-ADPLL). 
Traditionally, ADPLLs are designed in a full custom IC design flow (including the digital components). Whenever the design 
is migrated to a new technology, almost every component has to be redesigned from scrach in the design kit (PDK) of the 
given technology. The scope of the project is to automate the design process of ADPLLs, an make use of place and route
method to obtain the layout of a PLL.

The common ADPLL topologies consists of several components, such as Voltage/Digitally Controlled Oscillators (V/DCO), 
high freqyuency presacller, programmable frequency dividers, FIR filters, Time-to-Digital Converters (TDC), etc.
Some components are better suited to be designed in a full custom IC design flow, others are better suited to be described 
in a HDL language, synthesized and autorouted by EDA tools.

This repostory hold the source code and related documentation of aformentioned components. As RTL descriptions are not suitable
for power, delay and area estimation it is encoureged to implement the components at gate level using stucutral descriptions. 
A gate level description is as close to a final netlist as possible and thus early power, delay and area assessment can be carried
out using Power and Area Aware Implementation Method, as developed in a related project [ELIB](https://github.com/botondkirei/ELib).

## Time-to-Digital Converter
Time-to-Digital converters (TDC) are key components in many application: physics, electronics, tsc, just to name a few. TDCs are deployed in All Digital Phase/Frequency Locked Loops for frequency/phase measurement. This project aims to develop and describe such components in HDL
### TDC topologies suited for digital synthesis
#### Delay-Line TDC
The delay line TDC is composed of a cascade of delay components. 
#### Vernier Delay-Line TDC
#### Gated Ring Oscillator TDC
#### Vernier Oscillator TDC
https://indico.cern.ch/event/590645/contributions/2528096/attachments/1440952/2218411/TDC_Cronotic_aida2020_annual_meeting_final.pdf
### Digital Techniques to improve the performance of synthesized TDCs
#### Calibration
#### Redundant TDC measurement
## Other TDC topologies suited for mixed signal implementation
### Time amplification TDC
## References
[1] F. Yuan, "CMOS time-to-digital converters for mixed-mode signal processing," in The Journal of Engineering, vol. 2014, no. 4, pp. 140-154, 4 2014.
[2] Chun-Cheng Liu; Soon-Jyh Chang; Guan-Ying Huang; Ying-Zu Lin; , "A 10-bit 50-MS/s SAR ADC With a Monotonic Capacitor Switching Procedure," Solid-State Circuits, IEEE Journal of , vol.45, no.4, pp.731-740, April 2010
[3] S. Mandai, T. Iizuka, T. Nakura, M. Ikeda and K. Asada, "Time-to-digital converter based on time difference amplifier with non-linearity calibration," 2010 Proceedings of ESSCIRC, Seville, 2010, pp. 266-269.
[4] Y. Balcıoğlu and G. Dündar, "A synthesizable Time to Digital Converter (TDC) with MIMO spatial oversampling method," 2015 IEEE 13th International New Circuits and Systems Conference (NEWCAS), Grenoble, 2015, pp. 1-4.
[5] Y. Park and D. D. Wentzloff, "A cyclic vernier time-to-digital converter synthesized from a 65nm CMOS standard library," Proceedings of 2010 IEEE International Symposium on Circuits and Systems, Paris, 2010, pp. 3561-3564.


## Digitally Controller Oscillator

The implementation of the controller oscillatory element remains a challange.



# Project Related Publications

# Usefull Reference
https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6891375
https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=8190103
