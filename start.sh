#!/bin/bash
echo "=========================================================="
echo " Запуск Minecraft Fabric 1.20.1 + Pehkui + CPM (5 ГБ RAM)"
echo "=========================================================="

# Копируем измерения Незера и Энда в формат Vanilla/Fabric при первом запуске
if [ -d "world_nether/DIM-1" ] && [ ! -d "world/DIM-1" ]; then
  echo "[MIGRATION] Копирование Nether в формат Fabric..."
  cp -r world_nether/DIM-1 world/
fi
if [ -d "world_the_end/DIM1" ] && [ ! -d "world/DIM1" ]; then
  echo "[MIGRATION] Копирование The End в формат Fabric..."
  cp -r world_the_end/DIM1 world/
fi

exec java -Xms3G -Xmx5G \
  -XX:+UseG1GC \
  -XX:+ParallelRefProcEnabled \
  -XX:MaxGCPauseMillis=200 \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+DisableExplicitGC \
  -XX:+AlwaysPreTouch \
  -XX:G1NewSizePercent=30 \
  -XX:G1MaxNewSizePercent=40 \
  -XX:G1ReservePercent=20 \
  -XX:G1HeapWastePercent=5 \
  -XX:G1MixedGCCountTarget=4 \
  -XX:InitiatingHeapOccupancyPercent=15 \
  -XX:G1MixedGCLiveThresholdPercent=90 \
  -XX:G1RSetUpdatingPauseTimePercent=5 \
  -XX:SurvivorRatio=32 \
  -XX:+PerfDisableSharedMem \
  -XX:MaxTenuringThreshold=1 \
  -jar fabric-server-launch.jar nogui
