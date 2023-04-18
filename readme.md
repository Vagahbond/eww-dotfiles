# Vagahbar

This is the eww bar configuration I made the rice I use on my daily driver. 

It currently runs on NixOS but this configuration is made so that it can be used on any type of setup. 

## Installation

1) Clone this repos in `~/.config/eww`
2) If you want to use other widgets alognside this bar, you can just paste the content of `eww.yuck` in yours, and it should import the files correctly. Same applies for the scss file.
3) For the auto-adaptive feature to work, you must be on Hyprland, and run the script `./bar/listen_events.sh` on session open (`exec` directive).

### Adaptive bar

The way the adaptive bar works is by using `tail -f` on a file, having in the meantime a script writing repeatedly on this file a "mode" of dipslay (tiled or fullscreen). If you want to adapt it to another windows manager, simply use their IPC to detect the displaying mode on it.

### Colors
