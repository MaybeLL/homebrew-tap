class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.4.0", revision: "992cc18131fcb820600c6f30ea137ec9e2e9d8aa"
  version "0.4.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "19a69b1ff84bde6f20108f1f2b9709040132a28e2931d23fbae264aa3d5c7d34"
    sha256 cellar: :any_skip_relocation, sequoia:       "a5c68f6870677c0403fc9a8db1c06038439c94c8c98fa2439def771f718c4d4c"
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
