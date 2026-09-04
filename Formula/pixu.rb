class Pixu < Formula
  desc "Terminal image viewer - render images directly in your terminal"
  homepage "https://github.com/xvoland/pixu"
  url "https://github.com/xvoland/pixu/archive/refs/tags/v1.3.6.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  version "1.3.6"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version} -X main.buildSource=#{version}"
    system "go", "build", "-ldflags", ldflags, "-o", bin/"pixu", "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixu --version")
  end
end
