Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH v7 0/5] ACPI based PCI support for arm64
Date: Fri, 29 Jan 2016 14:35:35 +0530
Message-ID: <1454058340-7904-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here is another update to this patchset.

This patchset provides a generic ACPI based PCI host controller
implementation and uses it on arm64.

The first patch moves the common code to handle MCFG ACPI table from
arch/x86 to drivers/acpi/pci_mcfg.c. The last patch in the patchset
provides the generic implementation of an ACPI based PCI host
controller with a new file drivers/acpi/pci_host_acpi.c. The other
patches are to fix up arm64 and ACPI code to work with these two
patches.

The pci host controller implementation keeps a reference to
pci_mmcfg_region entry so that config space access is done with a
simple mapping and generic PCI config read/write. There is also an
implementation of raw_pci_read/raw_pci_write provided by walking the
pci_mmcfg_list.

The patchset is against 4.5-rc1. This is tested with arm64 QEMU and
OVMF and on x86 with qemu.

More testing or comments are welcome. The idea is to provide a
simpler alternative for ACPI PCI support in arm64, any feedback
from PCI or ACPI maintainers would be appreciated on this front.

Thanks,
JC.

v6->v7:
 - minor update of patches so that CONFIG_ACPI_PCI_HOST_GENERIC
   is only used when it is defined
 - rebased to 4.5-rc1

v5->v6:
 - fix arm64 with xen compile issue reported by kbuild bot

v4->v5:
 - Fix arm build issue reported by the kbuild bot
 - Use config_enabled instead of ifdef in pci_mcfg.c

v3->v4:
 - Handle suggestions from Arnd Bergmann <arnd@arndb.de>
    * move the implementation of host controller to drivers/acpi
      under config option CONFIG_ACPI_PCI_HOST_GENERIC
    * remove unnecessary arch hooks (this done as much as possible
      without affecting the scope of the patch, will need another
      separate patchset for the rest).
    * remove pcibios_assign_resources fs_initcall that was added
 - fixup domain_nr assignment code, and move ACPI companion set
   to PCI code.
 - Call map resource correctly in setup code
 - fix kbuild robot report
 - More testing

v2->v3:
 - Move maintenance of the pci_mmcfg_list to drivers/acpi/pci_mcfg.c
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
  PCI: Handle ACPI companion and domain number
  ACPI: PCI: Support platforms that need pci_remap_iospace
  arm64: pci: Add ACPI support
  PCI: ACPI: Add a generic ACPI based host controller

Jayachandran C (5):
  APCI: MCFG: Move mmcfg_list management to drivers/acpi
  ACPI: PCI: Support platforms that need pci_remap_iospace
  PCI: Handle ACPI companion and domain number
  arm64: pci: Add ACPI support
  PCI: ACPI: Add a generic ACPI based host controller

 arch/arm64/Kconfig             |   3 +
 arch/arm64/kernel/pci.c        |  34 ++++-
 arch/x86/include/asm/pci_x86.h |  24 +---
 arch/x86/pci/mmconfig-shared.c | 269 +++++------------------------------
 arch/x86/pci/mmconfig_32.c     |   1 +
 arch/x86/pci/mmconfig_64.c     |   1 +
 arch/x86/pci/numachip.c        |   1 +
 drivers/acpi/Kconfig           |   8 ++
 drivers/acpi/Makefile          |   2 +
 drivers/acpi/pci_host_acpi.c   | 186 ++++++++++++++++++++++++
 drivers/acpi/pci_mcfg.c        | 312 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pci_root.c        |  62 +++++++-
 drivers/acpi/resource.c        |   2 +
 drivers/pci/pci.c              |  15 +-
 drivers/pci/probe.c            |   2 +
 drivers/xen/pci.c              |   5 +-
 include/linux/pci-acpi.h       |  59 ++++++++
 17 files changed, 717 insertions(+), 269 deletions(-)
 create mode 100644 drivers/acpi/pci_host_acpi.c
 create mode 100644 drivers/acpi/pci_mcfg.c

-- 
1.9.1

