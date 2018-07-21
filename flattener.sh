#########################################################################
# File Name: flattener.sh
# Author: ma6174
# mail: ma6174@163.com
# Created Time: 六 12/30 00:54:25 2017
#########################################################################
#!/bin/bash

cd flat_contracts 
rm -rf *
cd ..
truffle-flattener contracts/PetCore.sol >flat_contracts/PetCoreFlat.sol
truffle-flattener contracts/SaleClockAuction.sol >flat_contracts/SaleClockAuctionFlat.sol
truffle-flattener contracts/SiringClockAuction.sol >flat_contracts/SiringClockAuctionFlat.sol
truffle-flattener contracts/GenePet.sol >flat_contracts/GenePetFlat.sol
