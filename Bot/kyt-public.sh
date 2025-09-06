#!/bin/bash

NS=$(cat /etc/xray/dns)
PUB=$(cat /etc/slowdns/server.pub)
domain=$(cat /etc/xray/domain)

# ---------- Deteksi Sistem Operasi ----------
OS=$(grep -E '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
VERSION=$(grep -E '^VERSION_ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')

# Hapus file sementara dpkg
rm -rf /var/lib/dpkg/stato* >/dev/null 2>&1
rm -rf /var/lib/dpkg/lock* >/dev/null 2>&1

# ---------- Fungsi Instalasi Tanpa Virtual Environment ----------
install_without_env() {
    echo "Sistem tidak mendukung virtual environment. Melanjutkan instalasi tanpa venv."
    cd /etc/systemd/system/
    rm -rf kyt-public.service
    cd /usr/bin
    rm -rf kyt-public bot-public *.session >/dev/null 2>&1
    apt update -y && apt upgrade -y
    apt install neofetch -y
    apt install -y python3 python3-pip git unzip
    wget https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Bot/bot-public.zip
    unzip bot-public.zip
    mv bot-public/* /usr/bin
    chmod +x /usr/bin/*
    rm -rf bot-public.zip
    wget https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Bot/kyt-public.zip
    unzip kyt-public.zip
    pip3 install -r kyt-public/requirements.txt
}

# ---------- Fungsi Instalasi Dengan Virtual Environment ----------
install_with_env() {
    echo "Sistem mendukung virtual environment. Melanjutkan instalasi dengan venv."
    apt update -y && apt upgrade -y
    apt install neofetch -y
    apt install -y python3 python3-pip git unzip python3-full -y
    cd /etc/systemd/system/
    rm -rf kyt-public.service
    cd /usr/bin
    rm -rf kyt-public bot-public *.session >/dev/null 2>&1
    python3 -m venv kyt-public_env
    source kyt-public_env/bin/activate
    wget https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Bot/bot-public.zip
    unzip bot-public.zip
    mv bot-public/* /usr/bin
    chmod +x /usr/bin/*
    rm -rf bot-public.zip
    wget https://raw.githubusercontent.com/NEW-KJSVIP/Kjs-projeck/main/Bot/kyt-public.zip
    unzip kyt-public.zip
    pip install --upgrade pip
    pip install -r kyt-public/requirements.txt
    deactivate
}

# ---------- Logika Pemilihan Instalasi ----------
if [[ "$OS" == "debian" && "$VERSION" == "12" ]] || ([[ "$OS" == "ubuntu" ]] && [[ "$VERSION" =~ ^24\. ]]); then
    ENV_PATH="/usr/bin/kyt-public_env/bin/python3"
    install_with_env
else
    ENV_PATH="/usr/bin/python3"
    install_without_env
fi

# ---------- Variabel Warna ----------
grenbo="\e[92;1m"
NC='\e[0m'

# ---------- Tampilan Banner ----------
clear
figlet SCRIPTUN VIP | lolcat
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PUBLIK PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${grenbo}Tutorial Create Bot Public & ID Telegram${NC}"
echo -e "${grenbo}[*] Create Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info ID Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

# ---------- Input Token Bot Publik ----------
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your ID Telegram : " admin

# ---------- Simpan Konfigurasi ----------
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt-public/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt-public/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt-public/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt-public/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt-public/var.txt
echo -e "#bot-public# $bottoken $admin" >/etc/bot/.bot-public.db

# ---------- Buat Service Systemd ----------
cat > /etc/systemd/system/kyt-public.service << END
[Unit]
Description=Simple kyt-public - @kyt-public
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=$ENV_PATH -m kyt-public
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start kyt-public
systemctl enable kyt-public
systemctl restart kyt-public

# ---------- Hapus File Instalasi ----------
cd /root
rm -rf kyt-public.sh

# ---------- Selesai ----------
clear
echo "Done"
echo "Your Bot Public Data"
echo -e "==============================="
echo "Token Bot     : $bottoken"
echo "Admin         : $admin"
echo "Domain        : $domain"
echo -e "==============================="
echo "Installations complete, type /menu on your bot"
