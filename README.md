# 🛠️ RTL to GDSII Flow with Custom Inverter Cell on Sky130 & PicoRV32 Integration

This repository demonstrates a full **RTL to GDSII ASIC design flow** using the **SkyWater 130nm** PDK. It includes:

- 🧱 Design and characterization of a **custom inverter standard cell** (`sky130_vsdin`)
- 🔬 SPICE-based analysis and verification using **Magic** and **NGSPICE**
- 🔗 Seamless integration of the cell into a **RISC-V core (`PicoRV32`)**
- 🚀 RTL to GDSII flow using **[OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)** and **OpenROAD**

---

---




## 🔧 Part 1: Custom Standard Cell Creation & Characterization

This section outlines the process we followed to design, simulate, and characterize our **custom inverter cell**. The layout methodology and characterization flow were **inspired by the open-source repository [`vsdstdcelldesign`](https://github.com/nickson-jose/vsdstdcelldesign)**, which served as a valuable reference during the development of our standard cell.


---

### ✅ Step 1: Clone the Custom Inverter Layout Repository

```bash
# Navigate to your OpenLane working directory
cd ~/Desktop/work/tools/openlane_working_dir/openlane

# Clone the inverter layout GitHub repo
git clone https://github.com/nickson-jose/vsdstdcelldesign

# Move into the cloned repo
cd vsdstdcelldesign

# Copy the Magic tech file for Sky130
cp ~/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech .

# Confirm the files
ls

# Open layout in Magic
magic -T sky130A.tech sky130_inv.mag &
````

---

### 🧪 Step 2: SPICE Netlist Extraction via Magic

Once inside the Magic GUI:

1. Run **Design Rule Check (DRC)**:

   ```tcl
   drc why
   ```

2. Extract the layout and generate the **SPICE netlist**:

   ```tcl
   extract all
   ext2spice cthresh 0
   ext2spice
   ```

📦 Output: A `sky130_inv.spice` netlist for simulation.

---

### 📐 Step 3: Characterize the Inverter Using NGSPICE

Inside the `CustomCell/` directory, we provide a spice netlist with libraries  for:

* 📈 DC Transfer Characteristics
* ⏱️ Transient Response (Rise/Fall Delay)
* ⚡ Power Consumption

#### ▶️ Run the Simulation:

```bash
# Navigate to the testbench directory
cd CustomCell

# Launch NGSPICE to simulate
ngspice sky130_inv.spice
```

✨ The waveform output and power/delay metrics can be used for cell library generation or integration.

---

## 📚 External Links & Tools

* 🔗 [SkyWater Open PDK (Sky130)](https://github.com/google/skywater-pdk)
* 🧰 [OpenLane Flow](https://github.com/The-OpenROAD-Project/OpenLane)
* 💡 [PicoRV32 - Minimal RISC-V CPU Core](https://github.com/cliffordwolf/picorv32)
* 🧪 [Magic VLSI Layout Tool](http://opencircuitdesign.com/magic/)
* ⚙️ [NGSPICE Simulator](https://ngspice.sourceforge.io/)

---

# 🚀 RTL to GDSII Flow: Integrating Custom Inverter with PicoRV32 on Sky130

This section documents **Part 2** of the project, where we integrate our custom inverter into the **PicoRV32 RISC-V core** and perform a complete **RTL to GDSII flow** using the **OpenLane toolchain** with the **SkyWater 130nm PDK**.

We recommend using the following pre-built OpenLane working directory:
🔗 [OpenLane working environment by Fayiz Ferosh](https://github.com/fayizferosh/soc-design-and-planning-nasscom-vsd/tree/main/Desktop/work/tools/openlane_working_dir)

All required tools and dependencies are already downloaded in this environment.

---

## 🐳 Launch OpenLane using Docker

Use the command below to launch OpenLane from Docker:

```bash
sudo docker run -it --rm \
-v /home/iraj/VLSI/openlane_working_dir/openlane:/openLANE_flow \
-v /home/iraj/VLSI/openlane_working_dir/openlane/pdks:/home/iraj/VLSI/openlane_working_dir/openlane/pdks \
-e PDK_ROOT=/home/iraj/VLSI/openlane_working_dir/openlane/pdks \
-u 0:0 efabless/openlane:v0.15
```

### 🔍 Explanation:

* `-it`: Runs an interactive terminal session
* `--rm`: Automatically removes the container after exit
* `-v`: Mounts host directories into Docker (code and PDKs)
* `-e PDK_ROOT=...`: Specifies the PDK root directory
* `-u 0:0`: Runs Docker as root user
* `efabless/openlane:v0.15`: Specifies the OpenLane version

---

## 📁 Replace the PicoRV32 Folder

Replace the default `picorv32a` folder in the OpenLane `designs` directory with **your custom `picorv32a` folder**.

```bash
cd Desktop/work/tools/openlane_working_dir/openlane
```

---

## 🧪 OpenLane Interactive Flow

```bash
./flow.tcl -interactive
```

```tcl
package require openlane 0.9
```

### 🔧 Prep the Design

```tcl
prep -design picorv32a -tag 04-07_04-38 -overwrite
```

You can either reuse an existing run directory (`runs/04-07_04-38`) or generate a fresh one:

```tcl
prep -design picorv32a
```
```bash
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```
```bash
set ::env(SYNTH_STRATEGY) "DELAY 3"
```
```bash
set ::env(SYNTH_SIZING) 1
```

---

## 🧠 Step-by-Step Flow Explanation

### 1️⃣ Synthesis

```tcl
run_synthesis
28. Printing statistics.

=== picorv32a ===

   Number of wires:              22757
   Number of wire bits:          23139
   Number of public wires:        1565
   Number of public wire bits:    1947
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:              23037
     sky130_fd_sc_hd__a2111o_2       7
     sky130_fd_sc_hd__a2111oi_2      1
     sky130_fd_sc_hd__a211o_2       48
     sky130_fd_sc_hd__a211oi_2       7
     sky130_fd_sc_hd__a21bo_2       44
     sky130_fd_sc_hd__a21boi_2     125
     sky130_fd_sc_hd__a21o_2       582
     sky130_fd_sc_hd__a21oi_2     1078
     sky130_fd_sc_hd__a221o_2       82
     sky130_fd_sc_hd__a221oi_2       4
     sky130_fd_sc_hd__a22o_2       226
     sky130_fd_sc_hd__a22oi_2      305
     sky130_fd_sc_hd__a2bb2o_2      24
     sky130_fd_sc_hd__a2bb2oi_2     17
     sky130_fd_sc_hd__a311o_2       17
     sky130_fd_sc_hd__a31o_2        95
     sky130_fd_sc_hd__a31oi_2       95
     sky130_fd_sc_hd__a32o_2        41
     sky130_fd_sc_hd__a32oi_2       15
     sky130_fd_sc_hd__a41o_2        11
     sky130_fd_sc_hd__a41oi_2        5
     sky130_fd_sc_hd__and2_2       492
     sky130_fd_sc_hd__and2b_2       23
     sky130_fd_sc_hd__and3_2       411
     sky130_fd_sc_hd__and3b_2        7
     sky130_fd_sc_hd__and4_2        76
     sky130_fd_sc_hd__and4b_2        3
     sky130_fd_sc_hd__buf_1       1644
     sky130_fd_sc_hd__buf_2         14
     sky130_fd_sc_hd__conb_1        42
     sky130_fd_sc_hd__dfxtp_2     1613
     sky130_fd_sc_hd__inv_2         98
     sky130_fd_sc_hd__mux2_1      1224
     sky130_fd_sc_hd__mux2_2       902
     sky130_fd_sc_hd__mux4_1       221
     sky130_fd_sc_hd__nand2_2     3394
     sky130_fd_sc_hd__nand2b_2       1
     sky130_fd_sc_hd__nand3_2     2128
     sky130_fd_sc_hd__nand3b_2     317
     sky130_fd_sc_hd__nor2_2      1887
     sky130_fd_sc_hd__nor2b_2       10
     sky130_fd_sc_hd__nor3_2        61
     sky130_fd_sc_hd__nor3b_2        7
     sky130_fd_sc_hd__o2111a_2      15
     sky130_fd_sc_hd__o2111ai_2     74
     sky130_fd_sc_hd__o211a_2      338
     sky130_fd_sc_hd__o211ai_2     249
     sky130_fd_sc_hd__o21a_2       156
     sky130_fd_sc_hd__o21ai_2     1040
     sky130_fd_sc_hd__o21ba_2       17
     sky130_fd_sc_hd__o21bai_2     151
     sky130_fd_sc_hd__o221a_2       44
     sky130_fd_sc_hd__o221ai_2      11
     sky130_fd_sc_hd__o22a_2        38
     sky130_fd_sc_hd__o22ai_2      264
     sky130_fd_sc_hd__o2bb2a_2      25
     sky130_fd_sc_hd__o2bb2ai_2    323
     sky130_fd_sc_hd__o311a_2        3
     sky130_fd_sc_hd__o311ai_2       2
     sky130_fd_sc_hd__o31a_2        14
     sky130_fd_sc_hd__o31ai_2        4
     sky130_fd_sc_hd__o32a_2        12
     sky130_fd_sc_hd__o32ai_2        2
     sky130_fd_sc_hd__or2_2        387
     sky130_fd_sc_hd__or2b_2        29
     sky130_fd_sc_hd__or3_2         64
     sky130_fd_sc_hd__or3b_2        10
     sky130_fd_sc_hd__or4_2         70
     sky130_fd_sc_hd__or4b_2         3
     sky130_fd_sc_hd__xnor2_2       36
     sky130_fd_sc_hd__xor2_2        86
     sky130_vsdinv                2166

   Chip area for module '\picorv32a': 209181.872000

29. Executing Verilog backend.
Dumping module `\picorv32a'.

Warnings: 307 unique messages, 307 total
End of script. Logfile hash: da0220ae91, CPU: user 34.64s system 0.37s, MEM: 99.04 MB peak
Yosys 0.9+3621 (git sha1 84e9fa7, gcc 8.3.1 -fPIC -Os)
Time spent: 75% 2x abc (102 sec), 6% 33x opt_expr (8 sec), ...
[INFO]: Changing netlist from 0 to /openLANE_flow/designs/picorv32a/runs/05-07_15-41/results/synthesis/picorv32a.synthesis.v
[INFO]: Running Static Timing Analysis...
# TODO set this as parameter
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
[INFO]: Setting load to: 0.01765
set_load  $cap_load [all_outputs]
Startpoint: resetn (input port clocked by clk)
Endpoint: _42736_ (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: min

Fanout     Cap    Slew   Delay    Time   Description
----------------------------------------------------------------------------
                 0.00    0.00    0.00   clock clk (rise edge)
                         0.00    0.00   clock network delay (ideal)
                         0.00    0.00 ^ input external delay
                 0.02    0.01    0.01 ^ resetn (in)
    5    0.01                           resetn (net)
                 0.02    0.00    0.01 ^ _41347_/S (sky130_fd_sc_hd__mux2_1)
                 0.02    0.07    0.08 ^ _41347_/X (sky130_fd_sc_hd__mux2_1)
    1    0.00                           _00003_ (net)
                 0.02    0.00    0.08 ^ _42736_/D (sky130_fd_sc_hd__dfxtp_2)
                                 0.08   data arrival time

                 0.00    0.00    0.00   clock clk (rise edge)
                         0.00    0.00   clock network delay (ideal)
                         0.00    0.00   clock reconvergence pessimism
                                 0.00 ^ _42736_/CLK (sky130_fd_sc_hd__dfxtp_2)
                        -0.02   -0.02   library hold time
                                -0.02   data required time
----------------------------------------------------------------------------
                                -0.02   data required time
                                -0.08   data arrival time
----------------------------------------------------------------------------
                                 0.09   slack (MET)


Startpoint: _42923_ (rising edge-triggered flip-flop clocked by clk)
Endpoint: _42703_ (rising edge-triggered flip-flop clocked by clk)
Path Group: clk
Path Type: max

Fanout     Cap    Slew   Delay    Time   Description
----------------------------------------------------------------------------
                 0.00    0.00    0.00   clock clk (rise edge)
                         0.00    0.00   clock network delay (ideal)
                 0.00    0.00    0.00 ^ _42923_/CLK (sky130_fd_sc_hd__dfxtp_2)
                 1.01    1.31    1.31 ^ _42923_/Q (sky130_fd_sc_hd__dfxtp_2)
   39    0.13                           cpu_state[3] (net)
                 1.01    0.00    1.31 ^ _42093_/S (sky130_fd_sc_hd__mux2_1)
                 8.52    6.56    7.86 ^ _42093_/X (sky130_fd_sc_hd__mux2_1)
  161    0.63                           _00357_ (net)
                 8.52    0.00    7.86 ^ _42583_/S0 (sky130_fd_sc_hd__mux4_1)
                 0.18    2.51   10.37 v _42583_/X (sky130_fd_sc_hd__mux4_1)
    1    0.00                           _00361_ (net)
                 0.18    0.00   10.37 v _42586_/A1 (sky130_fd_sc_hd__mux4_1)
                 0.14    1.14   11.51 v _42586_/X (sky130_fd_sc_hd__mux4_1)
    1    0.00                           _00365_ (net)
                 0.14    0.00   11.51 v _42088_/A1 (sky130_fd_sc_hd__mux2_1)
                 0.13    0.70   12.22 v _42088_/X (sky130_fd_sc_hd__mux2_1)
    1    0.00                           _00370_ (net)
                 0.13    0.00   12.22 v _21612_/B (sky130_fd_sc_hd__nand2_2)
                 0.11    0.16   12.38 ^ _21612_/Y (sky130_fd_sc_hd__nand2_2)
    3    0.01                           _18851_ (net)
                 0.11    0.00   12.38 ^ _26230_/B2 (sky130_fd_sc_hd__o221a_2)
                 0.07    0.37   12.75 ^ _26230_/X (sky130_fd_sc_hd__o221a_2)
    1    0.00                           _01718_ (net)
                 0.07    0.00   12.75 ^ _41953_/A0 (sky130_fd_sc_hd__mux2_1)
                 0.07    0.21   12.96 ^ _41953_/X (sky130_fd_sc_hd__mux2_1)
    1    0.00                           _01719_ (net)
                 0.07    0.00   12.96 ^ _26238_/A1_N (sky130_fd_sc_hd__a2bb2o_2)
                 0.08    0.52   13.47 v _26238_/X (sky130_fd_sc_hd__a2bb2o_2)
    1    0.00                           _04123_ (net)
                 0.08    0.00   13.47 v _26239_/C1 (sky130_fd_sc_hd__a311o_2)
                 0.08    0.56   14.04 v _26239_/X (sky130_fd_sc_hd__a311o_2)
    1    0.00                           _01720_ (net)
                 0.08    0.00   14.04 v _41548_/A0 (sky130_fd_sc_hd__mux2_1)
                 0.10    0.61   14.65 v _41548_/X (sky130_fd_sc_hd__mux2_1)
    1    0.00                           _21109_ (net)
                 0.10    0.00   14.65 v _42703_/D (sky130_fd_sc_hd__dfxtp_2)
                                14.65   data arrival time

                 0.00   12.00   12.00   clock clk (rise edge)
                         0.00   12.00   clock network delay (ideal)
                         0.00   12.00   clock reconvergence pessimism
                                12.00 ^ _42703_/CLK (sky130_fd_sc_hd__dfxtp_2)
                        -0.31   11.69   library setup time
                                11.69   data required time
----------------------------------------------------------------------------
                                11.69   data required time
                               -14.65   data arrival time
----------------------------------------------------------------------------
                                -2.95   slack (VIOLATED)


tns -266.40
wns -2.95
[INFO]: Synthesis was successful
```

🔹 Converts RTL (Verilog) into a gate-level netlist using a standard cell library.
🔹 Performs optimizations and maps the logic to physical cells.

---

### 2️⃣ Floorplanning and IO Placement


```tcl
init_floorplan
place_io
tap_decap_or
```


🔹 Creates a chip outline, defines core area and margins.
🔹 Places IO pins around the core.
🔹 Adds tap and decap cells for well-tap and power integrity.

---

### 3️⃣ Placement

Running placement
```tcl
run_placement
```

🔹 Automatically places standard cells within the floorplan.

![Placement Screenshot](images/placement.png)

---

### 4️⃣ Clock Tree Synthesis (CTS)

```tcl
unset ::env(LIB_CTS)
run_cts
```

🔹 Adds buffers/inverters to balance clock signal delays (skew).
🔹 Ensures the clock reaches all flip-flops in sync.

![CTS Screenshot](https://github.com/user-attachments/assets/dbf3ad4d-9a4c-45ee-87c3-c8abf0d77423)

---

### 5️⃣ Power Distribution Network (PDN)

```tcl
gen_pdn
```

🔹 Creates VDD and GND grid to distribute power.
🔹 Essential for avoiding IR drop and powering the whole chip.

View PDN in Magic:

```bash
cd home/VLSI/openlane_working_dir/openlane/designs/picorv32a/runs/04-07_04-38/tmp/floorplan/
magic -T home/VLSI/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech \
lef read ../../tmp/merged.lef def read 14-pdn.def &
```

---

### 6️⃣ Routing (TritonRoute)

```tcl
run_routing
```

🔹 Connects all placed cells and pins using metal layers.
🔹 Ensures DRC-clean signal paths.

To view routed DEF in Magic:

```bash
cd home/VLSI/openlane_working_dir/openlane/designs/picorv32a/runs/04-07_04-38/results/routing/
magic -T home/VLSI/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech \
lef read ../../tmp/merged.lef def read picorv32a.def &
```



## ⏱️ Post-Route Timing Analysis with OpenSTA

```tcl
openroad
read_lef /openLANE_flow/designs/picorv32a/runs/04-07_04-38/tmp/merged.lef
read_def /openLANE_flow/designs/picorv32a/runs/04-07_04-38/results/routing/picorv32a.def
write_db pico_route.db
read_db pico_route.db
read_verilog /openLANE_flow/designs/picorv32a/runs/04-07_04-38/results/synthesis/picorv32a.synthesis_preroute.v
read_liberty $::env(LIB_SYNTH_COMPLETE)
link_design picorv32a
read_sdc /openLANE_flow/designs/picorv32a/src/my_base.sdc
set_propagated_clock [all_clocks]
read_spef /openLANE_flow/designs/picorv32a/runs/04-07_04-38/results/routing/picorv32a.spef
report_checks -path_delay min_max -fields {slew trans net cap input_pins} -format full_clock_expanded -digits 4
exit
```

### 📈 Why Timing Analysis?

* Validates that signal arrival times meet setup/hold constraints.
* Ensures clock domain timing is safe.

---

## 🎯 Final Layout View

![Final Layout](Images/layout.png)

---

✅ With this flow, your custom inverter is successfully integrated into a real RISC-V design and taped out to GDSII using industry-standard open-source tools.



```

---

Would you like me to include **Part 2** as well in the same style (integration into OpenLane and PicoRV32 RTL-to-GDS flow)?
```
