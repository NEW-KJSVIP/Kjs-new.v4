#!/bin/bash

# ===============================
# UPDATE SCRIPT SYSTEM - RAINBOW NEON + EMOTIKON
# ===============================

dateFromServer=$(curl -s --insecure -I https://google.com/ | grep ^Date: | sed 's/Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# ===============================
# WARNA NEON RAINBOW
# ===============================
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
PURPLE='\e[1;35m'
CYAN='\e[1;36m'
NC='\e[0m'
NEON_COLORS=($RED $GREEN $YELLOW $BLUE $PURPLE $CYAN)

# ===============================
# FUN BAR RAINBOW + EMOTIKON
# ===============================
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"

    # Jalankan update di background
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &

    tput civis
    bar_length=20
    sp=('⏳' '⚡' '💻' '🔥' '🔄' '✔️')

    percent=0
    while [[ ! -e $HOME/fim ]]; do
        percent=$((percent + 2))
        [[ $percent -gt 100 ]] && percent=100

        num_hash=$((percent*bar_length/100))
        num_space=$((bar_length-num_hash))
        bar=""
        for ((i=0; i<num_hash; i++)); do
            color=${NEON_COLORS[$RANDOM % ${#NEON_COLORS[@]}]}
            bar+="${color}#${NC}"
        done
        for ((i=0; i<num_space; i++)); do
            bar+=" "
        done

        spinner=${sp[$RANDOM % ${#sp[@]}]}
        echo -ne "\r  \033[1;37mUpdating System \033[1;37m[${bar}] ${percent}% ${spinner}"
        sleep 0.08
    done

    # Tampilkan 100% DONE dengan warna neon
    final_bar=""
    for ((i=0;i<bar_length;i++)); do
        color=${NEON_COLORS[$RANDOM % ${#NEON_COLORS[@]}]}
        final_bar+="${color}#${NC}"
    done
    echo -e "\r  \033[1;37mUpdating System [${final_bar}] 100% ✔️ ${GREEN}DONE!${NC}"
    tput cnorm
    [[ -e $HOME/fim ]] && rm $HOME/fim
}

# ===============================
# Fungsi Res1: Update Menu & File
# ===============================
res1() {
    cd
    wget -q https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Cdy/menu.zip
    wget -q -O /usr/bin/enc "https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Enc/encrypt"
    chmod +x /usr/bin/enc

    7z x -pas123@Newbie menu.zip >/dev/null 2>&1
    chmod +x menu/*
    enc menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu menu.zip *.sh* /usr/local/sbin/*~ /usr/local/sbin/gz* /usr/local/sbin/*.bak /usr/local/sbin/m-noobz

    wget -q -O /usr/local/sbin/m-noobz "https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Cfg/m-noobz"
    chmod +x /usr/local/sbin/m-noobz
}

# ===============================
# MAIN SCRIPT
# ===============================
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          UPDATE SCRIPT        \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

echo -e "  \033[1;91mUpdating script service...\033[1;37m"
fun_bar 'res1'

echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -n 1 -s -r -p "Press [ Enter ] to back to menu"
menu
