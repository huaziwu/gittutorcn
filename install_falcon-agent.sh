#!/bin/bash

BASEDIR="/usr/local"
WORKSPACE="$BASEDIR/open-falcon"
mkdir -p $WORKSPACE

DOWNLOAD="http://7xiumq.com1.z0.glb.clouddn.com/open-falcon-binary-0.0.4.tar.gz" 
[ -d "$WORKSPACE" ] && cd $WORKSPACE
mkdir ./tmp
wget $DOWNLOAD -O open-falcon-latest.tar.gz >/dev/null 2>&1
tar -zxf open-falcon-latest.tar.gz -C ./tmp/
for x in `find ./tmp/ -name "falcon-agent-3.1.4.tar.gz"`;do \
    app=`echo $x|cut -d '-' -f2`; \
    mkdir -p $app; \
    tar -zxf $x -C $app; \
done

[ -f "open-falcon-latest.tar.gz" ] && rm -f open-falcon-latest.tar.gz
[ -d "./tmp" ] && rm -fr ./tmp 

[ -d "./agent" ] && cd ./agent
[ -f cfg.example.json ] && mv cfg.example.json cfg.json
sed -i "s/127.0.0.1/10.210.238.79/" cfg.json
./control start
NUM=`ps ax |grep "falcon-agent"|grep -v "grep"|wc -l` 
#echo $NUM
if [ $NUM -eq 1 ];then
    echo "falcon-agent install successful"
fi

