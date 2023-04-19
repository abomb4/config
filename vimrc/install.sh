#!/bin/bash

# 获取脚本路径和目录
script_path=$(realpath $0)
script_dir=$(dirname $script_path)

# 定义 vimrc 文件路径和目标路径
vimrc="$script_dir/vimrc"
vimrc_dest="$HOME/.vimrc"

# 检查目标文件是否存在
if [ -f "$vimrc_dest" ]; then
  # 备份目标文件
  echo "备份已经存在的配置文件 $vimrc_dest"
  bak_dest="$vimrc_dest.bak"
  i=1
  while [ -f "$bak_dest" ]; do
    bak_dest="$vimrc_dest.bak.$i"
    i=$((i+1))
  done
  mv "$vimrc_dest" "$bak_dest"
  echo "已将 $vimrc_dest 备份到 $bak_dest"
fi

# 复制vimrc文件到目标路径
cp "$vimrc" "$vimrc_dest"
echo "已经将 $vimrc 复制到了 $vimrc_dest"
