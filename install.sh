#!/bin/bash

# 设置UTF-8编码避免乱码
export LANG=en_US.UTF-8

# 创建目标主目录
typst_dir="$HOME/.local/share/typst/packages/local"

# 定义需要安装的模板数组
declare -A templates
templates=(
    ["undergraduate-thesis-template"]="bit-undergraduate-thesis-template"  # 可以从toml读取，这里为简化直接写死
    ["slides-template"]=""  # 将从toml文件中读取
)

# 循环处理每个模板
for source in "${!templates[@]}"; do
    toml_file="$source/typst.toml"
    
    if [ -f "$toml_file" ]; then
        # 读取toml文件获取信息
        version=$(grep 'version = ' "$toml_file" | sed 's/version = "\(.*\)"/\1/')
        
        # 获取模板名称
        name=${templates[$source]}
        if [ -z "$name" ]; then
            name=$(grep 'name = ' "$toml_file" | sed 's/name = "\(.*\)"/\1/')
        fi
        
        # 创建目标目录
        dest_dir="$typst_dir/$name/$version"
        mkdir -p "$dest_dir"
        
        # 复制模板文件
        cp -r "$source/"* "$dest_dir/"
        
        echo "$name 模板已安装到: $dest_dir"
    else
        echo "未找到 $source 的typst.toml文件"
    fi
done
