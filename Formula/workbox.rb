class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.6.0", revision: "9ba7bcebca8387381ea0ab3f50ffce7a9c8ec76d"
  version "0.6.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c1e28eedb2536ea13e2f7aacf4a913433307fb881cb0017f166ec24c1fdfcbe1"
    sha256 cellar: :any_skip_relocation, sequoia:       "fd23af38ac7b09a5e7f0c104a9ea517c45898efcd180c19258c2ca93c418db5c"
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
