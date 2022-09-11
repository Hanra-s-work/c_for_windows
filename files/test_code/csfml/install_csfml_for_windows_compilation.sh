#!/bin/bash

MAIN_MENU_QUESTION="Which version of the compiler would you like to install? [(A)ll/(3)2bit version/(6)4bit version]"
RESPONSE=""
ERROR_MESSAGE="Please only enter A for all, 3 for 32bit or 6 for 64bit."

LINK_FOR_32="https://www.sfml-dev.org/files/CSFML-2.5.1-windows-32-bit.zip"
FILE_32BIT_NAME="CSFML-2.5.1-windows-32-bit.zip"
FOLDER_32BIT_NAME="CSFML-2.5.1-windows-32-bit"
DESTINATION_32BIT_PATH=/usr/lib/gcc/i686-w64-mingw32
THE_32BIT_MINGW32_VERSION=10.3.1

LINK_FOR_64="https://www.sfml-dev.org/files/CSFML-2.5.1-windows-64-bit.zip"
FILE_64BIT_NAME="CSFML-2.5.1-windows-64-bit.zip"
FOLDER_64BIT_NAME="CSFML-2.5.1-windows-64-bit"
DESTINATION_64BIT_PATH=/usr/lib/gcc/x86_64-w64-mingw32
THE_64BIT_MINGW32_VERSION=10.3.1

WATERMARK="Created by (c) Henry Letellier"

# /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/../../../../x86_64-w64-mingw32/bin/ld: cannot find -lcsfml-graphics
# /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/../../../../x86_64-w64-mingw32/bin/ld: cannot find -lcsfml-audio
# /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/../../../../x86_64-w64-mingw32/bin/ld: cannot find -lcsfml-system
# /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/../../../../x86_64-w64-mingw32/bin/ld: cannot find -lcsfml-window

# links to fiddle with


# for the 32 bits:
# dl 32bit v csfml
# unzip 32bit v csfml
# cd 32bit v csfml
# mv bin/* /usr/x86_64-w64-mingw32/bin/
# mv include/* /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/include/
# cp lib/gcc/* /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/
# mkdir /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/gcc/
# mv lib/gcc/* /usr/lib/gcc/x86_64-w64-mingw32/10.3.1/gcc/


function yes_no_question {
    while true; do
        read -p "$1 [(Y)es/(n)o]: " yn
        case $yn in
            [Yy]* ) 
                return $TRUE;
                break;;
            [Nn]* ) 
                return $FALSE;
                break;;
            * ) 
                echo "Please enter yes or no."
                echo "You have entered: $yn";;
        esac
    done
}

function is_admin() {
    if [[ $EUID -ne 0 ]]
    then
        echo "It is recommended that this script is launched with administator rights."
        echo "If you wish to proceed, the rights will be asked at the step when required."
        yes_no_question "Do you wish to grant this script administrator rights?"
        USR_ANSW=$?
        if [[ $USR_ANSW -eq $TRUE ]]
        then
            sudo $1
            exit 0
        else
            echo "You have decided to not grant administator rights to the program."
            echo "It will thus ask them when required."
        fi
    fi
}

function download_a_ressource() {
    # $1 The link (i.e. $LINK_FOR_32)
    # $2 The filename (i.e. $FILE_32BIT_NAME)
    echo "Fetching $2 at $1"
    curl -LO $1 -o $2
}

function extract_compressed_file() {
    # $1 The compressed file (i.e. $FILE_32BIT_NAME)
    # $2 The name of the output folder (i.e. $FOLDER_32BIT_NAME)
    echo "Decompressing $1"
    unzip -q $1 -d $2
}

function copy_folder() {
    # $1 source, $2 dest
    echo "Copying $1 to $2"
    sudo cp -r $1 $2
}

function install_for_compiler() {
    # $1 source path (i.e. $FOLDER_32BIT_NAME)
    # $2 dest path (i.e. $DESTINATION_32BIT_PATH)
    # $3 version path (i.e. $MINGW32_VERSION)
    copy_folder $1/bin/* $2/bin/
    copy_folder $1/include/* $2/$3/include/
    copy_folder $1/lib/gcc/* $2/$3/
    copy_folder $1/lib/gcc/ $2/$3/
}


function cleanup_temp_files() {
    # $1 is the folder/file you wish to remove
    echo "Deleting $1"
    rm -rf $1
}

function install_for_32bit() {
    download_a_ressource $LINK_FOR_32 $FILE_32BIT_NAME
    extract_compressed_file $FILE_32BIT_NAME $FOLDER_32BIT_NAME
    rm -rf $FILE_32BIT_NAME
    install_for_compiler $FOLDER_32BIT_NAME $DESTINATION_32BIT_PATH $THE_32BIT_MINGW32_VERSION
    cleanup_temp_files $FOLDER_32BIT_NAME
}

function install_for_64bit() {
    download_a_ressource $LINK_FOR_64 $FILE_64BIT_NAME
    extract_compressed_file $FILE_64BIT_NAME $FOLDER_64BIT_NAME
    rm -rf $FILE_64BIT_NAME
    install_for_compiler $FOLDER_64BIT_NAME $DESTINATION_64BIT_PATH $THE_64BIT_MINGW32_VERSION
    cleanup_temp_files $FOLDER_64BIT_NAME
}

function yes_no_question {
    while true; do
        read -p "$1 [(Y)es/(n)o]: " yn
        case $yn in
            [Yy]* )
                return $TRUE;
                break;;
            [Nn]* )
                return $FALSE;
                break;;
            * )
                echo "Please enter yes or no."
                echo "You have entered: $yn";;
        esac
    done
}

function what_to_install() {
    while true; do
        read -p "$MAIN_MENU_QUESTION" RESPONSE
        case $RESPONSE in
            [Aa]* )
                install_for_32bit
                install_for_64bit
                break;;
            [32]* )
                install_for_32bit
                break;;
            [64]* )
                install_for_64bit
                break;;
            * )
                echo "$ERROR_MESSAGE"
                echo "You have entered '$RESPONSE'"
        esac
    done
}


echo "$WATERMARK"
is_admin $0
what_to_install
echo "$WATERMARK"
