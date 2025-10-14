* Sync up to at least the drivechain fork height which you can find in chainparams src/kernel/chainparams.cpp consensus.DrivechainHeight 
During this sync do not use the -drivechain command line argument

* If you have extra blocks invalidate them and wait for the rollback of blocks to complete

Example:

getblockhash 917280
00000000000000000000a1ac5fb4674cfd0e1b2b1c47f79038515382ec5eb678

invalidateblock 00000000000000000000a1ac5fb4674cfd0e1b2b1c47f79038515382ec5eb678

* Shut down the node

* Start the node again with the -drivechain command line argument

