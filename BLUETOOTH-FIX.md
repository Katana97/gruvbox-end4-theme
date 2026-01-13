# Bluetooth Headphones Fix for Shure AONIC TW2

## The Problem
Bluetooth headphones would pair but not create audio devices. A2DP profiles wouldn't appear.

## The Solution
Two critical fixes were needed:

### 1. Enable Bluetooth Services in `/etc/bluetooth/main.conf`
Add this line under `[General]`:
```
Enable=Source,Sink,Media,Socket
```

### 2. Remove Conflicting WirePlumber Configs
These files were blocking Bluetooth:
- `/etc/wireplumber/wireplumber.conf.d/51-bluez-a2dp-only.conf`
- `/etc/wireplumber/wireplumber.conf.d/51-disable-bt-headset.conf`

## How to Fix After Updates

If Bluetooth breaks after an update:
```bash
# 1. Check /etc/bluetooth/main.conf still has Enable line
sudo nano /etc/bluetooth/main.conf
# Add: Enable=Source,Sink,Media,Socket

# 2. Remove any new Bluetooth restriction configs
sudo rm /etc/wireplumber/wireplumber.conf.d/*bluez*.conf
sudo rm /etc/wireplumber/wireplumber.conf.d/*bluetooth*.conf

# 3. Restart services
sudo systemctl restart bluetooth
systemctl --user restart wireplumber pipewire

# 4. Re-pair headphones
bluetoothctl remove 00:0E:DD:73:75:9B
# Then pair fresh via Bluetooth menu
```

## Verification
After connecting, check for A2DP profiles:
```bash
pactl list cards | grep -A30 "Shure" | grep "a2dp"
```

You should see profiles like `a2dp-sink-sbc`, `a2dp-sink-aac`, `a2dp-sink` (aptX).
