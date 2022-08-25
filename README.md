
# iiitb_sipo - serial in parallel out shift register

The shift register, which allows serial input (one bit after the other through a single data line) and produces a parallel output is known as Serial-In Parallel-Out shift register.


## Introduction
Flip flops can be used to store a single bit of binary data (1or 0). However, in order to store multiple bits of data, we need multiple flip flops. N flip flops are to be connected in an order to store n bits of data. A Register is a device which is used to store such information. It is a group of flip flops connected in series used to store multiple bits of data.
The information stored within these registers can be transferred with the help of shift registers.
The logic circuit given below shows a serial-in-parallel-out shift register. The circuit consists of four D flip-flops which are connected. The clear (CLR) signal is connected in addition to the clock signal to all the 4 flip flops in order to RESET them. The output of the first flip flop is connected to the input of the next flip flop and so on. All these flip-flops are synchronous with each other since the same clock signal is applied to each flip flop.

![App Screenshot](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/ff1.png)

## Applications

1. Temporary data storage
2. Data transfer
3. Data manipulation
4. As counters
5. The SIPO register is used for converting serial to parallel data therefore in communication lines.




## Block diagram
![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/sipo_blockdiagram.gif)

## Functional Characteristics

![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/waveform.png)   

## Functional Simulation   

In ubuntu    
first install iverilog and gtkwave by   
```
$   sudo apt get update  
$   sudo apt get install iverilog gtkwave
```
Now To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```   
$ sudo apt install -y git   
$ git clone https://github.com/adityasingh6256/iiitb_sipo   
$ cd iiitb_sipo    
$ iverilog iiitb_sipo.v iiitb_sipo_tb.v    
$ ./a.out    
$ gtkwave sipo.vcd
```
you will see your waveforms on gtkwave   
![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/7d9cbbe24e823d47b46bfcbc9705779b93fd15d2/images/RTL_simulation_waveform.png)   

this is RTL simulation,this is very raw and initial level simulation for design
now we do synthesis   

## Synthesis   

here we convert out RTL design code to gate level netlist using sky 130Technology standard library.   
for synthesis we install yosys and gvim   
command for that   
```
$ sudo apt-get update   
$ sudo apt-get -y install yosys   
$ sudo apt install vim-gtk3   
$ mkdir vlsi   
$ cd vlsi   
$ git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git   
$ gitclone https://github.com/kunalg123/vsdflow.git   
$ cd sky130RTLDesignAndSynthesisWorkshop   
$ cd verilog_files   
```   
now our terminal is at verilog files from here we give all the commands.   
i copy my project verilog code and test bench(iiitb_sipo.v , iiitb_sipo_tb.v) from my cloned github and paste it in verilog_files of  sky130RTLDesignAndSynthesisWorkshop directory.for easy   

yosys is for synthesis and gvim is just a text editor   
now command for synthesis   
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
 
## Gate Level Simulation    

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
  
 # Design RTL to GLS2   
 
 what are the steps   
 
 <p align="center">   
 
  <img width=""1300 height="600" src="https://github.com/adityasingh6256/iiitb_sipo/blob/00ddb962665250deda9ef39a795d71d52011a8fb/images/ASIC_flow.png">
  </p><br>    
 <p align="center">   
 <img width=""1300 height="600" src="https://github.com/adityasingh6256/iiitb_sipo/blob/00ddb962665250deda9ef39a795d71d52011a8fb/images/asic_flow2.png">
 </p><br>   
 
  ## Required Installations   
  
 we need OpenLane and EDA TOOLS    
 First Install Open Lane    
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
 Now we will install Magic to see our layouts   
 ```   
 
 git clone https://github.com/RTimothyEdwards/magic.git   
 cd magic/    
 ./configure    
 sudo make   
 sudo make install    
 ```   
 
Now for any problem in this process you can use this github repo The-OpenROAD-Project/OpenLane   
 
 
 
 ## Author   
 
 Aditya Singh    

## Contributors
-   Aditya Singh
-   Kunal Ghosh
-   Vinay Rayapati   
   
## Acknowledgements


- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
## Contact Information

- Aditya Singh ,M.Tech student, IIIT Bangalore, 12345adityasingh@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
