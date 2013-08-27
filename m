Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64192 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab3H0Vk6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 17:40:58 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so5390750pdj.22
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 14:40:56 -0700 (PDT)
Date: Tue, 27 Aug 2013 15:40:52 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Changes for v3.12 merge window
Message-ID: <20130827214052.GA17359@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here are the contents of my "next" branch, planned for release in v3.12.
Let me know if I'm missing something important.

In addition to what's already in "next", I hope to merge these for v3.12:

  - A fix for the pcie_cap_has_lnkctl()/pcie_get_minimum_link() problem
    reported by Yuval Mintz
  - The PCIe capability cleanups I posted today
  - Neil Horman's _OSC fix, which I think may fix a pciehp regression

I don't think the following will make it in this cycle:

  - Yijing Wang's Device Serial Number stuff.  I'm not happy with the
    VPD serial number support yet, and the whole series is a bit large
    for this late in the cycle.
  - Zhenzhong Duan's MSI/MSI-X rework.  Still waiting on some changelog
    updates.


Alex Williamson (13):
      PCI: Check all ACS features for multifunction downstream ports
      PCI: Differentiate ACS controllable from enabled
      PCI: Claim ACS support for AMD southbridge devices
      PCI: Add pci_reset_bridge_secondary_bus()
      PCI: Add hotplug_slot_ops.reset_slot()
      PCI: pciehp: Add reset_slot() method
      PCI: Add slot reset option to pci_dev_reset()
      PCI: Split out pci_dev lock/unlock and save/restore
      PCI: Add pci_reset_slot() and pci_reset_bus()
      PCI: Wake-up devices before saving config space for reset
      PCI: Tune secondary bus reset timing
      PCI: Remove aer_do_secondary_bus_reset()
      PCI: Add pci_probe_reset_slot() and pci_probe_reset_bus()

Bjorn Helgaas (13):
      frv/PCI: Mark pcibios_fixup_bus() as non-init
      Merge branch 'pci/aw-acs-fixes-v2' into next
      Merge branch 'pci/misc' into next
      PCI: Align bridge I/O windows as required by downstream devices & bridges
      Merge branch 'pci/wei-resource-cleanups' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/vipul-chelsio-reset-v2' into next
      Merge branch 'pci/aw-reset-v5' into next
      PCI: Drop "PCI-E" prefix from Max Payload Size message
      PCI: Simplify pcie_bus_configure_settings() interface
      PCI: Simplify MPS test for Downstream Port
      Merge branch 'pci/yinghai-assign-unassigned-v6' into next
      Merge branch 'pci/yijing-mps-v8' into next

Casey Leedom (4):
      PCI: Add pci_wait_for_pending_transaction()
      PCI: Chelsio quirk: Enable Bus Master during Function-Level Reset
      bnx2x: Use pci_wait_for_pending_transaction() instead of for loop
      PCI: Use pci_wait_for_pending_transaction() instead of for loop

Ezequiel Garcia (1):
      PCI: Rename "PCI Express support" kconfig title

Greg Kroah-Hartman (1):
      PCI: Convert class code to use dev_groups

Jingoo Han (1):
      PCI: exynos: Split into Synopsys part and Exynos part

Jon Mason (1):
      PCI: Fix MPS peer-to-peer DMA comment syntax

Jonghwan Choi (1):
      PCI: Fix comment typo in iov.c

Stefan Assmann (1):
      PCI: Return -ENOSYS for SR-IOV operations on non-SR-IOV devices

Thomas Petazzoni (1):
      PCI: mvebu: Make Marvell PCIe driver depend on OF

Tushar Behera (1):
      PCI: mvebu: Convert to use devm_ioremap_resource

Valentina Manea (1):
      x86/pci/mrst: Cleanup checkpatch.pl warnings

Wei Yang (3):
      PCI: Enumerate subordinate buses, not devices, in pci_bus_get_depth()
      PCI: Add comments for pbus_size_mem() parameters
      PCI: Fix types in pbus_size_io()

Yijing Wang (5):
      PCI: Update NumVFs register when disabling SR-IOV
      PCI: Fix comment typo for pci_add_cap_save_buffer()
      PCI: Remove unnecessary check for pcie_get_mps() failure
      PCI: Don't restrict MPS for slots below Root Ports
      PCI: Warn if unsafe MPS settings detected

Yinghai Lu (8):
      PCI: Drop temporary variable in pci_assign_unassigned_resources()
      PCI: Look for unassigned resources on per-bus basis
      PCI: Turn on reallocation for unassigned resources with host bridge offset
      PCI: Enable unassigned resource reallocation on per-bus basis
      PCI: Assign resources on a per-bus basis
      PCI: Delay enabling bridges until they're needed
      PCI: Move resource reallocation code to non-__init
      PCI: Assign resources for hot-added host bridge more aggressively

ethan.zhao (1):
      x86/PCI: MMCONFIG: Check earlier for MMCONFIG region at address zero

 .../devicetree/bindings/pci/designware-pcie.txt    |    3 +
 arch/arm/boot/dts/exynos5440.dtsi                  |    2 +
 arch/arm/kernel/bios32.c                           |    5 -
 arch/frv/mb93090-mb00/pci-vdk.c                    |    2 +-
 arch/m68k/platform/coldfire/pci.c                  |    1 -
 arch/mips/pci/pci.c                                |    1 -
 arch/powerpc/kernel/pci-common.c                   |    8 +-
 arch/sh/drivers/pci/pci.c                          |    1 -
 arch/tile/kernel/pci_gx.c                          |    9 +-
 arch/x86/pci/acpi.c                                |    9 +-
 arch/x86/pci/mmconfig-shared.c                     |    7 +-
 arch/x86/pci/mrst.c                                |   41 +-
 drivers/acpi/pci_root.c                            |    5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   18 +-
 drivers/parisc/lba_pci.c                           |    1 -
 drivers/pci/bus.c                                  |   19 -
 drivers/pci/host/Kconfig                           |    1 +
 drivers/pci/host/Makefile                          |    3 +-
 drivers/pci/host/pci-exynos.c                      |  530 ++++++++++
 drivers/pci/host/pci-mvebu.c                       |    7 +-
 drivers/pci/host/pcie-designware.c                 | 1011 ++++++--------------
 drivers/pci/host/pcie-designware.h                 |   65 ++
 drivers/pci/hotplug/acpiphp_glue.c                 |    1 -
 drivers/pci/hotplug/pciehp.h                       |    1 +
 drivers/pci/hotplug/pciehp_core.c                  |   12 +
 drivers/pci/hotplug/pciehp_hpc.c                   |   31 +
 drivers/pci/hotplug/pcihp_slot.c                   |    5 +-
 drivers/pci/iov.c                                  |   23 +-
 drivers/pci/pci-sysfs.c                            |   32 +-
 drivers/pci/pci.c                                  |  529 ++++++++--
 drivers/pci/pci.h                                  |    2 +-
 drivers/pci/pcie/Kconfig                           |    2 +-
 drivers/pci/pcie/aer/aerdrv.c                      |    2 +-
 drivers/pci/pcie/aer/aerdrv.h                      |    1 -
 drivers/pci/pcie/aer/aerdrv_core.c                 |   35 +-
 drivers/pci/probe.c                                |   69 +-
 drivers/pci/quirks.c                               |  147 ++-
 drivers/pci/setup-bus.c                            |  176 ++--
 drivers/pcmcia/cardbus.c                           |    1 -
 include/linux/pci.h                                |   10 +-
 include/linux/pci_hotplug.h                        |    4 +
 41 files changed, 1744 insertions(+), 1088 deletions(-)
 create mode 100644 drivers/pci/host/pci-exynos.c
 create mode 100644 drivers/pci/host/pcie-designware.h
