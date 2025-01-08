#!/bin/bash

# Удаление старых версий Docker
sudo apt remove -y docker docker-engine docker.io containerd runc

# Установка зависимостей
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Добавление ключа GPG Docker и репозитория
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Установка Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo docker --version

# Добавление пользователя в группу Docker
sudo usermod -aG docker ubuntu

# Перезагрузка системы
echo "Перезагрузка системы для применения изменений..."
sudo reboot

# После перезагрузки продолжите выполнение:
if [ "$1" == "continue" ]; then
    # Проверка Docker
    docker ps

    # Установка дополнительных библиотек
    sudo apt update
    sudo apt install -y libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0
    sudo apt install -y libgbm1 || sudo apt install -y libasound2

    # Загрузка OpenLedger
    wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip

    # Установка зависимостей для OpenLedger
    sudo apt install -y unzip screen
    unzip openledger-node-1.0.0-linux.zip
    sudo dpkg -i openledger-node-1.0.0.deb || sudo apt-get install -f -y
    sudo apt-get install -y desktop-file-utils
    sudo dpkg --configure -a

    # Запуск в screen-сессии
    screen -dmS openledger_node openledger-node --no-sandbox
    echo "OpenLedger успешно установлен и запущен!"
fi
