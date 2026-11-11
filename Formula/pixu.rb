class Pixu < Formula
  desc "Terminal image viewer - render images directly in your terminal"
  homepage "https://github.com/xvoland/pixu"
  url "https://github.com/xvoland/pixu/archive/refs/tags/v1.3.5.tar.gz"
  sha256 "9c6a137c2c83841fd16a32eb39809e95042ad388055a7b0594f8c4378c20a043"
  version "1.3.5"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version} -X main.buildSource=#{version}"
    system "go", "build", "-ldflags", ldflags, "-o", bin/"pixu", "."
    # Ad-hoc sign the binary on macOS (no Apple Developer cert needed) so that
    # Gatekeeper accepts it without the "developer cannot be verified" prompt
    # and users no longer need `xattr -dr com.apple.quarantine`.
    if OS.mac?
      system "codesign", "--force", "--timestamp=none", "--sign", "-", bin/"pixu"
      # Strip any quarantine attribute inherited from the downloaded source.
      system "xattr", "-dr", "com.apple.quarantine", bin/"pixu" rescue nil
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixu --version")
  end
end
