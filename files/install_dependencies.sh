#!/bin/bash
PACKAGE_MANAGER=dnf
PACKAGE_ARGUMENT=install
C_COMPILER=gcc.x86_64
TYPE_32BIT_INSTALLER=mingw32-gcc.x86_64
TYPE_64BIT_INSTALLER=mingw64-gcc.x86_64
echo "Installing gcc (a compiler for c)"
echo "Running sudo $PACKAGE_MANAGER $PACKAGE_ARGUMENT $C_COMPILER"
sudo $PACKAGE_MANAGER $PACKAGE_ARGUMENT $C_COMPILER
echo "Installing compiler for 32 bit windows systems"
echo "Installing sudo $PACKAGE_MANAGER $PACKAGE_ARGUMENT $TYPE_32BIT_INSTALLER"
sudo $PACKAGE_MANAGER $PACKAGE_ARGUMENT $TYPE_32BIT_INSTALLER
echo "Installing compiler for 64 bit windows systems"
echo "Installing sudo $PACKAGE_MANAGER $PACKAGE_ARGUMENT $TYPE_64BIT_INSTALLER"
sudo $PACKAGE_MANAGER $PACKAGE_ARGUMENT $TYPE_64BIT_INSTALLER
echo "Thank you for using this script"
echo "This script was created by (c) Henry Letellier"
