#!/bin/bash

# 打一声招呼
toilet -F metal "install jetbrains-toolbox..."

# 定义一个带有样式效果的echo函数
echo_style() {
  echo -e "\033[1;33;47m$1\033[0m"
}

# 安装FUSE2
sudo apt install libfuse2
# 安装Jetbrains toolbox, 并利用其安装Android Studio
TOOLBOX_URL="https://download-alibaba.jetbrains.com.cn/toolbox/jetbrains-toolbox-2.5.2.35332.tar.gz"
wget -O toolbox.tar.gz $TOOLBOX_URL
echo_style "Jetbrains toolbox下载完成"

mkdir -p $HOME/Jetbrains-toolbox
echo_style "解压Jetbrains toolbox..."
tar -zxvf toolbox.tar.gz -C $HOME/Jetbrains-toolbox
echo_style "Jetbrains toolbox解压完成！"
rm toolbox.tar.gz

# 将解压后的文件移出来，并重命名
cd $HOME/Jetbrains-toolbox
for file in *; do
  mv "$file" "$HOME/jetbrains-toolbox"
done
rm -r $HOME/Jetbrains-toolbox

# 打开toolbox
cd $HOME/jetbrains-toolbox
echo_style "打开Jetbrains toolbox..."
./jetbrains-toolbox
echo_style "Jetbrains toolbox已打开"

echo_style "请在toolbox里下载Android Studio和其他要用到的IDE"
while true; do
  read -p "Have you installed? (Y/y to continue, N/n to exit):" user_input
  case $user_input in
      [Yy]) break;;
      [Nn]) exit 1;;
      *) echo_style "Invalid input. Please press Y/y to continue or N/n to exit.";;
  esac
done

# 打开安装flutter的脚本
cd -
./4_flutter_setup.sh
