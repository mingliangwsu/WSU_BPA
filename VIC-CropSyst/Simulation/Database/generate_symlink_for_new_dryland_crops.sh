#!/bin/bash
curdir=$pwd
cd ./Rotation/Code
#ln -s 2501.CS_rotation 12501.CS_rotation
ln -s 4005.CS_rotation 14005.CS_rotation 
ln -s 4006.CS_rotation 14006.CS_rotation 
ln -s 4010.CS_rotation 14010.CS_rotation 
ln -s 4011.CS_rotation 14011.CS_rotation 
ln -s 4101.CS_rotation 14101.CS_rotation 
ln -s 4103.CS_rotation 14103.CS_rotation 
ln -s 6001.CS_rotation 16001.CS_rotation 

cd ../../Management/Code
ln -s 2501.mgt 12501.mgt

cd ../../Crop/Code
ln -s 2501.CS_crop 12501.CS_crop
cd $curdir
