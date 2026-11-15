class ProxmoxBackupClientStatic < Formula
  desc "Statically linked Proxmox Backup Client"
  homepage "https://pbs.proxmox.com/"
  url "http://download.proxmox.com/debian/pbs-client/dists/trixie/main/binary-amd64/proxmox-backup-client-static_4.0.1-1_amd64.deb",
      using: :nounzip
  version "4.0.1-1"
  sha256 "REPLACE_WITH_ACTUAL_SHA256"
  license "AGPL-3.0-or-later"

  livecheck do
    url "http://download.proxmox.com/debian/pbs-client/dists/trixie/main/binary-amd64/Packages"
    regex(/^Filename: .*?proxmox-backup-client-static_([^_]+)_amd64\.deb$/i)
  end

  depends_on :linux
  depends_on arch: :x86_64
  depends_on "binutils" => :build
  depends_on "zstd" => :build

  def install
    system "ar", "x", Dir["*.deb"].first
    system "tar", "-xf", Dir["data.tar.*"].first
    bin.install "usr/bin/proxmox-backup-client"
  end

  test do
    assert_match version.to_s.split("-").first, shell_output("#{bin}/proxmox-backup-client version")
  end
end