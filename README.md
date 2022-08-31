
# iiitb_sipo - serial in parallel out shift register

The shift register, which allows serial input (one bit after the other through a single data line) and produces a parallel output is known as Serial-In Parallel-Out shift register.
# Table of contents
 - [1. Introduction](#1-Introduction)<br>
 - [2. Applications](#2-Applications)<br>
 - [3. Block Diagram](#3-Block-Diagram)<br>
 - [4. Functional Characteristics](#4-Functional-Characteristics)<br>
 - [5. Functional Simulation](#5-Functional-Simulation)<br>
   - [5.1. Softwares Used](#51-Softwares-Used)<br>
   - [5.2. Simulation Results](#52-Simulation-Results)<br>
 - [6. Synthesis](#6-Synthesis)<br>
   - [6.1. Softwares Used](#61-Softwares-Used)<br>
   - [6.2. Run Synthesis](#62-Run-Synthesis)<br>
 - [7. Netlist](#7-Netlist)<br>
 - [8. Gate Level Simulation GLS](#8-Gate-Level-Simulation-GLS)<br>
 - [9. Physical Design - RTL to GDSII](#9-Physical-Design---RTL-to-GDSII)<br>
   - [9.1. Software used and Installation](#91-Software-used-and-Installation)
   - [9.2. Config.json file](#92-Config.json-file)
   - [9.3. Design a Inverter library cell - sky130_vsdinv](#93-Design-a-Inverter-library-cell---sky130_vsdinv)
   - [9.4. Preparation and Integration of Custom Cell in OpenLane](#94-Preparation-and-Integration-of-Custom-Cell-in-OpenLane)
   - [9.5. Synthesis](#95-Synthesis)
   - [9.6. Floorplan](#96-Floorplan)
   - [9.7. Placement](#97-Placement)
   - [9.8. Clock Tree Synthesis](#98-Clock-Tree-Synthesis)
   - [9.9. Routing](#99-Routing)
   - [9.10 Logs and Reports](#910-Logs-and-Reports)
 - [10. Summary](#10-Summary)
 - [Author](#11-Author)
 - [Contributors](#12-Contributors)
 - [Acknowledgement](#13-Acknowledgement)
 - [Contact Information](#14-Contact-Information)
 - [References](#15-References)


# 1. Introduction
Flip flops can be used to store a single bit of binary data (1or 0). However, in order to store multiple bits of data, we need multiple flip flops. N flip flops are to be connected in an order to store n bits of data. A Register is a device which is used to store such information. It is a group of flip flops connected in series used to store multiple bits of data.
The information stored within these registers can be transferred with the help of shift registers.
The logic circuit given below shows a serial-in-parallel-out shift register. The circuit consists of four D flip-flops which are connected. The clear (CLR) signal is connected in addition to the clock signal to all the 4 flip flops in order to RESET them. The output of the first flip flop is connected to the input of the next flip flop and so on. All these flip-flops are synchronous with each other since the same clock signal is applied to each flip flop.

![App Screenshot](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/ff1.png)

# 2. Applications

1. Temporary data storage   
2. Data transfer
3. Data manipulation
4. As counters
5. The SIPO register is used for converting serial to parallel data therefore in communication lines.




# 3. Block diagram
![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/sipo_blockdiagram.gif)

# 4. Functional Characteristics

![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/waveform.png)   

# 5. Functional Simulation   

## 5.1. Softwares Used  
### iverilog and gtkwave   
In ubuntu    
first install iverilog and gtkwave by   
```
sudo apt get update  
sudo apt get install iverilog gtkwave
sudo apt install -y git 
```
Now To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
## 5.2. Simulation Results   

```     
git clone https://github.com/adityasingh6256/iiitb_sipo   
cd iiitb_sipo    
iverilog iiitb_sipo.v iiitb_sipo_tb.v    
./a.out    
gtkwave sipo.vcd
```   
you will see your waveforms on gtkwave   
![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/7d9cbbe24e823d47b46bfcbc9705779b93fd15d2/images/RTL_simulation_waveform.png)   

this is RTL simulation,this is very raw and initial level simulation for design
now we do synthesis   

# 6. Synthesis     

here we convert out RTL design code to gate level netlist using sky 130Technology standard library.   
for synthesis we install yosys and gvim   

## 6.1. Softwares used  

```
sudo apt-get update   
sudo apt-get -y install yosys   
sudo apt install vim-gtk3   
mkdir vlsi   
cd vlsi   
git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git   
gitclone https://github.com/kunalg123/vsdflow.git   
cd sky130RTLDesignAndSynthesisWorkshop   
cd verilog_files   
```   
now our terminal is at verilog files from here we give all the commands.   
i copy my project verilog code and test bench(iiitb_sipo.v , iiitb_sipo_tb.v) from my cloned github and paste it in verilog_files of  sky130RTLDesignAndSynthesisWorkshop directory.for easy   

yosys is for synthesis and gvim is just a text editor   
now command for synthesis  
## 6.2. Run Synthesis
```   
yosys   
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib   
read_verilog iiitb_sipo.v   
synth -top iiitb_sipo   
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib   
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib   
stat
flatten   
show   
write_verilog -noattr iiitb_sipo_net.v
```  
# 7. Netlist   

after synth -top iiitb_sipo we will able to see netlist stats.   
<p align="center">
 <img width="400" height="700" src="https://github.com/adityasingh6256/iiitb_sipo/blob/aa4a878dcc96cac8bbec6d8089a3deed125952e1/images/stats_sipo.png">
 </p><br>   
 
instead of giving all these commands one by one for synthesis and netlist we can use yosys_run.sh file from sky130RTLDesignAndSynthesisWorkshop after editing project name and locations in it.   
command for that is   
```   
yosys -s yosys_run.sh   
```   

 when you give the command 'show' you will see this   
 <p align="center">
 <img width=""1500 height="500" src="https://github.com/adityasingh6256/iiitb_sipo/blob/e0e9e75525081237cada24abdf90561d63ea50eb/images/netlist.png">
 </p><br>   
 And now you get your netlist file iiitb_sipo_net.v    
 
# 8. Gate Level Simulation GLS   

now we compare`Functional Simulation` with `GLS` simulation,if they are same then we are good to move for `Physical Design`.   
command for GLS   

```   
iverilog -DFUNCTIONAL -DUNIT_DELAY=#0 ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v iiitb_sipo_net.v iiitb_sipo_tb.v   
./a.out   
gtkwave sipo.vcd   
```   
here i give delay of 0 ns ,i can give delay as i will need.   
now you see gtkwave waveform and compare it with fuctional simulation waveform    
<p align="center">   
 <img width=""1300 height="600" src="https://github.com/adityasingh6256/iiitb_sipo/blob/1e8317dca9b7481e00631672e31329957a6c76bc/images/GLS_waveform.png">
 </p><br>    
  Now after GLS we move for physical design and we will make final layout of chip.    
  
# 9. Physical Design - RTL to GDSII   
 
 what are the steps   
 
 <p align="center">    
 <img width=""1300 height="600" src="https://github.com/adityasingh6256/iiitb_sipo/blob/00ddb962665250deda9ef39a795d71d52011a8fb/images/ASIC_flow.png">
  </p><br>    
 <p align="center">   
 <img width=""1300 height="600" src="https://github.com/adityasingh6256/iiitb_sipo/blob/00ddb962665250deda9ef39a795d71d52011a8fb/images/asic_flow2.png">
 </p><br>   
 
## 9.1. Software used and Installation   
 
### OpenLane   
 
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

more at https://github.com/The-OpenROAD-Project/OpenLane   
 
Required Installations   
  
 ```   
 git clone https://github.com/The-OpenROAD-Project/OpenLane.git    
 cd OpenLane   
 sudo make   
 sudo make test   
 sudo make mount   
 ```    
 You can use the following example as a smoke test:   
 
 ```   
 ./flow.tcl -design spm   
 ```    
 ### magic   
 The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.
 
 Now we will install Magic to see our layouts   
 ```   
 
 git clone https://github.com/RTimothyEdwards/magic.git   
 cd magic   
 ```   
 Need some System Requirements in Magic installation   
 ```   
 sudo apt-get install m4    
 sudo apt-get install tcsh    
 sudo apt-get install csh    
 sudo apt-get install libx11-dev   
 sudo apt-get install tcl-dev tk-dev   
 sudo apt-get install libcairo2-dev   
 sudo apt-get install mesa-common-dev libglu1-mesa-dev   
 sudo apt-get install libncurses-dev   
 ```   
 Now magic installation   
 ```   
 ./configure   
 sudo make   
 sudo make install   
 magic   
 ```   
 more at http://opencircuitdesign.com/   
 
 
## 9.2. Config.json file  
 
 ```
 {
    "DESIGN_NAME": "iiitb_sipo",
    "VERILOG_FILES": "dir::src/iiitb_sipo.v",
    "CLOCK_PORT": "clk",
    "CLOCK_NET": "clk",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 65,
    "PL_RANDOM_GLB_PLACEMENT": 1,
    "PL_TARGET_DENSITY": 0.5,
    "FP_SIZING" : "relative",

"LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
"LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
"LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
"LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",
"TEST_EXTERNAL_GLOB": "dir::../iiitb_sipo/src/*",
"SYNTH_DRIVING_CELL":"sky130_vsdinv",

    "pdk::sky130*": {
        "FP_CORE_UTIL": 5,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 5
        }
    }
}    
```    
## 9.3. Design a Inverter library cell - sky130_vsdinv   

First, clone the github repo containing the inverter and prepare for the next steps.
```
git clone https://github.com/nickson-jose/vsdstdcelldesign.git
cd vsdstdcelldesign
cp ./libs/sky130A.tech sky130A.tech
magic -T sky130A.tech sky130_inv.mag &   
```   

On typing the following commands, the following netlist will open.

<p align="center">
  <img src="/images/raw_vsdinv.png">
</p><br>

Now, to extract the spice netlist, type the following commands in the tcl console. Here, parasitic capacitances and resistances of the inverter is extracted by  `cthresh 0 rthresh 0`.
```
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```
<p align="center">
  <img src="/images/ext_all.png">
</p><br>

The extracted spice model is shown below (which is edited to simulate the inverter).
```
* SPICE3 file created from sky130_inv.ext - technology: sky130A

.option scale=0.01u
.include ./libs/pshort.lib
.include ./libs/nshort.lib


M1001 Y A VGND VGND nshort_model.0 ad=1435 pd=152 as=1365 ps=148 w=35 l=23
M1000 Y A VPWR VPWR pshort_model.0 ad=1443 pd=152 as=1517 ps=156 w=37 l=23
VDD VPWR 0 3.3V
VSS VGND 0 0V
Va A VGND PULSE(0V 3.3V 0 0.1ns 0.1ns 2ns 4ns)
C0 Y VPWR 0.08fF
C1 A Y 0.02fF
C2 A VPWR 0.08fF
C3 Y VGND 0.18fF
C4 VPWR VGND 0.74fF


.tran 1n 20n
.control
run
.endc
.end
```
open terminal   
```   
cd vsdstdcelldesign   
ngspice sky130_inv.spice  // open ngspice
ngspice 1-> plot y vs time a
```   

<p align="center">
  <img src="/images/inv_plot.png">
</p><br>

To get a grid and to ensure the ports are placed correctly we type the following command in the tcl console
```
grid 0.46um 0.34um 0.23um 0.17um
```
In Magic Layout window, first source the .mag file for the design (here inverter). Then Edit >> Text which opens up a dialogue box. Then do the steps shown in the below figure.

<p align="center">
  <img src="/images/inv6.png">
</p><br>

<p align="center">
  <img src="/images/inv7.png">
</p><br>

<p align="center">
  <img src="/images/inv8.png">
</p><br>

<p align="center">
  <img src="/images/inv9.png">
</p><br>

Now, to extract the lef file and save it, type the following command.
```
lef write
```
<p align="center">
  <img src="/images/inv5.png">
</p><br>

The extracted lef file is shown below.
```   
VERSION 5.7 ;
  NOWIREEXTENSIONATPIN ON ;
  DIVIDERCHAR "/" ;
  BUSBITCHARS "[]" ;
MACRO sky130_vsdinv
  CLASS CORE ;
  FOREIGN sky130_vsdinv ;
  ORIGIN 0.000 0.000 ;
  SIZE 1.380 BY 2.720 ;
  SITE unithd ;
  PIN A
    DIRECTION INPUT ;
    USE SIGNAL ;
    ANTENNAGATEAREA 0.165600 ;
    PORT
      LAYER li1 ;
        RECT 0.060 1.180 0.510 1.690 ;
    END
  END A
  PIN Y
    DIRECTION OUTPUT ;
    USE SIGNAL ;
    ANTENNADIFFAREA 0.287800 ;
    PORT
      LAYER li1 ;
        RECT 0.760 1.960 1.100 2.330 ;
        RECT 0.880 1.690 1.050 1.960 ;
        RECT 0.880 1.180 1.330 1.690 ;
        RECT 0.880 0.760 1.050 1.180 ;
        RECT 0.780 0.410 1.130 0.760 ;
    END
  END Y
  PIN VPWR
    DIRECTION INOUT ;
    USE POWER ;
    PORT
      LAYER nwell ;
        RECT -0.200 1.140 1.570 3.040 ;
      LAYER li1 ;
        RECT -0.200 2.580 1.430 2.900 ;
        RECT 0.180 2.330 0.350 2.580 ;
        RECT 0.100 1.970 0.440 2.330 ;
      LAYER mcon ;
        RECT 0.230 2.640 0.400 2.810 ;
        RECT 1.000 2.650 1.170 2.820 ;
      LAYER met1 ;
        RECT -0.200 2.480 1.570 2.960 ;
    END
  END VPWR
  PIN VGND
    DIRECTION INPUT ;
    USE GROUND ;
    PORT
      LAYER li1 ;
        RECT 0.100 0.410 0.450 0.760 ;
        RECT 0.150 0.210 0.380 0.410 ;
        RECT 0.000 -0.150 1.460 0.210 ;
      LAYER mcon ;
        RECT 0.210 -0.090 0.380 0.080 ;
        RECT 1.050 -0.090 1.220 0.080 ;
      LAYER met1 ;
        RECT -0.110 -0.240 1.570 0.240 ;
    END
  END VGND
END sky130_vsdinv
END LIBRARY
```   
## 9.4. Preparation and Integration of Custom Cell in OpenLane    

 ### Generating the Layout   
 
 Preparation steps
 ```
 cd OpenLane   
 cd designs   
 mkdir iiitb_sipo   
 cd iiitb_sipo   
 makdir src   
 ```
 Now, paste the verilog code `iiitb_gc.v`,and `sky130_vsdinv.lef`, `sky130_fd_sc_hd__fast.lib`,  `sky130_fd_sc_hd__slow.lib` and `sky130_fd_sc_hd__typical.lib` from vsdstdcelldesign folder to the folder `OpenLane/designs/iiitb_sipo/src`, and also make your config.json file and place it in the iiitb_sipo folder in Designs.

We will do all in Interactive OpenLane Flow

```   
prep -design iiitb_sipo
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
run_synthesis    
```   

 <p align="center">   
 <img width="1200" height="400" src="https://github.com/adityasingh6256/iiitb_sipo/blob/f734709c674bc3f851476d805c83fdeb3caa6df5/images/prep_design.png">
 </p><br>   
 

## 9.5. Synthesis  

  <p align="center">
  <img src="/images/synthesis.png">
</p><br>   
 
 
  Synthesis stats   
   <p align="center">
  <img src="/images/stats_synthesis.png ">
  </p><br>   
 
 ## 9.6. Floorplan   
 
 <p align="center">
  <img src="/images/floorplan.png ">
  </p><br>    
 
 ### Core and Die area  
 
 CORE AREA
 
  <p align="center">
  <img src="/images/core_area.png ">
  </p><br>  
 
 DIE AREA   
 
 <p align="center">
  <img src="/images/die_area.png ">
  </p><br>  
 
 ## 9.7. Placement   
 
  <p align="center">
  <img src="/images/placement1.png ">
  </p><br>  
 
<p align="center">
  <img src="/images/placement.png ">
  </p><br> 
 
 magic cmd for placement layout 
 
 ```   
 cd ../home/aditya/vsd/OpenLane/designs/iiitb_sipo/runs/RUN_2022.08.30_12.48.56/results/placement/
 magic -T /home/aditya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_sipo.def &
```   


 we can see our Custom cell sky130_vsdinv   
 
 <p align="center">
  <img src="/images/sky130_vsdinv_placement.png">
  </p><br>   
  
## 9.8. Clock Tree Synthesis   
  The next step is to run run clock tree synthesis. The CTS run adds clock buffers in therefore buffer delays come into picture and our analysis from here on deals with real clocks. To run clock tree synthesis, type the following commands
  ```   
  run_cts   
  ```   
 

The netlist with clock buffers can be viewed by going to the location `results\cts\iiitb_sipo.v`

Also, sta report post synthesis can be viewed by going to the location `logs\cts\12-cts.log`
<p align="center">
  <img src="/images/cts.png">
</p><br>

    
## 9.9. Routing    
 ```    
 run_routing  
 ```   
 
  <p align="center">
  <img src="/images/routing1.png">
  </p><br> 
    
 
 
  magic cmd for Routing layout   
  
 ``` 
 cd ../home/aditya/vsd/OpenLane/designs/iiitb_sipo/runs/RUN_2022.08.30_12.48.56/results/routing/
 magic -T /home/aditya/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_sipo.def &
 ```    
 
  <p align="center">
  <img src="/images/routing.png">
  </p><br> 
    
 ZOOM VIEW   
 
  <p align="center">   
 <img width="1200" height="700" src="https://github.com/adityasingh6256/iiitb_sipo/blob/fb97377e7c30c157f347616964d1dc7ebc96cb10/images/zoom_routing.png">
 </p><br>   
 
 we can see our Custom cell sky130_vsdinv    
 
   <p align="center">   
 <img width="1200" height="700" src="https://github.com/adityasingh6256/iiitb_sipo/blob/fb97377e7c30c157f347616964d1dc7ebc96cb10/images/sky130_vsdinv_routing.png">
  </p><br>    
  Area report by magic   
  Area of the chip is 4384.215 sq micrometers.
   <p align="center">
  <img src="/images/box_area.png">
  </p><br>   
  
  
 ## 9.10. Logs and Reports  
  we can check it in 
  
  /home/aditya/vsd/OpenLane/designs/iiitb_sipo/runs/RUN_2022.08.30_12.48.56/logs/routing/  
 
 ### Time report   
 
   <p align="center">
  <img src="/images/time_report.png">
  </p><br> 
    
  
  ### Congestion Report   
  
    <p align="center">
  <img src="/images/congestion_report.png">
  </p><br> 
     
  
  ### Power and Area report   
  
   <p align="center">
  <img src="/images/power_report.png">
  </p><br> 
        
# 10. Summary   
  
### VLSI INTERACTIVE OPENLANE FLOW    

```    
cd OpenLane/ 
sudo make mount 
./flow.tcl -interactive
package require openlane 0.9
prep -design picorv32a
run_synthesis
run_floorplan
run_placement
run_cts
run_routing
run_magic
run_magic_spice_export
run_magic_drc
run_netgen
run_magic_antenna_check

```    

  
### VLSI NON INTERACTIVE OPENLANE FLOW  

To generate the layout, type the following commands    
 ```
 cd OpenLane   
 sudo make mount   
 ./flow.tcl -design iiitb_sipo
 ```    
 
 Now open magic in new terminal using folowing command to see the final layout  in non interactive way   
 
 ```
 cd OpenLane   
 cd ..designs/..iiitb_sipo/..runs/..RUN_2022.08.21_12.53.02/..results/..final/..def/
 magic -T /home/aditya/vsd/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../../tmp/merged.nom.lef def read iiitb_sipo.def &
 ```   
 
# 11. Author    
 
 Aditya Singh    

# 12. Contributors   

 -   Aditya Singh
 -   Kunal Ghosh
 -   Vinay Rayapati   
   
# 13. Acknowledgement   

- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.

# 14. Contact Information

- Aditya Singh ,M.Tech student, IIIT Bangalore, 12345adityasingh@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
# 15. *References*  

1.  [SIPO](https://www.allaboutcircuits.com/textbook/digital/chpt-12/serial-in-parallel-out-shift-register/)   

2. for synthesis and pysical design - [VSDIAT](https://vsdiat.com/)    

3. For magic,pdks,openlane ..EDA tools-[opencircuitdesign](http://opencircuitdesign.com/)   

4. Icarus Verilog - [iverilog](http://iverilog.icarus.com/)      

5. GTK Wave [documentation](http://gtkwave.sourceforge.net/gtkwave.pdf)   

6. [Yosys](https://yosyshq.net/yosys/) synthesis tool    
