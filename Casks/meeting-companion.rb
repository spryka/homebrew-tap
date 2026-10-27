cask "meeting-companion" do
  version "1.7.2"
  sha256 "d63ee02bdb38b3637e09445dc470dceb2e60ac4a9b18d3a992e1578b00dbe972"

  url "https://github.com/spryka/meeting-companion/releases/download/v#{version}/Meeting-Companion-#{version}-arm64.zip"
  name "Meeting Companion"
  desc "Local meeting audio recorder and transcriber"
  homepage "https://github.com/spryka/meeting-companion"

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
    Download local speech models from the app before the first transcription.
    Recordings and model caches are kept when the cask is uninstalled.
  EOS
end
