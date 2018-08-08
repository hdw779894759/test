#!/usr/bin/env bash

# 进入项目根目录
cd $PROJ_PATH/test

# 删除原有工程
rm -rf /target

# 忽略测试编译生成新的项目工程
mvn clean install -Dmaven.test.skip=true

# 启动新项目
java -jar target/test-0.0.1-SNAPSHOT.jar &

# 退出
exit