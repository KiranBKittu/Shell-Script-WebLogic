############### For Linux JAN26 14C ################
#!/bin/bash

# Variables
sourceipaddress=ip # need to add soure ip 

mkdir -p /oracle/Softwares/CPUJAN2026_14C

scp -pr weblogic@:$sourceipaddress/oracle/Softwares/CPUJAN2026_14C/p38140262_141100_Generic.zip /oracle/Softwares/CPUJAN2026_14C

cd /oracle/Softwares/CPUJAN2026_14C
nohup unzip /oracle/Softwares/CPUJAN2026_14C/p38140262_141100_Generic.zip

echo "Unzipping OPatch version"

cd /oracle/Softwares/CPUJAN2026_14C/WLS_SPB_14.1.1.0.250701/tools/opatch/generic/
nohup unzip /oracle/Softwares/CPUJAN2026_14C/WLS_SPB_14.1.1.0.250701/tools/opatch/generic/p28186730_1394220_Generic.zip

############### Applying OPATCH VERSION ################

cd /oracle/Softwares/CPUJAN2026_14C/WLS_SPB_14.1.1.0.250701/tools/opatch/generic/6880880

/usr/java/jdk1.8.0-x64/bin/java -jar /oracle/Softwares/CPUJAN2026_14C/WLS_SPB_14.1.1.0.250701/tools/opatch/generic/6880880/opatch_generic.jar oracle_home=/oracle/middleware -silent

############### Applying WebLogic Patch ################

echo "Applying WebLogic Patch"

/oracle/middleware/Oracle_Home/OPatch/opatch napply -oh /oracle/Middleware/Oracle_Home -phBaseFile /oracle/Softwares/CPUJAN2026_14C/WLS_SPB_14.1.1.0.250701/binary_patches/linux64_patchlist.txt -silent

######################## END ########################