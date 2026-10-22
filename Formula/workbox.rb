class Workbox < Formula
  desc "Reusable configurations and safe local Git workspace preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.2.0", revision: "061b06184e06afdce3467258ec43262875974509"
  version "0.2.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2732fce558f82b7edbb533a7af58f1a2ae99a85d9bb43ecd4a97be453bd27ea1"
    sha256 cellar: :any_skip_relocation, sequoia:       "68e84db7c7892708461e14f626419389dd52182ce74489c82a0dd3768a42f589"
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
