######################## For AIX JAN26 14C ########################

mkdir -p /oracle/Softwares/CPU_JAN2026_14C
# Variables
sourceipaddress=ip # need to add soure ip 

scp -Opr weblogic@$sourceipaddress:/oracle/Softwares/CPU_JAN2026_14C/p38799653_141100_Generic.zip /oracle/Softwares/CPU_JAN2026_14C

echo "Unzipping patch binary"
cd /oracle/Softwares/CPU_JAN2026_14C
nohup /usr/java8_64/bin/jar -xvf /oracle/Softwares/CPU_JAN2026_14C/p38799653_141100_Generic.zip

echo "Unzipping OPatch version"
cd /oracle/Softwares/CPU_JAN2026_14C/WLS_SPB_14.1.1.0.251226/tools/opatch/generic
nohup /usr/java8_64/bin/jar -xvf /oracle/Softwares/CPU_JAN2026_14C/WLS_SPB_14.1.1.0.251226/tools/opatch/generic/p28186730_1394222_Generic.zip

################ Applying OPATCH VERSION ##########################

echo "Applying opatch version"
cd /oracle/Softwares/CPU_JAN2026_14C/WLS_SPB_14.1.1.0.251226/tools/opatch/generic/6880880
/usr/java8_64/bin/java -jar /oracle/Softwares/CPU_JAN2026_14C/WLS_SPB_14.1.1.0.251226/tools/opatch/generic/6880880/opatch_generic.jar oracle_home=/oracle/middleware -silent

################ Applying WebLogic Patch #########################

echo "Applying WebLogic Patch"
cd /oracle/Softwares/CPU_JAN2026_14C/WLS_SPB_14.1.1.0.251226/binary_patches
/oracle/middleware/OPatch/opatch napply -oh /oracle/middleware -phBaseFile /oracle/Softwares/CPU_JAN2026_14C/WLS_SPB_14.1.1.0.251226/binary_patches/aix64_patchlist.txt -silent

######################## END ####################################