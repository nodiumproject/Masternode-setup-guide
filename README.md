# Masternode-setup-guide
Latest masternode setup guide

INITIAL SETUP:

Wallet:

1. Download wallet for your desktop, apple, linux or windows available in our wallets repository
2. Launch wallet, allow to sync
3. Click on 'debug console' found in 'tools' - Type 'masternode genkey' - exit console
4. Go to 'receiving wallets' found in files - create masternode wallet, by creating a new wallet, called 'masternode1'
5. Send EXACTLY 10,000 coins to 'masternode1' wallet
6. Go back to 'debug console' - Type 'masternode outputs' 
7.  Go to 'open masternode configuration file' - found on 'tools' in menu
 a. You will see an example such as this:
 
  Masternode config file
 Format: alias IP:port masternodeprivkey collateral_output_txid collateral_output_index
 Example: mn1 127.0.0.2:6250 93HaYBVUCYjEMeeH1Y4sBALQZE1Yc1K64xiqgX  2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0

b. Add your own real working node details under it.
1 - Put the masternode wallet name, i.e - masternode1
2 - Put the server IP address (your vultr ip) followed by the port :6250
3 - Put the masternodes output exactly.

Example below

Masternode1 124.842.07.0:6250 119cCx5YeA519YkTzun4EptdexAo3RvQXaPdkP 838328ce57cc8b168d932d138001781b77b22470c05cf2235a3284093cb0019db 0

c. Once complete, save file

FINAL STAGE:

(Get ready for SSH, as seen in steps below you will use it)

8. Copy this, and save as a file to use later on desktop. 

a. externlip and bind = your vultr ip address
b. masternodeaddr = your vultr ip address + port
c. masternodeprivkey = masternode gen key

(keep all safe)

listen=1
server=1
daemon=1
logtimestamps=1
maxconnections=256
masternode=1
externalip=207.148.3.88
bind=207.148.3.88
masternodeaddr=207.148.3.88:6250
masternodeprivkey=-13bkESxBStGfzHAGAAke61kX0E5tLUeNgTTHWhpmJ5EBai4XZFa

Above is a non functioning dummy, replace with your own 

Wallet side - complete 

Now begin SSH setup

*****


First steps:
VPS server required: Recommend the following:
- www.vultr.com - $5 Basic cloud computer package - Choose any country - ubuntu 16.04.x64 - Server (Name anything you want, i.e matrix)

Second steps:

Depending upon which you're using. Download the following:
Windows - PUTTY
Mac - Terminal (on mac already)

1. Load SSH terminal
2. Copy your IP from VPS - And for windows Putty simply enter in and press enter. (Mac use the key: *** do this.....
3. It will login to server. Follow the comands below, typing one by one, each line, followed by pressing enter
4. root
5. (vultr password)

STAGE 1:

1. fallocate -l 3G /swapfile
2. chmod 600 /swapfile
3. mkswap /swapfile
4. swapon /swapfile
5. echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab

STAGE 2:

1. git clone https://github.com/nodiumproject/Nodium nodium

STAGE 3:

1. cd nodium
2. sudo apt-get install -y pkg-config
3. sudo apt-get -y install build-essential autoconf automake libtool libboost-all-dev libgmp-dev libssl-dev libcurl4-openssl-dev git
4. sudo add-apt-repository ppa:bitcoin/bitcoin
(press enter, follow through)
5. sudo apt-get update
6. sudo apt-get install libdb4.8-dev libdb4.8++-dev
(say yes on continue)

STAGE 4:

1. sudo chmod +x share/genbuild.sh
2. sudo chmod +x autogen.sh
3. sudo chmod 755 src/leveldb/build_detect_platform
4. sudo ./autogen.sh
5. sudo ./configure
6. sudo make 
(LEAVE TO INSTALL)

STAGE 5:

1. ./Nodiumd -daemon
(save the rpc username and password)
2. sudo nano ~/.Nodium/Nodium.conf
(this opens nano pad)
3. Paste the rpc username and password in)
4. Paste the completed config details from wallet setup stage above

example: 

rpc user=user1
rpc pass=fdf43324234
listen=1
server=1
daemon=1
logtimestamps=1
maxconnections=256
masternode=1
externalip=144.202.23.23
bind=144.202.23.23
masternodeaddr=144.202.23.23:6250
masternodeprivkey=jij9000909hjgffh

5. Exit the nano pad. By pressing control x, then save as same file now and exit.

STAGE 6:

1. ./Nodiumd -daemon
(STARTS SERVER)
2. ./Nodium-cli getinfo
(CHECKS SERVER STATUS)

****
RE-OPEN YOUR WALLET, ALLOW TO SYNC THEN START THE MASTERNODE BY CLICKING 'START ALIAS'

FOLLOW STEPS CORRECTLY, AND YOUR NODIUM MASTERNODE WILL BEGIN RUNNING.

ALLOW TIME FOR MASTERNODE TO SYNC AND TIMER WILL BEGIN TO SHOW LATER ON.

***

SUCCESS! - Begin earning for supporting the $XN network!
