#!/usr/bin/env bash

# 停止正在运行的所有进程函数
killJavaTask(){
    pid=`netstat -anp|grep 8090|awk '{print $7}'|cut -d/ -f1`
    echo "server alive at pid :$pid"
    if [ "$pid"="" ]
     then
        echo "no server pid alive"
     else
        kill -9 $pid
    fi
}


# 进入项目根目录
cd $PROJ_PATH/test

# 忽略测试编译生成新的项目工程
mvn clean install -Dmaven.test.skip=true

# 停止原来的项目
killJavaTask

# 删除原有工程
rm -rf /target

# 后台方式启动新项目
java -jar target/test-0.0.1-SNAPSHOT.jar &