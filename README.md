# Homebrew tap

Готовые приложения для macOS. Сборка исходников и Xcode не нужны.
Для доступа к gitlab.lamoda.tech может понадобиться корпоративная сеть или VPN.
Проекты публичные: токен GitLab для скачивания не требуется.

## Подключение и установка

Нужен установленный [Homebrew](https://brew.sh).
Один раз подключи репозиторий:

```sh
brew tap bulat/apps https://gitlab.lamoda.tech/bulat.fayzulin/homebrew-tap.git
```

Установи приложение:

```sh
brew install --cask bulat/apps/meeting-companion
```

Meeting Companion требует Mac с процессором M-серии и macOS 15+.
Перед установкой и обновлением заверши приложение через меню в строке меню.
При первом запуске разреши микрофон и системный звук; календарь необязателен.
Приложение скачает модели, затем транскрибация работает локально без интернета.

Приложение пока без Apple notarization. Если macOS блокирует первый запуск,
открой "Системные настройки → Конфиденциальность и безопасность → Всё равно открыть".
Не отключай Gatekeeper. На корпоративном Mac запуск может ограничиваться политикой компании.

## Если приложение уже установлено вручную

Для той же версии и идентичного содержимого можно передать установку Homebrew:

```sh
brew install --cask --adopt bulat/apps/meeting-companion
```

Если Homebrew сообщает, что файлы отличаются, не используй `--force` вслепую.
Заверши приложение и сохрани старый `.app` вне `/Applications`, затем выполни
обычную установку. Записи и модели находятся отдельно от приложения.
Смена сертификата подписи при обновлении может потребовать заново выдать разрешения macOS.

## Обновление

```sh
brew update
brew upgrade --cask bulat/apps/meeting-companion
```

Обновления устанавливаются по команде, приложение само их не скачивает.

## Удаление

```sh
brew uninstall --cask bulat/apps/meeting-companion
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

3. Загрузи архив в Generic Package Registry проекта Meeting Companion (ID 3810):
   пакет `meeting-companion`, версия `VERSION`, файл `Meeting-Companion-VERSION-arm64.zip`.
   Опубликованные архивы не перезаписывай; для другой сборки выпускай новую версию.
4. Обнови `version` и `sha256` в `Casks/meeting-companion.rb` и проверь:

   ```sh
   brew style Casks/meeting-companion.rb
   brew fetch --cask bulat/apps/meeting-companion
   ```

5. Закоммить и отправь изменение в этот репозиторий. После `brew update`
   пользователи увидят новую версию. Один тег приложения сам по себе cask не обновляет.

Не добавляй в рецепты токены, сертификаты, ключи или удаление пользовательских данных.
