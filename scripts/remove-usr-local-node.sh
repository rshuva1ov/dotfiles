#!/usr/bin/env bash
# Удаление старого Node.js с nodejs.org из /usr/local (нужен пароль sudo).
# Запуск: ./scripts/remove-usr-local-node.sh

set -euo pipefail

echo "Будут удалены бинарники и npm из /usr/local (установщик nodejs.org)."
echo "Активный Node должен быть из: $(command -v node 2>/dev/null || echo 'не найден')"
read -r -p "Продолжить? [y/N] " ans
[[ "${ans,,}" == y || "${ans,,}" == yes ]] || exit 0

sudo rm -f /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npx
sudo rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/corepack
rmdir /usr/local/lib/node_modules 2>/dev/null || true

echo "Готово. Проверка:"
which -a node npm 2>/dev/null || true
node -v
npm -v
