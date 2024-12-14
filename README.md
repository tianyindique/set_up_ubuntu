# set_up_ubuntu

这是几个脚本，用于给新安装的ubuntu系统进行基本的配置,并安装配置Android Studio和Flutter
我是直接从官网复制的链接，随着时间推移，脚本可能失效

# 使用方法
## 1.进入脚本所在目录
`cd path/to/your_script`
## 2.赋予脚本执行权限
`chmod +x your_script`
每一个脚本都要加哦
## 3.执行脚本（只用执行第一个）
`./1_ubuntu_configure.sh`

## 第一个脚本要实现的功能
### 为ubuntu换源，我选的是中科大的源
### 安装几个常用的工具
包括curl wget git 
### 安装几个办公和影音工具
包括 libreoffice vlc gimp
###安装几个开发工具
包括 build-essential python3 nodejs npm python3-pip
## 第二个脚本要实现的功能
### 安装QQ
## 第三个脚本要实现的功能
### 安装Jetbrains-toolbox，并用这个安装Android Studio和其他IDE（自己在toolbox里点击来下载）
## 第四个脚本里要实现的功能
### 安装flutter
