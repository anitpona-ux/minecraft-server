#!/bin/bash
set -e

echo "=========================================================="
echo "      Minecraft Paper 1.20.1 Auto-Setup Script            "
echo "=========================================================="

echo "[1/5] Установка Java 17 и утилит..."
if command -v apk >/dev/null 2>&1; then
  sudo apk update
  sudo apk add --no-cache openjdk17-jre-headless tmux curl wget bash gcompat libstdc++
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y openjdk-17-jre-headless tmux curl wget bash
fi

echo "[2/5] Создание структуры папок..."
mkdir -p plugins config

echo "[3/5] Скачивание Paper 1.20.1 (Build 196)..."
if [ ! -f "paper-1.20.1.jar" ]; then
  curl -fsSL -o paper-1.20.1.jar "https://fill-data.papermc.io/v1/objects/234a9b32098100c6fc116664d64e36ccdb58b5b649af0f80bcccb08b0255eaea/paper-1.20.1-196.jar"
fi

echo "[4/5] Скачивание плагинов Simple Voice Chat и Custom Player Models..."
curl -fsSL -o plugins/voicechat-bukkit.jar "https://cdn.modrinth.com/data/9eGKb6K1/versions/CxMI5WBR/voicechat-bukkit-2.6.26.jar"
curl -fsSL -o plugins/CustomPlayerModels-Bukkit.jar "https://cdn.modrinth.com/data/h1E7sQNL/versions/srG0b8oU/CustomPlayerModels-Bukkit-0.6.20a.jar"

echo "[5/5] Скачивание агента туннелирования Playit.gg..."
if [ ! -f "playit" ]; then
  curl -fsSL -o playit "https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64"
  chmod +x playit
fi

chmod +x start.sh run-tunnel.sh 2>/dev/null || true

echo "=========================================================="
echo " Установка завершена успешно!"
echo " Для запуска сервера введите: ./start.sh"
echo " Для подключения друзей введите в новом окне: ./run-tunnel.sh"
echo "=========================================================="
