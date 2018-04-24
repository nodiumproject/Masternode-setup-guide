# Masternode-setup-guide

Latest masternode setup guide.

## Initial Setup

On your wallet:

1. Download wallet for your Apple, linux or Windows available in our wallets repository
2. Launch wallet, allow to sync
3. Click on `debug console` found in `tools` - Type `masternode genkey` - exit console
4. Go to `receiving wallets` found in files - create masternode wallet, by creating a new wallet, called `masternode1`
5. Send EXACTLY 10,000 coins to `masternode1` wallet
6. Go back to `debug console` - Type `masternode outputs`
7. Go to 'open masternode configuration file' - found on 'tools' in menu
 a. You will see an example such as this:

## Masternode config file

In your wallet, go to `Tools` > `Open masternode configuration file`.

The format is like this:

```
alias IP:port masternodeprivkey collateral_output_txid collateral_output_index
```

Example:

```
mn1 127.0.0.2:6250 93HaYBVUCYjEMeeH1Y4sBALQZE1Yc1K64xiqgX  2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0
```


Add your own real working node details under it.

1. Put the masternode wallet name, i.e - `masternode1`
2. Put the server IP address (your vultr ip) followed by the port :6250
3. Put the masternodes output exactly.
4
Example below

```
Masternode1 124.842.07.0:6250 119cCx5YeA519YkTzun4EptdexAo3RvQXaPdkP 838328ce57cc8b168d932d138001781b77b22470c05cf2235a3284093cb0019db 0
```

Once complete, save file

## Final stage

(Get ready for SSH, as seen in steps below you will use it)

Copy this, and save as a file to use later on desktop.

1. externalip and bind = your vultr ip address
2. masternodeaddr = your vultr ip address + port
3. masternodeprivkey = masternode gen key

(keep all safe)

```
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
```

Above is a non functioning dummy, replace with your own

Wallet side is now completed. Now begins the SSH setup.

*****

# Set up the Masternode on a Linux VPS

## Choose your VPS

VPS server required: Recommend the following:
- www.vultr.com
- $5 Basic cloud computer package
- Choose any country
- Ubuntu 16.04.x64
- Server (Name anything you want, i.e matrix)

## Start an SSH session

Depending upon which you're using. Download the following:

- [Windows - PUTTY](https://www.putty.org/)
- Mac - Terminal (on mac already)

Next:

1. Load SSH terminal
2. Copy your IP from VPS - And for windows Putty simply enter in and press enter.
3. It will login to server. Follow the commands below, typing one by one, each line, followed by pressing enter
4. Username: root
5. Password: (vultr password)

## Configure SWAP

```
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab
```

## Clone the project

```
cd /root/
git clone https://github.com/nodiumproject/Nodium nodium
```

## Configure & compile the Nodium project

```
cd nodium
sudo apt-get install -y pkg-config
sudo apt-get -y install build-essential autoconf automake libtool libboost-all-dev libgmp-dev libssl-dev libcurl4-openssl-dev git
sudo add-apt-repository ppa:bitcoin/bitcoin
```

(press enter, follow through)

```
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev
```

(say yes on continue)

## Start the Nodium build

```
sudo chmod +x share/genbuild.sh
sudo chmod +x autogen.sh
sudo chmod 755 src/leveldb/build_detect_platform
sudo ./autogen.sh
sudo ./configure
sudo make
```

(LEAVE TO INSTALL)

## Start the Nodium masternode daemon

```
./Nodiumd -daemon
```

Save the rpc username and password in the output. Hit `CTRL+C` to stop the daemon.

Now, edit the masternode config to enter the RCP username/password.

```
sudo nano ~/.Nodium/Nodium.conf
```

(this opens nano pad)

Paste the rpc username and password in. Next, paste the completed config details from wallet setup stage above.

example:

```
rpcuser=user1
rpcpassword=fdf43324234
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
```

Now, exit the nano pad. By pressing control x, then save as same file now and exit.

## Start your Nodium server

```
./Nodiumd -daemon
```

This starts your server.

To check the status:

```
./Nodium-cli getinfo
```

****

# Use your wallet to start your masternode

Re-open your wallet (close + open). A masternode should now appear in the Masternodes tab. Allow the wallet to fully sync, then start the masternode by clicking `START ALIAS`.

Follow these steps correctly and your Nodium masternode will begin running.

Allow some time for your masternode to sync and the timer will being to show later on.

***

SUCCESS! - Begin earning for supporting the $XN network!

# Security
http://patheyman.com/masternode-secure/
https://pivx.org/knowledge-base/wallet-setup-guide/
