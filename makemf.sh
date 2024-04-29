#!/bin/bash

# 检查是否需要显示帮助信息
if [[ $1 == "help" || $1 == "-h" ]]; then
  echo "用法："
  echo "  makemf -n <要生成的 Makefile 名称> -m <GGUF 文件名称，包含后缀名>"
  exit 0
fi

# 检查参数数量
if [[ $# -eq 0 ]]; then
  echo "使用方法: $0 -n <模型名称> -m <模型文件>"
  exit 1
fi

# 解析命令行参数
while getopts ":n:m:" opt; do
  case $opt in
    n)
      name="$OPTARG"
      ;;
    m)
      model_file="$OPTARG"
      ;;
    \?)
      echo "必须同时提供 -n 和 -m 参数" >&2
      exit 1
      ;;
    :)
      echo "必须同时提供 -n 和 -m 参数" >&2
      exit 1
      ;;
  esac
done

# 确保参数已经提供
if [[ -z $name || -z $model_file ]]; then
  echo "必须同时提供 -n 和 -m 参数" >&2
  exit 1
fi

# 生成 Makefile
output_file="$name.mf"
echo "FROM ./$model_file" > "$output_file"

# 打印生成结果
echo "已生成："
echo ""
echo "  $output_file"
echo ""
echo "生成模型文件："
echo ""
echo "  ollama create $name -f ./$output_file"
echo ""
echo "运行大模型"
echo ""
echo "  ollama run $name"
echo ""
