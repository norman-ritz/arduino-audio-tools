#!/bin/bash
##
# We compile an example for different architectures using arduino-cli in order to identify compile errors 
# The return codes are made available in the build-examples-log.txt file. 
# -> rc=0: success
# -> rc=1: error
##
git -C .. pull
git -C ../../ESP32-A2DP pull

function compile_example {
    ARCH=$1
    FILE="./examples-stream/streams-generator-serial"
    # take action on each file. $f store current file name
    arduino-cli compile -b "$ARCH" "$FILE"
    EC=$?
    echo -e "$ARCH $FILE -> rc=$EC" >> "build-arch-log.txt"
}

rm build-arch-log.txt
compile_example "esp32:esp32:esp32" 
compile_example "esp8266:esp8266:generic" 
compile_example "arduino:mbed_rp2040:pico" 
compile_example "rp2040:rp2040:generic" 
compile_example "arduino:avr:nano" 
#compile_example "STMicroelectronics:stm32:GenF4" 

./cleanup.sh

