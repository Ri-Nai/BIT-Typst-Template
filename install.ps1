
# git clone https://github.com/Ri-Nai/BIT-Typst-Template.git
# cd BIT-Typst-Template

# 创建目标主目录
$typst_dir = "$env:USERPROFILE\AppData\Local\typst\packages\local"

# 定义需要安装的模板数组
$sources = @(
    "undergraduate-thesis-template",
    "slides-template"
)

# 循环处理每个模板
foreach ($source in $sources) {
    $toml_path = "$($source)\typst.toml"
    $name = "bit-$($source)"
    if (Test-Path $toml_path) {
        # 检测文件编码
        $content = Get-Content $toml_path -Raw
        # 读取toml文件获取信息
        $version = ($content | Select-String -Pattern 'version\s*=\s*"(.*)"').Matches.Groups[1].Value
        
        # 如果name未指定，则从toml中读取
        if (-not $name) {
            $name = ($content | Select-String -Pattern 'name\s*=\s*"(.*)"').Matches.Groups[1].Value
        }
        Remove-Item -Path "$typst_dir\$name" -Recurse -Force -ErrorAction Ignore
        # 创建目标目录
        $dest_dir = "$typst_dir\$name\$version"
        New-Item -ItemType Directory -Force -Path $dest_dir | Out-Null
        
        # 复制模板文件
        Copy-Item -Path "$source\*" -Destination $dest_dir -Recurse -Force
        
        # 输出信息
        Write-Host "$name 模板已安装到: $dest_dir" -ForegroundColor Green
    } else {
        Write-Host "未找到 $source 的typst.toml文件" -ForegroundColor Red
    }
}
