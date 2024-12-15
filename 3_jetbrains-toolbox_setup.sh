#!/bin/bash

# 打一声招呼
toilet -F metal "Install JetBrains Toolbox..."

# 获取脚本所在目录
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# 定义带有样式效果的echo函数
echo_style() {
  echo -e "\033[1;33;47m$1\033[0m"  # 黄色字体，灰底
}
echo_error() {
  echo -e "\033[1;31m$1\033[0m"  # 红色字体
}

# 安装FUSE2
echo_style "Installing libfuse2..."
if ! sudo apt install -y libfuse2; then
  echo_error "Failed to install libfuse2. Please check your APT sources."
  exit 1
fi

# 下载JetBrains Toolbox
TOOLBOX_URL="https://download-alibaba.jetbrains.com.cn/toolbox/jetbrains-toolbox-2.5.2.35332.tar.gz"
TEMP_DIR=$(mktemp -d)
echo_style "Downloading JetBrains Toolbox..."
if ! wget -O "$TEMP_DIR/toolbox.tar.gz" "$TOOLBOX_URL"; then
  echo_error "Download failed. Please check the URL or your network connection."
  exit 1
fi

# 解压JetBrains Toolbox
INSTALL_DIR="$HOME/jetbrains-toolbox"
echo_style "Extracting JetBrains Toolbox..."
mkdir -p "$INSTALL_DIR"
if ! tar -zxvf "$TEMP_DIR/toolbox.tar.gz" -C "$INSTALL_DIR"; then
  echo_error "Extraction failed. Please check the downloaded file."
  exit 1
fi

# 清理临时文件
rm -rf "$TEMP_DIR"

# 打开JetBrains Toolbox
cd "$INSTALL_DIR" || exit 1
EXECUTABLE=$(find . -type f -name "jetbrains-toolbox" | head -n 1)
if [[ -x "$EXECUTABLE" ]]; then
  echo_style "Opening JetBrains Toolbox..."
  "$EXECUTABLE" &
else
  echo_error "JetBrains Toolbox executable not found!"
  exit 1
fi

# 提示用户安装Android Studio
echo_style "Please use JetBrains Toolbox to download Android Studio and other required IDEs."
for i in {1..5}; do  # 允许最多5次提示
  read -p "Have you installed? (Y/y to continue, N/n to exit):" user_input
  case $user_input in
    [Yy]) break ;;
    [Nn]) echo_error "Installation incomplete. Exiting."; exit 1 ;;
    *) echo_style "Invalid input. Please press Y/y to continue or N/n to exit." ;;
  esac
done

# 返回脚本所在目录并执行Flutter安装脚本
cd "$SCRIPT_DIR" || exit 1
if [[ -f "./4_flutter_setup.sh" ]]; then
  echo_style "Running Flutter setup script..."
  ./4_flutter_setup.sh
else
  echo_error "Flutter setup script not found!"
  exit 1
fi
