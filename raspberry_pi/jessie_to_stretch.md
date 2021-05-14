- To upgrade, first modify the files /etc/apt/sources.list and /etc/apt/sources.list.d/raspi.list. In both files, change every occurrence of the word ‘jessie’ to ‘stretch’. (Both files will require sudo to edit.)

- Run the following command lines to upgrade from jessie to sketch version

  ```bash
  sudo apt-get update
  sudo apt-get dist-upgrade
  ```
