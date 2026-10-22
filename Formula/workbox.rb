class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.1.3", revision: "9d17a8709875cb02aac05e39b8980fa187b5716d"
  version "0.1.3"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.1.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "06e1790731abaf8c10fccdb11e8c85904bc642c988ce4f08c5c6d9ce84c33683"
    sha256 cellar: :any_skip_relocation, sequoia:       "7e94e1f78a7accb017b4ee501e15b84d9e7796df611a40f6704e2685323d9c27"
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
