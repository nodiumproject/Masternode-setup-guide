#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

clear
echo
echo -e "${GREEN}Stopping Nodium Masternode...${NC}"
echo
~/nodium/src/nodium-cli stop
sleep 5
echo 
echo -e "${YELLOW}Removing Block data...${NC}"
echo
rm -R ~/.Nodium/blocks
rm -R ~/.Nodium/budget.dat
rm -R ~/.Nodium/chainstate
rm -R ~/.Nodium/database
rm -R ~/.Nodium/sporks
rm -R ~/.Nodium/zerocoin
rm ~/.Nodium/peers.dat
rm ~/.Nodium/mncache.dat
rm ~/.Nodium/*.log
echo
echo -e "${GREEN}Starting server...${NC}"
~/nodium/src/nodiumd -daemon
sleep 5
watch -g ~/nodium/src/nodium-cli masternode status
