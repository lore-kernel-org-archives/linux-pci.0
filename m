Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v3 0/5] Simple ACPI based PCI support for arm64
Date: Wed, 16 Dec 2015 18:12:30 +0530
Message-ID: <1450269755-21420-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset provides a generic ACPI based PCI host controller
implementation and uses it on arm64.

The first patch moves the common code to handle MCFG ACPI table from
arch/x86 to drivers/acpi/pci_mcfg.c. The last patch in the patchset
provides the generic PCI host controller with a new file
driver/pci/host/pci-host-acpi.c. The other patches are to fix
up arm64 and ACPI code to work with these two patches.

The pci-host-acpi implementation keeps a reference to pci_mmcfg_region
entry so that config space access is done with a simple mapping and
generic PCI config read/write. There is also an implementation of
raw_pci_read/raw_pci_write provided by walking the pci_mmcfg_list

This is tested with arm64 QEMU and OVMF and on x86 with qemu.
Comments are very welcome.

Thanks,
JC.

v2->v3:
 - Move maintainence of the pci_mmcfg_list to drivers/acpi/pci_mcfg.c
   without changing x86 logic
 - use the pci_mmcfg_list in ARM64 implementation
 - provide raw_pci_read/raw_pci_write

v1->v2:
 - use CONFIG_PCI_MMCONFIG on arm64, provide a weak implementation
   of pci_mmcfg_late_init for arm64.
 - The real implementation of pci_mmcfg_late_init is in pci-host-acpi.c
   and it will save the MCFG table entries to an array. Earlier this
   was done with an arch_init call
 - remove unneeded pci_bus_add_devices call and fix MCFG saving code
 - Added a patch to ACPI pci_root.c to handle arm64 PCI IO resources

Jayachandran C (5):
  APCI: MCFG: Move mmcfg_list management to drivers/acpi
  arm64: pci: Add ACPI support
  PCI: Handle NULL parent in pci_bus_assign_domain_nr
  ACPI: PCI: Support platforms that need pci_remap_iospace
  PCI: ACPI: Add a generic ACPI based host controller

 arch/arm64/Kconfig               |   3 +
 arch/arm64/kernel/pci.c          |  65 ++++++++-
 arch/x86/include/asm/pci_x86.h   |  24 +---
 arch/x86/pci/mmconfig-shared.c   | 269 +++++------------------------------
 arch/x86/pci/mmconfig_32.c       |   1 +
 arch/x86/pci/mmconfig_64.c       |   1 +
 drivers/acpi/Makefile            |   1 +
 drivers/acpi/pci_mcfg.c          | 298 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pci_root.c          |  62 +++++++-
 drivers/acpi/resource.c          |   2 +
 drivers/pci/host/Kconfig         |   7 +
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-host-acpi.c | 193 +++++++++++++++++++++++++
 drivers/pci/pci.c                |   7 +-
 include/linux/pci-acpi.h         |  33 +++++
 15 files changed, 701 insertions(+), 266 deletions(-)
 create mode 100644 drivers/acpi/pci_mcfg.c
 create mode 100644 drivers/pci/host/pci-host-acpi.c

-- 
1.9.1

