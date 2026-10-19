cask "meeting-companion" do
  version "1.6.0"
  sha256 "6eb08d16063301e2d6ba0ae5bc387301d8e44e12ef2b6862d1abf55f5c93c8b7"

  url "https://gitlab.lamoda.tech/api/v4/projects/3810/packages/generic/meeting-companion/#{version}/Meeting-Companion-#{version}-arm64.zip"
  name "Meeting Companion"
  desc "Local meeting audio recorder and transcriber"
  homepage "https://gitlab.lamoda.tech/bulat.fayzulin/meeting-companion"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Meeting Companion.app"

  preflight_steps do
    run "/bin/sh", args: ["-c", <<~SH]
      /usr/bin/pgrep -x MeetingCompanion >/dev/null
      status=$?
      if [ "$status" -eq 0 ]; then
        echo "Quit Meeting Companion from its menu bar menu before installing or updating." >&2
        exit 1
      fi
      [ "$status" -eq 1 ]
    SH
  end

  caveats <<~EOS
    This app requires Apple Silicon and macOS 15 or later.
    The app is not notarized by Apple. macOS may require approving its first
    launch in System Settings > Privacy & Security > Open Anyway.
    First launch downloads local speech models. Recordings and model caches
    are kept when the cask is uninstalled.
  EOS
end
