class Workbox < Formula
  desc "Reusable configurations and local Workbox instance preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.7.0", revision: "351c01e014238e8176c00c7fb931656104eaba44"
  version "0.7.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cd27c9c51c564ad36042e415def9be502686f116faae2fda609c6aea780d4f06"
    sha256 cellar: :any_skip_relocation, sequoia:       "51379a717dd8fa3af0c2022e1d2895f665dba4883150d5a20bb6c40625dad55c"
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
