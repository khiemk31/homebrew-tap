cask "shotmesh" do
  version "0.1.2"

  # arm64 và x64 build riêng (không universal) nên sha256/url tách theo chip.
  on_arm do
    sha256 "3250336c09f06075069c2813d0fb20791a56924f96c261a0649fae99ca7a00b6"

    url "https://github.com/khiemk31/shotmesh-releases/releases/download/v#{version}/Shotmesh-#{version}-arm64.dmg",
        verified: "github.com/khiemk31/shotmesh-releases/"
  end
  on_intel do
    sha256 "38bff652181307e23128fc50aa96c43921356238c077dfcf75e9354be6da6c4a"

    url "https://github.com/khiemk31/shotmesh-releases/releases/download/v#{version}/Shotmesh-#{version}.dmg",
        verified: "github.com/khiemk31/shotmesh-releases/"
  end

  name "Shotmesh"
  desc "Screenshot editor and mockup designer"
  homepage "https://shotmesh.com/"

  app "Shotmesh.app"

  # Bản dev preview chưa ký Developer ID / notarize, nên Gatekeeper sẽ báo
  # "app is damaged" nếu còn cờ quarantine. Homebrew 6 đã bỏ cả --no-quarantine
  # lẫn stanza quarantine trong DSL, nên gỡ cờ ở postflight là cách duy nhất
  # còn lại để `brew install` chạy một lệnh là xong.
  # BỎ KHỐI NÀY khi app đã được ký + notarize thật.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Shotmesh.app"]
  end

  zap trash: [
    "~/Library/Application Support/Shotmesh",
    "~/Library/Preferences/com.shotmesh.app.plist",
    "~/Library/Saved Application State/com.shotmesh.app.savedState",
  ]
end
