Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933022AbcJFSRj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Oct 2016 14:17:39 -0400
Date: Thu, 6 Oct 2016 13:17:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.9
Message-ID: <20161006181732.GA16579@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.9.

Bjorn


The following changes since commit 4fe0d154880bb6eb833cbe84fa6f385f400f0b9c:

  PCI: Use positive flags in pci_alloc_irq_vectors() (2016-08-16 14:07:30 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.9-changes

for you to fetch changes up to bdf530984d10b6b88b10a6d03057409a3f1c6897:

  Merge branch 'pci/host-vmd' into next (2016-10-05 14:00:21 -0500)

----------------------------------------------------------------
PCI changes for the v4.9 merge window:

  Enumeration
    microblaze: Add multidomain support for procfs (Bharat Kumar Gogada)

  Resource management
    Ignore requested alignment for PROBE_ONLY and fixed resources (Yongji Xie)
    Ignore requested alignment for VF BARs (Yongji Xie)

  PCI device hotplug
    Make core explicitly non-modular (Paul Gortmaker)

  PCIe native device hotplug
    Rename pcie_isr() locals for clarity (Bjorn Helgaas)
    Return IRQ_NONE when we can't read interrupt status (Bjorn Helgaas)
    Remove unnecessary guard (Bjorn Helgaas)
    Clean up dmesg "Slot(%s)" messages (Bjorn Helgaas)
    Remove useless pciehp_get_latch_status() calls (Bjorn Helgaas)
    Clear attention LED on device add (Keith Busch)
    Allow exclusive userspace control of indicators (Keith Busch)
    Process all hotplug events before looking for new ones (Mayurkumar Patel)
    Don't re-read Slot Status when queuing hotplug event (Mayurkumar Patel)
    Don't re-read Slot Status when handling surprise event (Mayurkumar Patel)
    Make explicitly non-modular (Paul Gortmaker)

  Power management
    Afford direct-complete to devices with non-standard PM (Lukas Wunner)
    Query platform firmware for device power state (Lukas Wunner)
    Recognize D3cold in pci_update_current_state() (Lukas Wunner)
    Avoid unnecessary resume after direct-complete (Lukas Wunner)
    Make explicitly non-modular (Paul Gortmaker)

  Virtualization
    Mark Atheros AR9580 to avoid bus reset (Maik Broemme)
    Check for pci_setup_device() failure in pci_iov_add_virtfn() (Po Liu)

  MSI
    Enable PCI_MSI_IRQ_DOMAIN support for ARC (Joao Pinto)

  AER
    Remove aerdriver.nosourceid kernel parameter (Bjorn Helgaas)
    Remove aerdriver.forceload kernel parameter (Bjorn Helgaas)
    Fix aer_probe() kernel-doc comment (Cao jin)
    Add bus flag to skip source ID matching (Jon Derrick)
    Avoid memory allocation in interrupt handling path (Jon Derrick)
    Cache capability position (Keith Busch)
    Make explicitly non-modular (Paul Gortmaker)
    Remove duplicate AER severity translation (Tyler Baicar)
    Send correct severity to calculate AER severity (Tyler Baicar)

  Precision Time Measurement
    Add Precision Time Measurement (PTM) support (Jonathan Yong)
    Add PTM clock granularity information (Bjorn Helgaas)
    Add pci_enable_ptm() for drivers to enable PTM on endpoints (Bjorn Helgaas)

  Generic host bridge driver
    Fix pci_remap_iospace() failure path (Lorenzo Pieralisi)
    Make explicitly non-modular (Paul Gortmaker)

  Altera host bridge driver
    Remove redundant platform_get_resource() return value check (Bjorn Helgaas)
    Poll for link training status after retraining the link (Ley Foon Tan)
    Rework config accessors for use without a struct pci_bus (Ley Foon Tan)
    Move retrain from fixup to altera_pcie_host_init() (Ley Foon Tan)
    Make MSI explicitly non-modular (Paul Gortmaker)
    Make explicitly non-modular (Paul Gortmaker)
    Relax device number checking to allow SR-IOV (Po Liu)

  ARM Versatile host bridge driver
    Fix pci_remap_iospace() failure path (Lorenzo Pieralisi)

  Axis ARTPEC-6 host bridge driver
    Drop __init from artpec6_add_pcie_port() (Niklas Cassel)

  Freescale i.MX6 host bridge driver
    Make explicitly non-modular (Paul Gortmaker)

  Intel VMD host bridge driver
    Add quirk for AER to ignore source ID (Jon Derrick)
    Allocate IRQ lists with correct MSI-X count (Jon Derrick)
    Convert to use pci_alloc_irq_vectors() API (Jon Derrick)
    Eliminate vmd_vector member from list type (Jon Derrick)
    Eliminate index member from IRQ list (Jon Derrick)
    Synchronize with RCU freeing MSI IRQ descs (Keith Busch)
    Request userspace control of PCIe hotplug indicators (Keith Busch)
    Move VMD driver to drivers/pci/host (Keith Busch)

  Marvell Aardvark host bridge driver
    Fix pci_remap_iospace() failure path (Lorenzo Pieralisi)
    Remove redundant dev_err call in advk_pcie_probe() (Wei Yongjun)

  Microsoft Hyper-V host bridge driver
    Use zero-length array in struct pci_packet (Dexuan Cui)
    Use pci_function_description[0] in struct definitions (Dexuan Cui)
    Remove the unused 'wrk' in struct hv_pcibus_device (Dexuan Cui)
    Handle vmbus_sendpacket() failure in hv_compose_msi_msg() (Dexuan Cui)
    Handle hv_pci_generic_compl() error case (Dexuan Cui)
    Use list_move_tail() instead of list_del() + list_add_tail() (Wei Yongjun)

  NVIDIA Tegra host bridge driver
    Fix pci_remap_iospace() failure path (Lorenzo Pieralisi)
    Remove redundant _data suffix (Thierry Reding)
    Use of_device_get_match_data() (Thierry Reding)

  Qualcomm host bridge driver
    Make explicitly non-modular (Paul Gortmaker)

  Renesas R-Car host bridge driver
    Consolidate register space lookup and ioremap (Bjorn Helgaas)
    Don't disable/unprepare clocks on prepare/enable failure (Geert Uytterhoeven)
    Add multi-MSI support (Grigory Kletsko)
    Fix pci_remap_iospace() failure path (Lorenzo Pieralisi)
    Fix some checkpatch warnings (Sergei Shtylyov)
    Try increasing PCIe link speed to 5 GT/s at boot (Sergei Shtylyov)

  Rockchip host bridge driver
    Add DT bindings for Rockchip PCIe controller (Shawn Lin)
    Add Rockchip PCIe controller support (Shawn Lin)
    Improve the deassert sequence of four reset pins (Shawn Lin)
    Fix wrong transmitted FTS count (Shawn Lin)
    Increase the Max Credit update interval (Rajat Jain)

  Samsung Exynos host bridge driver
    Make explicitly non-modular (Paul Gortmaker)

  ST Microelectronics SPEAr13xx host bridge driver
    Make explicitly non-modular (Paul Gortmaker)

  Synopsys DesignWare host bridge driver
    Return data directly from dw_pcie_readl_rc() (Bjorn Helgaas)
    Exchange viewport of `MEMORYs' and `CFGs/IOs' (Dong Bo)
    Check LTSSM training bit before deciding link is up (Jisheng Zhang)
    Move link wait definitions to .c file (Joao Pinto)
    Wait for iATU enable (Joao Pinto)
    Add iATU Unroll feature (Joao Pinto)
    Fix pci_remap_iospace() failure path (Lorenzo Pieralisi)
    Make explicitly non-modular (Paul Gortmaker)
    Relax device number checking to allow SR-IOV (Po Liu)
    Keep viewport fixed for IO transaction if num_viewport > 2 (Pratyush Anand)
    Remove redundant platform_get_resource() return value check (Wei Yongjun)

  TI DRA7xx host bridge driver
    Make explicitly non-modular (Paul Gortmaker)

  TI Keystone host bridge driver
    Propagate request_irq() failure (Wei Yongjun)

  Xilinx AXI host bridge driver
    Keep both legacy and MSI interrupt domain references (Bharat Kumar Gogada)
    Clear interrupt register for invalid interrupt (Bharat Kumar Gogada)
    Clear correct MSI set bit (Bharat Kumar Gogada)
    Dispose of MSI virtual IRQ (Bharat Kumar Gogada)
    Make explicitly non-modular (Paul Gortmaker)
    Relax device number checking to allow SR-IOV (Po Liu)

  Xilinx NWL host bridge driver
    Expand error logging (Bharat Kumar Gogada)
    Enable all MSI interrupts using MSI mask (Bharat Kumar Gogada)
    Make explicitly non-modular (Paul Gortmaker)

  Miscellaneous
    Drop CONFIG_KEXEC_CORE ifdeffery (Lukas Wunner)
    portdrv: Make explicitly non-modular (Paul Gortmaker)
    Make DPC explicitly non-modular (Paul Gortmaker)

----------------------------------------------------------------
Bharat Kumar Gogada (7):
      PCI: xilinx-nwl: Expand error logging
      PCI: xilinx-nwl: Enable all MSI interrupts using MSI mask
      PCI: xilinx: Keep both legacy and MSI interrupt domain references
      PCI: xilinx: Clear interrupt register for invalid interrupt
      PCI: xilinx: Clear correct MSI set bit
      PCI: xilinx: Dispose of MSI virtual IRQ
      microblaze/PCI: Add multidomain support for procfs

Bjorn Helgaas (24):
      PCI: designware: Return data directly from dw_pcie_readl_rc()
      PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints
      PCI: rcar: Consolidate register space lookup and ioremap
      PCI: Add PTM clock granularity information
      Merge branch 'pci/demodularize' into next
      Merge branch 'pci/ptm' into next
      PCI: pciehp: Rename pcie_isr() locals for clarity
      PCI: altera: Remove redundant platform_get_resource() return value check
      PCI: pciehp: Return IRQ_NONE when we can't read interrupt status
      PCI: pciehp: Remove unnecessary guard
      PCI: pciehp: Clean up dmesg "Slot(%s)" messages
      PCI: pciehp: Remove useless pciehp_get_latch_status() calls
      PCI/AER: Remove aerdriver.nosourceid kernel parameter
      PCI/AER: Remove aerdriver.forceload kernel parameter
      Merge branch 'pci/aer' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/hotplug' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/pm' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/virtualization' into next
      Merge branches 'pci/host-aardvark', 'pci/host-altera', 'pci/host-artpec', 'pci/host-designware', 'pci/host-hv', 'pci/host-keystone', 'pci/host-rcar', 'pci/host-rockchip', 'pci/host-tegra' and 'pci/host-xilinx' into next
      Merge branch 'pci/host-vmd' into next

Cao jin (1):
      PCI/AER: Fix aer_probe() kernel-doc comment

Dexuan Cui (5):
      PCI: hv: Use zero-length array in struct pci_packet
      PCI: hv: Use pci_function_description[0] in struct definitions
      PCI: hv: Remove the unused 'wrk' in struct hv_pcibus_device
      PCI: hv: Handle vmbus_sendpacket() failure in hv_compose_msi_msg()
      PCI: hv: Handle hv_pci_generic_compl() error case

Dong Bo (1):
      PCI: designware: Exchange viewport of `MEMORYs' and `CFGs/IOs'

Geert Uytterhoeven (1):
      PCI: rcar: Don't disable/unprepare clocks on prepare/enable failure

Grigory Kletsko (1):
      PCI: rcar: Add multi-MSI support

Jisheng Zhang (1):
      PCI: designware: Check LTSSM training bit before deciding link is up

Joao Pinto (4):
      PCI: designware: Move link wait definitions to .c file
      PCI: designware: Wait for iATU enable
      PCI: designware: Add iATU Unroll feature
      PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for ARC

Jon Derrick (7):
      PCI/AER: Add bus flag to skip source ID matching
      x86/PCI: VMD: Add quirk for AER to ignore source ID
      x86/PCI: VMD: Allocate IRQ lists with correct MSI-X count
      x86/PCI: VMD: Convert to use pci_alloc_irq_vectors() API
      x86/PCI: VMD: Eliminate vmd_vector member from list type
      x86/PCI: VMD: Eliminate index member from IRQ list
      PCI/AER: Avoid memory allocation in interrupt handling path

Jonathan Yong (1):
      PCI: Add Precision Time Measurement (PTM) support

Keith Busch (6):
      PCI: pciehp: Clear attention LED on device add
      x86/PCI: VMD: Synchronize with RCU freeing MSI IRQ descs
      PCI: pciehp: Allow exclusive userspace control of indicators
      x86/PCI: VMD: Request userspace control of PCIe hotplug indicators
      PCI/AER: Cache capability position
      x86/PCI: VMD: Move VMD driver to drivers/pci/host

Ley Foon Tan (3):
      PCI: altera: Poll for link training status after retraining the link
      PCI: altera: Rework config accessors for use without a struct pci_bus
      PCI: altera: Move retrain from fixup to altera_pcie_host_init()

Lorenzo Pieralisi (6):
      PCI: aardvark: Fix pci_remap_iospace() failure path
      PCI: designware: Fix pci_remap_iospace() failure path
      PCI: versatile: Fix pci_remap_iospace() failure path
      PCI: rcar: Fix pci_remap_iospace() failure path
      PCI: generic: Fix pci_remap_iospace() failure path
      PCI: tegra: Fix pci_remap_iospace() failure path

Lukas Wunner (5):
      PCI: Drop CONFIG_KEXEC_CORE ifdeffery
      PCI: Afford direct-complete to devices with non-standard PM
      PCI: Query platform firmware for device power state
      PCI: Recognize D3cold in pci_update_current_state()
      PCI: Avoid unnecessary resume after direct-complete

Maik Broemme (1):
      PCI: Mark Atheros AR9580 to avoid bus reset

Mayurkumar Patel (3):
      PCI: pciehp: Process all hotplug events before looking for new ones
      PCI: pciehp: Don't re-read Slot Status when queuing hotplug event
      PCI: pciehp: Don't re-read Slot Status when handling surprise event

Niklas Cassel (1):
      PCI: artpec6: Drop __init from artpec6_add_pcie_port()

Paul Gortmaker (17):
      PCI: altera: Make MSI explicitly non-modular
      PCI: altera: Make explicitly non-modular
      PCI: imx6: Make explicitly non-modular
      PCI: portdrv: Make explicitly non-modular
      PCI: spear: Make explicitly non-modular
      PCI: designware: Make explicitly non-modular
      PCI: exynos: Make explicitly non-modular
      PCI: generic: Make explicitly non-modular
      PCI: Make DPC explicitly non-modular
      PCI/PME: Make explicitly non-modular
      PCI/AER: Make explicitly non-modular
      PCI: dra7xx: Make explicitly non-modular
      PCI: qcom: Make explicitly non-modular
      PCI: xilinx: Make explicitly non-modular
      PCI: xilinx-nwl: Make explicitly non-modular
      PCI: hotplug: Make core explicitly non-modular
      PCI: pciehp: Make explicitly non-modular

Po Liu (4):
      PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()
      PCI: altera: Relax device number checking to allow SR-IOV
      PCI: designware: Relax device number checking to allow SR-IOV
      PCI: xilinx: Relax device number checking to allow SR-IOV

Pratyush Anand (1):
      PCI: designware: Keep viewport fixed for IO transaction if num_viewport > 2

Rajat Jain (1):
      PCI: rockchip: Increase the Max Credit update interval

Sergei Shtylyov (2):
      PCI: rcar: Fix some checkpatch warnings
      PCI: rcar: Try increasing PCIe link speed to 5 GT/s at boot

Shawn Lin (4):
      dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe controller
      PCI: rockchip: Add Rockchip PCIe controller support
      PCI: rockchip: Improve the deassert sequence of four reset pins
      PCI: rockchip: Fix wrong transmitted FTS count

Thierry Reding (2):
      PCI: tegra: Remove redundant _data suffix
      PCI: tegra: Use of_device_get_match_data()

Tyler Baicar (2):
      PCI/AER: Remove duplicate AER severity translation
      ACPI / APEI: Send correct severity to calculate AER severity

Wei Yongjun (4):
      PCI: keystone: Propagate request_irq() failure
      PCI: hv: Use list_move_tail() instead of list_del() + list_add_tail()
      PCI: aardvark: Remove redundant dev_err call in advk_pcie_probe()
      PCI: designware: Remove redundant platform_get_resource() return value check

Yongji Xie (2):
      PCI: Ignore requested alignment for PROBE_ONLY and fixed resources
      PCI: Ignore requested alignment for VF BARs

 Documentation/PCI/pcieaer-howto.txt                |   26 +-
 .../devicetree/bindings/pci/designware-pcie.txt    |    3 +
 .../devicetree/bindings/pci/rockchip-pcie.txt      |  106 ++
 MAINTAINERS                                        |    9 +
 arch/arc/include/asm/Kbuild                        |    1 +
 arch/microblaze/pci/pci-common.c                   |    4 +-
 arch/x86/Kconfig                                   |   13 -
 arch/x86/include/asm/pci.h                         |   14 +
 arch/x86/pci/Makefile                              |    2 -
 arch/x86/pci/common.c                              |    7 +
 drivers/acpi/apei/ghes.c                           |    2 +-
 drivers/pci/Kconfig                                |    2 +-
 drivers/pci/host/Kconfig                           |   27 +
 drivers/pci/host/Makefile                          |    2 +
 drivers/pci/host/pci-aardvark.c                    |   12 +-
 drivers/pci/host/pci-dra7xx.c                      |   31 +-
 drivers/pci/host/pci-exynos.c                      |   16 +-
 drivers/pci/host/pci-host-common.c                 |   15 +-
 drivers/pci/host/pci-hyperv.c                      |   65 +-
 drivers/pci/host/pci-imx6.c                        |    9 +-
 drivers/pci/host/pci-keystone.c                    |    5 +-
 drivers/pci/host/pci-tegra.c                       |   54 +-
 drivers/pci/host/pci-versatile.c                   |    8 +-
 drivers/pci/host/pcie-altera-msi.c                 |   20 +-
 drivers/pci/host/pcie-altera.c                     |  209 ++--
 drivers/pci/host/pcie-artpec6.c                    |    4 +-
 drivers/pci/host/pcie-designware-plat.c            |    3 -
 drivers/pci/host/pcie-designware.c                 |  209 +++-
 drivers/pci/host/pcie-designware.h                 |   10 +-
 drivers/pci/host/pcie-qcom.c                       |   28 +-
 drivers/pci/host/pcie-rcar.c                       |  190 ++-
 drivers/pci/host/pcie-rockchip.c                   | 1229 ++++++++++++++++++++
 drivers/pci/host/pcie-spear13xx.c                  |   11 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |  105 +-
 drivers/pci/host/pcie-xilinx.c                     |   90 +-
 {arch/x86/pci => drivers/pci/host}/vmd.c           |   49 +-
 drivers/pci/hotplug/cpci_hotplug.h                 |    2 -
 drivers/pci/hotplug/cpci_hotplug_core.c            |   10 -
 drivers/pci/hotplug/pci_hotplug_core.c             |   18 +-
 drivers/pci/hotplug/pciehp.h                       |    3 +
 drivers/pci/hotplug/pciehp_core.c                  |   23 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   84 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  121 +-
 drivers/pci/iov.c                                  |    5 +-
 drivers/pci/pci-acpi.c                             |   22 +
 drivers/pci/pci-driver.c                           |   17 +-
 drivers/pci/pci.c                                  |   75 +-
 drivers/pci/pci.h                                  |    9 +
 drivers/pci/pcie/Kconfig                           |   11 +
 drivers/pci/pcie/Makefile                          |    1 +
 drivers/pci/pcie/aer/aerdrv.c                      |   36 +-
 drivers/pci/pcie/aer/aerdrv.h                      |    9 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   61 +-
 drivers/pci/pcie/aer/aerdrv_errprint.c             |    6 +-
 drivers/pci/pcie/pcie-dpc.c                        |   18 +-
 drivers/pci/pcie/pme.c                             |   16 +-
 drivers/pci/pcie/portdrv_pci.c                     |   17 +-
 drivers/pci/pcie/ptm.c                             |  142 +++
 drivers/pci/probe.c                                |    6 +-
 drivers/pci/quirks.c                               |   18 +
 include/linux/aer.h                                |    2 +-
 include/linux/pci.h                                |   26 +-
 include/uapi/linux/pci_regs.h                      |   12 +-
 63 files changed, 2550 insertions(+), 810 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
 create mode 100644 drivers/pci/host/pcie-rockchip.c
 rename {arch/x86/pci => drivers/pci/host}/vmd.c (95%)
 create mode 100644 drivers/pci/pcie/ptm.c
