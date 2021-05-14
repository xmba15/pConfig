 - Check the version of Raspbian
```bash
cat /proc/device-tree/model
```

 - Swap Ctrl and CapsLk key for Raspbian
```bash
modify XKBOPTIONS="ctrl:swapcaps" in /etc/default/keyboard
sudo dpkg-reconfigure keyboard-configuration
```