#!/bin/bash

#!/bin/bash

# Function to display the menu
display_menu() {
    echo "Please select a Device to build."
    echo "1. Tab S7+ WIFI"
    echo "2. Tab S7+ 5G"
    echo "3. Tab S7 LTE"
    echo "4. Note 20 Ultra 5G (KOR)"
    echo "5. Galaxy S20FE"
#    echo "3. Tab S7 LTE"
    echo "6. Exit"
}

# Function to set environment variables
set_environment() {
    case $1 in
        1)
            export NAME="Tab S7+ WIFI"
            export DEVICE="gts7xlwifi_eur_open"
            ;;
        2)
            export NAME="Tab S7+ 5g"
            export DEVICE="gts7xl_eur_openx"
            ;;
        3)
            export NAME="Tab S7 LTE"
            export DEVICE="gts7l_eur_open"
            ;;
        4)
            export NAME="Note 20 Ultra 5G (KOREAN)"
            export DEVICE="c2q_kor_singlew"
            ;;
        5)
            export NAME="Galaxy S20FE"
            export DEVICE="r8q_eur_openx"
            ;;
        6)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Function to proceed to the next command
next_command() {
    echo "Building for $NAME"
    PATH=$(pwd)/toolchain/clang-r522817/bin:$PATH
    PATH=$(pwd)/toolchain/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH
    make -j$(nproc --all) O=out ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- vendor/$(echo $DEVICE)_defconfig LLVM=1 LLVM_IAS=1
    make -j$(nproc --all) O=out ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-android- LLVM=1 LLVM_IAS=1
}

# Main script logic
while true; do
    display_menu
    read -p "Enter your choice: " choice
    set_environment $choice

    if [[ $choice -ge 1 && $choice -le 3 ]]; then
        next_command
        break
    fi
done
