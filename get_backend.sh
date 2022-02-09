#!/bin/bash

script_path=../../../jeecg-boot/jeecg-boot/db/jeecgboot-mysql-5.7.sql
jar_path=../../../jeecg-boot/jeecg-boot/jeecg-boot-module-system/target/jeecg-boot-module-system-2.4.6.jar

mkdir -p backend/scripts
cp $script_path backend/scripts

mkdir -p backend/dist
cp $jar_path backend/dist