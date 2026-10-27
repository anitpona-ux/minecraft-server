#!/bin/bash
set -e

echo "=========================================================="
echo "      Minecraft Paper 1.20.1 Auto-Setup Script            "
echo "=========================================================="

echo "[1/5] Установка Java 21 и утилит..."
if command -v apk >/dev/null 2>&1; then
  sudo apk update
  sudo apk add --no-cache openjdk21-jre-headless tmux curl wget bash gcompat libstdc++
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y openjdk-21-jre-headless tmux curl wget bash
fi

echo "[2/5] Создание структуры папок..."
mkdir -p mods config

echo "[3/5] Скачивание Fabric Server 1.20.1 (Loader 0.16.10)..."
if [ ! -f "fabric-server-launch.jar" ]; then
  curl -fsSL -o fabric-server-launch.jar "https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.16.10/1.0.1/server/jar"
fi

echo "[4/5] Скачивание модов Fabric (Fabric API, Pehkui, CPM, VoiceChat, Lithium, FerriteCore)..."
curl -fsSL -o mods/fabric-api.jar "https://cdn.modrinth.com/data/P7dR8mSH/versions/rvI2dfzR/fabric-api-0.92.12%2B1.20.1.jar"
curl -fsSL -o mods/Pehkui.jar "https://cdn.modrinth.com/data/t5W7Jfwy/versions/6fzxx6SC/Pehkui-3.8.3%2B1.14.4-1.21.jar"
curl -fsSL -o mods/CustomPlayerModels.jar "https://cdn.modrinth.com/data/h1E7sQNL/versions/3XedKRav/CustomPlayerModels-Fabric-1.20-0.6.27a.jar"
curl -fsSL -o mods/voicechat.jar "https://cdn.modrinth.com/data/9eGKb6K1/versions/moiHjUsv/voicechat-fabric-1.20.1-2.6.26.jar"
curl -fsSL -o mods/lithium.jar "https://cdn.modrinth.com/data/gvQqBUqZ/versions/iEcXOkz4/lithium-fabric-mc1.20.1-0.11.4.jar"
curl -fsSL -o mods/ferritecore.jar "https://cdn.modrinth.com/data/uXXizFIs/versions/unerR5MN/ferritecore-6.0.1-fabric.jar"
curl -fsSL -o mods/Chunky.jar "https://cdn.modrinth.com/data/fALzjamp/versions/NHWYq9at/Chunky-1.3.146.jar"

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
