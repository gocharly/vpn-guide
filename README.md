# vpn-guide

Автоматизация и шаблон быстрого развертывания личного VPN (VLESS-Reality + 3X-UI) на KVM VPS.

---

## 1. Развертывание в одну команду

Подключитесь к VPS по SSH и запустите:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/gocharly/vpn-guide/main/scripts/install.sh)
```

Что делает скрипт:
- Обновляет пакеты и ставит `curl`, `socat`, `ufw`.
- Открывает только нужные порты: `22` (SSH), `443` (VLESS-Reality), `2053` (Панель).
- Ставит веб-панель **3X-UI** и предлагает задать логин/пароль.

---

## 2. Настройка подключения (VLESS-Reality)

1. Откройте панель в браузере: `http://IP_СЕРВЕРА:2053`
2. Перейдите в **Inbounds** -> **Add Inbound**.
3. Заполните параметры по таблице ниже:

| Параметр | Значение | Зачем нужно |
| :--- | :--- | :--- |
| **Protocol** | `vless` | Быстрый легковесный протокол без лишнего оверхеда |
| **Port** | `443` | Стандартный HTTPS-порт (не триггерит фильтры) |
| **Security** | `Reality` | Маскировка под реальный веб-трафик |
| **Cert** | Нажать `Get New Cert` | Панель сгенерирует ключи шифрования `x25519` |
| **Target** | `dl.google.com:443` | Сервер-маскировка (должен поддерживать TLS 1.3) |
| **SNI** | `dl.google.com` | Должен совпадать с Target |
| **uTLS** | `chrome` | Отпечаток браузера для обхода эвристик |

4. Нажмите **Create**.
5. Нажмите на иконку **QR-код** в строке клиента для подключения телефона или ПК.

---

## 3. Альтернатива: запуск в Docker

Если предпочитаете Docker Compose вместо системного демона:

```bash
git clone https://github.com/gocharly/vpn-guide.git
cd vpn-guide/docker
docker compose up -d
```

---

## 4. Клиенты для подключения

| Платформа | Приложение | Как подключить |
| :--- | :--- | :--- |
| **iOS** | [Streisand](https://apps.apple.com/app/streisand/id6450534064) / [FoXray](https://apps.apple.com/app/foxray/id6448898396) | Нажать `+` -> Сканировать QR |
| **Android** | [v2rayNG](https://github.com/2dust/v2rayNG) | Нажать `+` -> Сканировать QR |
| **macOS / Windows** | [Hiddify](https://github.com/hiddify/hiddify-next) | Добавить из буфера обмена (`vless://...`) |

---

## 5. Проверка работы соединения

После подключения проверьте исходящий IP и отсутствие утечек DNS:

```bash
# Проверка IP через терминал (должен вернуть IP вашего VPS)
curl -4 ifconfig.me
```

Либо откройте в браузере `2ip.io` или `browserleaks.com/ip`.

---

<div align="center">
  <sub>реализовано by <a href="https://t.me/gitmash"><b>@gitmash</b></a></sub>
</div>
