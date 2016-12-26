Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 0/6] Support the PCIe for TM2(exynos5433)
Date: Mon, 26 Dec 2016 14:20:23 +0900
Message-id: <20161226052029.10552-1-jh80.chung@samsung.com>
References: <CGME20161226052030epcas1p45f543765960d14ccf9cd40c2b9cca84b@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is for supporting PCIe exynos5433.
TM2(exynos5433) supports the PCIe for WiFi. In driver/pci/host/, there is pci-exynos.c.
But i can't touch anything. The below reasons are why i added the new file.
1. Don't have the exynos5440 TRM
- I can't check anything for exynso5440.
- So i can't touch anything for using PHY generic framework.
2. Can't test the exynos5440 board.
- If used the phy generic framework, can't ensure whether it's working fine or not.
3. There is no maintiain for exynos5440.
- i don't know anywhere pci-exynos5440 is used.

As i know, Bjorn(PCIe Maintainer) agreed about adding the new file.

So i added the new pci-exynos5433 file in driver/pci/host/.
And adds the phy-exynos-pcie.c for using PHY generic framework.
When use the PHY generic framework, controlling pcie is more easier than now.

There are future works,
      - Supporting MSI
      - If possible, combine the one file to pci-exynos.c

This is based on httt://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git (for-next branch)
(Because PCI git repository doesn't snycrhonize yet.)

The below is working messesage

[    0.817081] OF: PCI: host bridge /soc/pcie@15700000 ranges:
[    0.817264] OF: PCI:   No bus range found for /soc/pcie@15700000, using [bus 00-ff]
[    0.821377] OF: PCI:    IO 0x0c001000..0x0c010fff -> 0x00000000
[    0.827270] OF: PCI:   MEM 0x0c011000..0x0ffffffe -> 0x0c011000
[    0.934306] exynos5433-pcie 156b0000.pcie: link up
[    0.934649] exynos5433-pcie 156b0000.pcie: PCI host bridge to bus 0000:00
[    0.934867] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.935045] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.935243] pci_bus 0000:00: root bus resource [mem 0x0c011000-0x0ffffffe]
[    0.953719] pci 0000:00:00.0: BAR 8: assigned [mem 0x0c200000-0x0c7fffff]
[    0.953941] pci 0000:01:00.0: BAR 2: assigned [mem 0x0c400000-0x0c7fffff 64bit]
[    0.956672] pci 0000:01:00.0: BAR 0: assigned [mem 0x0c200000-0x0c207fff 64bit]
[    0.963959] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.968368] pci 0000:00:00.0:   bridge window [mem 0x0c200000-0x0c7fffff]
[    0.975241] pcieport 0000:00:00.0: of_irq_parse_pci() failed with rc=-22
[    0.982124] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt

Jaehoon Chung (6):
  phy: exynos-pcie: Add support for Exynos PCIe phy
  Documetation: samsung-phy: add the exynos-pcie-phy binding
  ARM64: dts: exynos5433: add the pcie_phy node for PCIe
  PCI: exynos5433: Add new exynos pci host controller for Exynos5433
  Documentation: pci: add the exynos5433-pcie binding
  ARM64: exynos: add the pcie node for TM2

 .../devicetree/bindings/pci/exynos5433-pcie.txt    |  36 +++
 .../devicetree/bindings/phy/samsung-phy.txt        |  21 ++
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |   7 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  11 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  37 +++
 drivers/pci/host/Kconfig                           |   9 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-exynos5433.c                  | 338 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-exynos-pcie.c                      | 227 ++++++++++++++
 11 files changed, 695 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/exynos5433-pcie.txt
 create mode 100644 drivers/pci/host/pci-exynos5433.c
 create mode 100644 drivers/phy/phy-exynos-pcie.c

-- 
2.10.2
