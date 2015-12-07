Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v2 0/4] Simple ACPI based PCI support for arm64
Date: Mon, 7 Dec 2015 22:50:25 +0530
Message-ID: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a very simple and generic implementation of a PCI host controller
based on ACPI. This approach does not pull in the MMCONFIG and ECAM code
from x86. The MCFG table is a simple ACPI table, and there is no need to
move the complex code from x86 (sorted linked list with a lot of global
vars) to acpi for parsing it.

The config space access is done with pci-host-generic style simple
mapping and generic PCI config read/write.

This is tested with arm64 QEMU and OVMF. Comments are very welcome.

I would also add that I am posting this as an option, if another
implementation is accepted upstream, I would happily drop this.

Thanks,
JC.

v1->v2:
 - use CONFIG_PCI_MMCONFIG on arm64, provide a weak implementation
   of pci_mmcfg_late_init for arm64.
 - The real implementation of pci_mmcfg_late_init is in pci-host-acpi.c
   and it will save the MCFG table entries to an array. Earlier this
   was done with an arch_init call
 - remove unneeded pci_bus_add_devices call and fix MCFG saving code
 - Added a patch to ACPI pci_root.c to handle arm64 PCI IO resources

Jayachandran C (4):
  arm64: pci: Add ACPI support
  PCI: Handle NULL parent in pci_bus_assign_domain_nr
  PCI: ACPI: Add a generic ACPI based host controller
  ACPI: PCI: Support platforms that need pci_remap_iospace

 arch/arm64/Kconfig               |   3 +
 arch/arm64/kernel/pci.c          |  50 +++++++++-
 drivers/acpi/pci_root.c          |  62 +++++++++++-
 drivers/acpi/resource.c          |   2 +
 drivers/pci/host/Kconfig         |   7 ++
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-host-acpi.c | 209 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c                |   7 +-
 8 files changed, 335 insertions(+), 6 deletions(-)
 create mode 100644 drivers/pci/host/pci-host-acpi.c

-- 
1.9.1

