# Nodium Masternode setup guide

> In this guide we will install a Nodium masternode the EASY way :)<br><br>
Let's get started!

## 1. Initial wallet setup
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
* 1.7 Go back to `debug console` and type `masternode outputs` <br />
* 1.8 Copy the transaction id and output id
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
* Go to Connection and adjust the session timer to 30. This is to ensure that you don't get kicked from the server.<br>
![image](https://github.com/zaemliss/installers/raw/master/timeout.png)<br>
* Go back to Session.
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

## 4. Masternode config file in the wallet

4.1 Go to `open masternode configuration file` in the wallet - found on the 'tools' menu <br />
   Here you will see the format and an example( these three lines are comments so they have no effect ) <br />
The format is like this:

```
# Masternode config file
# Format: alias IP:port masternodeprivkey collateral_output_txid collateral_output_index
# Example: MN01 127.0.0.2:51474 93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0
```

4.2. Add your own real working node details under it. <br />
4.3. Put the masternode wallet name, i.e - `MN01` <br />
4.4 Put the server IP address ( your vultr ip or other vps/vm ip) followed by the port :6250 <br />
4.5 Put the private key generated in step 1.4 <br />
4.6 Put the transaction hash and output id from step 1.7 <br />
Example below

```
MN01 124.842.07.0:6250 119cCx5YeA519YkTzun4EptdexAo3RvQXaPdkP 838328ce57cc8b168d932d138001781b77b22470c05cf2235a3284093cb0019db 0
```

4.7 Once complete, save the file <br />

The file will look like this:
```
# Masternode config file
# Format: alias IP:port masternodeprivkey collateral_output_txid collateral_output_index
# Example: mn1 127.0.0.2:51474 93HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg 2bcd3c84c84f87eaa86e4e56834c92927a07f9e18718810b92e0d0324456a67c 0
MN01 124.842.07.0:6250 119cCx5YeA519YkTzun4EptdexAo3RvQXaPdkP 838328ce57cc8b168d932d138001781b77b22470c05cf2235a3284093cb0019db 0
```
4.8 Restart the wallet<br>
4.9 Go to your wallet and go to the masternode page.<br>
* Select the masternode and press: "Start alias".<br>
![Imgur](https://i.imgur.com/jXDVZqO.png)<br>

To verify that the masternode is running on the vps:
* Type: `cd ~/nodium/src`  ENTER
* Type: `./nodium-cli masternode status`  ENTER
* If you get this output you are done:<br>
![Imgur](https://i.imgur.com/tWVgO2O.png)

<br>
If you followed these steps correctly your Nodium masternode should be running right now!<br>

> 🎉🎉🎉🎉🎉🎉 !!!!! Congratulations, begin earning rewards for supporting the $XN network! !!!!! 🎉🎉🎉🎉🎉🎉<br>

After some time the rewards will be distributed in your wallet.

<br>

# 5. Troubleshooting

5.1 Cannot bind port
When using another VPS provider (Microsoft Azure for example) as mentioned in this guide, you might not be able to directly bind the port to your external VPS IP. You will get an error at the end of the setup. In that case you need to bind it to your local IP. You can find the local IP by typing logging in to the VPS with the in the guide given user:
* Type: `ifconfig`  ENTER
* Look for the `eth0` interface:<br>
![Imgur](https://i.imgur.com/ftQlQLp.png)
* Copy `inet addr:<i>10.0.1.5</i>` (example)<br>
* Type: `nano ~/.Nodium/nodium.conf`  ENTER
* Change: `bind=<i>10.0.1.5</i>` (example)<br>
* Type: `ctrl+o`
* Type: `ctrl+x` <br>

Now, login to the VPS portal to add the inbound network port (6250) because your host could not bind it through the VPS host.
This is pretty generic (Microsoft Azure example) please follow the hoster guides for your situation. 
<br>
![Imgur](https://i.imgur.com/YcNrWKF.png)
<br>
Next, back on the VPS:
* Type: ~/nodium/src/nodiumd -daemon
Now it will start the Nodium NM using the new settings you just made.

# 6. Security

## 6.1 Wallet

Encrypt your wallet! This prevents other people ( who have access to your computer or get access to your wallet.dat file ) to get in your wallet. Don't lose that password. If you lose it the wallet is locked forever and nobobdy will be able to recover your funds.

Backup your wallet! The beauty of digital files is that you can back them up and store them somewhere safe. After encrypting your wallet make sure you back it up and keep it somewhere safe ( on a usb for example).

## 6.2 VPS

For the more advanced user I advise making your VPS more secure from all kinds of attacks. We don't want other people stealing our masternode right?
Please look at this guide http://patheyman.com/masternode-secure/ for more info.

# 7. Questions?

If you have a problem or a question you can find us in the #support channel on our Discord.
