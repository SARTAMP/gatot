#!/bin/bash
clear
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
MYIP=$(wget -qO- ipinfo.io/ip)
REPO='https://package.makhlukvpn.my.id/'
idc='https://update.makhlukvpn.my.id/'
start=$(date +%s)
secs_to_human() {
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}
function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
sleep 2
}
function print_install() {
echo -e "${Green} ┌──────────────────────────────────────────┐ ${FONT}"
echo -e "${YELLOW} # Memasang $1 "
echo -e "${Green} └──────────────────────────────────────────┘ ${FONT}"
sleep 2
clear
}
function print_success() {
echo -e "${Green} ┌──────────────────────────────────────────┐ ${FONT}"
echo -e "${YELLOW} # $1 berhasil dipasang"
echo -e "${Green} └──────────────────────────────────────────┘ ${FONT}"
sleep 2
clear
}
function print_error() {
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}
function is_root() {
if [[ 0 == "$UID" ]]; then
print_ok "Root user Start installation process"
else
print_error "The current user is not the root user, please switch to the root user and run the script again"
fi
}
MakhlukVpn() {
sudo apt install curl -y
sudo apt install wget -y
sudo apt install vnstat -y
MYIP=$(wget -qO- ipinfo.io/ip);
IZIN=$(curl -sS https://raw.githubusercontent.com/SARTAMP/gatot/main/Name | grep $MYIP | awk '{print $1}')
valid=$(curl -sS https://raw.githubusercontent.com/SARTAMP/gatot/main/Name | grep $MYIP | awk '{print $4}')
Name=$(curl -sS https://raw.githubusercontent.com/SARTAMP/gatot/main/Name | grep $MYIP | awk '{print $3}')
Versi=$(curl -sS https://raw.githubusercontent.com/SARTAMP/gatot/main/Name | grep $MYIP | awk '{print $5}')
echo "Loading..."
sleep 2
if [ $MYIP = $IZIN ]; then
echo -e "[ ${green}INFO${NC} ] Permission Accepted..."
else
echo "                                                              "
echo -e "$Lyellow                ⚡ PREMIUM SPEED SCRIPT ⚡"$NC
echo -e "$green┌──────────────────────────────────────────┐ "$NC
echo -e "$Lyellow                  Autoscript By Makhlukvpn"$NC
echo -e "$Lyellow                    CONTACT TELEGRAM"$NC
echo -e "$Lyellow               https://t.me/Makhlukvpn"$NC
echo -e "$green└──────────────────────────────────────────┘"$NC
exit 0
fi
echo "INSTALLING SCRIPT..."
cat >/root/.user.ini <<-END
vps  Author  Exp  Versi IpVps
ScriptAutoInstaller MakhlukTunnel
END
}
function first_setup(){
timedatectl set-timezone Asia/Jakarta
wget -O /usr/sbin/mtsc.list "${idc}last/mtsc.list" >/dev/null 2>&1
wget -O /etc/ssh/sshd_config ${REPO}config/sshd_config >/dev/null 2>&1
chmod 644 /etc/ssh/sshd_config
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
}
function base_package() {
sudo apt autoremove git man-db apache2 ufw exim4 firewalld snapd* -y;
clear
print_install "Memasang paket yang dibutuhkan"
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1  >/dev/null 2>&1
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt update -y
apt-get install --no-install-recommends software-properties-common
add-apt-repository ppa:vbernat/haproxy-2.0 -y
apt-get -y install haproxy=2.0.\*
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
curl https://haproxy.debian.net/bernat.debian.org.gpg |
gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
http://haproxy.debian.net buster-backports-1.8 main \
>/etc/apt/sources.list.d/haproxy.list
sudo apt-get update
apt-get -y install haproxy=1.8.\*
else
echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
exit 1
fi
sudo apt install software-properties-common -y
sudo apt install at -y
sudo apt install python -y
sudo apt install squid -y
sudo apt install nginx -y
sudo apt install openvpn -y
sudo apt install fail2ban -y
sudo apt install iptables -y
sudo apt install iptables-persistent -y
sudo apt install netfilter-persistent -y
sudo apt install chrony -y
sudo apt install cron -y
sudo apt install resolvconf -y
sudo apt install pwgen openssl netcat bash-completion ntpdate -y
sudo apt install xz-utils apt-transport-https dnsutils socat -y
sudo apt install git tar lsof ruby zip unzip p7zip-full python3-pip libc6  gnupg gnupg2 gnupg1 -y
sudo apt install net-tools bc jq easy-rsa python3-certbot-nginx p7zip-full tuned -y
sudo apt install libopentracing-c-wrapper0 libopentracing1 linux-tools-common util-linux -y
apt-get install lolcat -y
gem install lolcat
dpkg --configure -a
apt --fix-broken install
apt-get install --fix-missing
print_ok "Berhasil memasang paket yang dibutuhkan"
}
function dir_xray() {
echo -e "Membuat direktori xray"
mkdir -p /etc/{shell,xray,slowdns,websocket,vmess,vless,trojan,shadowsocks}
mkdir -p /tmp/{menu,core}
mkdir -p /root/.config/{psiphon,udp,rclone}
mkdir -p /var/log/xray
mkdir -p /var/www/html
touch /var/log/xray/{access.log,error.log}
chmod +x /var/log/xray
chmod 777 /var/log/xray/*.log
touch /root/install.log
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/ssh/.ssh.db
touch /etc/shadowsocks/.shadowsocks.db
clear
}
function add_domain() {
echo -e "${red}┌──────────────────────────────────────────┐\033[0m${NC}"
echo "          𝐌𝐚𝐤𝐡𝐥𝐮𝐤𝐓𝐮𝐧𝐧𝐞𝐥 "
echo -e "${red}└──────────────────────────────────────────┘\033[0m${NC}"
echo -e "${red}    ♦️${NC} ${green} CUSTOM SETUP DOMAIN VPS     ${NC}"
echo -e "${red}┌──────────────────────────────────────────┐\033[0m${NC}"
echo "1. Gunakan Domain Dari Script"
echo "2. Gunakan Domain Sendiri"
echo -e "${red}└──────────────────────────────────────────┘\033[0m${NC}"
read -rp "Choose Your Domain Installation : " dom
if test $dom -eq 1; then
clear
curl "${idc}tools/DOMAIN" | bash | tee /root/install.log
print_success "Domain Script"
elif test $dom -eq 2; then
read -rp "Enter Your Domain : " domen
echo $domen > /etc/xray/domain
else
echo "Not Found Argument"
exit 1
fi
print_success "Domain Sendiri"
clear
}
function pasang_ssl() {
print_install "SSL Certificate"
domain=$(cat /etc/xray/domain)
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
rm -rf /root/.acme.sh
mkdir /root/.acme.sh
systemctl stop $STOPWEBSERVER
systemctl stop nginx
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/haproxy.pem
chmod +x /etc/haproxy/haproxy.pem
chmod +x /etc/xray/xray.key
chmod +x /etc/xray/xray.crt
print_success "SSL Certificate"
}
function install_xray(){
print_install "Websocket"
wget -O /usr/sbin/drws.py "${REPO}core/python/drws.py" >/dev/null 2>&1
wget -O /usr/sbin/opws.py "${REPO}core/python/opws.py" >/dev/null 2>&1
wget -O /usr/sbin/ovws.py "${REPO}core/python/ovws.py" >/dev/null 2>&1
wget -O /usr/sbin/stws.py "${REPO}core/python/stws.py" >/dev/null 2>&1
wget -O /etc/systemd/system/ws@.service "${REPO}service/ws@.service" >/dev/null 2>&1
chmod +x /usr/sbin/*.py
chmod 644 /etc/systemd/system/ws@.service
print_success "Websocket"
print_install "Xray Core Latest"
echo tidak ada data apapun >/etc/xray/link
curl -s ipinfo.io/city >> /etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /etc/xray/isp
xray_latest="$(curl -s https://api.github.com/repos/dharak36/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
xraycore_link="https://github.com/dharak36/Xray-core/releases/download/v$xray_latest/xray.linux.64bit"
curl -sL "$xraycore_link" -o xray
mv xray /usr/sbin/xray
chmod +x /usr/sbin/xray
wget -O /etc/xray/config.json "${REPO}nginx/xray/config.json" >/dev/null 2>&1
curl "${idc}tools/IPSERVER" | bash | tee /root/install.log
rm -rf /etc/systemd/system/xray.service.d
rm -rf /etc/systemd/system/xray@.service.d
rm -rf /etc/systemd/system/xray@.service
wget -O /etc/systemd/system/xray.service "${REPO}service/xray.service" >/dev/null 2>&1
wget -O /etc/systemd/system/iptables.service "${REPO}service/iptables.service" >/dev/null 2>&1
print_success "Xray Config"
}
function install_ovpn(){
print_install "OpenVPN"
wget -O /root/.config/rclone/OPENVPN "${idc}tools/OPENVPN" >/dev/null 2>&1
bash /root/.config/rclone/OPENVPN | tee /root/install.log
wget -O /etc/pam.d/common-password "${REPO}config/common-password" >/dev/null 2>&1
chmod +x /etc/pam.d/common-password
print_success "OpenVPN"
}
function install_slowdns(){
print_install "SlowDNS"
curl "${idc}tools/NSDOMAIN" | bash | tee /root/install.log
cd
NS=$(cat /etc/xray/dns)
wget -O /etc/slowdns/dnstt-server "${REPO}core/dnstt-server" >/dev/null 2>&1
chmod +x /etc/slowdns/dnstt-server >/dev/null 2>&1
/etc/slowdns/dnstt-server -gen-key -privkey-file /etc/slowdns/server.key -pubkey-file /etc/slowdns/server.pub
chmod +x /etc/slowdns/*
wget -O /etc/systemd/system/server.service "${REPO}service/server.service" >/dev/null 2>&1
sed -i "s/xxxx/$NS/g" /etc/systemd/system/server.service
sleep 2
print_success "SlowDNS"
}
function install_custom() {
print_install "BadVPN"
wget -O /usr/sbin/badvpn "${REPO}core/badvpn" >/dev/null 2>&1
wget -q -O /etc/systemd/system/badvpn1.service "${REPO}service/badvpn1.service" >/dev/null 2>&1
wget -q -O /etc/systemd/system/badvpn2.service "${REPO}service/badvpn2.service" >/dev/null 2>&1
wget -q -O /etc/systemd/system/badvpn3.service "${REPO}service/badvpn3.service" >/dev/null 2>&1
chmod +x /usr/sbin/badvpn > /dev/null 2>&1
print_success "BadVPN"
print_install "Udp-Custom"
curl "${idc}tools/UDP-CUSTOM" | bash | tee /root/install.log
print_success "Udp-Custom"
}
function install_rclone() {
print_install "Rclone"
apt install rclone
wget -O /root/.config/rclone/rclone.conf "$(REPO)config/rclone.conf" >/dev/null 2>&1
printf "q\n" | rclone config
print_success "Rclone"
}
function download_config(){
print_install "Tools"
wget -O /etc/haproxy/haproxy.cfg "${REPO}nginx/haproxy/hap.conf" >/dev/null 2>&1
wget -O /etc/nginx/conf.d/drop.conf "${REPO}nginx/haproxy/load.conf" >/dev/null 2>&1
wget -O /etc/nginx/nginx.conf "${REPO}config/nginx.conf" >/dev/null 2>&1
wget -q -O /etc/squid/squid.conf "${REPO}config/squid.conf" >/dev/null 2>&1
mkdir -p /var/log/squid/cache/
chmod 777 /var/log/squid/cache/
echo "* - nofile 65535" >> /etc/security/limits.conf
mkdir -p /etc/sysconfig/
echo "ulimit -n 65535" >> /etc/sysconfig/squid
apt install dropbear -y
wget -q -O /etc/default/dropbear "${REPO}config/dropbear" >/dev/null 2>&1
chmod 644 /etc/default/dropbear
sudo apt install wondershaper
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
git pull
sudo make install
cd
rm -rf wondershaper
echo > /home/limit
wget -O /tmp/menu/menu.zip "${idc}last/hapwspy.zip" >/dev/null 2>&1
cd /tmp/menu && 7z e -password-out menu.zip >/dev/null 2>&1
rm menu.zip && chmod +x * && cd
mv /tmp/menu/* /usr/sbin/
wget -O /var/www/html/web.zip "${idc}last/web.zip" >/dev/null 2>&1
cd /var/www/html/ && unzip web.zip >/dev/null 2>&1
cd && rm /var/www/html/web.zip
wget -O /root/.config/psiphon/psiphon "https://github.com/Psiphon-Labs/psiphon-tunnel-core-binaries/raw/master/psiphond/psiphond" >/dev/null 2>&1
cd /root/.config/psiphon && chmod +x psiphon
./psiphon --ipaddress ${MYIP} --web 3000 --protocol SSH:3001 --protocol OSSH:3002 --protocol FRONTED-MEEK-OSSH:8443 generate
wget -O /etc/systemd/system/psiphon.service "${REPO}service/psiphon.service" >/dev/null 2>&1
mv psiphon /usr/sbin && cd
cp /root/.config/psiphon/*.dat /var/www/html/psiphon.txt
cat >/root/.profile <<EOF
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
statx
EOF
chmod 644 /root/.profile
cat >/etc/cron.d/xp_all << EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
59 23 * * * root /usr/sbin/xp
EOF
cat >/etc/cron.d/clear_log << EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/5 * * * * root /usr/sbin/clearlog
EOF
cat >/etc/cron.d/lim_all << EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/15 * * * * root /usr/sbin/lim.x vmess
*/15 * * * * root /usr/sbin/lim.x vless
*/15 * * * * root /usr/sbin/lim.x trojan
*/15 * * * * root /usr/sbin/lim.x ss
*/15 * * * * root /usr/sbin/lim.x ssh
EOF
cat >/etc/cron.d/daily_reboot << EOF
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 0 * * * root /sbin/reboot
EOF
service cron restart
wget -O /etc/rc.local "${REPO}config/rc.local" >/dev/null 2>&1
chmod +x /etc/rc.local
wget -O /etc/systemd/system/rc-local.service "${REPO}service/rc-local.service" >/dev/null 2>&1
echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells
print_success "Tools"
}
function tambahan(){
print_install "SpeedTest"
wget -O /usr/sbin/speedtest "${REPO}core/speedtest" >/dev/null 2>&1
chmod +x /usr/sbin/speedtest
print_success "SpeedTest"
print_install "Gotop"
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1
print_success "Gotop COre"
curl "${idc}tools/BBR" | bash | tee /root/install.log
print_success "BBR Plus"
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
print_success "Swap + 1GB"
chronyc sourcestats -v
chronyc tracking -v
tuned-adm profile network-latency
print_ok "Selesai pemasangan modul tambahan"
}
function enable_services(){
print_install "All Service"
systemctl daemon-reload
systemctl enable --now netfilter-persistent
systemctl start netfilter-persistent
systemctl enable --now badvpn1
systemctl enable --now badvpn2
systemctl enable --now badvpn3
systemctl enable --now nginx
systemctl enable --now chronyd
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now haproxy
systemctl enable --now iptables.service
systemctl enable --now squid
systemctl enable --now ws@drws
systemctl enable --now ws@opws
systemctl enable --now ws@ovws
systemctl enable --now ws@stws
systemctl enable --now server
systemctl enable --now custom
systemctl enable --now psiphon
systemctl enable --now fail2ban
cp /lib/systemd/system/haproxy.service /etc/systemd/system/
cp /lib/systemd/system/nginx.service /etc/systemd/system/
sleep 1
systemctl enable --now haproxy.service
systemctl enable --now nginx.service
wget -O /etc/issue.net "${REPO}/issue.net" >/dev/null 2>&1
print_success "All Service"
}
function finish(){
TIMES="10"
NAMES=$(curl -sS https://raw.githubusercontent.com/Annnjayy/Multi/Auth/name | grep $MYIP | awk '{print $3}')
EXPSC=$(curl -sS https://raw.githubusercontent.com/Annnjayy/Multi/Auth/name | grep $MYIP | awk '{print $4}')
CHATID="1906388998"
LOCAL_DATE="/usr/bin/"
MYIP=$(wget -qO- ipinfo.io/ip)
ISP=$(wget -qO- ipinfo.io/org)
CITY=$(curl -s ipinfo.io/city)
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
OSL=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
KEY="6023255035:AAHADCHIcBc0Xzu-isQggu1x7v9ddSQOqm0"
URL="https://api.telegram.org/bot$KEY/sendMessage"
domain=$(cat /etc/xray/domain)
TEXT="
<code>────────────────────</code>
<b>⚠️AUTOSCRIPT PREMIUM⚠️</b>
<code>────────────────────</code>
<code>Owner   : </code><code>$NAMES</code>
<code>Ip vps  : </code><code>$MYIP</code>
<code>Domain  : </code><code>$domain</code>
<code>Date    : </code><code>$TIME</code>
<code>Ram     : </code><code>$RAMMS MB</code>
<code>System  : </code><code>$OSL</code>
<code>Country : </code><code>$CITY</code>
<code>Isp     : </code><code>$ISP</code>
<code>Exp Sc  : </code><code>$EXPSC</code>
<code>────────────────────</code>
<i>Automatic Notification from</i>
<i>@MakhlukVpnTunnel</i>
<code>────────────────────</code>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
mv /etc/openvpn/OvenVPN.zip /var/www/html/
sed -i "s/xxx/${domain}/g" /var/www/html/index.html
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/drop.conf
sed -i "s/xxxx/${MYIP}/g" /etc/squid/squid.conf
sed -i "s/xxx/${domain}/g" /etc/squid/squid.conf
echo MakhlukVpnTunnel >/root/.config/respond
echo switch off >/root/.config/.backup
mkdir -p /run/xray
chown www-data.www-data /var/log/xray
chown www-data.www-data /run/xray
apt install python3 python3-pip git
wget -O /root/.config/panel.zip "${idc}last/panel.zip" >/dev/null 2>&1
cd /root/.config && unzip panel.zip >/dev/null 2>&1
rm panel.zip && mv xolpanel/shell.zip /etc/shell
cd /etc/shell && 7z e -password-out shell.zip >/dev/null 2>&1
chmod 755 * && rm shell.zip && cd
wget -O /etc/systemd/system/xolpanel.service "${REPO}service/xolpanel.service" >/dev/null 2>&1
alias bash2="bash --init-file <(echo '. ~/.bashrc; unset HISTFILE')"
apt-get clean all
sudo apt-get autoremove -y
rm ~/.bash_history
clear
wget -O /etc/info ${REPO}info >/dev/null 2>&1
echo "`cat /etc/info`"
secs_to_human "$(($(date +%s) - ${start}))"
echo -e "         ${YELLOW} Processing Reboot Your Vps${FONT} 10 second .... "
sleep 10
rm /root/setup-main-ub >/dev/null 2>&1
rm /tmp/*.sh >/dev/null 2>&1
rm /tmp/*.zip >/dev/null 2>&1
rm /root/*.sh >/dev/null 2>&1
rm /root/*.zip >/dev/null 2>&1
reboot
}
function install_all() {
dir_xray
add_domain
pasang_ssl
install_xray
install_ovpn
install_slowdns
install_custom
install_rclone
download_config
tambahan
enable_services
finish
}
MakhlukVpn
first_setup
base_package
install_all
