Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:46488 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbbBIOgI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 09:36:08 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so24944125obb.13
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2015 06:36:07 -0800 (PST)
Date: Mon, 9 Feb 2015 08:36:03 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v3.20
Message-ID: <20150209143603.GA16468@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes intended for v3.20.

Bjorn


The following changes since commit c3e59ee4e76686b0c84ca8faa1011d10cd4ca1b8:

  PCI: Mark Atheros AR93xx to avoid bus reset (2015-01-16 10:04:38 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.20-changes

for you to fetch changes up to cb8e92d8e4d9f8562071b6ab39e1b837e9e7af39:

  Merge branch 'pci/misc' into next (2015-02-07 08:22:24 -0600)

----------------------------------------------------------------
PCI changes for the v3.20 merge window:

  Enumeration
    - Move domain assignment from arm64 to generic code (Lorenzo Pieralisi)
    - ARM: Remove artificial dependency on pci_sys_data domain (Lorenzo Pieralisi)
    - ARM: Move to generic PCI domains (Lorenzo Pieralisi)
    - Generate uppercase hex for modalias var in uevent (Ricardo Ribalda Delgado)
    - Add and use generic config accessors on ARM, PowerPC (Rob Herring)

  Resource management
    - Free resources on failure in of_pci_get_host_bridge_resources() (Lorenzo Pieralisi)
    - Fix infinite loop with ROM image of size 0 (Michel Dänzer)

  PCI device hotplug
    - Handle surprise add even if surprise removal isn't supported (Bjorn Helgaas)

  Virtualization
    - Mark AMD/ATI VGA devices that don't reset on D3hot->D0 transition (Alex Williamson)
    - Add DMA alias quirk for Adaptec 3405 (Alex Williamson)
    - Add Wellsburg (X99) to Intel PCH root port ACS quirk (Alex Williamson)
    - Add ACS quirk for Emulex NICs (Vasundhara Volam)

  MSI
    - Fail MSI-X mappings if there's no space assigned to MSI-X BAR (Yijing Wang)

  Freescale Layerscape host bridge driver
    - Fix platform_no_drv_owner.cocci warnings (Julia Lawall)

  NVIDIA Tegra host bridge driver
    - Remove unnecessary tegra_pcie_fixup_bridge() (Lucas Stach)

  Renesas R-Car host bridge driver
    - Fix error handling of irq_of_parse_and_map() (Dmitry Torokhov)

  TI Keystone host bridge driver
    - Fix error handling of irq_of_parse_and_map() (Dmitry Torokhov)
    - Fix misspelling of current function in debug output (Julia Lawall)

  Xilinx AXI host bridge driver
    - Fix harmless format string warning (Arnd Bergmann)

  Miscellaneous
    - Use standard parsing functions for ASPM sysfs setters (Chris J Arges)
    - Add pci_device_to_OF_node() stub for !CONFIG_OF (Kevin Hao)
    - Delete unnecessary NULL pointer checks (Markus Elfring)
    - Add and use defines for PCIe Max_Read_Request_Size (Rafał Miłecki)
    - Include clk.h instead of clk-private.h (Stephen Boyd)

----------------------------------------------------------------
Alex Williamson (4):
      PCI: Add flag for devices that don't reset on D3hot->D0 transition
      PCI: Mark AMD/ATI VGA devices that don't reset on D3hot->D0 transition
      PCI: Add DMA alias quirk for Adaptec 3405
      PCI: Add Wellsburg (X99) to Intel PCH root port ACS quirk

Arnd Bergmann (1):
      PCI: xilinx: Fix harmless format string warning

Bjorn Helgaas (9):
      Merge branches 'pci/domain' and 'pci/hotplug' into next
      Merge branches 'pci/host-keystone', 'pci/host-layerscape', 'pci/host-rcar' and 'pci/host-tegra' into next
      PCI: pciehp: Handle surprise add even if surprise removal isn't supported
      Merge branches 'pci/host-keystone', 'pci/host-tegra', 'pci/host-xgene' and 'pci/host-xilinx' into next
      Merge branches 'pci/enumeration', 'pci/hotplug', 'pci/resource' and 'pci/virtualization' into next
      Merge branch 'pci/config' into next
      Merge branches 'pci/host-generic' and 'pci/host-versatile' into next
      Merge branches 'pci/misc' and 'pci/msi' into next
      Merge branch 'pci/misc' into next

Chris J Arges (1):
      PCI/ASPM: Use standard parsing functions for sysfs setters

Dmitry Torokhov (2):
      PCI: keystone: Fix error handling of irq_of_parse_and_map()
      PCI: rcar: Fix error handling of irq_of_parse_and_map()

Julia Lawall (2):
      PCI: layerscape: Fix platform_no_drv_owner.cocci warnings
      PCI: keystone: Fix misspelling of current function in debug output

Kevin Hao (1):
      PCI: Add pci_device_to_OF_node() stub for !CONFIG_OF

Lorenzo Pieralisi (4):
      PCI: Move domain assignment from arm64 to generic code
      CNS3xxx: Remove artificial dependency on pci_sys_data domain.
      ARM/PCI: Move to generic PCI domains
      of/pci: Free resources on failure in of_pci_get_host_bridge_resources()

Lucas Stach (2):
      PCI: tegra: Remove unnecessary tegra_pcie_fixup_bridge()
      PCI: tegra: Remove unnecessary tegra_pcie_fixup_bridge()

Markus Elfring (1):
      PCI: Delete unnecessary NULL pointer checks

Michel Dänzer (1):
      PCI: Fix infinite loop with ROM image of size 0

Rafał Miłecki (5):
      PCI: Add defines for PCIe Max_Read_Request_Size
      rapidio/tsi721: use PCI define for Max_Read_Request_Size
      tile: use PCI define for Max_Read_Request_Size
      [SCSI] esas2r: use PCI define for Max_Read_Request_Size
      r8169: use PCI define for Max_Read_Request_Size

Ricardo Ribalda Delgado (1):
      PCI: Generate uppercase hex for modalias var in uevent

Rob Herring (19):
      frv/PCI: Add struct pci_ops member names to initialization
      MIPS: PCI: Add struct pci_ops member names to initialization
      mn10300/PCI: Add struct pci_ops member names to initialization
      powerpc/PCI: Add struct pci_ops member names to initialization
      PCI: Add generic config accessors
      ARM: cns3xxx: Convert PCI to use generic config accessors
      PCI: versatile: Add DT docs for ARM Versatile PB PCIe driver
      ARM: dts: versatile: add PCI controller binding
      PCI: versatile: Add DT-based ARM Versatile PB PCIe host driver
      ARM: integrator: Convert PCI to use generic config accessors
      ARM: sa1100: Convert PCI to use generic config accessors
      ARM: ks8695: Convert PCI to use generic config accessors
      powerpc/fsl_pci: Convert PCI to use generic config accessors
      powerpc/powermac: Convert PCI to use generic config accessors
      PCI: generic: Convert to use generic config accessors
      PCI: rcar: Convert to use generic config accessors
      PCI: tegra: Convert to use generic config accessors
      PCI: xgene: Convert to use generic config accessors
      PCI: xilinx: Convert to use generic config accessors

Stephen Boyd (1):
      PCI: xgene: Include clk.h instead of clk-private.h

Vasundhara Volam (1):
      PCI: Add ACS quirk for Emulex NICs

Yijing Wang (1):
      PCI: Fail MSI-X mappings if there's no space assigned to MSI-X BAR

 .../devicetree/bindings/pci/versatile.txt          |  59 +++++
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |   3 +
 arch/arm/boot/dts/versatile-pb.dts                 |  37 ++++
 arch/arm/include/asm/mach/pci.h                    |   6 -
 arch/arm/include/asm/pci.h                         |   7 -
 arch/arm/kernel/bios32.c                           |   3 -
 arch/arm/mach-cns3xxx/pcie.c                       |  92 +++-----
 arch/arm/mach-integrator/pci_v3.c                  |  62 +-----
 arch/arm/mach-ks8695/pci.c                         |  77 +------
 arch/arm/mach-sa1100/pci-nanoengine.c              |  94 +-------
 arch/arm64/kernel/pci.c                            |  22 --
 arch/frv/mb93090-mb00/pci-vdk.c                    |   4 +-
 arch/mips/pci/pci-bcm1480.c                        |   4 +-
 arch/mips/pci/pci-octeon.c                         |   4 +-
 arch/mips/pci/pcie-octeon.c                        |  12 +-
 arch/mn10300/unit-asb2305/pci.c                    |   4 +-
 arch/powerpc/platforms/cell/celleb_scc_pciex.c     |   4 +-
 arch/powerpc/platforms/powermac/pci.c              | 209 ++++--------------
 arch/powerpc/sysdev/fsl_pci.c                      |  46 +---
 arch/tile/kernel/pci.c                             |   4 +-
 arch/x86/pci/xen.c                                 |   4 +
 drivers/net/ethernet/realtek/r8169.c               |   6 +-
 drivers/of/of_pci.c                                |   4 +
 drivers/pci/access.c                               |  87 ++++++++
 drivers/pci/host/Kconfig                           |   4 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                |  51 +----
 drivers/pci/host/pci-keystone.c                    |   4 +-
 drivers/pci/host/pci-layerscape.c                  |   1 -
 drivers/pci/host/pci-mvebu.c                       |  15 +-
 drivers/pci/host/pci-rcar-gen2.c                   |  51 +----
 drivers/pci/host/pci-tegra.c                       |  68 +-----
 drivers/pci/host/pci-versatile.c                   | 237 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       | 152 +------------
 drivers/pci/host/pcie-designware.c                 |   3 -
 drivers/pci/host/pcie-rcar.c                       |   7 +-
 drivers/pci/host/pcie-xilinx.c                     |  92 +-------
 drivers/pci/hotplug/cpci_hotplug_core.c            |   3 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   2 -
 drivers/pci/msi.c                                  |   5 +
 drivers/pci/pci-driver.c                           |   2 +-
 drivers/pci/pci.c                                  |  51 ++++-
 drivers/pci/pcie/aspm.c                            |  12 +-
 drivers/pci/quirks.c                               |  64 ++++++
 drivers/pci/rom.c                                  |   7 +-
 drivers/rapidio/devices/tsi721.c                   |   2 +-
 drivers/rapidio/devices/tsi721.h                   |   2 -
 drivers/scsi/esas2r/esas2r_init.c                  |   5 +-
 include/linux/pci.h                                |  15 ++
 include/uapi/linux/pci_regs.h                      |   4 +
 51 files changed, 744 insertions(+), 978 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
 create mode 100644 drivers/pci/host/pci-versatile.c
