#!/bin/bash

# ===============================
# METS STORE - ULTRA-FUTURISTIC MAIN MENU
# ===============================

# WARNA NEON RGB
RED='\e[1;31m'; GREEN='\e[1;32m'; YELLOW='\e[1;33m'
BLUE='\e[1;34m'; PURPLE='\e[1;35m'; CYAN='\e[1;36m'; NC='\e[0m'
NEON_COLORS=($RED $GREEN $YELLOW $BLUE $PURPLE $CYAN)

# ===============================
# FUN BAR WAVE + EMOTIKON PERSISTENT
# ===============================
fun_bar() {
    CMD="$1"
    bar_length=20
    sp=('⏳' '⚡' '💻' '🔥' '🔄' '✔️')

    (
        $CMD >/dev/null 2>&1
        touch $HOME/fim
    ) &

    tput civis
    wave_pos=0
    while [[ ! -e $HOME/fim ]]; do
        bar=""
        for ((i=0;i<bar_length;i++)); do
            color=${NEON_COLORS[$RANDOM % ${#NEON_COLORS[@]}]}
            [[ $i -eq $wave_pos ]] && bar+="${color}#${NC}" || bar+="${color}-${NC}"
        done
        spinner=${sp[$RANDOM % ${#sp[@]}]}
        echo -ne "\r  \033[1;37mSystem Running \033[1;37m[${bar}] ${spinner}"
        wave_pos=$(( (wave_pos + 1) % bar_length ))
        sleep 0.08
    done

    final_bar=""
    for ((i=0;i<bar_length;i++)); do
        color=${NEON_COLORS[$RANDOM % ${#NEON_COLORS[@]}]}
        final_bar+="${color}#${NC}"
    done
    echo -e "\r  \033[1;37mSystem Running [${final_bar}] ✔️ ${GREEN}DONE!${NC}"
    tput cnorm
    [[ -e $HOME/fim ]] && rm $HOME/fim
}

# ===============================
# Contoh Fungsi Update Task
# ===============================
update_task() {
    # Simulasi proses update
    sleep 5
    res1
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
# MAIN MENU
# ===============================
main_menu() {
    clear
    echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    # Neon rainbow header animasi
    for ((i=0;i<50;i++)); do
        color=${NEON_COLORS[$RANDOM % ${#NEON_COLORS[@]}]}
        echo -ne "${color}━${NC}"
        sleep 0.005
    done
    echo -e ""
    echo -e " \e[1;97;101m        METS STORE - ULTRA MENU        \e[0m"
    for ((i=0;i<50;i++)); do
        color=${NEON_COLORS[$RANDOM % ${#NEON_COLORS[@]}]}
        echo -ne "${color}━${NC}"
        sleep 0.005
    done
    echo -e "\n"

    # Menu Items neon
    echo -e "${CYAN} 1${NC}) Update Script ⚡"
    echo -e "${GREEN} 2${NC}) Menu Tools 💻"
    echo -e "${YELLOW} 3${NC}) Settings 🔄"
    echo -e "${RED} 4${NC}) Exit ✔️"
    echo -e ""

    read -p "Select menu: " option
    case $option in
        1) echo -e "\n  \033[1;91mUpdating script service...\033[1;37m"; fun_bar "update_task"; main_menu ;;
        2) echo -e "\n  \033[1;92mOpening Tools Menu...\033[1;37m"; sleep 1; main_menu ;;
        3) echo -e "\n  \033[1;93mOpening Settings...\033[1;37m"; sleep 1; main_menu ;;
        4) echo -e "\n  \033[1;91mExiting...✔️\033[0m"; exit ;;
        *) echo -e "\n  ${RED}Invalid option${NC}"; sleep 1; main_menu ;;
    esac
}

# Jalankan Main Menu
main_menu
