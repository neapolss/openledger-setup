#!/bin/bash

# Удаление старых версий Docker
sudo apt remove -y docker docker-engine docker.io containerd runc

# Установка необходимых зависимостей
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Добавление ключа GPG и репозитория Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Установка Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Проверка версии Docker
sudo docker --version

# Установка дополнительных библиотек
sudo apt update
sudo apt install -y libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0

# Скачивание OpenLedger
wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip

# Установка unzip и screen
sudo apt install -y unzip screen

# Распаковка OpenLedger
unzip openledger-node-1.0.0-linux.zip

# Установка OpenLedger
sudo dpkg -i openledger-node-1.0.0.deb

# Исправление возможных зависимостей
sudo apt-get install -f

# Установка дополнительных инструментов
sudo apt-get install -y desktop-file-utils
sudo dpkg --configure -a
sudo apt-get install -y libgbm1
sudo apt-get install -y libasound2

# Добавление текущего пользователя в группу Docker
sudo usermod -aG docker ubuntu

# Перезагрузка системы
sudo reboot
