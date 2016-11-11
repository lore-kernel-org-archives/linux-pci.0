Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Nov 2016 12:40:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Vecu Bosseur <vecu.bosseur@gmail.com>
Subject: [GIT PULL] PCI fixes for v4.9
Message-ID: <20161111184004.GA11885@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Update MAINTAINERS for Intel VMD driver filename
  - Update Rockchip rk3399 host bridge driver DTS and resets
  - Fix ROM shadow problem that made some video device initialization fail


The following changes since commit 416379f9ebded501eda882e6af0a7aafc1866700:

  PCI: designware: Check for iATU unroll support after initializing host (2016-11-04 15:28:55 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.9-fixes-3

for you to fetch changes up to bc79c9851a76d76f269d9ef5150e180825650b67:

  PCI: VMD: Update filename to reflect move (2016-11-10 16:26:32 -0600)

----------------------------------------------------------------
pci-v4.9-fixes-3

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI: Don't attempt to claim shadow copies of ROM

Keith Busch (1):
      PCI: VMD: Update filename to reflect move

Shawn Lin (2):
      PCI: rockchip: Add three new resets as required properties
      arm64: dts: rockchip: add three new resets for rk3399 PCIe controller

 .../devicetree/bindings/pci/rockchip-pcie.txt      | 11 ++--
 MAINTAINERS                                        |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  7 ++-
 drivers/pci/host/pcie-rockchip.c                   | 62 ++++++++++++++++++++++
 drivers/pci/setup-res.c                            |  8 +++
 5 files changed, 84 insertions(+), 6 deletions(-)
