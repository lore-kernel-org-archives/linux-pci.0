Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57892 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab2IWF0F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Sep 2012 01:26:05 -0400
Received: by pbbrr4 with SMTP id rr4so5255945pbb.19
        for <linux-pci@vger.kernel.org>; Sat, 22 Sep 2012 22:26:04 -0700 (PDT)
Message-ID: <505E9D5E.6030003@gmail.com>
Date: Sun, 23 Sep 2012 13:25:50 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: Changes for 3.7 merge window
References: <CAErSpo6UJQ-ZCZ9CjeOA6_2F_YPbVXzt5FPmPPzfkKmJML0ZdQ@mail.gmail.com>
In-Reply-To: <CAErSpo6UJQ-ZCZ9CjeOA6_2F_YPbVXzt5FPmPPzfkKmJML0ZdQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
	Could we get this small patch merged for 3.7 window?
	https://patchwork.kernel.org/patch/1362151/
	Thanks!
	Gerry

On 09/22/2012 05:16 AM, Bjorn Helgaas wrote:
> The 3.7 merge window should open soon.  Below is what I currently have
> queued up in my "next" branch.  If I'm missing something important,
> let me know.
> 
> In addition to what's already in my "next" branch, I expect to merge
> these pending patches:
> 
> Taku:
>     e3faec8 PCI/ACPI: Add resource-assign code for devices under
> hot-added hostbridge
>     4c695d4 PCI/ACPI: Use acpi_driver_data() rather than searching
> acpi_pci_roots
>     d3c6632 PCI/ACPI: Protect acpi_pci_roots list with mutex
>     fcd9871 PCI/ACPI: Use acpi_pci_root info rather than looking it up again
>     3edf0e7 PCI/ACPI: Pass acpi_pci_root to acpi_pci_drivers'
> add/remove interface
>     5a66836 PCI/ACPI: Protect acpi_pci_drivers list with mutex
>     1e0cf7f PCI/ACPI: Notify acpi_pci_drivers when hot-plugging PCI root bridges
>     b57fdd9 PCI/ACPI: Use normal list for struct acpi_pci_driver
> 
> Yinghai:
>     da10491 ia64/PCI: Clear host bridge aperture struct resource
>     4cd8daf x86/PCI: Clear host bridge aperture struct resource
>     817a268 PCI: Use correct type when freeing bus resource list
>     1965f66 PCI: Check P2P bridge for invalid secondary/subordinate range
> 
> 
> Here's the main list of what's already in "next":
> 
> Alan Cox (1):
>       PCI: cpqphp: Remove unreachable path
> 
> Bjorn Helgaas (38):
>       PCI: acpiphp: Stop disabling bridges on remove
>       PCI: acpiphp: Use common pci_stop_and_remove_bus_device()
>       pcmcia: Use common pci_stop_and_remove_bus_device()
>       PCI: Don't export stop_bus_device and remove_bus_device interfaces
>       PCI: Remove pci_stop_and_remove_behind_bridge()
>       PCI: Use list_for_each_entry() for bus->devices traversal
>       PCI: Fold stop and remove helpers into their callers
>       PCI: Stop and remove devices in one pass
>       PCI: Remove unused, commented-out, code
>       PCI: Rename local variables to conventional names
>       PCI: Leave normal LIST_POISON in deleted list entries
>       frv/PCI: Use list_for_each_entry() for bus->devices traversal
>       parisc/PCI: Enable PERR/SERR on all devices
>       parisc/PCI: Use list_for_each_entry() for bus->devices traversal
>       sgi-agp: Use list_for_each_entry() for bus->devices traversal
>       PCI: Remove unused pci_dev_b()
>       PCI: Add pci_find_next_ext_capability()
>       PCI: Add Vendor-Specific Extended Capability header info
>       PCI: Wait for pending transactions to complete before 82599 FLR
>       r8169: Preserve other Device Control bits when setting NOSNOOP_EN
>       Merge branch 'pci/jiang-pcie-cap' into next
>       Merge branch 'pci/bjorn-find-next-ext-cap' into next
>       Merge branch 'pci/bjorn-cleanup-remove' into next
>       PCI: Remove the fakephp driver
>       PCI: Remove bus number resource debug messages
>       Merge branch 'pci/bjorn-remove-fakephp' into next
>       Merge branch 'pci/feng-avoid-kmalloc' into next
>       Merge branch 'pci/oliver-pciehp-resume' into next
>       Merge branch 'pci/shengzhou-irq' into next
>       Merge branch 'pci/gavin-window-alignment' into next
>       Merge branch 'pci/stephen-const' into next
>       Merge commit 'v3.6-rc5' into next
>       Merge branch 'pci/trivial' into next
>       Merge branch 'pci/jiang-get-domain-bus-slot' into next
>       Merge branch 'pci/konstantin-sysfs' into next
>       Merge branch 'pci/thierry-fixup-irqs' into next
>       Revert "PCI: Use hotplug-safe pci_get_domain_bus_and_slot()"
>       Merge branch
> 'pci/yinghai-revert-pci_find_bus-and-remove-cleanup' into next
> 
> Feng Tang (2):
>       PCI: Use pci_device_id on stack for pci_get_subsys/class() to
> avoid kmalloc
>       PCI: Remove the obsolete no_pci_devices() check
> 
> Gavin Shan (5):
>       PCI: Add weak pcibios_window_alignment() interface
>       PCI: Align P2P windows using pcibios_window_alignment()
>       PCI: Refactor pbus_size_mem()
>       powerpc/PCI: Override pcibios_window_alignment()
>       powerpc/powernv: I/O and memory alignment for P2P bridges
> 
> Jan Beulich (1):
>       PCI: Drop bogus default from ARCH_SUPPORTS_MSI
> 
> Jiang Liu (40):
>       PCI: Add accessors for PCI Express Capability
>       PCI/core: Use PCI Express Capability accessors
>       PCI/hotplug: Use PCI Express Capability accessors
>       PCI/portdrv: Use PCI Express Capability accessors
>       PCI/pciehp: Use PCI Express Capability accessors
>       PCI/PME: Use PCI Express Capability accessors
>       PCI/AER: Use PCI Express Capability accessors
>       PCI/ASPM: Use PCI Express Capability accessors
>       ARM: PCI: Use PCI Express Capability accessors
>       MIPS: PCI: Use PCI Express Capability accessors
>       tile: PCI: Use PCI Express Capability accessors
>       r8169: Use PCI Express Capability accessors
>       bnx2x: Use PCI Express Capability accessors
>       tg3: Use PCI Express Capability accessors
>       e1000e: Use PCI Express Capability accessors
>       igb: Use PCI Express Capability accessors
>       vxge: Use PCI Express Capability accessors
>       mlx4: Use PCI Express Capability accessors
>       niu: Use PCI Express Capability accessors
>       myri10ge: Use PCI Express Capability accessors
>       cxgb3: Use PCI Express Capability accessors
>       cxgb4: Use PCI Express Capability accessors
>       atl1c: Use PCI Express Capability accessors
>       ath9k: Use PCI Express Capability accessors
>       iwlegacy: Use PCI Express Capability accessors
>       iwlwifi: Use PCI Express Capability accessors
>       rtlwifi: Use PCI Express Capability accessors
>       IB/mthca: Use PCI Express Capability accessors
>       IB/qib: Use PCI Express Capability accessors
>       [SCSI] qla4xxx: Use PCI Express Capability accessors
>       [SCSI] qla4xxx: Use PCI Express Capability accessors
>       drm/radeon: Use PCI Express Capability accessors
>       rapdio/tsi721: Use PCI Express Capability accessors
>       et131x: Use PCI Express Capability accessors
>       rtl8192e: Use PCI Express Capability accessors
>       ia64/PCI: Use hotplug-safe pci_get_domain_bus_and_slot()
>       PCI/vga: Use hotplug-safe pci_get_domain_bus_and_slot()
>       PCI/cpcihp: Use hotplug-safe pci_get_domain_bus_and_slot()
>       PCI: Use hotplug-safe pci_get_domain_bus_and_slot()
>       xen-pcifront: Use hotplug-safe pci_get_domain_bus_and_slot()
> 
> Konstantin Khlebnikov (1):
>       PCI: Convert "new_id"/"remove_id" into generic pci_bus driver attributes
> 
> Lance Ortiz (1):
>       PCI/AER: Print completion message at KERN_INFO to match starting message
> 
> Mathias Krause (1):
>       PCI: Drop duplicate const in DECLARE_PCI_FIXUP_SECTION
> 
> Oliver Neukum (1):
>       PCI: pciehp: Always implement resume, regardless of pciehp_force param
> 
> Randy Dunlap (1):
>       PCI: Fix drivers/pci/pci.c kernel-doc warnings
> 
> Shengzhou Liu (1):
>       PCI: Use dev->irq instead of dev->pin to enable non MSI/INTx interrupt
> 
> Stephen Hemminger (4):
>       PCI: Make pci_error_handlers const
>       netdev: make pci_error_handlers const
>       scsi: make pci error handlers const
>       make drivers with pci error handlers const
> 
> Thierry Reding (2):
>       PCI: Discard __init annotations for pci_fixup_irqs() and related functions
>       PCI: Provide a default pcibios_update_irq()
> 
> Yijing Wang (3):
>       PCI: Add pcie_flags_reg to cache PCIe capabilities register
>       PCI: Introduce pci_pcie_type(dev) to replace pci_dev->pcie_type
>       PCI: Remove unused field pcie_type from struct pci_dev
> 
> Yinghai Lu (1):
>       PCI: Stop all children first, before removing all children
> 
>  Documentation/feature-removal-schedule.txt         |  32 --
>  arch/alpha/kernel/pci.c                            |   6 -
>  arch/arm/kernel/bios32.c                           |   9 -
>  arch/arm/mach-tegra/pcie.c                         |  12 +-
>  arch/frv/mb93090-mb00/pci-vdk.c                    |   4 +-
>  arch/ia64/pci/pci.c                                |   8 -
>  arch/ia64/sn/kernel/io_common.c                    |   4 +-
>  arch/m68k/kernel/pcibios.c                         |   5 -
>  arch/mips/pci/pci-octeon.c                         |  15 +-
>  arch/mips/pci/pci.c                                |   6 -
>  arch/powerpc/include/asm/machdep.h                 |   3 +
>  arch/powerpc/kernel/pci-common.c                   |  20 ++
>  arch/powerpc/platforms/powernv/pci-ioda.c          |  41 ++-
>  arch/sh/drivers/pci/pci.c                          |   5 -
>  arch/sparc/kernel/leon_pci.c                       |   9 -
>  arch/sparc/kernel/pci.c                            |   4 -
>  arch/tile/kernel/pci.c                             |  34 +-
>  arch/tile/kernel/pci_gx.c                          |   8 -
>  arch/unicore32/kernel/pci.c                        |   8 -
>  arch/x86/pci/visws.c                               |   5 -
>  arch/xtensa/kernel/pci.c                           |   8 -
>  drivers/block/nvme.c                               |   2 +-
>  drivers/char/agp/sgi-agp.c                         |   5 +-
>  drivers/gpu/drm/radeon/evergreen.c                 |  10 +-
>  drivers/gpu/vga/vgaarb.c                           |  15 +-
>  drivers/infiniband/hw/mthca/mthca_reset.c          |   8 +-
>  drivers/infiniband/hw/qib/qib.h                    |   2 +-
>  drivers/infiniband/hw/qib/qib_pcie.c               |  40 +--
>  drivers/iommu/intel-iommu.c                        |   6 +-
>  drivers/media/dvb/ngene/ngene-cards.c              |   2 +-
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   4 +-
>  drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   2 +-
>  drivers/net/ethernet/broadcom/bnx2.c               |   2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  20 +-
>  drivers/net/ethernet/broadcom/tg3.c                |  52 +--
>  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |   2 +-
>  drivers/net/ethernet/chelsio/cxgb3/t3_hw.c         |  22 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  12 +-
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   6 +-
>  drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
>  drivers/net/ethernet/intel/e100.c                  |   2 +-
>  drivers/net/ethernet/intel/e1000/e1000_main.c      |   2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c         |  29 +-
>  drivers/net/ethernet/intel/igb/igb_main.c          |  14 +-
>  drivers/net/ethernet/intel/igbvf/netdev.c          |   2 +-
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c        |   2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   4 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   2 +-
>  drivers/net/ethernet/mellanox/mlx4/main.c          |   2 +-
>  drivers/net/ethernet/mellanox/mlx4/reset.c         |   8 +-
>  drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |  31 +-
>  drivers/net/ethernet/neterion/s2io.c               |   2 +-
>  drivers/net/ethernet/neterion/vxge/vxge-config.c   |   4 +-
>  drivers/net/ethernet/neterion/vxge/vxge-main.c     |   2 +-
>  .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |   2 +-
>  .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   4 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |   2 +-
>  drivers/net/ethernet/qlogic/qlge/qlge_main.c       |   2 +-
>  drivers/net/ethernet/realtek/r8169.c               |  44 +--
>  drivers/net/ethernet/sun/niu.c                     |  19 +-
>  drivers/net/wireless/ath/ath9k/pci.c               |  21 +-
>  drivers/net/wireless/iwlegacy/common.h             |   4 +-
>  drivers/net/wireless/iwlwifi/pcie/trans.c          |   7 +-
>  drivers/net/wireless/rtlwifi/pci.c                 |   8 +-
>  drivers/parisc/dino.c                              |  10 +-
>  drivers/parisc/lba_pci.c                           |   7 +-
>  drivers/pci/Kconfig                                |   1 -
>  drivers/pci/access.c                               | 202 ++++++++++++
>  drivers/pci/hotplug/Kconfig                        |  24 +-
>  drivers/pci/hotplug/Makefile                       |   3 -
>  drivers/pci/hotplug/acpiphp_glue.c                 |  46 +--
>  drivers/pci/hotplug/cpcihp_generic.c               |   8 +-
>  drivers/pci/hotplug/cpqphp_ctrl.c                  |  21 +-
>  drivers/pci/hotplug/fakephp.c                      | 164 ----------
>  drivers/pci/hotplug/pciehp_acpi.c                  |   6 +-
>  drivers/pci/hotplug/pciehp_core.c                  |  28 +-
>  drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
>  drivers/pci/hotplug/pcihp_slot.c                   |  20 +-
>  drivers/pci/iov.c                                  |   6 +-
>  drivers/pci/pci-driver.c                           |  57 +---
>  drivers/pci/pci.c                                  | 358 ++++++---------------
>  drivers/pci/pcie/aer/aer_inject.c                  |   2 +-
>  drivers/pci/pcie/aer/aerdrv.c                      |  26 +-
>  drivers/pci/pcie/aer/aerdrv_acpi.c                 |   2 +-
>  drivers/pci/pcie/aer/aerdrv_core.c                 |  67 +---
>  drivers/pci/pcie/aspm.c                            | 119 +++----
>  drivers/pci/pcie/pme.c                             |  29 +-
>  drivers/pci/pcie/portdrv_bus.c                     |   2 +-
>  drivers/pci/pcie/portdrv_core.c                    |  34 +-
>  drivers/pci/pcie/portdrv_pci.c                     |  27 +-
>  drivers/pci/probe.c                                |  33 +-
>  drivers/pci/proc.c                                 |  19 --
>  drivers/pci/quirks.c                               |  31 +-
>  drivers/pci/remove.c                               | 156 +++------
>  drivers/pci/rom.c                                  |  59 ----
>  drivers/pci/search.c                               |  63 ++--
>  drivers/pci/setup-bus.c                            |  81 +++--
>  drivers/pci/setup-irq.c                            |   9 +-
>  drivers/pci/xen-pcifront.c                         |  10 +-
>  drivers/pcmcia/cardbus.c                           |  15 +-
>  drivers/rapidio/devices/tsi721.c                   |  18 +-
>  drivers/scsi/ipr.c                                 |   2 +-
>  drivers/scsi/lpfc/lpfc_init.c                      |   2 +-
>  drivers/scsi/mpt2sas/mpt2sas_scsih.c               |   2 +-
>  drivers/scsi/qla2xxx/qla_nx.c                      |   8 +-
>  drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
>  drivers/scsi/qla4xxx/ql4_nx.c                      |   4 +-
>  drivers/scsi/qla4xxx/ql4_os.c                      |   2 +-
>  drivers/scsi/sym53c8xx_2/sym_glue.c                |   2 +-
>  drivers/staging/et131x/et131x.c                    |  19 +-
>  drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |   8 +-
>  drivers/tty/serial/8250/8250_pci.c                 |   2 +-
>  drivers/tty/serial/jsm/jsm_driver.c                |   2 +-
>  drivers/xen/xen-pciback/pci_stub.c                 |   2 +-
>  include/linux/pci.h                                |  55 +++-
>  include/linux/pci_regs.h                           |   7 +
>  include/linux/pcieport_if.h                        |   2 +-
>  117 files changed, 939 insertions(+), 1636 deletions(-)
>  delete mode 100644 drivers/pci/hotplug/fakephp.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

