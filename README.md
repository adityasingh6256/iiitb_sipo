
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

![screenshot app](https://github.com/adityasingh6256/iiitb_sipo/blob/06de0e1ca40f7cbad47a1649b86ddf0c33ef7c2a/images/sipo_waveform.png)



## Functional Simulation

In ubuntu  
first install iverilog and gtkwave by   

$   sudo apt get update  
$   sudo apt get install iverilog gtkwave

Now To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.

$ sudo apt install -y git   
$ git clone https://github.com/adityasingh6256/iiitb_sipo   
$ cd iiitb_sipo    
$ iverilog iiitb_sipo.v iiitb_sipo_tb.v    
$ ./a.out    
$ gtkwave sipo.vcd    

you will see your waveforms on gtkwave

## Contributors
-   Aditya Singh
-   Kunal Ghosh
-   Vinay Rayapati 
## Acknowledgements


- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
## Contact Information

- Aditya Singh ,M.Tech student, IIIT Bangalore, 12345adityasingh@gmail.com
- Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
