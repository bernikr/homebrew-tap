class ProxmoxBackupClientStatic < Formula
  desc "Statically linked Proxmox Backup Client"
  homepage "https://pbs.proxmox.com/"
  url "http://download.proxmox.com/debian/pbs-client/dists/trixie/main/binary-amd64/proxmox-backup-client-static_4.2.8-1_amd64.deb",
      using: :nounzip
  version "4.2.8-1"
  sha256 "f20e5dd1565362f2c9bbfa892e4bda04e5e7a8fd9a14ef7c681ca716ac7c4001"
  license "AGPL-3.0-or-later"

  livecheck do
    url "http://download.proxmox.com/debian/pbs-client/dists/trixie/main/binary-amd64/Packages"
    regex(/^Filename: .*?proxmox-backup-client-static_([^_]+)_amd64\.deb$/i)
  end

  bottle do
    root_url "https://github.com/bernikr/homebrew-tap/releases/download/proxmox-backup-client-static-4.2.8-1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "738ab158942a7ba0caad10c1db5c1038cf74d4cd293dbc5aa30f5fb4ec2df0d6"
  end

  depends_on :linux
  depends_on arch: :x86_64

  def install
    system "ar", "x", Dir["*.deb"].first
    system "tar", "-xf", Dir["data.tar.*"].first
    bin.install "usr/bin/proxmox-backup-client"
    bin.install "usr/bin/pxar"
  end

  test do
    assert_match version.to_s.split("-").first, shell_output("#{bin}/proxmox-backup-client version")
    assert_match "create <archive>", shell_output("#{bin}/pxar help")
  end
end