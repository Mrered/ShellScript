#!/bin/bash

# 指定目标文件路径
target_file="/opt/homebrew/opt/ollama/homebrew.mxcl.ollama.plist"

# 将给定的 XML 内容赋值给一个变量
xml_content='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>EnvironmentVariables</key>
    <dict>
        <key>OLLAMA_HOST</key>
        <string>0.0.0.0</string>
    </dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>homebrew.mxcl.ollama</string>
    <key>LimitLoadToSessionType</key>
    <array>
        <string>Aqua</string>
        <string>Background</string>
        <string>LoginWindow</string>
        <string>StandardIO</string>
        <string>System</string>
    </array>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/opt/ollama/bin/ollama</string>
        <string>serve</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>/opt/homebrew/var/log/ollama.log</string>
    <key>StandardOutPath</key>
    <string>/opt/homebrew/var/log/ollama.log</string>
    <key>WorkingDirectory</key>
    <string>/opt/homebrew/var</string>
</dict>
</plist>'

# 使用 echo 将 XML 内容写入目标文件
echo "$xml_content" > "$target_file"

# 输出完成信息
echo "文件已成功写入：$target_file"
