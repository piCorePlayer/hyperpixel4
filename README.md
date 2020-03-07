# HyperPixel 4.0" Drivers for Raspberry Pi 3B+ or older

HyperPixel 4.0 is an 800x480 pixel display for the Raspberry Pi, with optional capacitive touchscreen.

These drivers are for Raspberry Pi models before the Pi 3B+.

## Installing / Uninstalling

1. Clone this GitHub repository to your Pi:
```
git clone https://github.com/pimoroni/hyperpixel4 -b pCP
```
2. copy dist/hp4-init to /mnt/mmcblk0p1/tce
3. Add /mnt/mmcblk0p1/tce/hp4-init to /opt/bootlocal.sh  (Add it before pCP startup)
4. Add to /mnt/mmcblk0p1/config.txt:
**pi0-pi3B+**
```
dtoverlay=hyperpixel4,touchscreen-size-x=800,touchscreen-size-y=480
display_rotate=1
overscan_left=0
overscan_right=0
overscan_top=0
overscan_bottom=0
enable_dpi_lcd=1
display_default_lcd=1
dpi_group=2
dpi_mode=87
dpi_output_format=0x7f216
hdmi_timings=480 0 10 16 59 800 0 15 113 15 0 0 0 60 0 32000000 6
```
**pi4:**
```
dtoverlay=hyperpixel4,touchscreen-size-x=800,touchscreen-size-y=480
display_rotate=1
gpio=0-25=a2
enable_dpi_lcd=1
dpi_group=2
dpi_mode=87
dpi_output_format=0x7f216
dpi_timings=480 0 10 16 59 800 0 15 113 15 0 0 0 60 0 32000000 6
```
**Rotation**

    * The settings above will show the display in landscape mode with the RPI 40pin header on the bottom
    * To rotate the display 180 degrees, change the rotation line to:
  ```
  display_rotate=3
  ```
    * The touchscreen will need calibrated after a change in rotation.

5. Install jivelite
    * Copy dist/jivelite.sh to /mnt/mmcblk0p2/tce/jivelite.sh
    * Install jivelite from the pCP Tweaks web page, then reboot.
6. Touch calibration
    * After boot, start a ssh session to your pi, and run the following commands. When you run ts_calibrate, touch the targets on your display.
```
sudo pkill jivelite
sudo ts_calibrate
pcp br
```
7. Backlight
   * From the pCP Extension interface install the extension pigpiod.tcz
   * Copy dist/lcd-brightness.sh to /home/tc/lcd-brightness.sh
   * Save and then reboot, everything should be setup.
