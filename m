Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdGHUnx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Jul 2017 16:43:53 -0400
Date: Sat, 8 Jul 2017 15:43:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.13
Message-ID: <20170708204349.GA6995@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - add sysfs max_link_speed/width, current_link_speed/width (Wong Vee
    Khee)

  - make host bridge IRQ mapping much more generic (Matthew Minter, Lorenzo
    Pieralisi)

  - convert most drivers to pci_scan_root_bus_bridge() (Lorenzo Pieralisi)

  - mutex sriov_configure() (Jakub Kicinski)

  - mutex pci_error_handlers callbacks (Christoph Hellwig)

  - split ->reset_notify() into ->reset_prepare()/reset_done() (Christoph
    Hellwig)

  - support multiple PCIe portdrv interrupts for MSI as well as MSI-X
    (Gabriele Paoloni)

  - allocate MSI/MSI-X vector for Downstream Port Containment (Gabriele
    Paoloni)

  - fix MSI IRQ affinity pre/post/min_vecs issue (Michael Hernandez)

  - test INTx masking during enumeration, not at run-time (Piotr Gregor)

  - avoid using device_may_wakeup() for runtime PM (Rafael J. Wysocki)

  - restore the status of PCI devices across hibernation (Chen Yu)

  - keep parent resources that start at 0x0 (Ard Biesheuvel)

  - enable ECRC only if device supports it (Bjorn Helgaas)

  - restore PRI and PASID state after Function-Level Reset (CQ Tang)

  - skip DPC event if device is not present (Keith Busch)

  - check domain when matching SMBIOS info (Sujith Pandel)

  - mark Intel XXV710 NIC INTx masking as broken (Alex Williamson)

  - avoid AMD SB7xx EHCI USB wakeup defect (Kai-Heng Feng)

  - work around long-standing Macbook Pro poweroff issue (Bjorn Helgaas)

  - add Switchtec "running" status flag (Logan Gunthorpe)

  - fix dra7xx incorrect RW1C IRQ register usage (Arvind Yadav)

  - modify xilinx-nwl IRQ chip for legacy interrupts (Bharat Kumar Gogada)

  - move VMD SRCU cleanup after bus, child device removal (Jon Derrick)

  - add Faraday clock handling (Linus Walleij)

  - configure Rockchip MPS and reorganize (Shawn Lin)

  - limit Qualcomm TLP size to 2K (hardware issue) (Srinivas Kandagatla)

  - support Tegra MSI 64-bit addressing (Thierry Reding)

  - use Rockchip normal (not privileged) register bank (Shawn Lin)

  - add HiSilicon Kirin SoC PCIe controller driver (Xiaowei Song)

  - add Sigma Designs Tango SMP8759 PCIe controller driver (Marc Gonzalez)

  - add MediaTek PCIe host controller support (Ryder Lee)

  - add Qualcomm IPQ4019 support (John Crispin)

  - add HyperV vPCI protocol v1.2 support (Jork Loeser)

  - add i.MX6 regulator support (Quentin Schulz)


You should see these merge conflicts:

  - kernel/irq/affinity.c
      6f9a22bc5775 ("PCI/MSI: Ignore affinity if pre/post vector count ...")
      9a0ef98e186d ("genirq/affinity: Assign vectors to all present CPUs")

  - drivers/nvme/host/pci.c
      c336cc0ee4eb ("PCI: Split ->reset_notify() method ...")
      d86c4d8ef31b ("nvme: move reset workqueue handling to common code")

  - drivers/net/wireless/marvell/mwifiex/pcie.c
      c336cc0ee4eb ("PCI: Split ->reset_notify() method ...")
      68efd0386988 ("mwifiex: pcie: stop setting/clearing 'surprise_removed'")

      Note: silent conflict in mwifiex_pcie_reset_done()

  - drivers/gpu/drm/radeon/radeon_device.c
      5938628c51a7 ("drm/radeon: make MacBook Pro d3_delay quirk more generic")
      4eb59793cca0 ("drm/radeon: add a PX quirk for another K53TK variant")

My suggested resolutions are at
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v4.13-merge


The following changes since commit 4d071c3238987325b9e50e33051a40d1cce311cc:

  PCI/PM: Add needs_resume flag to avoid suspend complete optimization (2017-05-23 14:18:17 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.13-changes

for you to fetch changes up to 6aed468480e8b03ece5a395fe8013e66348a2547:

  Merge branch 'pci/host-tango' into next (2017-07-07 13:42:25 -0500)

----------------------------------------------------------------
pci-v4.13-changes

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Mark Intel XXV710 NIC INTx masking as broken

Ard Biesheuvel (1):
      PCI: Do not disregard parent resources starting at 0x0

Arvind Yadav (4):
      PCI: dwc: dra7xx: Use RW1C for IRQSTATUS_MSI and IRQSTATUS_MAIN
      PCI: rcar-gen2: Make of_device_ids const
      PCI: rockchip: Check for clk_prepare_enable() errors during resume
      PCI: xilinx: Make of_device_ids const

Bharat Kumar Gogada (1):
      PCI: xilinx-nwl: Modify IRQ chip for legacy interrupts

Bjorn Helgaas (36):
      MIPS: Loongson: Remove unused PCI_BAR_COUNT definition
      MIPS: PCI: Remove unused busn_offset
      efi/fb: Correct PCI_STD_RESOURCE_END usage
      PCI: Correct PCI_STD_RESOURCE_END usage
      PCI: Enable ECRC only if device supports it
      PCI: Work around poweroff & suspend-to-RAM issue on Macbook Pro 11
      drm/amdgpu: remove unnecessary save/restore of pdev->d3_delay
      drm/radeon: make MacBook Pro d3_delay quirk more generic
      PCI: qcom: Reorder to put v0 functions together, v1 functions together, etc
      PCI: versatile: Add local struct device pointers
      PCI: vmd: Correct comment: VMD domains start at 0x10000, not 0x1000
      Merge branch 'pci/dpc' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/pm' into next
      Merge branch 'pci/portdrv' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/switchtec' into next
      Merge branch 'pci/virtualization' into next
      Merge branch 'pci/irq-fixups' into next
      Merge branch 'pci/host-designware' into next
      Merge branch 'pci/host-dra7xx' into next
      Merge branch 'pci/host-faraday' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-kirin' into next
      Merge branch 'pci/host-mediatek' into next
      Merge branch 'pci/host-qcom' into next
      Merge branch 'pci/host-rcar' into next
      Merge branch 'pci/host-rockchip' into next
      Merge branch 'pci/host-tegra' into next
      Merge branch 'pci/host-versatile' into next
      Merge branch 'pci/host-vmd' into next
      Merge branch 'pci/host-xilinx' into next
      Merge branch 'pci/host-tango' into next

CQ Tang (1):
      PCI: Restore PRI and PASID state after Function-Level Reset

Chen Yu (1):
      PCI/PM: Restore the status of PCI devices across hibernation

Christoph Hellwig (3):
      PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()
      PCI: Split ->reset_notify() method into ->reset_prepare() and ->reset_done()
      PCI: Remove __pci_dev_reset() and pci_dev_reset()

Colin Ian King (1):
      PCI: qcom: Fix spelling mistake: "asser" -> "assert"

Gabriele Paoloni (2):
      PCI/portdrv: Support multiple interrupts for MSI as well as MSI-X
      PCI/portdrv: Allocate MSI/MSI-X vector for Downstream Port Containment

Jakub Kicinski (1):
      PCI: Protect pci_driver->sriov_configure() usage with device_lock()

Jean Delvare (1):
      x86/PCI: Simplify Dell DMI B1 quirk

Jean-Philippe Brucker (1):
      PCI: Cache PRI and PASID bits in pci_dev

Jisheng Zhang (2):
      PCI: host: Mark PCIe/PCI (MSI) cascade ISR as IRQF_NO_THREAD
      PCI: dwc: Constify dw_pcie_host_ops structures

John Crispin (1):
      PCI: qcom: Add support for IPQ4019 PCIe controller

Jon Derrick (1):
      PCI: vmd: Move SRCU cleanup after bus, child device removal

Jork Loeser (5):
      PCI: hv: Fix comment formatting and use proper integer fields
      PCI: hv: Use page allocation for hbus structure
      PCI: hv: Temporary own CPU-number-to-vCPU-number infra
      PCI: hv: Add vPCI version protocol negotiation
      PCI: hv: Use vPCI protocol version 1.2

Kai-Heng Feng (1):
      x86/PCI: Avoid AMD SB7xx EHCI USB wakeup defect

Keith Busch (2):
      PCI/DPC: Skip DPC event if device is not present
      PCI/DPC: Fix control register setting

Linus Walleij (2):
      PCI: faraday: Add clock bindings
      PCI: faraday: Add clock handling

Logan Gunthorpe (2):
      switchtec: Add "running" status flag to fw partition info ioctl
      switchtec: Add device IDs for additional Switchtec products

Lorenzo Pieralisi (37):
      PCI: xilinx-nwl: Remove nwl_pcie_enable_msi() unused bus parameter
      PCI: iproc: Convert link check to raw PCI config accessors
      PCI: faraday: Convert IRQ masking to raw PCI config accessors
      PCI: Initialize bridge release function at bridge allocation
      PCI: Add pci_free_host_bridge() interface
      PCI: Add devm_pci_alloc_host_bridge() interface
      PCI: faraday: Fix host bridge memory leakage
      PCI: tegra: Fix host bridge memory leakage
      PCI: Add pci_scan_root_bus_bridge() interface
      PCI: Make pci_register_host_bridge() PCI core internal
      ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: designware: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: aardvark: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: rcar: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: iproc: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: versatile: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: altera: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: xilinx: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: xgene: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: generic: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: rockchip: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: xilinx-nwl: Convert PCI scan API to pci_scan_root_bus_bridge()
      PCI: Remove pci_scan_root_bus_msi()
      ARM/PCI: Remove pci_fixup_irqs() call for bios32 host controllers
      PCI: tegra: Drop pci_fixup_irqs()
      PCI: xilinx: Drop pci_fixup_irqs()
      PCI: rcar: Drop pci_fixup_irqs()
      PCI: iproc: Drop pci_fixup_irqs()
      PCI: designware: Drop pci_fixup_irqs()
      PCI: faraday: Drop pci_fixup_irqs()
      PCI: generic: Drop pci_fixup_irqs()
      PCI: versatile: Drop pci_fixup_irqs()
      PCI: altera: Drop pci_fixup_irqs()
      PCI: xgene: Move to struct pci_host_bridge IRQ mapping functions
      PCI: rockchip: Move to struct pci_host_bridge IRQ mapping functions
      PCI: xilinx-nwl: Move to struct pci_host_bridge IRQ mapping functions
      arm64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()

Marc Gonzalez (2):
      PCI: Add DT binding for Sigma Designs Tango PCIe controller
      PCI: tango: Add Sigma Designs Tango SMP8759 PCIe host bridge support

Matthew Minter (5):
      PCI: Build setup-irq.o on all arches
      PCI: Add IRQ mapping function pointers to pci_host_bridge struct
      PCI: Add pci_assign_irq() function and have pci_fixup_irqs() use it
      OF/PCI: Update of_irq_parse_and_map_pci() comment
      PCI: Add a call to pci_assign_irq() in pci_device_probe()

Michael Hernandez (1):
      PCI/MSI: Ignore affinity if pre/post vector count is more than min_vecs

Peter Robinson (1):
      PCI: dwc: dra7xx: Depend on appropriate SoC or compile test

Piotr Gregor (1):
      PCI: Test INTx masking during enumeration, not at run-time

Quentin Schulz (1):
      PCI: imx6: Add regulator support

Rafael J. Wysocki (1):
      PCI/PM: Avoid using device_may_wakeup() for runtime PM

Ryder Lee (2):
      PCI: mediatek: Add MediaTek PCIe host controller support
      dt-bindings: PCI: Add documentation for MediaTek PCIe

Shawn Lin (9):
      PCI: rockchip: Control vpcie0v9 for system PM
      PCI: rockchip: Rename rockchip_cfg_atu() to rockchip_pcie_cfg_atu()
      PCI: rockchip: Move configuration accesses into rockchip_pcie_cfg_atu()
      PCI: rockchip: Split out rockchip_pcie_cfg_configuration_accesses()
      PCI: rockchip: Reconfigure configuration space header type
      PCI: rockchip: Configure RC's MPS setting
      MAINTAINERS: Remove Wenrui Li as Rockchip PCIe driver maintainer
      PCI: rockchip: Use local struct device pointer consistently
      PCI: rockchip: Use normal register bank for config accessors

Srinivas Kandagatla (1):
      PCI: qcom: Limit TLP size to 2K to work around hardware issue

Sujith Pandel (1):
      PCI: Add domain number check to find_smbios_instance_string()

Thierry Reding (2):
      PCI: tegra: Support MSI 64-bit addressing
      PCI: tegra: Do not allocate MSI target memory

Vincent Legoll (1):
      x86/PCI: Fix whitespace in set_bios_x() printk

Wolfram Sang (1):
      PCI: rcar: Use proper name for the R-Car SoC

Wong Vee Khee (1):
      PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc

Xiaowei Song (1):
      PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver

 .../devicetree/bindings/pci/faraday,ftpci100.txt   |   7 +
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   4 +
 .../bindings/pci/mediatek,mt7623-pcie.txt          | 130 +++++
 .../devicetree/bindings/pci/qcom,pcie.txt          |  20 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   2 +-
 .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
 Documentation/driver-model/devres.txt              |   1 +
 MAINTAINERS                                        |  17 +-
 arch/arm/include/asm/mach/pci.h                    |   3 +-
 arch/arm/kernel/bios32.c                           |  44 +-
 arch/arm/mach-dove/pcie.c                          |  17 +-
 arch/arm/mach-iop13xx/pci.c                        |  31 +-
 arch/arm/mach-iop13xx/pci.h                        |   3 +-
 arch/arm/mach-mv78xx0/pcie.c                       |  16 +-
 arch/arm/mach-orion5x/common.h                     |   3 +-
 arch/arm/mach-orion5x/pci.c                        |  25 +-
 arch/arm64/kernel/pci.c                            |  10 +-
 .../asm/mach-loongson64/cs5536/cs5536_pci.h        |   1 -
 arch/mips/include/asm/pci.h                        |   1 -
 arch/mips/pci/pci-legacy.c                         |   3 +-
 arch/x86/include/uapi/asm/hyperv.h                 |   6 +
 arch/x86/pci/common.c                              |  27 +-
 arch/x86/pci/fixup.c                               |  47 ++
 arch/x86/pci/pcbios.c                              |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 -
 drivers/gpu/drm/radeon/radeon_device.c             |  11 -
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |  36 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  75 +--
 drivers/nvme/host/pci.c                            |  15 +-
 drivers/of/of_pci_irq.c                            |   3 +-
 drivers/pci/Makefile                               |  17 +-
 drivers/pci/ats.c                                  |  87 +++-
 drivers/pci/dwc/Kconfig                            |  11 +
 drivers/pci/dwc/Makefile                           |   1 +
 drivers/pci/dwc/pci-dra7xx.c                       |   6 +-
 drivers/pci/dwc/pci-exynos.c                       |   2 +-
 drivers/pci/dwc/pci-imx6.c                         |  39 +-
 drivers/pci/dwc/pci-keystone.c                     |   2 +-
 drivers/pci/dwc/pci-layerscape.c                   |   6 +-
 drivers/pci/dwc/pcie-armada8k.c                    |   2 +-
 drivers/pci/dwc/pcie-artpec6.c                     |   2 +-
 drivers/pci/dwc/pcie-designware-host.c             |  43 +-
 drivers/pci/dwc/pcie-designware-plat.c             |   5 +-
 drivers/pci/dwc/pcie-designware.h                  |   2 +-
 drivers/pci/dwc/pcie-kirin.c                       | 517 +++++++++++++++++++
 drivers/pci/dwc/pcie-qcom.c                        | 440 +++++++++++++---
 drivers/pci/dwc/pcie-spear13xx.c                   |   2 +-
 drivers/pci/host/Kconfig                           |  25 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-aardvark.c                    |  21 +-
 drivers/pci/host/pci-ftpci100.c                    | 143 ++++--
 drivers/pci/host/pci-host-common.c                 |  27 +-
 drivers/pci/host/pci-hyperv.c                      | 445 ++++++++++++++---
 drivers/pci/host/pci-rcar-gen2.c                   |   2 +-
 drivers/pci/host/pci-tegra.c                       |  42 +-
 drivers/pci/host/pci-versatile.c                   |  36 +-
 drivers/pci/host/pci-xgene.c                       |  23 +-
 drivers/pci/host/pcie-altera.c                     |  24 +-
 drivers/pci/host/pcie-iproc-bcma.c                 |   7 +-
 drivers/pci/host/pcie-iproc-platform.c             |   7 +-
 drivers/pci/host/pcie-iproc.c                      | 135 +++--
 drivers/pci/host/pcie-mediatek.c                   | 554 +++++++++++++++++++++
 drivers/pci/host/pcie-rcar.c                       |  40 +-
 drivers/pci/host/pcie-rockchip.c                   | 147 ++++--
 drivers/pci/host/pcie-tango.c                      | 141 ++++++
 drivers/pci/host/pcie-xilinx-nwl.c                 |  79 ++-
 drivers/pci/host/pcie-xilinx.c                     |  36 +-
 drivers/pci/host/vmd.c                             |  10 +-
 drivers/pci/iov.c                                  |   4 -
 drivers/pci/msi.c                                  |  14 +-
 drivers/pci/pci-driver.c                           |   3 +
 drivers/pci/pci-label.c                            |   7 +-
 drivers/pci/pci-sysfs.c                            | 204 +++++++-
 drivers/pci/pci.c                                  | 227 ++++-----
 drivers/pci/pci.h                                  |   1 -
 drivers/pci/pcie/pcie-dpc.c                        |   4 +-
 drivers/pci/pcie/portdrv.h                         |   7 +-
 drivers/pci/pcie/portdrv_core.c                    | 104 ++--
 drivers/pci/probe.c                                | 140 ++++--
 drivers/pci/quirks.c                               |  19 +-
 drivers/pci/setup-irq.c                            |  45 +-
 drivers/pci/switch/switchtec.c                     |  40 +-
 drivers/video/fbdev/efifb.c                        |   2 +-
 include/linux/interrupt.h                          |   4 +-
 include/linux/pci-ats.h                            |  10 +
 include/linux/pci.h                                |  35 +-
 include/linux/pci_ids.h                            |   2 +
 include/uapi/linux/pci_regs.h                      |   1 +
 include/uapi/linux/switchtec_ioctl.h               |   3 +
 kernel/irq/affinity.c                              |  13 +-
 90 files changed, 3787 insertions(+), 825 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
 create mode 100644 drivers/pci/dwc/pcie-kirin.c
 create mode 100644 drivers/pci/host/pcie-mediatek.c
 create mode 100644 drivers/pci/host/pcie-tango.c
