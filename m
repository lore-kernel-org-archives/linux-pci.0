Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42440 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995AbcESPt5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 May 2016 11:49:57 -0400
Date: Thu, 19 May 2016 10:49:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Subject: [GIT PULL] PCI changes for v4.7
Message-ID: <20160519154946.GA20036@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.7.

There is a silent conflict that needs to be resolved when you pull this:

  - e3156048346c ("iommu/amd: Fix checking of pci dma aliases"), which is
    already in your tree, added a use of PCI_DEV_FLAGS_DMA_ALIAS_DEVFN.

  - 338c3149a221 ("PCI: Add support for multiple DMA aliases"), which is
    included in this pull request, replaces PCI_DEV_FLAGS_DMA_ALIAS_DEVFN
    with pdev->dma_alias_mask to support multiple aliases.

The conflict resolution I suggest is attached below.  The identical patch
has been in linux-next and was supplied by both Jacek Lawrynowicz and Joerg
Roedel (and probably Stephen as well).

Bjorn


The following changes since commit b2d7a9cd3ff8ec561348267c2ef7d47b2b91e801:

  Revert "PCI: imx6: Add support for active-low reset GPIO" (2016-04-05 16:20:37 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.7-changes

for you to fetch changes up to e257ef55ce51d7ec399193ee85acda8b8759d930:

  Merge branches 'pci/arm64' and 'pci/host-hv' into next (2016-05-17 14:35:46 -0500)

----------------------------------------------------------------
PCI changes for the v4.7 merge window:

  Enumeration
    Refine PCI support check in pcibios_init() (Adrian-Ken Rueegsegger)
    Provide common functions for ECAM mapping (Jayachandran C)
    Allow all PCIe services on non-ACPI host bridges (Jon Derrick)
    Remove return values from pcie_port_platform_notify() and relatives (Jon Derrick)
    Widen portdrv service type from 4 bits to 8 bits (Keith Busch)
    Add Downstream Port Containment portdrv service type (Keith Busch)
    Add Downstream Port Containment driver (Keith Busch)

  Resource management
    Identify Enhanced Allocation (EA) BAR Equivalent resources in sysfs (Alex Williamson)
    Supply CPU physical address (not bus address) to iomem_is_exclusive() (Bjorn Helgaas)
    alpha: Call iomem_is_exclusive() for IORESOURCE_MEM, but not IORESOURCE_IO (Bjorn Helgaas)
    Mark Broadwell-EP Home Agent 1 as having non-compliant BARs (Prarit Bhargava)
    Disable all BAR sizing for devices with non-compliant BARs (Prarit Bhargava)
    Move PCI I/O space management from OF to PCI core code (Tomasz Nowicki)

  PCI device hotplug
    acpiphp_ibm: Avoid uninitialized variable reference (Dan Carpenter)
    Use cached copy of PCI_EXP_SLTCAP_HPC bit (Lukas Wunner)

  Virtualization
    Mark Intel i40e NIC INTx masking as broken (Alex Williamson)
    Reverse standard ACS vs device-specific ACS enabling (Alex Williamson)
    Work around Intel Sunrise Point PCH incorrect ACS capability (Alex Williamson)

  IOMMU
    Add pci_add_dma_alias() to abstract implementation (Bjorn Helgaas)
    Move informational printk to pci_add_dma_alias() (Bjorn Helgaas)
    Add support for multiple DMA aliases (Jacek Lawrynowicz)
    Add DMA alias quirk for mic_x200_dma (Jacek Lawrynowicz)

  Thunderbolt
    Fix double free of drom buffer (Andreas Noever)
    Add Intel Thunderbolt device IDs (Lukas Wunner)
    Fix typos and magic number (Lukas Wunner)
    Support 1st gen Light Ridge controller (Lukas Wunner)

  Generic host bridge driver
    Use generic ECAM API (Jayachandran C)

  Cavium ThunderX host bridge driver
    Don't clobber read-only bits in bridge config registers (David Daney)
    Use generic ECAM API (Jayachandran C)

  Freescale i.MX6 host bridge driver
    Use enum instead of bool for variant indicator (Andrey Smirnov)
    Implement reset sequence for i.MX6+ (Andrey Smirnov)
    Factor out ref clock enable (Bjorn Helgaas)
    Add initial imx6sx support (Christoph Fritz)
    Add reset-gpio-active-high boolean property to DT (Petr Štetiar)
    Add DT property for link gen, default to Gen1 (Tim Harvey)
    dts: Specify imx6qp version of PCIe core (Andrey Smirnov)
    dts: Fix PCIe reset GPIO polarity on Toradex Apalis Ixora (Petr Štetiar)

  Marvell Armada host bridge driver
    add DT binding for Marvell Armada 7K/8K PCIe controller (Thomas Petazzoni)
    Add driver for Marvell Armada 7K/8K PCIe controller (Thomas Petazzoni)

  Marvell MVEBU host bridge driver
    Constify mvebu_pcie_pm_ops structure (Jisheng Zhang)
    Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for mvebu_pcie_pm_ops (Jisheng Zhang)

  Microsoft Hyper-V host bridge driver
    Report resources release after stopping the bus (Vitaly Kuznetsov)
    Add explicit barriers to config space access (Vitaly Kuznetsov)

  Renesas R-Car host bridge driver
    Select PCI_MSI_IRQ_DOMAIN (Arnd Bergmann)

  Synopsys DesignWare host bridge driver
    Remove incorrect RC memory base/limit configuration (Gabriele Paoloni)
    Move Root Complex setup code to dw_pcie_setup_rc() (Jisheng Zhang)

  TI Keystone host bridge driver
    Add error IRQ handler (Murali Karicheri)
    Remove unnecessary goto statement (Murali Karicheri)

  Miscellaneous
    Fix spelling errors (Colin Ian King)

----------------------------------------------------------------
Adrian-Ken Rueegsegger (1):
      x86/PCI: Refine PCI support check in pcibios_init()

Alex Williamson (4):
      PCI: Mark Intel i40e NIC INTx masking as broken
      PCI: Reverse standard ACS vs device-specific ACS enabling
      PCI: Work around Intel Sunrise Point PCH incorrect ACS capability
      PCI: Identify Enhanced Allocation (EA) BAR Equivalent resources in sysfs

Andreas Noever (1):
      thunderbolt: Fix double free of drom buffer

Andrey Smirnov (3):
      PCI: imx6: Use enum instead of bool for variant indicator
      PCI: imx6: Implement reset sequence for i.MX6+
      ARM: dts: imx6qp: Specify imx6qp version of PCIe core

Arnd Bergmann (1):
      PCI: rcar: Select PCI_MSI_IRQ_DOMAIN

Bjorn Helgaas (10):
      PCI: Add pci_add_dma_alias() to abstract implementation
      PCI: Move informational printk to pci_add_dma_alias()
      PCI: imx6: Factor out ref clock enable
      Merge branches 'pci/enumeration', 'pci/hotplug', 'pci/misc', 'pci/ntb', 'pci/thunderbolt' and 'pci/virtualization' into next
      PCI: Supply CPU physical address (not bus address) to iomem_is_exclusive()
      alpha/PCI: Call iomem_is_exclusive() for IORESOURCE_MEM, but not IORESOURCE_IO
      Merge branches 'pci/host-armada', 'pci/host-designware', 'pci/host-hv', 'pci/host-imx6', 'pci/host-keystone', 'pci/host-mvebu', 'pci/host-rcar', 'pci/host-thunder' and 'pci/host-vmd' into next
      Merge branches 'pci/dpc', 'pci/resource' and 'pci/thunderbolt' into next
      Merge branches 'pci/hotplug' and 'pci/resource' into next
      Merge branches 'pci/arm64' and 'pci/host-hv' into next

Christoph Fritz (1):
      PCI: imx6: Add initial imx6sx support

Colin Ian King (1):
      PCI: Fix spelling errors

Dan Carpenter (1):
      PCI: acpiphp_ibm: Avoid uninitialized variable reference

David Daney (1):
      PCI: thunder: Don't clobber read-only bits in bridge config registers

Gabriele Paoloni (1):
      PCI: designware: Remove incorrect RC memory base/limit configuration

Jacek Lawrynowicz (2):
      PCI: Add support for multiple DMA aliases
      PCI: Add DMA alias quirk for mic_x200_dma

Jayachandran C (2):
      PCI: Provide common functions for ECAM mapping
      PCI: generic, thunder: Use generic ECAM API

Jisheng Zhang (3):
      PCI: designware: Move Root Complex setup code to dw_pcie_setup_rc()
      PCI: mvebu: Constify mvebu_pcie_pm_ops structure
      PCI: mvebu: Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for mvebu_pcie_pm_ops

Jon Derrick (2):
      PCI/ACPI: Allow all PCIe services on non-ACPI host bridges
      PCI: Remove return values from pcie_port_platform_notify() and relatives

Keith Busch (3):
      PCI: Widen portdrv service type from 4 bits to 8 bits
      PCI: Add Downstream Port Containment portdrv service type
      PCI: Add Downstream Port Containment driver

Lukas Wunner (4):
      PCI: Add Intel Thunderbolt device IDs
      thunderbolt: Fix typos and magic number
      thunderbolt: Support 1st gen Light Ridge controller
      PCI: Use cached copy of PCI_EXP_SLTCAP_HPC bit

Murali Karicheri (2):
      PCI: keystone: Add error IRQ handler
      PCI: keystone: Remove unnecessary goto statement

Petr Štetiar (2):
      ARM: dts: imx6: Fix PCIe reset GPIO polarity on Toradex Apalis Ixora
      PCI: imx6: Add reset-gpio-active-high boolean property to DT

Prarit Bhargava (2):
      x86/PCI: Mark Broadwell-EP Home Agent 1 as having non-compliant BARs
      PCI: Disable all BAR sizing for devices with non-compliant BARs

Thomas Petazzoni (2):
      dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe controller
      PCI: armada: Add driver for Marvell Armada 7K/8K PCIe controller

Tim Harvey (1):
      PCI: imx6: Add DT property for link gen, default to Gen1

Tomasz Nowicki (1):
      PCI, of: Move PCI I/O space management to PCI core code

Vitaly Kuznetsov (2):
      PCI: hv: Report resources release after stopping the bus
      PCI: hv: Add explicit barriers to config space access

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  18 +-
 .../devicetree/bindings/pci/pci-armada8k.txt       |  38 +++
 .../devicetree/bindings/pci/pci-keystone.txt       |   1 +
 arch/alpha/kernel/pci-sysfs.c                      |   4 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |   5 +-
 arch/arm/boot/dts/imx6qp.dtsi                      |   3 +
 arch/x86/pci/common.c                              |   2 +-
 arch/x86/pci/fixup.c                               |   7 +
 drivers/iommu/iommu.c                              |  10 +-
 drivers/of/address.c                               | 116 +--------
 drivers/pci/Kconfig                                |   3 +
 drivers/pci/Makefile                               |   2 +
 drivers/pci/ecam.c                                 | 164 +++++++++++++
 drivers/pci/ecam.h                                 |  67 ++++++
 drivers/pci/host/Kconfig                           |  14 ++
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-dra7xx.c                      |   4 +-
 drivers/pci/host/pci-host-common.c                 | 114 ++++-----
 drivers/pci/host/pci-host-common.h                 |  47 ----
 drivers/pci/host/pci-host-generic.c                |  52 +---
 drivers/pci/host/pci-hyperv.c                      |  24 +-
 drivers/pci/host/pci-imx6.c                        | 213 +++++++++++++----
 drivers/pci/host/pci-keystone-dw.c                 |  38 +++
 drivers/pci/host/pci-keystone.c                    |  52 +++-
 drivers/pci/host/pci-keystone.h                    |   6 +
 drivers/pci/host/pci-mvebu.c                       |   7 +-
 drivers/pci/host/pci-thunder-ecam.c                |  39 +--
 drivers/pci/host/pci-thunder-pem.c                 | 134 ++++++-----
 drivers/pci/host/pcie-armada8k.c                   | 262 +++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 |  47 ++--
 drivers/pci/host/pcie-xilinx-nwl.c                 |   2 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |   2 +
 drivers/pci/pci-sysfs.c                            |   7 +-
 drivers/pci/pci.c                                  | 160 ++++++++++++-
 drivers/pci/pcie/Kconfig                           |  14 ++
 drivers/pci/pcie/Makefile                          |   2 +
 drivers/pci/pcie/pcie-dpc.c                        | 163 +++++++++++++
 drivers/pci/pcie/portdrv.h                         |  15 +-
 drivers/pci/pcie/portdrv_acpi.c                    |  12 +-
 drivers/pci/pcie/portdrv_core.c                    |  36 ++-
 drivers/pci/probe.c                                |   7 +-
 drivers/pci/quirks.c                               | 196 +++++++++++++--
 drivers/pci/search.c                               |  14 +-
 drivers/thunderbolt/ctl.c                          |   2 +-
 drivers/thunderbolt/eeprom.c                       |   8 +-
 drivers/thunderbolt/nhi.c                          |  19 +-
 drivers/thunderbolt/switch.c                       |  20 +-
 drivers/thunderbolt/tb.c                           |   2 +-
 drivers/thunderbolt/tb.h                           |   2 +-
 drivers/thunderbolt/tb_regs.h                      |   2 +-
 include/linux/ioport.h                             |   4 +
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   1 +
 include/linux/of_address.h                         |   9 -
 include/linux/pci.h                                |  18 +-
 include/linux/pci_ids.h                            |  18 ++
 include/linux/pcieport_if.h                        |   2 +
 include/uapi/linux/pci_regs.h                      |  20 +-
 57 files changed, 1664 insertions(+), 587 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 drivers/pci/ecam.h
 delete mode 100644 drivers/pci/host/pci-host-common.h
 create mode 100644 drivers/pci/host/pcie-armada8k.c
 create mode 100644 drivers/pci/pcie/pcie-dpc.c


From: Joerg Roedel <jroedel@suse.de>
Date: Tue, 17 May 2016 12:13:57 +0200
Subject: [PATCH] iommu/amd: Use pci_dma_add_alias function

The pci_dma_add_alias() function is the new interface and
replaces the old direct-access of 'struct pci_dev'. Convert the
last use of the old interface to the new one in the AMD
IOMMU driver.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5efadad..3839fd2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -263,8 +263,7 @@ static u16 get_alias(struct device *dev)
 	 */
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
-		pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		pdev->dma_alias_devfn = ivrs_alias & 0xff;
+		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
 		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
 			dev_name(dev));
-- 
2.6.6


