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

# Directory structure

For each key component in a PLL a "standalone" directory is reserved (with their own readme.md and contributing.md). 

## SLM - System Level Models

System level models of ADPLLs can be found in SLM directory. Usually this models are numerical models of PLLs, it is encoureged
to use Octave Gnu to describe de behavoir at system level. 

## DCO - Digitally controlled oscillator

## LPF - Lowpass Filter (loop filter)

## TDC - Time-to-Digital converter

## Misc - Miscellaneous

Other components: Frequency dividers, Flying Adder Synthesizer, etc.

# Project Related Publications

# Usefull Reference
https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6891375
https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=8190103
