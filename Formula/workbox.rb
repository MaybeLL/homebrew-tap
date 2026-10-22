class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.3.2", revision: "bbd841018989e3650a86314ca205b09ea99af669"
  version "0.3.2"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b1f7f1661f30e2b4cb00cbd22348a3800801fc2395a8af33fc35c31b0092555c"
    sha256 cellar: :any_skip_relocation, sequoia:       "4c6fa97ff7d57102969c5d5f4530d3a0d2d456fc64c42b20ed948bff6aa36d3e"
  end

  depends_on "go" => :build
  uses_from_macos "git"

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/workbox"
    system "go", "run", "./tools/release", "--notices-output", "THIRD_PARTY_NOTICES.txt"
    doc.install "THIRD_PARTY_NOTICES.txt", "docs"
    pkgshare.install "scripts/check-install.sh"
  end

  test do
    system "sh", pkgshare/"check-install.sh", bin/"workbox"
  end
end
