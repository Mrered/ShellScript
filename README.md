# ShellScript

![CI](https://github.com/Mrered/ShellScript/actions/workflows/release.yml/badge.svg) ![license](https://img.shields.io/github/license/Mrered/ShellScript) ![code-size](https://img.shields.io/github/languages/code-size/Mrered/ShellScript) ![repo-size](https://img.shields.io/github/repo-size/Mrered/ShellScript)

## 内容

|   脚本名称    |             介绍             |
| :-----------: | :--------------------------: |
|   `makemf`    |         生成Makefile         |
| `ollamaplist` | 使 Ollama Serve 监听 0.0.0.0 |

## 搭配 Homebrew 使用

```sh
brew install --formula brewforge/chinese/<脚本名称>
```

## 用法

- makemf

```sh
cd <包含 GGUF 文件的路径>
makemf -n <要生成的 Makefile 名称> -m <GGUF 文件名称，包含后缀名>
```

- ollamaplist

```sh
ollamaplist
```
