class Pixu < Formula
  desc "Terminal image viewer - render images directly in your terminal"
  homepage "https://github.com/xvoland/pixu"
  url "https://github.com/xvoland/pixu/archive/refs/tags/v1.3.6.tar.gz"
  sha256 "03c1c8ec0fc89c3d6dbc6fe6e0a59469047c813e9ae9e5f3b22d08abf59fdb14"
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
