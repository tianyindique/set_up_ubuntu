#!/bin/bash

set -e

# 打一声招呼
sudo apt-get -y install toilet > /dev/null
toilet -F gay "Hello"
toilet -F metal "I will help you configure ubuntu"

#----------Step1 换源     
#--------
#------ 
#备份当前的源列表
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
#更换为中科大镜像源
sudo bash -c 'cat > /etc/opt/sources.list' <<EOF
#中科大镜像源
deb https://mirrors.ustc.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ jammy-proposed main restricted universe multiverse
EOF

#更新系统
sudo apt update
sudo apt upgrade -y


#----------Step2 安装常用软件
#--------
#------
# 网络工具
sudo apt install curl wget git -y
# 办公和多媒体
sudo apt install libreoffice vlc gimp -y
# 开发工具
sudo apt install build-essential python3 nodejs npm python3-pip -y

#----------Step3 安装驱动程序
#--------
#------
sudo ubuntu-drivers autoinstall

#----------Step4 启用防火墙
#--------
#------
sudo ufw enable

#----------Step5 设置时间和区域
#--------
#------
sudo timedatectl set-timezone Asia/Shanghai

#----------Step6 安装常用字体
#--------
#------
#sudo apt install ttf-mscorefonts-installer
#sudo apt install fonts-noto

#----------Step7 清理和优化
#--------
#------
sudo apt autoremove
sudo apt clean

# 打开安装QQ的脚本
./2_QQ_setup.sh
