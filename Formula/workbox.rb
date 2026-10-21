class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.1.1", revision: "028fb153bb905c2acbee6e0eb715081040e12304"
  version "0.1.1"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "74e7e4f8937f0d91822aed9d078e4e7ba7531b5d9aef56cae210ed9c7fae227d"
    sha256 cellar: :any_skip_relocation, sequoia:       "f9fcbcdc229e1d02bb9ead0206c7929e93e27a47a3e26c3122b50659ff92c9f0"
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
