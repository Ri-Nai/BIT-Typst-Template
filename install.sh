#!/bin/bash

# 设置UTF-8编码避免乱码
export LANG=en_US.UTF-8

# 创建目标主目录
typst_dir="$HOME/Library/Caches/typst/packages/local"
# 定义需要安装的模板数组（macOS 默认 bash 为 3.x，不支持关联数组，改用二维数组模拟）
templates_sources=(
    "undergraduate-thesis-template"
    "slides-template"
)
templates_names=(
    "bit-undergraduate-thesis-template"
    ""
)

# 循环处理每个模板
for idx in "${!templates_sources[@]}"; do
    source="${templates_sources[$idx]}"
    name_override="${templates_names[$idx]}"
    toml_file="$source/typst.toml"
    
    if [ -f "$toml_file" ]; then
        # 读取toml文件获取信息
        version=$(grep 'version = ' "$toml_file" | sed 's/version = "\(.*\)"/\1/')
        
        # 获取模板名称
        name="$name_override"
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
