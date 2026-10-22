class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.3.1", revision: "5a62db348aa97daa36c0a06189da7326c9116ab5"
  version "0.3.1"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "312026803f376acbfed0b3b2d85e0e58fa87ebc36a8cd6945cabae230f4b984d"
    sha256 cellar: :any_skip_relocation, sequoia:       "c2116fab04a486179e4647be7530e8ce810986da521cf68334d0617b8ca2982e"
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
