#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "错误：此脚本必须以 root 权限运行!" 
   exit 1
fi

NEW_PASS=$(openssl rand -base64 24 | tr -dc 'A-Za-z0-9' | head -c16)

TARGET_FILE="compose.yml"
if [ -f "$TARGET_FILE" ]; then
    sed -i "s/example/$NEW_PASS/g" "$TARGET_FILE"
    echo "✅ 已将 $TARGET_FILE 中的数据库密码替换为: $NEW_PASS"
else
    echo "❌ 错误：未找到 $TARGET_FILE 文件，替换失败！"
fi

PORTS=(9987 10011 30033)

echo "--- 正在配置防火墙 ---"

# 5. 循环执行开放指令
for port in "${PORTS[@]}"; do
    ufw allow "$port" > /dev/null 2>&1
done

ALL_SUCCESS=true
UFW_STATUS=$(ufw status)

for port in "${PORTS[@]}"; do
    if echo "$UFW_STATUS" | grep -qw "$port"; then
        echo "[OK] 端口 $port 已确认开启"
    else
        echo "[FAIL] 端口 $port 开启失败"
        ALL_SUCCESS=false
    fi
done

echo "-----------------------"


if [ "$ALL_SUCCESS" = true ]; then
    echo "🎉 恭喜！所有端口设置成功并已生效。"
else
    echo "⚠️  警告：部分端口未能正确配置，请检查 ufw 是否已启用 (ufw status)。"
fi