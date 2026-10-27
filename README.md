# 🎮 Minecraft Paper 1.20.1 Server (Codespaces Ready)

Полностью настроенный и оптимизированный сервер Minecraft **Paper 1.20.1** для запуска в **GitHub Codespaces**.

## 📦 Что включено:
- **Ядро**: [Paper 1.20.1 (Build 196)](https://papermc.io/)
- **Оптимизация**: Тонкая настройка тиков мобов, чанков и параметров Aikar's Flags (G1GC, 6 ГБ RAM)
- **Плагины**:
  - 🎙️ **Simple Voice Chat** (версия для Bukkit/Paper)
  - 🎨 **Custom Player Models (CPM)** (версия для Bukkit/Paper)
- **Туннелирование**: Утилита `Playit.gg` для подключения друзей без белого IP и проброса портов

---

## 🚀 Как запустить в GitHub Codespaces:
1. Создайте Codespace на базе этого репозитория (`Create codespace on main`).
2. При создании Codespace автоматически выполнится скрипт `setup.sh` (скачает ядро и плагины).
3. В терминале Codespace введите:
   ```bash
   ./start.sh
   ```
4. Для подключения друзей через `Playit.gg` (в отдельной вкладке терминала):
   ```bash
   ./run-tunnel.sh
   ```
   Перейдите по сгенерированной ссылке `claim`, и вам выдадут постоянный адрес (например, `xxx.joinmc.link`).
