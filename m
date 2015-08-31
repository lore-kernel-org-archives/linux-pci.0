Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37774 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbbHaNOk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2015 09:14:40 -0400
Received: by igui7 with SMTP id i7so53878443igu.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2015 06:14:39 -0700 (PDT)
Date: Mon, 31 Aug 2015 08:14:35 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.3
Message-ID: <20150831131435.GA647@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes for v4.3.

Bjorn


The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.3-changes

for you to fetch changes up to 9ca678d1dff610f7df6ac9b31fd9152c4426f815:

  Merge branches 'pci/enumeration' and 'pci/misc' into next (2015-08-28 15:53:08 -0500)

----------------------------------------------------------------
PCI changes for the v4.3 merge window:

  Enumeration
    Allocate ATS struct during enumeration (Bjorn Helgaas)
    Embed ATS info directly into struct pci_dev (Bjorn Helgaas)
    Reduce size of ATS structure elements (Bjorn Helgaas)
    Stop caching ATS Invalidate Queue Depth (Bjorn Helgaas)
    iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth (Bjorn Helgaas)
    Move MPS configuration check to pci_configure_device() (Bjorn Helgaas)
    Set MPS to match upstream bridge (Keith Busch)
    ARM/PCI: Set MPS before pci_bus_add_devices() (Murali Karicheri)
    Add pci_scan_root_bus_msi() (Lorenzo Pieralisi)
    ARM/PCI, designware, xilinx: Use pci_scan_root_bus_msi() (Lorenzo Pieralisi)

  Resource management
    Call pci_read_bridge_bases() from core instead of arch code (Lorenzo Pieralisi)

  PCI device hotplug
    pciehp: Remove unused interrupt events (Bjorn Helgaas)
    pciehp: Remove ignored MRL sensor interrupt events (Bjorn Helgaas)
    pciehp: Handle invalid data when reading from non-existent devices (Jarod Wilson)
    pciehp: Simplify pcie_poll_cmd() (Yijing Wang)
    Use "slot" and "pci_slot" for struct hotplug_slot and struct pci_slot (Yijing Wang)
    Protect pci_bus->slots with pci_slot_mutex, not pci_bus_sem (Yijing Wang)
    Hold pci_slot_mutex while searching bus->slots list (Yijing Wang)

  Power management
    Disable async suspend/resume for JMicron multi-function SATA/AHCI (Zhang Rui)

  Virtualization
    Add ACS quirks for Intel I219-LM/V (Alex Williamson)
    Restore ACS configuration as part of pci_restore_state() (Alexander Duyck)

  MSI
    Add pcibios_alloc_irq() and pcibios_free_irq() (Jiang Liu)
    x86: Implement pcibios_alloc_irq() and pcibios_free_irq() (Jiang Liu)
    Add helpers to manage pci_dev->irq and pci_dev->irq_managed (Jiang Liu)
    Free legacy IRQ when enabling MSI/MSI-X (Jiang Liu)
    ARM/PCI: Remove msi_controller from struct pci_sys_data (Lorenzo Pieralisi)
    Remove unused pcibios_msi_controller() hook (Lorenzo Pieralisi)

  Generic host bridge driver
    Remove dependency on ARM-specific struct hw_pci (Jayachandran C)
    Build setup-irq.o for arm64 (Jayachandran C)
    Add arm64 support (Jayachandran C)

  APM X-Gene host bridge driver
    Add APM X-Gene PCIe 64-bit prefetchable window (Duc Dang)
    Add support for a 64-bit prefetchable memory window (Duc Dang)
    Drop owner assignment from platform_driver (Krzysztof Kozlowski)

  Broadcom iProc host bridge driver
    Allow BCMA bus driver to be built as module (Hauke Mehrtens)
    Delete unnecessary checks before phy calls (Markus Elfring)
    Add arm64 support (Ray Jui)

  Synopsys DesignWare host bridge driver
    Don't complain missing *config* reg space if va_cfg0 is set (Murali Karicheri)

  TI DRA7xx host bridge driver
    Disable pm_runtime on get_sync failure (Kishon Vijay Abraham I)
    Add PM support (Kishon Vijay Abraham I)
    Clear MSE bit during suspend so clocks will idle (Kishon Vijay Abraham I)
    Add support to make GPIO drive PERST# line (Kishon Vijay Abraham I)

  Xilinx AXI host bridge driver
    Check for MSI interrupt flag before handling as INTx (Russell Joyce)

  Miscellaneous
    Fix Intersil/Techwell TW686[4589] AV capture class code (Krzysztof Hałasa)
    Use PCI_CLASS_SERIAL_USB instead of bare number (Bjorn Helgaas)
    Fix generic NCR 53c810 class code quirk (Bjorn Helgaas)
    Fix TI816X class code quirk (Bjorn Helgaas)
    Remove unused "pci_probe" flags (Bjorn Helgaas)
    Host bridge driver code simplifications (Fabio Estevam)
    Add dev_flags bit to access VPD through function 0 (Mark Rustad)
    Add VPD function 0 quirk for Intel Ethernet devices (Mark Rustad)
    Kill off set_irq_flags() usage (Rob Herring)
    Remove Intel Cherrytrail D3 delays (Srinidhi Kasagar)
    Clean up pci_find_capability() (Wei Yang)

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Add ACS quirks for Intel I219-LM/V

Alexander Duyck (1):
      PCI: Restore ACS configuration as part of pci_restore_state()

Bjorn Helgaas (30):
      PCI: Use PCI_CLASS_SERIAL_USB instead of bare number
      PCI: Fix generic NCR 53c810 class code quirk
      PCI: Fix TI816X class code quirk
      PCI: Revert aeb30016fec3 ("PCI: add Intel USB specific reset method")
      PCI: Shift PCI_CLASS_NOT_DEFINED consistently with other classes
      PCI: Fix pcie_port_device_resume() comment
      PCI: Add pcie_downstream_port() (true for Root and Switch Downstream Ports)
      PCI: Remove useless redundant code
      iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
      PCI: Remove unused "pci_probe" flags
      Merge branches 'pci/host-designware', 'pci/host-xgene' and 'pci/host-xilinx' into next
      Merge branches 'pci/irq', 'pci/misc', 'pci/resource' and 'pci/virtualization' into next
      PCI: pciehp: Remove unused interrupt events
      PCI: pciehp: Remove ignored MRL sensor interrupt events
      PCI: Allocate ATS struct during enumeration
      PCI: Embed ATS info directly into struct pci_dev
      PCI: Reduce size of ATS structure elements
      PCI: Rationalize pci_ats_queue_depth() error checking
      PCI: Inline the ATS setup code into pci_ats_init()
      PCI: Use pci_physfn() rather than looking up physfn by hand
      PCI: Clean up ATS error handling
      PCI: Move ATS declarations to linux/pci.h so they're all together
      PCI: Stop caching ATS Invalidate Queue Depth
      PCI: Remove pci_ats_enabled()
      Merge branches 'pci/hotplug', 'pci/iommu', 'pci/irq' and 'pci/virtualization' into next
      Merge branches 'pci/host-dra7xx' and 'pci/host-iproc' into next
      PCI: Drop references acquired by of_parse_phandle()
      PCI: Move MPS configuration check to pci_configure_device()
      Merge branches 'pci/host-dra7xx', 'pci/host-imx6' and 'pci/host-spear' into next
      Merge branches 'pci/enumeration' and 'pci/misc' into next

Duc Dang (2):
      arm64: dts: Add APM X-Gene PCIe 64-bit prefetchable window
      PCI: xgene: Add support for a 64-bit prefetchable memory window

Fabio Estevam (3):
      PCI: dra7xx: Remove unneeded use of IS_ERR_VALUE()
      PCI: spear: Use BUG_ON() instead of condition followed by BUG()
      PCI: imx6: Simplify a trivial if-return sequence

Hauke Mehrtens (1):
      PCI: iproc: Allow BCMA bus driver to be built as module

Jarod Wilson (1):
      PCI: pciehp: Handle invalid data when reading from non-existent devices

Jayachandran C (3):
      PCI: generic: Remove dependency on ARM-specific struct hw_pci
      PCI: Build setup-irq.o for arm64
      PCI: generic: Add arm64 support

Jiang Liu (4):
      PCI: Add pcibios_alloc_irq() and pcibios_free_irq()
      PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
      PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed
      PCI/MSI: Free legacy IRQ when enabling MSI/MSI-X

Keith Busch (1):
      PCI: Set MPS to match upstream bridge

Kishon Vijay Abraham I (5):
      PCI: dra7xx: Disable pm_runtime on get_sync failure
      PCI: dra7xx: Add PM support
      PCI: dra7xx: Clear MSE bit during suspend so clocks will idle
      PCI: dra7xx: Add support to make GPIO drive PERST# line
      ARM: dts: am57xx-evm: Add 'gpios' property with gpio2_8

Krzysztof =?utf-8?Q?Ha=C5=82asa?= (1):
      PCI: Add quirk for Intersil/Techwell TW686[4589] AV capture cards

Krzysztof Kozlowski (1):
      PCI: xgene: Drop owner assignment from platform_driver

Lorenzo Pieralisi (6):
      PCI: Call pci_read_bridge_bases() from core instead of arch code
      ARM/PCI: Replace panic with WARN messages on failures
      PCI: Add pci_scan_root_bus_msi()
      ARM/PCI, designware, xilinx: Use pci_scan_root_bus_msi()
      ARM/PCI: Remove msi_controller from struct pci_sys_data
      PCI/MSI: Remove unused pcibios_msi_controller() hook

Mark Rustad (2):
      PCI: Add dev_flags bit to access VPD through function 0
      PCI: Add VPD function 0 quirk for Intel Ethernet devices

Markus Elfring (1):
      PCI: iproc: Delete unnecessary checks before phy calls

Murali Karicheri (2):
      ARM/PCI: Set MPS before pci_bus_add_devices()
      PCI: designware: Don't complain missing *config* reg space if va_cfg0 is set

Rami Rosen (1):
      PCI: Remove a broken link in quirks.c

Ray Jui (1):
      PCI: iproc: Add arm64 support

Rob Herring (1):
      PCI: Kill off set_irq_flags() usage

Russell Joyce (1):
      PCI: xilinx: Check for MSI interrupt flag before handling as INTx

Srinidhi Kasagar (2):
      PCI: Remove Intel Cherrytrail D3 delays
      PCI / ACPI: Fix pci_acpi_optimize_delay() comment

Wei Yang (2):
      PCI: Move PCI_FIND_CAP_TTL to pci.h and use it in quirks
      PCI: Simplify pci_find_(ext_)capability() return value checks

Yijing Wang (4):
      PCI: Use "slot" and "pci_slot" for struct hotplug_slot and struct pci_slot
      PCI: pciehp: Simplify pcie_poll_cmd()
      PCI: Protect pci_bus->slots with pci_slot_mutex, not pci_bus_sem
      PCI: Hold pci_slot_mutex while searching bus->slots list

Zhang Rui (1):
      PCI: Disable async suspend/resume for JMicron multi-function SATA/AHCI

 Documentation/devicetree/bindings/pci/ti-pci.txt |   3 +
 arch/alpha/kernel/pci.c                          |   7 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts          |   4 +
 arch/arm/boot/dts/dra7.dtsi                      |   2 +-
 arch/arm/include/asm/mach/pci.h                  |   5 -
 arch/arm/kernel/bios32.c                         |  45 +++-----
 arch/arm64/boot/dts/apm/apm-storm.dtsi           |  23 ++--
 arch/frv/mb93090-mb00/pci-frv.c                  |   8 --
 arch/frv/mb93090-mb00/pci-frv.h                  |   8 --
 arch/frv/mb93090-mb00/pci-vdk.c                  |   2 -
 arch/ia64/pci/pci.c                              |   5 +-
 arch/microblaze/pci/pci-common.c                 |   9 +-
 arch/mips/pci/pci.c                              |   6 --
 arch/mn10300/unit-asb2305/pci-asb2305.c          |  22 ++--
 arch/mn10300/unit-asb2305/pci-asb2305.h          |   7 --
 arch/mn10300/unit-asb2305/pci.c                  |   1 -
 arch/powerpc/kernel/pci-common.c                 |   8 +-
 arch/powerpc/kernel/pci_of_scan.c                |   6 +-
 arch/sh/drivers/pci/pci-sh4.h                    |   8 --
 arch/sparc/kernel/pci.c                          |   6 +-
 arch/x86/include/asm/pci_x86.h                   |   2 -
 arch/x86/pci/common.c                            |  21 ++--
 arch/x86/pci/fixup.c                             |  13 ---
 arch/x86/pci/intel_mid_pci.c                     |   9 +-
 arch/x86/pci/irq.c                               |  23 +---
 arch/xtensa/kernel/pci.c                         |   4 -
 drivers/acpi/pci_irq.c                           |  17 +--
 drivers/ata/ahci.c                               |  13 +--
 drivers/ata/pata_jmicron.c                       |  12 ---
 drivers/iommu/intel-iommu.c                      |  28 +++--
 drivers/parisc/dino.c                            |   3 -
 drivers/parisc/lba_pci.c                         |   1 -
 drivers/pci/Makefile                             |   1 +
 drivers/pci/access.c                             |  84 +++++++++++++--
 drivers/pci/ats.c                                | 131 ++++++++---------------
 drivers/pci/host/Kconfig                         |   4 +-
 drivers/pci/host/pci-dra7xx.c                    | 122 ++++++++++++++++++++-
 drivers/pci/host/pci-host-generic.c              |  52 +++++----
 drivers/pci/host/pci-imx6.c                      |  12 +--
 drivers/pci/host/pci-keystone-dw.c               |   2 -
 drivers/pci/host/pci-mvebu.c                     |   1 +
 drivers/pci/host/pci-tegra.c                     |   1 -
 drivers/pci/host/pci-xgene-msi.c                 |   2 -
 drivers/pci/host/pci-xgene.c                     |  13 ++-
 drivers/pci/host/pcie-designware.c               |  15 ++-
 drivers/pci/host/pcie-iproc.c                    |  60 ++++++-----
 drivers/pci/host/pcie-iproc.h                    |   4 +-
 drivers/pci/host/pcie-rcar.c                     |   1 -
 drivers/pci/host/pcie-spear13xx.c                |   3 +-
 drivers/pci/host/pcie-xilinx.c                   |  30 +++---
 drivers/pci/hotplug/pci_hotplug_core.c           | 122 ++++++++++-----------
 drivers/pci/hotplug/pciehp.h                     |  14 +--
 drivers/pci/hotplug/pciehp_hpc.c                 |  48 +++++----
 drivers/pci/msi.c                                |  22 +---
 drivers/pci/pci-acpi.c                           |   2 +-
 drivers/pci/pci-driver.c                         |  26 +++--
 drivers/pci/pci.c                                |  14 +--
 drivers/pci/pci.h                                |   2 +
 drivers/pci/pcie/portdrv_core.c                  |   2 +-
 drivers/pci/probe.c                              |  92 +++++++++++-----
 drivers/pci/quirks.c                             | 126 ++++++++++++++--------
 drivers/pci/slot.c                               |  29 +++--
 include/linux/pci-ats.h                          |  49 ---------
 include/linux/pci.h                              |  60 +++++++++--
 64 files changed, 796 insertions(+), 681 deletions(-)
