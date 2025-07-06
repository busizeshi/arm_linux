#!/bin/bash
cd /home/jwd/development/arm_linux/imx6ull_linux_drivers
cd ./1_chrdevbase

make -j 12

arm-linux-gnueabihf-gcc chrdevbaseApp.c -o chrdevbaseApp

cp *.ko ~/linux/nfs/rootfs/lib/modules/4.1.15/
cp *App ~/linux/nfs/rootfs/lib/modules/4.1.15/

make clean