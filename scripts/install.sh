#!/usr/bin/env bash
set -euo pipefail

# VPN Server Quick Bootstrap (Ubuntu 22.04 / 24.04)
# Automates packages, security, ufw firewall, and 3X-UI installation

echo "=== [1/4] Обновление системы ==="
export DEBIAN_FRONTEND=noninteractive
apt update -y && apt upgrade -y

echo "=== [2/4] Установка базовых утилит ==="
apt install -y curl wget socat ufw tar jq git

echo "=== [3/4] Настройка фаервола UFW ==="
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp comment 'SSH'
ufw allow 443/tcp comment 'VLESS-Reality'
ufw allow 2053/tcp comment '3X-UI Web Panel'
ufw --force enable

echo "=== [4/4] Запуск официального скрипта 3X-UI ==="
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)

echo "=== Установка завершена! ==="
echo "Панель доступна по адресу: http://$(curl -s4 ifconfig.me):2053"
