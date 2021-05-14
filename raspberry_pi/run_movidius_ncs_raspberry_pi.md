 + Install raspbian sketch version on raspberry pi 3 model B
 + Resize default swap size (default 100MB) to 2GB:
   - Edit CONF_SWAPSIZE value in /etc/dphys-swapfile to 2048 and run the following command
   ```bash
   sudo systemctl stop dphys-swapfile
   sudo systemctl start dphys-swapfile
   ```
   - run
   ```bash
   free -h
   ```
   to check if swap size has been changed
   