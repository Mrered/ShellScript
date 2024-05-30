#!/bin/zsh

# 打印生成结果的函数
print_result() {
  local output_file=$1
  local name=${output_file%.mf}
  
  echo "已生成：$output_file"
  echo ""
  echo "生成模型文件："
  echo ""
  echo "  ollama create $name -f ./$output_file"
  echo ""
  echo "运行大模型："
  echo ""
  echo "  ollama run $name"
  echo ""
}

# 检查是否需要显示帮助信息
if [[ $1 == "help" || $1 == "-h" ]]; then
  echo "用法："
  echo "  makemf -n <要生成的 Makefile 名称> -m <GGUF 文件名称，包含后缀名>"
  echo "  makemf -a  # 自动为当前目录下的所有 .gguf 文件生成 Makefile"
  exit 0
fi

# 检查参数数量
if [[ $# -eq 0 ]]; then
  echo "使用方法: $0 -n <模型名称> -m <模型文件> 或 $0 -a"
  exit 1
fi

# 解析命令行参数
while getopts ":n:m:a" opt; do
  case $opt in
    n)
      name="$OPTARG"
      ;;
    m)
      model_file="$OPTARG"
      ;;
    a)
      auto_mode=true
      ;;
    \?)
      echo "无效的选项: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "选项 -$OPTARG 需要一个参数" >&2
      exit 1
      ;;
  esac
done

# 扫描当前目录下的所有 .gguf 文件
gguf_files=(*.gguf)

# 自动模式：为每个 .gguf 文件生成一个 Makefile
if [[ $auto_mode == true ]]; then
  for file in "${gguf_files[@]}"; do
    output_file="${file%.gguf}.mf"
    echo "FROM ./$file" > "$output_file"
    print_result "$output_file"
  done
  exit 0
fi

# 非自动模式：确保参数已经提供
if [[ -z $name || -z $model_file ]]; then
  echo "必须同时提供 -n 和 -m 参数，或者使用 -a 参数" >&2
  exit 1
fi

# 生成 Makefile
output_file="$name.mf"
echo "FROM ./$model_file" > "$output_file"
print_result "$output_file"

# 如果没有使用 -a 参数，列出当前目录的所有 .gguf 文件，并让用户选择生成 Makefile 的文件
if [[ $auto_mode != true ]]; then
  echo "当前目录下的 .gguf 文件："
  for i in "${!gguf_files[@]}"; do
    echo "$((i+1)). ${gguf_files[$i]}"
  done
  echo "请输入文件序号（多个序号用空格隔开，或使用 1-3 表示连续序号）："
  read -r user_input

  # 解析用户输入的序号
  selected_files=()
  for input in $user_input; do
    if [[ $input =~ ^[0-9]+$ ]]; then
      selected_files+=("${gguf_files[$((input-1))]}")
    elif [[ $input =~ ^[0-9]+-[0-9]+$ ]]; then
      start=$(echo $input | cut -d'-' -f1)
      end=$(echo $input | cut -d'-' -f2)
      for ((i=start; i<=end; i++)); do
        selected_files+=("${gguf_files[$((i-1))]}")
      done
    fi
  done

  # 为选定的文件生成 Makefile
  for file in "${selected_files[@]}"; do
    output_file="${file%.gguf}.mf"
    echo "FROM ./$file" > "$output_file"
    print_result "$output_file"
  done
fi
