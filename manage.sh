#!/bin/bash
set -e

DIR="/workspaces/minecraft-server"
cd "$DIR"

case "$1" in
  start)
    if tmux has-session -t mc 2>/dev/null; then
      echo "[INFO] Сервер Minecraft УЖЕ ЗАПУЩЕН в сессии mc."
    else
      echo "[INFO] Запуск Minecraft сервера (Paper 1.20.1)..."
      tmux new-session -d -s mc './start.sh'
      echo "[OK] Сервер Minecraft успешно запущен!"
    fi

    if tmux has-session -t tunnel 2>/dev/null; then
      echo "[INFO] Туннель Playit УЖЕ ЗАПУЩЕН."
    else
      echo "[INFO] Запуск туннеля Playit..."
      tmux new-session -d -s tunnel 'bash run-tunnel.sh'
      echo "[OK] Туннель Playit успешно запущен!"
    fi
    ;;

  stop)
    echo "[INFO] Сохранение миров и остановка сервера..."
    tmux send-keys -t mc 'stop' C-m 2>/dev/null || true
    sleep 6
    if tmux has-session -t mc 2>/dev/null; then
      tmux kill-session -t mc 2>/dev/null || true
    fi
    echo "[OK] Сервер Minecraft безопасно остановлен."
    ;;

  restart)
    echo "[1/3] Остановка сервера..."
    tmux send-keys -t mc 'stop' C-m 2>/dev/null || true
    sleep 6
    tmux kill-session -t mc 2>/dev/null || true

    echo "[2/3] Запуск сервера..."
    tmux new-session -d -s mc './start.sh'
    echo "[OK] Сервер перезапущен в фоновой сессии mc."

    echo "[3/3] Ожидание инициализации мира (8 сек)..."
    sleep 8
    tail -n 8 logs/latest.log 2>/dev/null || true
    ;;

  status)
    echo "=== Активные сессии tmux ==="
    tmux ls 2>/dev/null || echo "Нет активных сессий!"
    echo ""
    echo "=== Память RAM ==="
    free -h
    echo ""
    echo "=== Запрос TPS ==="
    tmux send-keys -t mc 'tps' C-m 2>/dev/null || true
    sleep 1
    tail -n 5 logs/latest.log 2>/dev/null || true
    echo ""
    echo "=== Активные туннели Playit ==="
    ./playit tunnels list 2>/dev/null || true
    ;;

  *)
    echo "Использование: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac
