#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "使用方法: $0 -n <模型名称> -m <模型文件>"
  exit 1
fi

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

if [[ -z $name || -z $model_file ]]; then
  echo "必须同时提供 -n 和 -m 参数" >&2
  exit 1
fi

output_file="$name.mf"
echo "FROM ./$model_file" > "$output_file"

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
