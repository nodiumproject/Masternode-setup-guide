
#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

PROJECT="Nodium"
PROJECT_FOLDER="/root/nodium"
DAEMON_BINARY="nodiumd"
DAEMON_BINARY_PATH="/root/nodium/src/nodiumd"
DAEMON_START="/root/nodium/src/nodiumd -daemon"
CLI_BINARY="/root/nodium/src/nodium-cli"
CONF_FILE="/root/.Nodium/nodium.conf"
TMP_FOLDER=$(mktemp -d)
RPC_USER="nodium-Admin"
MN_PORT=6250
RPC_PORT=19647
CRONTAB_LINE="@reboot sleep 60 && /root/nodium/src/nodiumd -daemon"
BINARIES="https://github.com/nodiumproject/Wallets/raw/master/Linux-16.04x64%20zerocoin.zip"

function checks() 
{
  if [[ $(lsb_release -d) != *16.04* ]]; then
    echo -e "${RED}You are not running Ubuntu 16.04. Installation is cancelled.${NC}"
    exit 1
  fi

  if [[ $EUID -ne 0 ]]; then
     echo -e "${RED}$0 must be run as root.${NC}"
     exit 1
  fi

  if [ -n "$(pidof $DAEMON_BINARY)" ]; then
    echo -e "The $PROJECT_NAME daemon is already running. $PROJECT_NAME does not support multiple masternodes on one host."
    NEW_NODE="n"
    exit 1
  else
    NEW_NODE="new"
  fi
}

function pre_install()
{
  echo -e "${BLUE}Installing dns utils...${NC}"
  sudo apt-get install -y dnsutils
  echo -e "${BLUE}Installing pwgen...${NC}"
  sudo apt-get install -y pwgen
  PASSWORD=$(pwgen -s 64 1)
  WANIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
}

function show_header()
{
  clear
  echo -e "${RED}■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■${NC}"
  echo -e "${YELLOW}$PROJECT Masternode Installer v3.0.6 - chris 2018 | On server VPS IP: $WANIP${NC}"
  echo -e "${RED}■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■${NC}"
  echo
  echo -e "${BLUE}This script will automate the installation of your ${YELLOW}$PROJECT ${BLUE}masternode along with the server configuration."
  echo -e "It will:"
  echo
  echo -e " ${YELLOW}■${NC} Create a swap file"
  echo -e " ${YELLOW}■${NC} Prepare your system with the required dependencies"
  echo -e " ${YELLOW}■${NC} Obtain the latest $PROJECT masternode files from the official $PROJECT repository"
  #echo -e " ${YELLOW}■${NC} Create a user and password to run the $PROJECT masternode service and install it"
  echo -e " ${YELLOW}■${NC} Add Brute-Force protection using fail2ban"
  echo -e " ${YELLOW}■${NC} Update the system firewall to only allow SSH, the masternode ports and outgoing connections"
  echo -e " ${YELLOW}■${NC} Add a schedule entry for the service to restart automatically on power cycles/reboots."
  echo
  read -e -p "$(echo -e ${YELLOW}Continue with installation? [Y/N] ${NC})" CHOICE

if [[ ("$CHOICE" == "n" || "$CHOICE" == "N") ]]; then
  exit 1;
fi
}

function get_masternode_key()
{
  echo -e "${YELLOW}Enter your masternode key for your conf file ${BLUE}(you created this in windows)${YELLOW}, then press ${GREEN}[ENTER]${NC}: " 
  echo -e "${RED}Make ${YELLOW}SURE ${RED}you copy from your ${BLUE}masternode genkey ${RED}in your windows/Mac wallet and then paste the key below."
  echo -e "Typing the key out incorrectly is 99% of all installation issues. ${NC}"
  echo
  read -p 'Masternode Private Key: ' GENKEY
  echo
}

function create_swap()
{
  fallocate -l 3G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo
  echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab
}

function install_prerequisites()
{
  echo
  echo -e "${BLUE}Installing Pre-requisites${NC}"
  sudo apt-get install -y pkg-config
  sudo add-apt-repository ppa:bitcoin/bitcoin -y
  sudo apt-get update
  sudo apt-get install -y git unzip build-essential pkg-config libevent-dev libtool libboost-all-dev libgmp-dev libssl-dev libcurl4-openssl-dev git
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y libdb4.8-dev libdb4.8++-dev libminiupnpc-dev
  sudo apt-get install -y autoconf automake
}

function build_project()
{
  mkdir $PROJECT_FOLDER
  mkdir $PROJECT_FOLDER/src
  cd $PROJECT_FOLDER/src
  wget $BINARIES
  unzip Lin*.zip
  rm *.zip
  chmod +x *
  
  if [ -f $DAEMON_BINARY_PATH ]; then
    echo -e "${BLUE}$PROJECT_NAME Daemon and CLI installed, proceeding to next step...${NC}"
    echo
  else
    RETVAL=$?
    echo -e "${RED}installation has failed. Please see error above : $RETVAL ${NC}"
    exit 1
  fi
}

function create_conf_file()
{
  echo
  echo -e "${BLUE}Starting daemon to create conf file${NC}"
  echo -e "${YELLOW}Ignore any errors you see below. This will take 30 seconds.${NC}"
  $DAEMON_START
  sleep 30
  $CLI_BINARY getmininginfo
  $CLI_BINARY stop
  echo
  echo -e "${BLUE}Stopping the daemon and writing config${NC}"

cat <<EOF > $CONF_FILE
rpcuser=$RPC_USER
rpcpassword=$PASSWORD
listen=1
server=1
daemon=1
logtimestamps=1
maxconnections=256
masternode=1
externalip=$WANIP
bind=$WANIP
masternodeaddr=$WANIP:$MN_PORT
masternodeprivkey=$GENKEY
EOF
}

function configure_firewall()
{
  echo
  echo -e "${BLUE}setting up firewall...${NC}"
  sudo apt-get install -y ufw
  sudo apt-get update -y
  
  #configure ufw firewall
  sudo ufw default allow outgoing
  sudo ufw default deny incoming
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw allow $MN_PORT/tcp
  sudo ufw logging on
}

function add_cron()
{
(crontab -l; echo "$CRONTAB_LINE") | crontab -
}

function start_wallet()
{
  echo
  echo -e "${BLUE}Re-Starting the wallet...${NC}"
  if [ -f $DAEMON_BINARY_PATH ]; then
    $DAEMON_START
    echo
    echo -e "${BLUE}Now wait for a full synchro (can take 10-15 minutes)${NC}"
    echo -e "${BLUE}Once Synchronized, go back to your Windows/Mac wallet,${NC}"
    echo -e "${BLUE}go to your Masternodes tab, click on your masternode and press on ${YELLOW}Start Alias${NC}"
    echo -e "${BLUE}Congratulations, you've set up your masternode!${NC}"
  else
    RETVAL=$?
    echo -e "${RED}Binary not found! Please scroll up to see errors above : $RETVAL ${NC}"
    exit 1
  fi
}

function deploy()
{
  checks
  pre_install
  show_header
  get_masternode_key
  create_swap
  install_prerequisites
  build_project
  create_conf_file
  configure_firewall
  add_cron
  start_wallet
}

deploy
