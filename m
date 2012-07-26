Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52023 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2GZTzz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:55 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Date: Thu, 26 Jul 2012 21:55:02 +0200
Message-Id: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support for device tree based probing of the PCIe
controller found on Tegra SoCs.

Patches 1 and 2 keep the pci_fixup_irqs() and ARM-specific
pci_common_init() functions around after init. This is required to
support driver probe deferral, which may cause built-in drivers to be
probed after __init data has already been freed.

Patch 3 allows a driver's probe function to pass per-controller private
data when calling the pci_common_init() function.

Patch 4 is trivial and has already been Acked-by: Stephen Warren before.

Patch 5 adds a flag to mark a struct resource as defining a PCI
configuration space. The flag will be used subsequently to differentiate
between memory-mapped I/O regions and PCI configuration space.

Patch 6 rewrites PCIe support as a driver and switches the Harmony and
TrimSlice boards to add the proper platform device instead of calling
the tegra_pcie_init() function. Patch 7 adds MSI support as an IRQ
domain.

Patches 8 and 9 add code to support the new PCIe controller binding used
by patch 10 to instantiate the controller from DT.


Thierry Reding (10):
  PCI: Keep pci_fixup_irqs() around after init
  ARM: pci: Keep pci_common_init() around after init
  ARM: pci: Allow passing per-controller private data
  ARM: tegra: Move tegra_pcie_xclk_clamp() to PMC
  resource: add PCI configuration space support
  ARM: tegra: Rewrite PCIe support as a driver
  ARM: tegra: pcie: Add MSI support
  of/address: Handle #address-cells > 2 specially
  of: Add of_pci_parse_ranges()
  ARM: tegra: pcie: Add device tree support

 .../bindings/pci/nvidia,tegra20-pcie.txt           |   94 ++
 arch/arm/boot/dts/tegra20.dtsi                     |   62 +
 arch/arm/include/asm/mach/pci.h                    |    1 +
 arch/arm/kernel/bios32.c                           |    7 +-
 arch/arm/mach-tegra/Kconfig                        |    1 +
 arch/arm/mach-tegra/board-dt-tegra20.c             |    7 +-
 arch/arm/mach-tegra/board-harmony-pcie.c           |   30 +-
 arch/arm/mach-tegra/board-harmony.c                |    1 +
 arch/arm/mach-tegra/board-harmony.h                |    1 +
 arch/arm/mach-tegra/board-trimslice.c              |   11 +-
 arch/arm/mach-tegra/board.h                        |    2 +-
 arch/arm/mach-tegra/devices.c                      |  142 ++
 arch/arm/mach-tegra/devices.h                      |    3 +
 arch/arm/mach-tegra/include/mach/iomap.h           |    3 -
 arch/arm/mach-tegra/include/mach/irqs.h            |    5 +-
 arch/arm/mach-tegra/include/mach/pci-tegra.h       |   38 +
 arch/arm/mach-tegra/pcie.c                         | 1406 ++++++++++++++------
 arch/arm/mach-tegra/pmc.c                          |   16 +
 arch/arm/mach-tegra/pmc.h                          |    1 +
 drivers/of/address.c                               |    8 +
 drivers/of/of_pci.c                                |   84 +-
 drivers/pci/setup-irq.c                            |    4 +-
 include/linux/ioport.h                             |    2 +-
 include/linux/of_pci.h                             |    2 +
 24 files changed, 1485 insertions(+), 446 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 create mode 100644 arch/arm/mach-tegra/include/mach/pci-tegra.h

-- 
1.7.11.2

