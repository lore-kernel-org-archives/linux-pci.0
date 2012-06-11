Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53309 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab2FKPF3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 11:05:29 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 00/10] ARM: tegra: Add PCIe device tree support
Date: Mon, 11 Jun 2012 17:05:08 +0200
Message-Id: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support for device tree based probing of the PCIe
controller found on Tegra SoCs.

Patches 1 and 2 keep the pci_fixup_irqs() and ARM-specific pci_common_init()
functions around after init. This is required to support driver probe
deferral, which may cause built-in drivers to be probed after __init data has
already been freed.

Patch 3 allows a driver's probe function to pass per-controller private data
when calling the pci_common_init() function.

Patch 4 is trivial and has already been Acked-by: Stephen Warren before.

Patch 5 rewrites PCIe support as a driver and switches the Harmony and
TrimSlice boards to add the proper platform device instead of calling the
tegra_pcie_init() function. Patch 6 adds MSI support as an IRQ domain.

Patch 7 finally implements device tree support and patches 8, 9 and 10 move
the Harmony and TrimSlice boards over to use information provided in the DTS
to probe the PCIe controller.

Thierry

Thierry Reding (10):
  PCI: Keep pci_fixup_irqs() around after init
  ARM: pci: Keep pci_common_init() around after init
  ARM: pci: Allow passing per-controller private data
  ARM: tegra: Move tegra_pcie_xclk_clamp() to PMC
  ARM: tegra: Rewrite PCIe support as a driver
  ARM: tegra: pcie: Add MSI support
  ARM: tegra: pcie: Add device tree support
  ARM: tegra: harmony: Initialize regulators from DT
  ARM: tegra: harmony: Initialize PCIe from DT
  ARM: tegra: trimslice: Initialize PCIe from DT

 .../devicetree/bindings/pci/tegra-pcie.txt         |   23 +
 arch/arm/boot/dts/tegra-harmony.dts                |   98 +++
 arch/arm/boot/dts/tegra-trimslice.dts              |   20 +
 arch/arm/boot/dts/tegra20.dtsi                     |    9 +
 arch/arm/include/asm/mach/pci.h                    |    1 +
 arch/arm/kernel/bios32.c                           |    7 +-
 arch/arm/mach-tegra/Kconfig                        |    1 +
 arch/arm/mach-tegra/board-dt-tegra20.c             |   35 +-
 arch/arm/mach-tegra/board-harmony-pcie.c           |   38 +-
 arch/arm/mach-tegra/board-harmony.c                |    1 +
 arch/arm/mach-tegra/board-harmony.h                |    1 +
 arch/arm/mach-tegra/board-trimslice.c              |   18 +-
 arch/arm/mach-tegra/board.h                        |    2 +-
 arch/arm/mach-tegra/devices.c                      |   32 +
 arch/arm/mach-tegra/devices.h                      |    1 +
 arch/arm/mach-tegra/include/mach/iomap.h           |    6 +
 arch/arm/mach-tegra/include/mach/irqs.h            |    5 +-
 arch/arm/mach-tegra/include/mach/pci-tegra.h       |   29 +
 arch/arm/mach-tegra/pcie.c                         |  926 +++++++++++++++-----
 arch/arm/mach-tegra/pmc.c                          |   16 +
 arch/arm/mach-tegra/pmc.h                          |    1 +
 drivers/pci/setup-irq.c                            |    4 +-
 22 files changed, 983 insertions(+), 291 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/tegra-pcie.txt
 create mode 100644 arch/arm/mach-tegra/include/mach/pci-tegra.h

-- 
1.7.10.4

