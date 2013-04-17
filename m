Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35609 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765Ab3DQQSD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Apr 2013 12:18:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Changes for v3.10 merge window
Date: Wed, 17 Apr 2013 18:25:56 +0200
Message-ID: <1825980.1C7UKqDGj6@vostro.rjw.lan>
In-Reply-To: <20130416171732.GA6356@google.com>
References: <20130416171732.GA6356@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 16, 2013 11:17:32 AM Bjorn Helgaas wrote:
> Below are the patches currently in my "next" branch, planned for
> release in v3.10.  If I'm missing something important, let me know.

Well, you said you took the "PCI / PM: Make pci_pme_active() ignore devices
without PME support" patch for v3.10, but it is not listed below.

Thanks,
Rafael


> Andy Shevchenko (1):
>       PCI: Fix missing prototype for pcie_port_acpi_setup()
> 
> Bjorn Helgaas (20):
>       Merge branch 'pci/shuah-defines' into next
>       PCI: Remove __weak annotation from pcibios_get_phb_of_node decl
>       PCI: Make local functions/structs static
>       PCI: Move cpci_hotplug_init() proto to header file
>       PCI: Remove unused variables
>       PCI: Fix __must_check annotation on pci_create_sysfs_dev_files()
>       PCI: Remove __must_check from definitions
>       PCI: Warn about failures instead of "must_check" functions
>       PCI: Remove "extern" from function declarations
>       Merge branch 'pci/gabor-get-of-node' into next
>       PCI: Remove unnecessary dependencies between PME and ACPI
>       PCI: Use PCI_EXP_SLTCAP_PSN mask when extracting slot number
>       EISA: Use dev_printk() when possible
>       EISA: Mark vendor ID resource as I/O port space
>       EISA: Initialize device before its resources
>       EISA: Log device resources in dmesg
>       Merge branch 'pci/bjorn-eisa' into next
>       Merge branch 'pci/misc' into next
>       Merge branch 'pci/jiang-subdrivers' into next
>       Merge branch 'pci/cleanup' into next
> 
> Gabor Juhos (1):
>       MIPS/PCI: Implement pcibios_get_phb_of_node
> 
> Jiang Liu (12):
>       PCI: When removing bus, always remove legacy files & unregister
>       PCI: Clean up usages of pci_bus->is_added
>       PCI: acpiphp: Remove all functions even if function 0 doesn't exist
>       PCI: acpiphp: Replace local macros with standard ACPI macros
>       PCI: Add pcibios hooks for adding and removing PCI buses
>       PCI/ACPI: Prepare stub functions to handle ACPI PCI (hotplug) slots
>       ia64/PCI: Implement pcibios_{add|remove}_bus() hooks
>       x86/PCI: Implement pcibios_{add|remove}_bus() hooks
>       PCI/ACPI: Handle PCI slot devices when creating/destroying PCI buses
>       PCI: acpiphp: Convert acpiphp to be builtin only, not modular
>       PCI: acpiphp: Do not use ACPI PCI subdriver mechanism
>       PCI: acpiphp: Protect acpiphp data structures from concurrent updates
> 
> Libin (1):
>       PCI: Use vma_pages() to replace (vm_end - vm_start) >> PAGE_SHIFT
> 
> Myron Stowe (4):
>       ahci: Use PCI_VENDOR_ID_MARVELL_EXT for 0x1b4b
>       [SCSI] mvsas: Use PCI_VENDOR_ID_MARVELL_EXT for 0x1b4b
>       [SCSI] mvumi: Use PCI_VENDOR_ID_MARVELL_EXT for 0x1b4b
>       PCI/ACPI: Remove support of ACPI PCI subdrivers
> 
> Prarit Bhargava (1):
>       PCI: aer_inject: Fix return values when device not found
> 
> Shuah Khan (4):
>       PCI: Add PCI_BUS_NUM() and PCI_DEVID() interfaces
>       PCI/AER: Remove local PCI_BUS() define and use PCI_BUS_NUM() from PCI
>       iommu/amd: Remove local PCI_BUS() define and use PCI_BUS_NUM() from PCI
>       iommu/amd: Remove calc_devid() and use PCI_DEVID() from PCI
> 
> Xiangliang Yu (1):
>       PCI: Define macro for Marvell vendor ID
> 
> Xiong Huang (1):
>       PCI: Add MSI INTX_DISABLE quirks for AR8161/AR8162/AR8171/AR8172/E210X
> 
> Yijing Wang (2):
>       PCI: acpiphp: Use list_for_each_entry_safe() in acpiphp_sanitize_bus()
>       PCI: acpiphp: Use normal list to simplify implementation
> 
> Yinghai Lu (1):
>       PCI: Clean up quirk_io_region
> 
>  arch/ia64/pci/pci.c                    |  11 +
>  arch/mips/pci/pci.c                    |   8 +-
>  arch/x86/pci/common.c                  |  11 +
>  drivers/acpi/pci_root.c                |  48 +---
>  drivers/acpi/pci_slot.c                | 170 ++------------
>  drivers/acpi/scan.c                    |   1 -
>  drivers/ata/ahci.c                     |  10 +-
>  drivers/eisa/eisa-bus.c                |  82 +++----
>  drivers/eisa/pci_eisa.c                |   5 +-
>  drivers/iommu/amd_iommu.c              |  14 +-
>  drivers/iommu/amd_iommu_init.c         |  40 ++--
>  drivers/iommu/amd_iommu_types.h        |  11 +-
>  drivers/pci/bus.c                      |  18 +-
>  drivers/pci/hotplug/Kconfig            |   7 +-
>  drivers/pci/hotplug/acpiphp.h          |  35 ++-
>  drivers/pci/hotplug/acpiphp_core.c     |  30 +--
>  drivers/pci/hotplug/acpiphp_glue.c     | 415 ++++++++++++---------------------
>  drivers/pci/hotplug/cpci_hotplug.h     |  44 ++--
>  drivers/pci/hotplug/cpqphp.h           |  70 +++---
>  drivers/pci/hotplug/cpqphp_nvram.h     |  12 +-
>  drivers/pci/hotplug/ibmphp.h           |  66 +++---
>  drivers/pci/hotplug/pci_hotplug_core.c |  15 +-
>  drivers/pci/hotplug/pciehp.h           |  22 +-
>  drivers/pci/hotplug/pciehp_acpi.c      |   2 +-
>  drivers/pci/hotplug/rpadlpar.h         |   8 +-
>  drivers/pci/hotplug/rpaphp.h           |  16 +-
>  drivers/pci/hotplug/shpchp.h           |  26 +--
>  drivers/pci/hotplug/shpchp_sysfs.c     |   2 +-
>  drivers/pci/msi.c                      |   4 +-
>  drivers/pci/pci-acpi.c                 |  30 +++
>  drivers/pci/pci-sysfs.c                |   4 +-
>  drivers/pci/pci.c                      |   8 +-
>  drivers/pci/pci.h                      |  89 ++++---
>  drivers/pci/pcie/Kconfig               |   2 +-
>  drivers/pci/pcie/aer/aer_inject.c      |  10 +-
>  drivers/pci/pcie/aer/aerdrv.h          |  14 +-
>  drivers/pci/pcie/aer/aerdrv_core.c     |   4 +-
>  drivers/pci/pcie/pme.c                 |   2 -
>  drivers/pci/pcie/portdrv.h             |  18 +-
>  drivers/pci/pcie/portdrv_acpi.c        |   1 +
>  drivers/pci/pcie/portdrv_pci.c         |  17 +-
>  drivers/pci/probe.c                    |  15 +-
>  drivers/pci/quirks.c                   | 148 +++++-------
>  drivers/pci/remove.c                   |   4 +-
>  drivers/pci/setup-bus.c                |   4 +-
>  drivers/pci/setup-res.c                |   2 -
>  drivers/pci/slot.c                     |   7 +-
>  drivers/scsi/mvsas/mv_init.c           |   6 +-
>  drivers/scsi/mvumi.c                   |   4 +-
>  drivers/scsi/mvumi.h                   |   1 -
>  include/linux/acpi.h                   |   9 -
>  include/linux/pci-acpi.h               |  29 +++
>  include/linux/pci-aspm.h               |  20 +-
>  include/linux/pci-ats.h                |  26 +--
>  include/linux/pci.h                    | 112 +++++----
>  include/linux/pci_hotplug.h            |  12 +-
>  include/linux/pci_ids.h                |   1 +
>  include/linux/pcieport_if.h            |   4 +-
>  58 files changed, 764 insertions(+), 1042 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
