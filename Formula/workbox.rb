class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.1.2", revision: "e42ff03d6bb0b7d3a225083a70feac6ca67e5f2d"
  version "0.1.2"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8f80e594c56dd8fa7cd13e2e693d1534a82b408fc753e4ba3379b2d95c47d66e"
    sha256 cellar: :any_skip_relocation, sequoia:       "1907a5c3cfe9f0ccefe1f32c0e90c90d922e8509a77733ec56b14d6e76af5c1f"
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
