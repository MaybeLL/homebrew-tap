class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.5.0", revision: "116e3657046861853c7aeb7c02cc369f57c476ad"
  version "0.5.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2dad93556d9d4de2f22b96938308da62939863692f60009ee983b527a906f65d"
    sha256 cellar: :any_skip_relocation, sequoia:       "25704b71ccf391af17999198eda1134dfeff88b6efcc6e012d9be6d4d79daf31"
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
