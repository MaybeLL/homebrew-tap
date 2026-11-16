class Workbox < Formula
  desc "Reusable configurations and local Workbox instance preparation"
  homepage "https://github.com/MaybeLL/workbox-cli"
  url "https://github.com/MaybeLL/workbox-cli.git", tag: "v0.8.0", revision: "840e48fca3ba1a0bc8e5e290f31a692e9ab956b4"
  version "0.8.0"
  license "MIT"

  bottle do
    root_url "https://github.com/MaybeLL/workbox-cli/releases/download/v0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fa827c7ce776a5da263919ef763621941fdaef2b59495b6be4302b942810d55f"
    sha256 cellar: :any_skip_relocation, sequoia:       "0daa169c528bfda37c2db88873d6edd62541a35edc15ea747968fd9673dcb53f"
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
