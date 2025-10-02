#!/bin/bash

NEW_PASS=$(openssl rand -base64 12 | tr -dc 'A-Za-z0-9' | head -c16)

sed -i "s/example/$NEW_PASS/g" compose.yml

echo "已将 compose.yml 中的数据库密码替换为: $NEW_PASS"

ufw allow 9987
ufw allow 10011
ufw allow 30033

ufw status | grep 9987
ufw status | grep 10011
ufw status | grep 30033
