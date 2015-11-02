Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 0/3] Fix rcar-pcie for arm64
Date: Mon,  2 Nov 2015 16:36:12 +0000
Message-Id: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first patches fixes the build problem, and the second patch reverts the
patch that removed the driver from arm64 builds. The final patch add a compat
string for the r8a7795 (arm64) device.

Tested on arm Koelsch board, all ok.

Tested on arm64 Salvator-X board using renesas-drivers-2015-10-27-v4.3-rc7 from
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git with PCI
next merged. 
Apart from patches to add the PCIe clock and DT nodes, I had to revert these
patches to get it to work on arm64:
 f075915ac0b1 ("PCI/MSI: Drop domain field from msi_controller")
 d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use struct device::msi_domain")
I'll look into this, but it doesn't stop us from applying these patches.

Harunobu Kurokawa (1):
  PCI: pcie-rcar: Add support for R-Car H3.

Phil Edworthy (2):
  PCI: pcie-rcar: Convert to DT resource parsing API
  Revert "PCI: rcar: Build pcie-rcar.c only on ARM"

 Documentation/devicetree/bindings/pci/rcar-pci.txt |   3 +-
 drivers/pci/host/Kconfig                           |   3 +-
 drivers/pci/host/pcie-rcar.c                       | 118 +++++++++++++--------
 3 files changed, 78 insertions(+), 46 deletions(-)

-- 
1.9.1

