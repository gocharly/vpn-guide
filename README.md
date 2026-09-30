# vpn-guide: Шаблон и автоматизация развертывания личного VPN (VLESS-Reality + 3X-UI)

Готовый шаблонный проект и скрипты автоматического развертывания персонального отказоустойчивого VPN на KVM VPS.

## Быстрый старт в 1 команду

Подключитесь к вашему VPS по SSH и выполните скрипт первичной подготовки и установки панели:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/gocharly/vpn-guide/main/scripts/install.sh)
```

Скрипт автоматически:
1. Обновит систему и установит нужные пакеты (`curl`, `socat`, `ufw`).
2. Настроит фаервол (откроет SSH `22`, VLESS `443` и панель `2053`).
3. Запустит официальный установщик **3X-UI**.

---

## Запуск через Docker Compose (Альтернатива)

Если предпочитаете контейнеризацию:

```bash
cd docker
docker compose up -d
```

---

## Настройка подключения VLESS-Reality в панели 3X-UI

1. Перейдите в браузере: `http://IP_СЕРВЕРА:2053`
2. Авторизуйтесь под созданным логином и паролем.
3. Раздел **Inbounds (Подключения)** -> **Add Inbound**:
   - **Protocol**: `vless`
   - **Port**: `443`
   - **Security**: `Reality`
   - Нажмите **Get New Cert** (генерация ключей `x25519`).
   - **Target / SNI**: `dl.google.com:443` / `dl.google.com`
   - **Short IDs**: сгенерируйте случайный ID.
   - **uTLS**: `chrome`
4. Нажмите **Create**.
5. Во вкладке клиентов нажмите кнопку **QR-код** или скопируйте ссылку `vless://...`.

---

## Клиентские приложения

- **Android**: [v2rayNG](https://github.com/2dust/v2rayNG)
- **iOS**: [Streisand](https://apps.apple.com/app/streisand/id6450534064) / [FoXray](https://apps.apple.com/app/foxray/id6448898396)
- **Windows / macOS / Linux**: [Hiddify](https://github.com/hiddify/hiddify-next)
