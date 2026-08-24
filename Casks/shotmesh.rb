cask "shotmesh" do
  version "0.1.0"

  # arm64 và x64 build riêng (không universal) nên sha256/url tách theo chip.
  on_arm do
    sha256 "3f183051bca9434f9353a0ae033088f5510e0763deef56e59c4dc29ca13f9401"

    url "https://github.com/khiemk31/shotmesh-releases/releases/download/v#{version}/Shotmesh-#{version}-arm64.dmg",
        verified: "github.com/khiemk31/shotmesh-releases/"
  end
  on_intel do
    sha256 "3b711f1958eaceef85533828ffb2f02f516ab26eb28aa889d5da0412dce0c471"

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
