# Nodium Masternode setup guide

> In this guide we will install a Nodium masternode the EASY way :)<br><br>
Let's get started!

## 1. Inital wallet setup
* 1.1 Download the [latest wallet](https://github.com/nodiumproject/Wallets) for your operating system which is available in our wallets repository.<br>
* 1.2 Launch the wallet and allow it to synchronize <br />
* 1.3 Click on `debug console` found in `tools`
![Imgur](https://i.imgur.com/OXxgGIA.png)
* 1.4 Type `masternode genkey` - copy the generated key and exit the console<br />
Save the private key in a text file for future use.<br>
* 1.5 Go to `receiving wallets` found in `files` - create masternode wallet, by creating a new wallet, called `masternode1` <br />
![Imgur](https://i.imgur.com/BsM6qhH.png)
Copy the address by right-clicking and selecting "Copy Address"<br>
* 1.6 Send EXACTLY 10,000 coins to `masternode1` wallet by pasting the copied address.<br>
Note that this has to be sent in **ONE transaction**. <br />
* 1.7. Go back to `debug console` and type `masternode outputs` <br />
Save the output in the text file for future use.

## 2. Get a VPS ( masternode server )
We recommend renting a VPS with www.vultr.com because they are fast and cheap.

* 2.1 Create an account:<br>
![Create account](https://i.imgur.com/ingiJYX.png)<br>
* 2.2 Deploy a new server
* 2.3 Choose a location close to you to have a fast connection
* 2.4 Choose Ubuntu 16.04  x64 as operating system and take the 5$ server size. This is sufficient.<br>
![Server size](https://i.imgur.com/OeUEHPy.png)<br>
* 2.5 Move to step 7 and give your masternode VPS a name.<br>
![Masternode name](https://i.imgur.com/QvBBvew.png)<br>
* 2.6 Click "Deploy now"<br>
The server is now being started. Please wait until the status is "Available".
* 2.7 Click the server name and copy the IP-address and password via the copy button.
![Masternode server information](https://i.imgur.com/5wJEIB1.png)<br>
Save them in the text file for future use.
## 3. Configure your masternode
Depending upon which operating system you are using follow the correct section:

### 3.1 Windows - [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
#### 3.1.1 Install PuTTY and run it.
* You will be greeted with the following page:<br>
![Imgur](https://i.imgur.com/X1k9vXi.png)<br>
* Fill the Host name field with the IP address you previously copied and click "Open".<br>
* You will see a popup asking you if you trust this host. Choose Yes!( this will only be asked once ).
![Imgur](https://i.imgur.com/Y2iEDj8.png)<br>
* Login as "root". Hit ENTER
* Copy the password you saved previously and right click in the putty terminal.  ENTER.
* You are now logged into your server:
![Imgur](https://i.imgur.com/USqQUEE.png)<br>
### 3.2 Mac/Linux - Terminal ( preinstalled )
* You can find Terminal by following the steps: 
* Go to Finder, Applications then click on utilities, then you'll find the terminal there.
![Imgur](https://i.imgur.com/a8880fe.png)<br>
* Type: ssh root@YourMasternodeIPaddress.  ENTER.
* You are now logged into your server.
### 3.3 General steps
Let's update our system to the latest version to make sure we are secure.
* Type: `sudo apt-get update`  ENTER
* Wait until this finishes
* Type: `sudo apt-get upgrade` ENTER
![Imgur](https://i.imgur.com/arg8fzn.png)<br>
* Type "y" if the system ask for the confirmation of updating the system.
> Now we start using the power of the script made by chris#1470 Core member of Nodium<br>

Remember that you can copy the text below and paste it in to the server via RIGHT-MOUSE click for PuTTY, or CMD-V for MAC<br>

* Type: `cd ~`  ENTER
* Type: `wget https://raw.githubusercontent.com/nodiumproject/Masternode-setup-guide/master/install-3.0.6.sh` ENTER
* Type: `chmod +x install-3.0.6.sh` ENTER
* Type: `./install-3.0.6.sh` ENTER
![Imgur](https://i.imgur.com/rILeKJU.png)<br>
* Type: `y` ENTER<br>
![Imgur](https://i.imgur.com/J9xMkku.png)<br>
* Type or copy your masternode private key you created before and saved in that text file.  ENTER
* Now get yourself a coffee ☕, this takes approximately 30 minutes.
![Imgur](https://i.imgur.com/gQFsPJv.png)<br>

* Go to your wallet and go to the masternode page.<br>
![Imgur](https://i.imgur.com/jXDVZqO.png)<br>
* Select the masternode and press: "Start alias".

To verify that the masternode is running on the vps:
* Type: `cd ~/nodium/src`  ENTER
* Type: `./nodium-cli masternode status`  ENTER
* If you get this output you are done:<br>
![Imgur](https://i.imgur.com/tWVgO2O.png)

<br>
If you followed these steps correctly your Nodium masternode should be running right now!<br>

> 🎉🎉🎉🎉🎉🎉 !!!!! Congratulations, begin earning rewards for supporting the $XN network! !!!!! 🎉🎉🎉🎉🎉🎉<br>

After some time the rewards will be distributed in your wallet.

# 4. Security

## 4.1 Wallet

Encrypt your wallet! This prevents other people ( who have access to your computer or get access to your wallet.dat file ) to get in your wallet. Don't lose that password. If you lose it the wallet is locked forever and nobobdy will be able to recover your funds.

Backup your wallet! The beauty of digital files is that you can back them up and store them somewhere safe. After encrypting your wallet make sure you back it up and keep it somewhere safe ( on a usb for example).

## 4.2 VPS

For the more advanced user I advise making your VPS more secure from all kinds of attacks. We don't want other people stealing our masternode right?
Please look at this guide http://patheyman.com/masternode-secure/ for more info.

# 5. Questions?

If you have a problem or a question you can find us in the #support channel on our Discord.