# RTL-to-GDS-with-a-custom-Inverter-Sky130_vsdinv-
Custom inverter cell (sky130_vsdin) designed using Magic layout editor and characterized via SPICE simulations. The cell is integrated into the PicoRV32 RISC-V processor and verified through RTL-to-GDSII flow using OpenLane and OpenROAD with the SkyWater 130nm PDK.


#### 1. Clone custom inverter standard cell design from github repository

```bash
# Change directory to openlane
cd Desktop/work/tools/openlane_working_dir/openlane

# Clone the repository with custom inverter design
git clone https://github.com/nickson-jose/vsdstdcelldesign

# Change into repository directory
cd vsdstdcelldesign

# Copy magic tech file to the repo directory for easy access
cp /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech .

# Check contents whether everything is present
ls

# Command to open custom inverter layout in magic
magic -T sky130A.tech sky130_inv.mag &
```
<p align="center">
<img src="https://github.com/user-attachments/assets/51adc6da-7ab2-4c1e-b0d8-920fca0ff34d"
alt="alt text" width = 553 height = 358  >
<p/>
  
<p align="center">
<img src="https://github.com/user-attachments/assets/84dc153a-bcff-43aa-a258-4c270915f3a9"
alt="alt text" width = 553 height = 358  >
<p/>
  
## Sky130 Tech File Labs
<p align="center">
<img src="https://github.com/user-attachments/assets/6cab866b-a43a-40e2-ac49-1f604bf1aaba"
alt="alt text" width = 553 height = 358  >
<p/>
After running this file we get output of ngspice like this,
<p align="center">
<img src="https://github.com/user-attachments/assets/57a7e29c-b1c3-47b3-b170-d759439f8b16"
alt="alt text" width = 553 height = 358  >
<p/>
Now, ploting the graph here by command, plot y vs time a.

<p align="center">
<img src="https://github.com/user-attachments/assets/499f77e8-4e2e-40fd-bf64-a96dd5f78e5f"
alt="alt text" width = 553 height = 358  >
<p/>

![Screenshot from 2025-02-20 20-43-33](https://github.com/user-attachments/assets/efd7e81f-9176-4fcc-a492-9148b304a1e5)

![Screenshot from 2025-02-20 20-44-31](https://github.com/user-attachments/assets/fc5a51b3-b7bb-4e93-9abf-43ca53c20d77)

![Screenshot from 2025-02-20 20-46-16](https://github.com/user-attachments/assets/32284bfd-b6e0-497d-8c7d-11c7d64aab22)
![Screenshot from 2025-02-20 20-46-19](https://github.com/user-attachments/assets/4a511589-42ac-4872-a6cf-894184b83e96)
![Screenshot from 2025-02-20 20-51-25](https://github.com/user-attachments/assets/7ea7f966-647b-4ad7-ba98-ea42de96125d)
![Screenshot from 2025-02-20 20-52-55](https://github.com/user-attachments/assets/b882bcb4-f4f9-447e-bff5-875834ac78e5)
![Screenshot from 2025-02-20 20-53-06](https://github.com/user-attachments/assets/62e210f6-9e8d-4467-8d32-923c396754a3)
![Screenshot from 2025-02-20 21-05-21](https://github.com/user-attachments/assets/4314438f-1ab4-444e-a880-7fd71077c163)
![Screenshot from 2025-02-20 21-07-19](https://github.com/user-attachments/assets/1a5e1994-9496-45fc-b75a-9c3523268b02)
![Screenshot from 2025-02-20 21-09-01](https://github.com/user-attachments/assets/6058de99-d7e5-4a91-bfa9-559ad682146c)
![Screenshot from 2025-02-20 21-13-09](https://github.com/user-attachments/assets/7f63946b-476a-4769-a563-2e6c570f0ede)
![Screenshot from 2025-02-20 21-13-24](https://github.com/user-attachments/assets/54359daa-bb0e-4628-9b22-2808650f5b8b)
