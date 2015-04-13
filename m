Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38590 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932748AbbDMRJf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2015 13:09:35 -0400
Received: by igbqf9 with SMTP id qf9so49697973igb.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2015 10:09:34 -0700 (PDT)
Date: Mon, 13 Apr 2015 12:09:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.1
Message-ID: <20150413170931.GA19151@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.1.

Bjorn


The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.1-changes

for you to fetch changes up to 5468d5a64bf1e002e5081fa280186d0eba09fa0e:

  Merge branch 'pci/misc' into next (2015-04-10 08:27:18 -0500)

----------------------------------------------------------------
PCI changes for the v4.1 merge window:

  Enumeration
    - Read capability list as dwords, not bytes (Sean O. Stalley)

  Resource management
    - Don't check for PNP overlaps with unassigned PCI BARs (Bjorn Helgaas)
    - Mark invalid BARs as unassigned (Bjorn Helgaas)
    - Show driver, BAR#, and resource on pci_ioremap_bar() failure (Bjorn Helgaas)
    - Fail pci_ioremap_bar() on unassigned resources (Bjorn Helgaas)
    - Assign resources before drivers claim devices (Yijing Wang)
    - Claim bus resources before pci_bus_add_devices() (Yijing Wang)

  Power management
    - Optimize device state transition delays (Aaron Lu)
    - Don't clear ASPM bits when the FADT declares it's unsupported (Matthew Garrett)

  Virtualization
    - Add ACS quirks for Intel 1G NICs (Alex Williamson)

  IOMMU
    - Add ptr to OF node arg to of_iommu_configure() (Murali Karicheri)
    - Move of_dma_configure() to device.c to help re-use (Murali Karicheri)
    - Fix size when dma-range is not used (Murali Karicheri)
    - Add helper functions pci_get[put]_host_bridge_device() (Murali Karicheri)
    - Add of_pci_dma_configure() to update DMA configuration (Murali Karicheri)
    - Update DMA configuration from DT (Murali Karicheri)
    - dma-mapping: limit IOMMU mapping size (Murali Karicheri)
    - Calculate device DMA masks based on DT dma-range size (Murali Karicheri)

  ARM Versatile host bridge driver
    - Check for devm_ioremap_resource() failures (Jisheng Zhang)

  Broadcom iProc host bridge driver
    - Add Broadcom iProc PCIe driver (Ray Jui)

  Marvell MVEBU host bridge driver
    - Add suspend/resume support (Thomas Petazzoni)

  Renesas R-Car host bridge driver
    - Fix position of MSI enable bit (Nobuhiro Iwamatsu)
    - Write zeroes to reserved PCIEPARL bits (Nobuhiro Iwamatsu)
    - Change PCIEPARL and PCIEPARH to PCIEPALR and PCIEPAUR (Nobuhiro Iwamatsu)
    - Verify that mem_res is 64K-aligned (Nobuhiro Iwamatsu)

  Samsung Exynos host bridge driver
    - Fix INTx enablement statement termination error (Jaehoon Chung)

  Miscellaneous
    - Make a shareable UUID for PCI firmware ACPI _DSM (Aaron Lu)
    - Clarify policy for vendor IDs in pci.txt (Michael S. Tsirkin)

----------------------------------------------------------------
Aaron Lu (3):
      PCI: Make a shareable UUID for PCI firmware ACPI _DSM
      PCI: Export pci_find_host_bridge() for use inside PCI core
      PCI/ACPI: Optimize device state transition delays

Alex Williamson (1):
      PCI: Add ACS quirks for Intel 1G NICs

Bjorn Helgaas (11):
      PNP: Don't check for overlaps with unassigned PCI BARs
      PCI: Mark invalid BARs as unassigned
      PCI: Show driver, BAR#, and resource on pci_ioremap_bar() failure
      PCI: Fail pci_ioremap_bar() on unassigned resources
      PCI: Cleanup control flow
      Merge branches 'pci/iommu' and 'pci/resource' into next
      Merge branches 'pci/enumeration' and 'pci/virtualization' into next
      PCI: keystone: Don't dereference possible NULL pointer
      PCI: layerscape: Simplify platform_get_resource_byname() failure checking
      Merge branches 'pci/host-exynos', 'pci/host-iproc', 'pci/host-keystone', 'pci/host-layerscape', 'pci/host-mvebu', 'pci/host-rcar' and 'pci/host-versatile' into next
      Merge branch 'pci/misc' into next

Darrick J. Wong (1):
      PCI: Fix typo in Thunderbolt kernel message

Jaehoon Chung (1):
      PCI: exynos: Fix INTx enablement statement termination error

Jisheng Zhang (1):
      PCI: versatile: Check for devm_ioremap_resource() failures

Matthew Garrett (1):
      PCI: Don't clear ASPM bits when the FADT declares it's unsupported

Michael S. Tsirkin (1):
      PCI: Clarify policy for vendor IDs in pci.txt

Murali Karicheri (8):
      of: iommu: Add ptr to OF node arg to of_iommu_configure()
      of: Move of_dma_configure() to device.c to help re-use
      of: Fix size when dma-range is not used
      PCI: Add helper functions pci_get[put]_host_bridge_device()
      of/pci: Add of_pci_dma_configure() to update DMA configuration
      PCI: Update DMA configuration from DT
      arm: dma-mapping: limit IOMMU mapping size
      of: Calculate device DMA masks based on DT dma-range size

Nobuhiro Iwamatsu (4):
      PCI: rcar: Fix position of MSI enable bit
      PCI: rcar: Write zeroes to reserved PCIEPARL bits
      PCI: rcar: Change PCIEPARL and PCIEPARH to PCIEPALR and PCIEPAUR
      PCI: rcar: Verify that mem_res is 64K-aligned

Ray Jui (3):
      PCI: Export symbols required for loadable host driver modules
      PCI: iproc: Add DT docs for Broadcom iProc PCIe driver
      PCI: iproc: Add Broadcom iProc PCIe support

Sean O. Stalley (1):
      PCI: Read capability list as dwords, not bytes

Thomas Petazzoni (1):
      PCI: mvebu: Add suspend/resume support

Yijing Wang (3):
      PCI: Assign resources before drivers claim devices (pci_scan_bus())
      PCI: Assign resources before drivers claim devices (pci_scan_root_bus())
      sparc/PCI: Claim bus resources before pci_bus_add_devices()

 Documentation/PCI/pci.txt                          |  12 +-
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  63 +++++
 arch/alpha/kernel/pci.c                            |   7 +
 arch/alpha/kernel/sys_nautilus.c                   |   4 +
 arch/arm/mach-dove/pcie.c                          |  12 +-
 arch/arm/mach-mv78xx0/pcie.c                       |  12 +-
 arch/arm/mach-orion5x/pci.c                        |  32 ++-
 arch/arm/mm/dma-mapping.c                          |   7 +
 arch/frv/mb93090-mb00/pci-vdk.c                    |   6 +-
 arch/ia64/sn/kernel/io_init.c                      |   2 +
 arch/m68k/coldfire/pci.c                           |   4 +
 arch/microblaze/pci/pci-common.c                   |   4 +
 arch/mips/pci/pci.c                                |  32 +--
 arch/mn10300/unit-asb2305/pci.c                    |   6 +-
 arch/s390/pci/pci.c                                |   2 +-
 arch/sh/drivers/pci/pci.c                          |  25 +-
 arch/sparc/kernel/leon_pci.c                       |  16 +-
 arch/sparc/kernel/pci.c                            |   3 +-
 arch/sparc/kernel/pcic.c                           |   4 +
 arch/tile/kernel/pci.c                             |   2 +
 arch/tile/kernel/pci_gx.c                          |   2 +
 arch/unicore32/kernel/pci.c                        |   9 +-
 arch/x86/pci/common.c                              |   2 +
 arch/xtensa/kernel/pci.c                           |  15 +-
 drivers/acpi/pci_root.c                            |  19 +-
 drivers/iommu/of_iommu.c                           |  10 +-
 drivers/of/device.c                                |  84 +++++++
 drivers/of/of_pci.c                                |  21 ++
 drivers/of/platform.c                              |  58 +----
 drivers/pci/host-bridge.c                          |  20 +-
 drivers/pci/host/Kconfig                           |  19 ++
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-exynos.c                      |   2 +-
 drivers/pci/host/pci-keystone-dw.c                 |   3 +-
 drivers/pci/host/pci-layerscape.c                  |   9 +-
 drivers/pci/host/pci-mvebu.c                       |  38 +++
 drivers/pci/host/pci-rcar-gen2.c                   |   3 +
 drivers/pci/host/pci-versatile.c                   |  13 +-
 drivers/pci/host/pcie-iproc-platform.c             | 108 +++++++++
 drivers/pci/host/pcie-iproc.c                      | 268 +++++++++++++++++++++
 drivers/pci/host/pcie-iproc.h                      |  42 ++++
 drivers/pci/host/pcie-rcar.c                       |  11 +-
 drivers/pci/hotplug/ibmphp_core.c                  |   8 +-
 drivers/pci/pci-acpi.c                             |  83 +++++++
 drivers/pci/pci-label.c                            |  11 +-
 drivers/pci/pci.c                                  |  21 +-
 drivers/pci/pci.h                                  |   2 +
 drivers/pci/pcie/aspm.c                            |  18 --
 drivers/pci/probe.c                                |   5 +-
 drivers/pci/quirks.c                               |  34 ++-
 drivers/pci/remove.c                               |   2 +
 drivers/pci/setup-bus.c                            |   1 +
 drivers/pci/setup-irq.c                            |   1 +
 drivers/pci/setup-res.c                            |   2 +
 drivers/pnp/quirks.c                               |   9 +-
 include/linux/of_device.h                          |   3 +
 include/linux/of_iommu.h                           |   6 +-
 include/linux/of_pci.h                             |   3 +
 include/linux/pci-acpi.h                           |   5 +
 include/linux/pci-aspm.h                           |   4 -
 include/linux/pci.h                                |   4 +
 61 files changed, 1007 insertions(+), 228 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
 create mode 100644 drivers/pci/host/pcie-iproc-platform.c
 create mode 100644 drivers/pci/host/pcie-iproc.c
 create mode 100644 drivers/pci/host/pcie-iproc.h
