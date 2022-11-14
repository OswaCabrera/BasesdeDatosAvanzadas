#!/bin/bash

#--@Autor: Oswaldo Cabrera Pérez
#--@Fecha creación: 06/09/2022
#--@Descripción: Creación de 3 loop devices

echo "Creando dispositivos con loop devices"

echo "Creando /unam-bda/disk-images"
mkdir -p /unam-bda/disk-images

cd /unam-bda/disk-images

echo "Creando disk*.img"

dd if=/dev/zero of=disk1.img bs=100M count=10
dd if=/dev/zero of=disk2.img bs=100M count=10
dd if=/dev/zero of=disk3.img bs=100M count=10

echo "MOstrando la creación de los archivos"

du -sh disk*.img

echo "Asociando archivos img a loop devices"
losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img

losetup -a

echo "Dando formato ext4"
mkfs.ext4 disk1.img
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

echo "Creando los directorios (puntos de montaje)"
mkdir /unam-bda/d01
mkdir /unam-bda/d02
mkdir /unam-bda/d03

