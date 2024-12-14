#!/bin/bash

set -e  # 发生错误时停止脚本

# 打一声招呼
toilet -F metal "install QQ..."

# 定义一个带有样式效果的echo函数
echo_style() {
  echo -e "\033[1;33;47m$1\033[0m"
}

# 更新软件包列表
sudo apt update

# 安装前置软件包
sudo apt-get install -y curl wget

# 下载QQ
echo_style "下载QQ......"
QQ_URL="https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.15_241210_amd64_01.deb"
wget -O qq.deb $QQ_URL
echo_style "QQ下载完成！"

# 安装QQ
echo_style "安装QQ......"
sudo dpkg -i qq.deb
echo_style "QQ安装完成！"

# 打开安装jetbrains-toolbox的脚本
./3_jetbrains-toolbox_setup.sh
