#!/bin/bash
ZIP_NAME=test_code.zip
cd install_csfml/files/test_code
cp $ZIP_NAME ../../..
cd ../../..
unzip -qq -u -d . $ZIP_NAME
rm -rf $ZIP_NAME
