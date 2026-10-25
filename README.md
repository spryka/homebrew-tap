# Homebrew tap

Готовые приложения для macOS. Сборка исходников и Xcode не нужны.
Публичные релизы доступны на GitHub без корпоративной сети и токенов.

## Подключение и установка

Нужен установленный [Homebrew](https://brew.sh).
Сначала обнови Homebrew, затем один раз подключи репозиторий:

```sh
brew update
brew tap spryka/tap
```

Установи приложение:

```sh
brew install --cask spryka/tap/meeting-companion
```

Если Homebrew сообщает `Refusing to load cask ... from untrusted tap`,
разреши загрузку этого рецепта и повтори установку:

```sh
brew trust --cask spryka/tap/meeting-companion
brew install --cask spryka/tap/meeting-companion
```

Meeting Companion требует Mac с процессором M-серии и macOS 15+.
Перед установкой и обновлением заверши приложение через меню в строке меню.
При первом запуске разреши микрофон и системный звук; календарь необязателен.
Перед первой транскрибацией нажми "Скачать модели" в основном окне.
После подготовки транскрибация работает локально без интернета.

Приложение пока без Apple notarization. Если macOS блокирует первый запуск,
открой "Системные настройки → Конфиденциальность и безопасность → Всё равно открыть".
Не отключай Gatekeeper. На корпоративном Mac запуск может ограничиваться политикой компании.

## Если приложение уже установлено вручную

Для той же версии и идентичного содержимого можно передать установку Homebrew:

```sh
brew install --cask --adopt spryka/tap/meeting-companion
```

Если Homebrew сообщает, что файлы отличаются, не используй `--force` вслепую.
Заверши приложение и сохрани старый `.app` вне `/Applications`, затем выполни
обычную установку. Записи и модели находятся отдельно от приложения.
Смена сертификата подписи при обновлении может потребовать заново выдать разрешения macOS.

## Обновление

```sh
brew update
brew upgrade --cask spryka/tap/meeting-companion
```

Обновления устанавливаются по команде, приложение само их не скачивает.

## Удаление

```sh
brew uninstall --cask spryka/tap/meeting-companion
```

Записи, настройки и скачанные модели сохраняются.

## Для разработчиков

Каждому приложению соответствует отдельный рецепт `Casks/<name>.rb`.
Он содержит версию, URL готового архива, SHA-256 и системные требования.

Новая версия Meeting Companion:

1. Собери приложение на Apple Silicon из релизного тега штатным
   `scripts/build-app.sh`. Используй прежний сертификат подписи.
2. Упакуй готовое приложение, сохраняя его подпись:

   ```sh
   ditto -c -k --sequesterRsrc --keepParent "dist/Meeting Companion.app" "dist/Meeting-Companion-VERSION-arm64.zip"
   shasum -a 256 "dist/Meeting-Companion-VERSION-arm64.zip"
   ```

3. Загрузи архив в [GitHub Releases](https://github.com/spryka/meeting-companion/releases)
   с тегом `vVERSION`, файл `Meeting-Companion-VERSION-arm64.zip`.
   Опубликованные архивы не перезаписывай; для другой сборки выпускай новую версию.
4. Обнови `version` и `sha256` в `Casks/meeting-companion.rb` и проверь:

   ```sh
   brew style Casks/meeting-companion.rb
   brew fetch --cask spryka/tap/meeting-companion
   ```

5. Закоммить и отправь изменение в этот репозиторий. После `brew update`
   пользователи увидят новую версию. Один тег приложения сам по себе cask не обновляет.

Не добавляй в рецепты токены, сертификаты, ключи или удаление пользовательских данных.

## Переход с GitLab

Если tap уже подключён как `bulat/apps`, поменяй адрес и обнови его:

```sh
brew tap --custom-remote bulat/apps https://github.com/spryka/homebrew-tap.git
brew update
brew upgrade --cask bulat/apps/meeting-companion
```

Это сохраняет имя tap для уже установленных приложений. Новые установки
используют `spryka/tap`.
