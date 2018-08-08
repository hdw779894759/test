# !/usr/bin/env bash
# kill旧项目，删除旧项目，启动新项目，备份老项目
DATE=$(date +%Y%m%d)

export JAVA_HOME PATH CLASSPATH
JAVA_HOME=/usr/java/jdk1.8.0_131
PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH

DIR=/root/test
JARFILE=test-0.0.1-SNAPSHOT.jar

if [ ! -d $DIR/backup ];
then mkdir -p $DIR/backup
fi
cd $DIR

ps -ef | grep $JARFILE | grep -v grep | awk '{print $2}' | xargs kill -9
mv $JARFILE backup/$JARFILE$DATE
mv -f /root/Jenkins-in/$JARFILE .
java -jar $JARFILE > out.log &
if [ $? = 0 ];then
sleep 30 tail -n 50 out.log
fi
cd backup/
ls -lt|awk 'NR>5{print $NF}'|xargs rm -rf
