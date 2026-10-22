class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.3.0", revision: "01b04446b3abbaeec4d6ec997be96d5a134dcef8"
  version "0.3.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1c5d140d7bafab2e179de94776184ebfd4ba9e5fe43094a8261e5e385c2746c3"
    sha256 cellar: :any_skip_relocation, sequoia:       "b94abf617709d002bfb43cd44b446c0b9d44f3960d3f4697ba914bb50c953f16"
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
