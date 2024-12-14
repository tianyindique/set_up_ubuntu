#!/bin/bash

set -e  # 发生错误时停止脚本

# 打一声招呼
sudo apt -y install toilet > /dev/null
toilet -F metal "install flutter..."
sudo apt-get -y remove toilet > /dev/null

# 定义一个带有样式效果的echo函数
echo_style() {
  echo -e "\033[1;33;47m$1\033[0m"
}


#提示用户准备代理环境
if grep -q "CN" /etc/timezone; then
  echo_style "You are in China. Please configure a proxy before proceeding"
fi
while true; do
  read -p "Are you ready? (Y/y to continue, N/n to exit):" user_input
  case $user_input in
      [Yy]) break;;
      [Nn]) exit 1;;
      *) echo_style "Invalid input. Please press Y/y to continue or N/n to exit.";;
  esac
done

#更新系统并安装依赖
echo_style "Updating system and install the following packages: "
echo_style "curl, git, unzip, xz-utils, zip, libglu1-mesa"
echo_style
echo_style "Step 1: Updating system..."
sudo apt-get update -y

echo_style "Step  2: Installing packages..."
#检查是否是AMD64或ARM64,如果不是，就退出并提示
ARCH=$(uname -m)
if [[ "$ARCH" != "x86_64" && "$ARCH" != "arm64" ]]; then
  echo_style "Unsupported architecture: $ARCH, only x86_64 and arm64 are supported."
  exit 1
fi
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa wget




# 安装Flutter SDK
#  下载
echo_style "Downloading Flutter SDK..."
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.27.0-stable.tar.xz"

wget -O flutter.tar.xz $FLUTTER_URL || { echo_style "Failed to download Flutter SDK"; exit 1; }
echo_style "Flutter has been downloaded successfully!"

#  解压
FLUTTER_INSTALL_DIR="$HOME/development"
echo_style "Extracting Flutter SDK to ${FLUTTER_INSTALL_DIR}..."
mkdir -p ${FLUTTER_INSTALL_DIR}
sudo tar -xf flutter.tar.xz -C ${FLUTTER_INSTALL_DIR}
echo_style "Flutter has been extracted successfully!"
sudo chown -R $USER:$USER "${FLUTTER_INSTALL_DIR}"

# 删除已经没用的flutter安装包
rm flutter.tar.xz
echo_style "Flutter SDK has been installed to ${FLUTTER_INSTALL_DIR} successfully!"

# 添加Flutter SDK到环境变量PATH
SHELL_TYPE=$(basename "$SHELL")
NEW_PATH="$HOME/development/flutter/bin"
 # 根据不同的shell类型来修改对应的配置文件
if [ "$SHELL_TYPE" == "bash" ]; then
  echo_style "Detected Bash shell. Adding PATH to ~/.bashrc"
  if ! grep -q "$NEW_PATH" ~/.bashrc; then
    echo "export PATH=\$PATH:$NEW_PATH" >> ~/.bashrc
  fi
  source ~/.bashrc
elif [ "$SHELL_TYPE" == "zsh" ]; then
  echo "Detected Zsh shell. Adding PATH to ~/.zshrc"
  # 将新的路径添加到 ~/.zshrc
  echo "export PATH=\$PATH:$NEW_PATH" >> ~/.zshrc
  # 使修改立即生效
  source ~/.zshrc
else
  echo "Unsupported shell: $SHELL_TYPE"
fi

source ~/.bashrc


# 同意Android licenses
# echo_style "Accepting Android licenses..."
# flutter doctor --android-licenses

# 提示用户运行flutter doctor来排查错误
echo_style "to check for any potential issues, please run the following command:"
echo_style "flutter doctor"
