#!/bin/bash
if [ ! -f "playit" ]; then
  curl -fsSL -o playit "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64"
  chmod +x playit
fi

echo "=========================================================="
echo " Запуск Playit.gg (публичный туннель без открытия портов)"
echo " Перейдите по ссылке claim, чтобы привязать домен!"
echo "=========================================================="

./playit
