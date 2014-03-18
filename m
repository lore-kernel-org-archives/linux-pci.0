Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48122 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbaCRV1h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Mar 2014 17:27:37 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so7949426pbc.27
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2014 14:27:36 -0700 (PDT)
Received: from google.com ([172.19.249.211])
        by mx.google.com with ESMTPSA id ug9sm55703634pbc.11.2014.03.18.14.27.35
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 14:27:35 -0700 (PDT)
Date: Tue, 18 Mar 2014 15:27:33 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Changes for v3.15 merge window
Message-ID: <20140318212733.GA2467@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here are the contents of my "next" branch, planned for release in v3.15.
Let me know if I'm missing something important.


Alex Williamson (3):
      PCI: Add device-specific PCI ACS enable
      PCI: Add pci_dev_flag for ACS enable quirks
      PCI: Enable quirks for PCIe ACS on Intel PCH root ports

Alexander Gordeev (6):
      PCI/MSI: Add pci_enable_msi() documentation back
      PCI/MSI: Fix cut-and-paste errors in documentation
      PCI/MSI: Add pci_enable_msi_exact() and pci_enable_msix_exact()
      ahci: Fix broken fallback to single MSI mode
      ahci: Use pci_enable_msi_range() instead of pci_enable_msi_block()
      vfio: Use pci_enable_msi_range() and pci_enable_msix_range()

Andreas Noever (8):
      PCI: Increment max correctly in pci_scan_bridge()
      PCI: Clarify the "scan anyway" comment in pci_scan_bridge()
      PCI: Assign CardBus bus number only during the second pass
      PCI: Use request_resource_conflict() instead of insert_ for bus numbers
      PCI: Make sure bus number resources stay within their parents bounds
      PCI: Remove pci_fixup_parent_subordinate_busnr()
      PCI: Check for child busses which use more bus numbers than allocated
      PCI: Don't scan random busses in pci_scan_bridge()

Andrew Lunn (1):
      PCI: mvebu: Use Device ID and revision from underlying endpoint

Ben Dooks (3):
      PCI: rcar: Check platform_get_irq() return code
      PCI: rcar: Add error interrupt handling
      PCI: rcar: Fix bridge logic configuration accesses

Bjorn Helgaas (68):
      x86/PCI: Drop pcibios_scan_root() check for bus already scanned
      x86/PCI: Use pcibios_scan_root() instead of pci_scan_bus_with_sysdata()
      x86/PCI: Use pcibios_scan_root() instead of pci_scan_bus_on_node()
      x86/PCI: Merge pci_scan_bus_on_node() into pcibios_scan_root()
      x86/PCI: Drop return value of pcibios_scan_root()
      x86/PCI: Add x86_pci_root_bus_node() to look up NUMA node from PCI bus
      x86/PCI: Use x86_pci_root_bus_node() instead of get_mp_bus_to_node()
      x86/PCI: Remove mp_bus_to_node[], set_mp_bus_to_node(), get_mp_bus_to_node()
      x86/PCI: Remove unnecessary list_empty(&pci_root_infos) check
      x86/PCI: Use NUMA_NO_NODE, not -1, for unknown node
      x86/PCI: Remove acpi_get_pxm() usage
      ia64 / sba_iommu: Use NUMA_NO_NODE, not MAX_NUMNODES, for unknown node
      ia64: Remove acpi_get_pxm() usage
      ACPI / numa: Fix acpi_get_node() prototype
      ACPI / numa: Simplify acpi_get_node() style
      ACPI / numa: Make __acpi_map_pxm_to_node(), acpi_get_pxm() static
      ACPI / numa: Use __weak, not the gcc-specific version
      Merge branch 'pci/numa-cleanup' into next
      PCI: Remove unnecessary list_empty(&pci_pme_list) check
      x86/PCI: Remove unnecessary local variable initialization
      x86/PCI: Reword comments
      x86/PCI: Fix function definition whitespace
      Merge branch 'pci/scan-bridge' into next
      Merge branch 'pci/virtualization' into next
      Merge branch 'pci/msi' into next
      misc: mic: Add include of <linux/irqreturn.h>
      Merge branch 'pci/list-for-each-entry' into next
      Merge branch 'pci/host-mvebu' into next
      PCI: Enable INTx if BIOS left them disabled
      Merge branch 'pci/misc' into next
      mei: Add include of <linux/irqreturn.h>
      iommu/amd: Add include of <linux/irqreturn.h>
      PCI: Remove unused SR-IOV VF Migration support
      PCI: pciehp: Cleanup whitespace
      Merge branch 'pci/list-for-each-entry' into next
      Merge branch 'pci/pciehp' into next
      Merge branch 'pci/dead-code' into next
      i2o: Fix I/O space allocation copy/paste error
      i2o: Fix I/O space alignment requirement
      i2o: Refactor i2o_iop_systab_set() PCI space allocation
      Merge branches 'pci/host-designware', 'pci/host-imx6' and 'pci/host-rcar' into next
      i2o: Use pci_bus_alloc_resource(), not allocate_resource() directly
      resource: Add resource_contains()
      vsprintf: Add support for IORESOURCE_UNSET in %pR
      PCI: Remove pci_find_parent_resource() use for allocation
      PCI: Mark resources as IORESOURCE_UNSET if we can't assign them
      PCI: Don't clear IORESOURCE_UNSET when updating BAR
      PCI: Check IORESOURCE_UNSET before updating BAR
      PCI: Don't try to claim IORESOURCE_UNSET resources
      PCI: Ignore BAR contents when firmware left decoding disabled
      PCI: Don't enable decoding if BAR hasn't been assigned an address
      PCI: Add "weak" generic pcibios_enable_device() implementation
      alpha/PCI: Use default pcibios_enable_device()
      microblaze/PCI: Use default pcibios_enable_device()
      sh/PCI: Use default pcibios_enable_device()
      sparc/PCI: Use default pcibios_enable_device() (Leon only)
      tile PCI RC: Use default pcibios_enable_device()
      s390/PCI: Use generic pci_enable_resources()
      Merge branch 'pci/resource' into next
      PCI: Enable INTx in pci_reenable_device() only when MSI/MSI-X not enabled
      PCI: Don't check resource_size() in pci_bus_alloc_resource()
      resources: Set type in __request_region()
      PCI: Check all IORESOURCE_TYPE_BITS in pci_bus_alloc_from_region()
      PCI: Change pci_bus_alloc_resource() type_mask to unsigned long
      PCI: Log IDE resource quirk in dmesg
      Revert "[PATCH] Insert GART region into resource map"
      Merge branch 'pci/misc' into next
      Merge branch 'pci/resource' into next

Dan Carpenter (1):
      PCI: cpqphp: Fix hex vs decimal typo in cpqhpc_probe()

Greg Kroah-Hartman (2):
      PCI/MSI: Check kmalloc() return value, fix leak of name
      PCI/MSI: Fix leak of msi_attrs

Jason Gunthorpe (2):
      bus: mvebu-mbus: Fix incorrect size for PCI aperture resources
      PCI: mvebu: Call request_resource() on the apertures

Jean-Jacques Hiblot (1):
      PCI: mvebu: Fix potential issue in range parsing

Liviu Dudau (1):
      PCI: Cleanup per-arch list of object files

Magnus Damm (3):
      PCI: rcar: Register each instance independently
      PCI: rcar: Break out window size handling
      PCI: rcar: Make the Kconfig dependencies more generic

Marek Vasut (1):
      PCI: imx6: Wait for retraining

Masanari Iida (1):
      PCI/MSI: Fix pci_msix_vec_count() htmldocs failure

Mohit Kumar (1):
      PCI: designware: Fix RC BAR to be single 64-bit non-prefetchable memory BAR

Paul Gortmaker (1):
      PCI: frv: replace now removed pci_bus_b() causing build failure

Rajat Jain (9):
      PCI: pciehp: Make check_link_active() non-static
      PCI: pciehp: Use link change notifications for hot-plug and removal
      PCI: pciehp: Enable link state change notifications
      PCI: pciehp: Don't disable the link permanently during removal
      PCI: pciehp: Don't check adapter or latch status while disabling
      PCI: pciehp: Disable link notification across slot reset
      PCI: pciehp: Ensure very fast hotplug events are also processed
      PCI: pciehp: Add hotplug_lock to serialize hotplug events
      PCI: pciehp: Remove a non-existent card, regardless of "surprise" capability

Sander Eikelenboom (2):
      x86/PCI: Set IORESOURCE_ROM_SHADOW only for the default VGA device
      ia64/PCI: Set IORESOURCE_ROM_SHADOW only for the default VGA device

Yijing Wang (8):
      PCI: pciehp: Don't turn slot off when hot-added device already exists
      PCI: Update outdated comment for pcibios_bus_report_status()
      ACPI / hotplug / PCI: Use list_for_each_entry() for bus traversal
      ARM/PCI: Use list_for_each_entry() for bus traversal
      drm: Use list_for_each_entry() for bus traversal
      powerpc/PCI: Use list_for_each_entry() for bus traversal
      pcmcia: Use list_for_each_entry() for bus traversal
      PCI: Remove pci_bus_b() and use list_for_each_entry() directly

 Documentation/PCI/MSI-HOWTO.txt            | 119 ++++++++++++++++--
 Documentation/PCI/pci-iov-howto.txt        |   4 -
 arch/alpha/kernel/pci.c                    |   6 -
 arch/arm/kernel/bios32.c                   |   9 +-
 arch/frv/mb93090-mb00/pci-frv.c            |   2 +-
 arch/ia64/hp/common/sba_iommu.c            |  32 ++---
 arch/ia64/include/asm/pci.h                |   2 +-
 arch/ia64/kernel/acpi.c                    |  28 ++---
 arch/ia64/pci/fixup.c                      |  25 ++--
 arch/ia64/pci/pci.c                        |  10 +-
 arch/microblaze/pci/pci-common.c           |   5 -
 arch/powerpc/kernel/pci_64.c               |   4 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c |   6 +-
 arch/s390/pci/pci.c                        |  16 +--
 arch/sh/drivers/pci/pci.c                  |   5 -
 arch/sparc/kernel/leon_pci.c               |   5 -
 arch/tile/kernel/pci_gx.c                  |  12 --
 arch/x86/include/asm/pci.h                 |   7 +-
 arch/x86/include/asm/topology.h            |  14 +--
 arch/x86/kernel/aperture_64.c              |  20 +--
 arch/x86/pci/acpi.c                        |  59 +++------
 arch/x86/pci/amd_bus.c                     |  10 --
 arch/x86/pci/bus_numa.c                    |  13 +-
 arch/x86/pci/common.c                      | 128 +++----------------
 arch/x86/pci/fixup.c                       |  24 ++--
 arch/x86/pci/irq.c                         |   6 +-
 arch/x86/pci/legacy.c                      |   4 +-
 arch/x86/pci/numaq_32.c                    |   6 +-
 arch/x86/pci/visws.c                       |   4 +-
 drivers/acpi/numa.c                        |  16 +--
 drivers/ata/ahci.c                         |  18 +--
 drivers/bus/mvebu-mbus.c                   |   4 +-
 drivers/gpu/drm/drm_fops.c                 |   3 +-
 drivers/iommu/amd_iommu_types.h            |   1 +
 drivers/message/i2o/iop.c                  |  85 +++++++------
 drivers/misc/mei/hw-me.h                   |   1 +
 drivers/misc/mic/card/mic_device.h         |   1 +
 drivers/misc/mic/host/mic_device.h         |   1 +
 drivers/pci/Makefile                       |  22 ++--
 drivers/pci/bus.c                          |   8 +-
 drivers/pci/host-bridge.c                  |   8 --
 drivers/pci/host/Kconfig                   |   2 +-
 drivers/pci/host/pci-imx6.c                |  47 +++++--
 drivers/pci/host/pci-mvebu.c               |  37 ++++--
 drivers/pci/host/pci-rcar-gen2.c           | 180 +++++++++++++++++----------
 drivers/pci/host/pcie-designware.c         |   2 +-
 drivers/pci/hotplug/acpiphp_glue.c         |   6 +-
 drivers/pci/hotplug/cpqphp_core.c          |   4 +-
 drivers/pci/hotplug/pciehp.h               |   5 +
 drivers/pci/hotplug/pciehp_acpi.c          |   1 +
 drivers/pci/hotplug/pciehp_core.c          |   8 +-
 drivers/pci/hotplug/pciehp_ctrl.c          | 173 ++++++++++++++++++++------
 drivers/pci/hotplug/pciehp_hpc.c           |  75 ++++++------
 drivers/pci/hotplug/pciehp_pci.c           |   2 +-
 drivers/pci/iov.c                          | 119 ------------------
 drivers/pci/msi.c                          |  10 +-
 drivers/pci/pci.c                          | 131 +++++++++++++-------
 drivers/pci/pci.h                          |   4 -
 drivers/pci/probe.c                        | 100 ++++++++-------
 drivers/pci/quirks.c                       | 190 +++++++++++++++++++++++++++++
 drivers/pci/rom.c                          |   2 +
 drivers/pci/search.c                       |  10 +-
 drivers/pci/setup-res.c                    |  37 ++++--
 drivers/pcmcia/yenta_socket.c              |  18 +--
 drivers/vfio/pci/vfio_pci_intrs.c          |  12 +-
 include/acpi/acpi_numa.h                   |   1 -
 include/linux/acpi.h                       |   9 +-
 include/linux/ioport.h                     |  12 +-
 include/linux/pci.h                        |  31 ++++-
 kernel/resource.c                          |  12 +-
 lib/vsprintf.c                             |  13 +-
 71 files changed, 1102 insertions(+), 904 deletions(-)
