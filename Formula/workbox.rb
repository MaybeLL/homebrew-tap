class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.1.0", revision: "8e15a8e61a42a5bbc7f5df3b02d875e32bde90d7"
  version "0.1.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "52c8dafa0cc105ccea7932b749452c0ec254e12cb7e0217b945afc61ae0e841c"
    sha256 cellar: :any_skip_relocation, sequoia:       "90db3349fd65bcf7b8b4cba94a1685d3fcf45b830c9b8dddf0ba4dbd51e2a9e8"
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
