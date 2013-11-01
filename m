Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38387 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab3KAPVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Nov 2013 11:21:07 -0400
Received: by mail-pa0-f48.google.com with SMTP id kq14so4162455pab.21
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2013 08:21:06 -0700 (PDT)
Received: from google.com ([172.29.166.5])
        by mx.google.com with ESMTPSA id go4sm11413467pbb.15.2013.11.01.08.21.04
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Nov 2013 08:21:05 -0700 (PDT)
Date: Fri, 1 Nov 2013 09:21:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Changes for v3.13 merge window
Message-ID: <20131101152102.GA27643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here are the contents of my "next" branch, planned for release in v3.13.
Let me know if I'm missing something important.

Bjorn


Alexey Neyman (1):
      x86/PCI: Coalesce multiple overlapping host bridge windows

Bjorn Helgaas (35):
      ACPI: Write _OSC bit field definitions in hex
      ACPI: Rename OSC_QUERY_TYPE to OSC_QUERY_DWORD
      ACPI: Tidy acpi_run_osc() declarations
      ACPI: Remove unused OSC_PCI_NATIVE_HOTPLUG
      ACPI: Write OSC_PCI_CONTROL_MASKS like OSC_PCI_SUPPORT_MASKS
      PCI/ACPI: Name _OSC #defines more consistently
      PCI/ACPI: Drop unnecessary _OSC existence tests
      PCI/ACPI: Move _OSC stuff from acpi_pci_root_add() to negotiate_os_control()
      PCI/ACPI: Split _OSC "support" and "control" flags into separate variables
      PCI/ACPI: Run _OSC only once for OSPM feature support
      PCI/ACPI: Skip _OSC control tests if _OSC support call failed
      PCI/ACPI: Separate out _OSC "PCIe port services disabled" path
      PCI/ACPI: Separate out _OSC "we don't support enough services" path
      PCI/ACPI: Decode _OSC bitmasks symbolically
      Merge branch 'pci/bjorn-osc' into next
      Merge branch 'pci/yijing-pci_is_pcie-v2' into next
      PCI: Drop "setting latency timer" messages
      [SCSI] qla2xxx: Use standard PCIe Capability Link register field names
      PCI: Document reason for using pci_is_root_bus()
      Merge branch 'pci/host-exynos' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-tegra' into next
      Merge branch 'pci/misc' into next
      IB/qib: Drop qib_tune_pcie_caps() and qib_tune_pcie_coalesce() return values
      PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
      MAINTAINERS: Add arch/x86/pci to PCI file patterns
      frv/PCI: Remove pcibios_last_bus
      mn10300/PCI: Remove useless pcibios_last_bus
      PCI: Report pci_pme_active() kmalloc failure
      Merge branch 'pci/gregkh-driver-core' into next
      Merge branch 'pci/host-exynos' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-rcar' into next
      Merge branch 'pci/yijing-mps-v1' into next
      Merge branch 'pci/misc' into next

Greg Kroah-Hartman (3):
      PCI: convert bus code to use bus_groups
      PCI: convert bus code to use drv_groups
      PCI: convert bus code to use dev_groups

Jingoo Han (4):
      MAINTAINERS: Add Jingoo Han as Samsung Exynos PCIe driver maintainer
      PCI: exynos: Add support for MSI
      PCI: exynos: Turn off power of phy block when link failed
      PCI: tegra: Add missing __iomem annotation

Joe Perches (1):
      PCI: Fix comment typo, remove unnecessary !! in pci_is_pcie()

Lan Tianyu (2):
      PCI: acpiphp: Convert to dynamic debug
      PCI: acpiphp_ibm: Convert to dynamic debug

Liu Chuansheng (1):
      PCI/PM: Remove pci_pm_complete()

Marek Vasut (2):
      PCI: imx6: Increase link startup timeout
      PCI: imx6: Probe the PCIe in fs_initcall()

Myron Stowe (2):
      cris/PCI: Remove unused pci_mem_start
      mn10300/PCI: Remove unused pci_mem_start

Pratyush Anand (1):
      PCI: designware: Add irq_create_mapping()

Sachin Kamat (4):
      PCI: Make pci_bus_attrs, pci_dev_attrs, dev_rescan_attr, dev_remove_attr, vga_attr static
      PCI: Make pci_dev_pm_ops static
      PCI: exynos: Remove redundant of_match_ptr
      PCI: imx6: Remove redundant of_match_ptr

Sean Cross (2):
      ARM: imx6q: Add PCIe bits to GPR syscon definition
      PCI: imx6: Add support for i.MX6 PCIe controller

Seungwon Jeon (1):
      PCI: designware: Add header guards

Tim Harvey (1):
      PCI: imx6: Fix imprecise abort handler

Todd E Brandt (1):
      PCI: Remove Intel Haswell D3 delays

Valentine Barshak (1):
      PCI: Add R-Car Gen2 internal PCI support

Wei Yang (2):
      PCI: Use pci_is_root_bus() to check for root bus
      PCI: Pass type, width, and prefetchability for window alignment

Wei Yongjun (2):
      PCI: exynos: Add missing clk_disable_unprepare() on error path
      PCI: imx6: Remove redundant dev_err() in imx6_pcie_probe()

Yijing Wang (17):
      PCI: Use pci_is_pcie() to simplify code
      x86/pci: Use cached pci_dev->pcie_cap to simplify code
      [SCSI] bfa: Use pcie_set()/get_readrq() to simplify code
      [SCSI] csiostor: Use pcie_capability_clear_and_set_word() to simplify code
      [SCSI] qla2xxx: Use pcie_is_pcie() to simplify code
      powerpc/pci: Use pci_is_pcie() to simplify code
      PCI: Export pcie_set_mps() and pcie_get_mps()
      tile/PCI: use cached pci_dev->pcie_mpss to simplify code
      IB/qib: Use pci_is_root_bus() to check whether it is a root bus
      IB/qib: Use pcie_set_mps() and pcie_get_mps() to simplify code
      PCI: Update pci_find_slot() description in pci.txt
      PCI: Remove unused "is_pcie" from pci_dev structure
      PCI: Remove unused PCI_MSIX_FLAGS_BIRMASK definition
      staging: et131x: Use pci_dev->pcie_mpss and pcie_set_readrq() to simplify code
      drm/radeon: use pcie_get_readrq() and pcie_set_readrq() to simplify code
      PCI: Add pci_dev_show_local_cpu() to simplify code
      PCI: Fail MSI/MSI-X initialization if device is not in PCI_D0

 Documentation/PCI/pci.txt                          |   8 +-
 .../devicetree/bindings/pci/designware-pcie.txt    |   7 +-
 MAINTAINERS                                        |   7 +
 arch/cris/include/asm/pci.h                        |   1 -
 arch/frv/mb93090-mb00/pci-frv.h                    |   1 -
 arch/frv/mb93090-mb00/pci-vdk.c                    |  36 --
 arch/mn10300/include/asm/pci.h                     |   1 -
 arch/mn10300/kernel/setup.c                        |   3 -
 arch/mn10300/unit-asb2305/pci-asb2305.h            |   1 -
 arch/mn10300/unit-asb2305/pci.c                    |   5 -
 arch/powerpc/kernel/eeh.c                          |   3 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   2 +-
 arch/tile/kernel/pci.c                             |   7 +-
 arch/x86/pci/acpi.c                                |   8 +-
 arch/x86/pci/fixup.c                               |  18 +-
 drivers/acpi/apei/apei-base.c                      |   6 +-
 drivers/acpi/bus.c                                 |  18 +-
 drivers/acpi/pci_root.c                            | 246 +++++----
 drivers/gpu/drm/radeon/evergreen.c                 |  19 +-
 drivers/infiniband/hw/qib/qib_pcie.c               | 126 ++---
 drivers/pci/host/Kconfig                           |  14 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-exynos.c                      | 132 ++++-
 drivers/pci/host/pci-imx6.c                        | 568 +++++++++++++++++++++
 drivers/pci/host/pci-rcar-gen2.c                   | 333 ++++++++++++
 drivers/pci/host/pci-tegra.c                       |   4 +-
 drivers/pci/host/pcie-designware.c                 | 257 +++++++++-
 drivers/pci/host/pcie-designware.h                 |  26 +-
 drivers/pci/hotplug/acpi_pcihp.c                   |   2 +-
 drivers/pci/hotplug/acpiphp.h                      |  10 -
 drivers/pci/hotplug/acpiphp_core.c                 |  37 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  23 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |  58 +--
 drivers/pci/hotplug/shpchp.h                       |   2 +-
 drivers/pci/msi.c                                  |   6 +-
 drivers/pci/pci-driver.c                           |  28 +-
 drivers/pci/pci-sysfs.c                            | 132 +++--
 drivers/pci/pci.c                                  |  11 +-
 drivers/pci/pci.h                                  |   4 +-
 drivers/pci/probe.c                                |   4 +-
 drivers/pci/quirks.c                               |  23 +
 drivers/pci/setup-bus.c                            |   4 +-
 drivers/scsi/bfa/bfad.c                            |  53 +-
 drivers/scsi/csiostor/csio_hw.c                    |  22 +-
 drivers/scsi/qla2xxx/qla_mr.c                      |   6 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  14 +-
 drivers/staging/et131x/et131x.c                    |  14 +-
 include/linux/acpi.h                               |  81 ++-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   8 +
 include/linux/pci.h                                |  10 +-
 include/uapi/linux/pci_regs.h                      |   4 +-
 51 files changed, 1822 insertions(+), 593 deletions(-)
 create mode 100644 drivers/pci/host/pci-imx6.c
 create mode 100644 drivers/pci/host/pci-rcar-gen2.c
