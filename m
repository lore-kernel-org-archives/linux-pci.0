Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbeBEUQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Feb 2018 15:16:19 -0500
Date: Mon, 5 Feb 2018 14:16:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v4.16
Message-ID: <20180205201610.GA91011@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - skip AER driver error recovery callbacks for correctable errors
    reported via ACPI APEI, as we already do for errors reported via
    the native path (Tyler Baicar)

  - fix DPC shared interrupt handling (Alex Williamson)

  - print full DPC interrupt number (Keith Busch)

  - enable DPC only if AER is available (Keith Busch)

  - simplify DPC code (Bjorn Helgaas)

  - calculate ASPM L1 substate parameter instead of hardcoding it
    (Bjorn Helgaas)

  - enable Latency Tolerance Reporting for ASPM L1 substates (Bjorn
    Helgaas)

  - move ASPM internal interfaces out of public header (Bjorn Helgaas)

  - allow hot-removal of VGA devices (Mika Westerberg)

  - speed up unplug and shutdown by assuming Thunderbolt controllers
    don't support Command Completed events (Lukas Wunner)

  - add AtomicOps support for GPU and Infiniband drivers (Felix
    Kuehling, Jay Cornwall)

  - expose "ari_enabled" in sysfs to help NIC naming (Stuart Hayes)

  - clean up PCI DMA interface usage (Christoph Hellwig)

  - remove PCI pool API (replaced with DMA pool) (Romain Perier)

  - deprecate pci_get_bus_and_slot(), which assumed PCI domain 0
    (Sinan Kaya)

  - move DT PCI code from drivers/of/ to drivers/pci/ (Rob Herring)

  - add PCI-specific wrappers for dev_info(), etc (Frederick Lawler)

  - remove warnings on sysfs mmap failure (Bjorn Helgaas)

  - quiet ROM validation messages (Alex Deucher)

  - remove redundant memory alloc failure messages (Markus Elfring)

  - fill in types for compile-time VGA and other I/O port resources
    (Bjorn Helgaas)

  - make "pci=pcie_scan_all" work for Root Ports as well as Downstream
    Ports to help AmigaOne X1000 (Bjorn Helgaas)

  - add SPDX tags to all PCI files (Bjorn Helgaas)

  - quirk Marvell 9128 DMA aliases (Alex Williamson)

  - quirk broken INTx disable on Ceton InfiniTV4 (Bjorn Helgaas)

  - fix CONFIG_PCI=n build by adding dummy pci_irqd_intx_xlate()
    (Niklas Cassel)

  - use DMA API to get MSI address for DesignWare IP (Niklas Cassel)

  - fix endpoint-mode DMA mask configuration (Kishon Vijay Abraham I)

  - fix ARTPEC-6 incorrect IS_ERR() usage (Wei Yongjun)

  - add support for ARTPEC-7 SoC (Niklas Cassel)

  - add endpoint-mode support for ARTPEC (Niklas Cassel)

  - add Cadence PCIe host and endpoint controller driver (Cyrille
    Pitchen)

  - handle multiple INTx status bits being set in dra7xx (Vignesh R)

  - translate dra7xx hwirq range to fix INTD handling (Vignesh R)

  - remove deprecated Exynos PHY initialization code (Jaehoon Chung)

  - fix MSI erratum workaround for HiSilicon Hip06/Hip07 (Dongdong
    Liu)

  - fix NULL pointer dereference in iProc BCMA driver (Ray Jui)

  - fix Keystone interrupt-controller-node lookup (Johan Hovold)

  - constify qcom driver structures (Julia Lawall)

  - rework Tegra config space mapping to increase space available for
    endpoints (Vidya Sagar)

  - simplify Tegra driver by using bus->sysdata (Manikanta Maddireddy)

  - remove PCI_REASSIGN_ALL_BUS usage on Tegra (Manikanta Maddireddy)

  - add support for Global Fabric Manager Server (GFMS) event to
    Microsemi Switchtec switch driver (Logan Gunthorpe)

  - add IDs for Switchtec PSX 24xG3 and PSX 48xG3 (Kelvin Cao)


You should see three merge conflicts:

  include/linux/pci.h - trivial conflict between
    856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume")
    0aa0f5d1084c ("PCI: Clean up whitespace in linux/pci.h, pci/pci.h")

  drivers/of/Kconfig - simple conflict between
    6019a3d07d72 ("of: enable unittests on UML")
    4670d610d592 ("PCI: Move OF-related PCI functions into PCI core")

  arch/powerpc/platforms/powernv/eeh-powernv.c - conflict between
    64ba3dc7bf7c ("powerpc/eeh: Update VF config space after EEH")
    fdabc3fe9982 ("PCI: Add #defines for Completion Timeout Disable feature")

In the EEH conflict, I modified a function that was renamed and moved
to arch/powerpc/kernel/eeh.c by the powerpc tree.  My resolution is at
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v4.16-merge


The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.16-changes

for you to fetch changes up to ab8c609356fbe8dbcd44df11e884ce8cddf3739e:

  Merge branch 'pci/spdx' into next (2018-02-01 11:40:07 -0600)

----------------------------------------------------------------
pci-v4.16-changes

----------------------------------------------------------------
Alex Deucher (1):
      PCI: Use dev_info() rather than dev_err() for ROM validation

Alex Williamson (2):
      PCI/DPC: Fix shared interrupt handling
      PCI: Add function 1 DMA alias quirk for Marvell 9128

Andy Shevchenko (3):
      powerpc/pci: Use for_each_pci_bridge() helper
      powerpc/pci: Unroll two pass loop when scanning bridges
      xen/pci: Use acpi_noirq_set() helper to avoid #ifdef

Bjorn Helgaas (58):
      PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
      PCI/ASPM: Enable Latency Tolerance Reporting when supported
      PCI/ASPM: Unexport internal ASPM interfaces
      PCI: Make PCI_SCAN_ALL_PCIE_DEVS work for Root as well as Downstream Ports
      MAINTAINERS: Include more PCI files
      PCI: Remove sysfs resource mmap warning
      PCI: Remove PCI_REASSIGN_ALL_RSRC use on arm and arm64
      vgacon: Set VGA struct resource types
      MIPS: Set I/O port resource types correctly
      powerpc: Set I/O port resource types correctly
      irqchip/i8259: Set I/O port resource types correctly
      resource: Set type of "reserve=" user-specified resources
      resource: Set type when reserving new regions
      PCI: Tidy up pci/probe.c comments
      PCI: Clean up whitespace in linux/pci.h, pci/pci.h
      PCI: Mark Ceton InfiniTV4 INTx masking as broken
      PCI: Add #defines for Completion Timeout Disable feature
      PCI: Add SPDX GPL-2.0 when no license was specified
      PCI/DPC: Rename interrupt_event_handler() to dpc_work()
      PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate
      PCI: Add SPDX GPL-2.0 to replace COPYING boilerplate
      PCI: Add SPDX GPL-2.0+ to replace GPL v2 or later boilerplate
      PCI: Add SPDX GPL-2.0+ to replace implicit GPL v2 or later statement
      PCI/DPC: Add local variable for DPC capability offset
      PCI/DPC: Rename struct dpc_dev.rp to rp_extensions
      PCI/DPC: Read RP PIO Log Size once at probe
      PCI/DPC: Process RP PIO details only if RP PIO extensions supported
      PCI/DPC: Squash dpc_rp_pio_print_tlp_header() into dpc_rp_pio_print_error()
      PCI/DPC: Rename local "status" to "dpc_status"
      PCI/DPC: Make RP PIO log size check more generic
      PCI/DPC: Squash dpc_rp_pio_print_error() into dpc_rp_pio_get_info()
      PCI/DPC: Push dpc->rp_pio_status assignment into dpc_rp_pio_get_info()
      PCI/DPC: Remove unnecessary RP PIO register structs
      PCI/DPC: Squash dpc_rp_pio_get_info() into dpc_process_rp_pio_error()
      PCI/DPC: Add and use DPC Status register field definitions
      PCI/DPC: Reformat DPC register definitions
      Merge branch 'pci/aer' into next
      Merge branch 'pci/aspm' into next
      Merge branch 'pci/deprecate-get-bus-and-slot' into next
      Merge branch 'pci/dma' into next
      Merge branch 'pci/dpc' into next
      Merge branch 'pci/dt-resources' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/hotplug' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/switchtec' into next
      Merge branch 'pci/trivial' into next
      Merge branch 'pci/virtualization' into next
      Merge remote-tracking branch 'lorenzo/pci/cadence' into next
      Merge remote-tracking branch 'lorenzo/pci/dwc' into next
      Merge remote-tracking branch 'lorenzo/pci/endpoint' into next
      Merge remote-tracking branch 'lorenzo/pci/keystone' into next
      Merge remote-tracking branch 'lorenzo/pci/rcar' into next
      Merge remote-tracking branch 'lorenzo/pci/tegra' into next
      Merge remote-tracking branch 'lorenzo/pci/xgene' into next
      Merge branch 'pci/spdx' into next

Christoph Hellwig (4):
      media: ttusb-budget: Remove pci_zalloc_coherent() abuse
      media: ttusb-dec: Remove pci_zalloc_coherent() abuse
      net: tsi108: Use DMA API properly
      PCI: Remove NULL device handling from PCI DMA API

Cyrille Pitchen (10):
      PCI: Regroup all PCI related entries into drivers/pci/Makefile
      PCI: OF: Add generic function to parse and allocate PCI resources
      PCI: generic: fix missing call of pci_free_resource_list()
      PCI: Add generic function to probe PCI host controllers
      PCI: Add vendor ID for Cadence
      PCI: cadence: Add host driver for Cadence PCIe controller
      PCI: endpoint: Add the function number as argument to EPC ops
      PCI: endpoint: Fix EPF device name to support multi-function devices
      dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint controller
      PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller

Dongdong Liu (1):
      PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode

Felix Kuehling (1):
      RDMA/qedr: Use pci_enable_atomic_ops_to_root()

Frederick Lawler (1):
      PCI: Add wrappers for dev_printk()

Geert Uytterhoeven (1):
      PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures

Jaehoon Chung (2):
      PCI: exynos: Remove deprecated PHY initialization code
      PCI: exynos: Fix a potential init_clk_resources NULL pointer dereference

Jay Cornwall (1):
      PCI: Add pci_enable_atomic_ops_to_root()

Johan Hovold (1):
      PCI: keystone: Fix interrupt-controller-node lookup

Julia Lawall (1):
      PCI: qcom: Account for const type of of_device_id.data

Keith Busch (3):
      PCI/AER: Return error if AER is not supported
      PCI/DPC: Enable DPC only if AER is available
      PCI/DPC: Fix interrupt message number print

Kelvin Cao (1):
      switchtec: Add device IDs for PSX 24xG3 and PSX 48xG3

Kishon Vijay Abraham I (2):
      PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
      PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_coherent()

Logan Gunthorpe (1):
      switchtec: Add Global Fabric Manager Server (GFMS) event

Lorenzo Pieralisi (1):
      PCI: xgene: Remove leftover pci_scan_child_bus() call

Lukas Wunner (1):
      PCI: pciehp: Assume NoCompl+ for Thunderbolt ports

Manikanta Maddireddy (3):
      PCI: tegra: Remove PCI_REASSIGN_ALL_BUS use on Tegra
      of: Export of_pci_range_to_resource()
      PCI: tegra: Use bus->sysdata to store and get host private data

Markus Elfring (1):
      PCI: Remove unnecessary messages for memory allocation failures

Mika Westerberg (1):
      PCI: hotplug: Drop checking of PCI_BRIDGE_CONTROL in *_unconfigure_device()

Niklas Cassel (22):
      PCI: designware-ep: Fix find_first_zero_bit() usage
      PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
      PCI: endpoint: Fix find_first_zero_bit() usage
      PCI: dwc: Use the DMA-API to get the MSI address
      PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
      PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writable
      PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init
      PCI: designware-ep: Remove static keyword from dw_pcie_ep_reset_bar()
      PCI: designware-ep: Add generic function for raising MSI irq
      PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode
      PCI: dwc: dra7xx: Assign pp->ops in dra7xx_add_pcie_port() rather than in probe
      PCI: dwc: dra7xx: Help compiler to remove unused code
      PCI: dwc: artpec6: Remove unused defines
      PCI: dwc: artpec6: Use BIT and GENMASK macros
      PCI: dwc: artpec6: Split artpec6_pcie_establish_link() into smaller functions
      bindings: PCI: artpec: Add support for endpoint mode
      PCI: dwc: artpec6: Add support for endpoint mode
      PCI: dwc: Make cpu_addr_fixup take struct dw_pcie as argument
      PCI: dwc: artpec6: Deassert the core before waiting for PHY
      bindings: PCI: artpec: Add support for the ARTPEC-7 SoC
      PCI: dwc: artpec6: Add support for the ARTPEC-7 SoC
      PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n build

Ray Jui (1):
      PCI: iproc: Fix NULL pointer dereference for BCMA

Rob Herring (3):
      PCI: Move OF-related PCI functions into PCI core
      powerpc/pci: Use of_irq_parse_and_map_pci() helper
      PCI: Make of_irq_parse_pci() static

Romain Perier (3):
      block: DAC960: Replace PCI pool old API
      net: e100: Replace PCI pool old API
      hinic: Replace PCI pool old API

Scott Telford (1):
      dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host controller

Sergey Senozhatsky (1):
      PCI: Remove unneeded kallsyms include

Sinan Kaya (23):
      alpha/PCI: Deprecate pci_get_bus_and_slot()
      powerpc/PCI: Deprecate pci_get_bus_and_slot()
      x86/PCI: Deprecate pci_get_bus_and_slot()
      ata: Deprecate pci_get_bus_and_slot()
      agp: nvidia: Deprecate pci_get_bus_and_slot()
      agp: sworks: Deprecate pci_get_bus_and_slot()
      edd: Deprecate pci_get_bus_and_slot()
      ibft: Deprecate pci_get_bus_and_slot()
      drm/gma500: Deprecate pci_get_bus_and_slot()
      drm/nouveau: deprecate pci_get_bus_and_slot()
      sl82c105: deprecate pci_get_bus_and_slot()
      iommu/amd: Deprecate pci_get_bus_and_slot()
      powerpc/via-pmu: Deprecate pci_get_bus_and_slot()
      bnx2x: Deprecate pci_get_bus_and_slot()
      pch_gbe: Deprecate pci_get_bus_and_slot()
      PCI: cpqhp: Deprecate pci_get_bus_and_slot()
      PCI: ibmphp: Deprecate pci_get_bus_and_slot()
      PCI: Deprecate pci_get_bus_and_slot()
      xen/pcifront: Deprecate pci_get_bus_and_slot()
      openprom: Deprecate pci_get_bus_and_slot()
      video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
      video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
      video: fbdev: riva: deprecate pci_get_bus_and_slot()

Stuart Hayes (1):
      PCI: Expose ari_enabled in sysfs

Tyler Baicar (1):
      PCI/AER: Skip recovery callbacks for correctable errors from ACPI APEI

Vidya Sagar (1):
      PCI: tegra: Refactor configuration space mapping code

Vignesh R (3):
      pci: dwc: pci-dra7xx: Make shutdown handler static
      PCI: dra7xx: Fix legacy INTD IRQ handling
      PCI: dra7xx: Iterate over INTx status bits

Wei Yongjun (1):
      PCI: dwc: artpec6: Fix return value check in artpec6_add_pcie_ep()

 Documentation/admin-guide/kernel-parameters.txt    |   6 +-
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   5 +-
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |  22 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |  60 +++
 .../bindings/pci/samsung,exynos5440-pcie.txt       |  58 +--
 MAINTAINERS                                        |  11 +
 arch/alpha/kernel/console.c                        |   1 +
 arch/alpha/kernel/pci.c                            |   2 +-
 arch/alpha/kernel/sys_nautilus.c                   |   2 +-
 arch/arm/include/asm/pci.h                         |   5 +-
 arch/arm/kernel/bios32.c                           |   2 +-
 arch/arm/mach-mvebu/Kconfig                        |   1 -
 arch/mips/jazz/setup.c                             |   8 +-
 arch/mips/mti-malta/malta-setup.c                  |  10 +-
 arch/powerpc/kernel/pci-common.c                   |  10 +-
 arch/powerpc/kernel/pci-hotplug.c                  |  20 +-
 arch/powerpc/kernel/pci_32.c                       |   3 +-
 arch/powerpc/kernel/pci_of_scan.c                  |   7 +-
 arch/powerpc/platforms/maple/time.c                |   2 +-
 arch/powerpc/platforms/powermac/feature.c          |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   6 +-
 arch/powerpc/sysdev/i8259.c                        |   6 +-
 arch/powerpc/sysdev/mv64x60_pci.c                  |   4 +-
 arch/x86/pci/irq.c                                 |   3 +-
 arch/x86/pci/xen.c                                 |   4 +-
 drivers/Makefile                                   |   5 +-
 drivers/ata/pata_ali.c                             |   3 +-
 drivers/block/DAC960.c                             |  38 +-
 drivers/block/DAC960.h                             |   4 +-
 drivers/char/agp/nvidia-agp.c                      |  12 +-
 drivers/char/agp/sworks-agp.c                      |   3 +-
 drivers/firmware/edd.c                             |   8 +-
 drivers/firmware/iscsi_ibft.c                      |   5 +-
 drivers/gpu/drm/gma500/cdv_device.c                |  16 +-
 drivers/gpu/drm/gma500/gma_device.c                |   4 +-
 drivers/gpu/drm/gma500/mid_bios.c                  |  12 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |  10 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |  18 +-
 drivers/gpu/drm/nouveau/dispnv04/arb.c             |   4 +-
 drivers/gpu/drm/nouveau/dispnv04/hw.c              |  10 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c   |  10 +-
 drivers/ide/sl82c105.c                             |   5 +-
 drivers/infiniband/hw/qedr/main.c                  |  59 +--
 drivers/iommu/amd_iommu.c                          |   3 +-
 drivers/iommu/amd_iommu_init.c                     |   9 +-
 drivers/iommu/amd_iommu_v2.c                       |   3 +-
 drivers/irqchip/irq-i8259.c                        |   4 +-
 drivers/macintosh/via-pmu.c                        |   2 +-
 drivers/media/usb/ttusb-budget/dvb-ttusb-budget.c  |  18 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |  18 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |  10 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h  |   1 +
 drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c  |  10 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.h  |   2 +-
 drivers/net/ethernet/intel/e100.c                  |  12 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |   6 +-
 drivers/net/ethernet/tundra/tsi108_eth.c           |  36 +-
 drivers/of/Kconfig                                 |  16 -
 drivers/of/Makefile                                |   2 -
 drivers/of/address.c                               |   9 +-
 drivers/of/of_pci.c                                | 384 --------------
 drivers/of/of_pci_irq.c                            | 131 -----
 drivers/pci/Kconfig                                |   3 +
 drivers/pci/Makefile                               |  14 +-
 drivers/pci/access.c                               |   9 +-
 drivers/pci/ats.c                                  |   1 +
 drivers/pci/bus.c                                  |   5 +-
 drivers/pci/cadence/Kconfig                        |  27 +
 drivers/pci/cadence/Makefile                       |   4 +
 drivers/pci/cadence/pcie-cadence-ep.c              | 542 +++++++++++++++++++
 drivers/pci/cadence/pcie-cadence-host.c            | 336 ++++++++++++
 drivers/pci/cadence/pcie-cadence.c                 | 126 +++++
 drivers/pci/cadence/pcie-cadence.h                 | 311 +++++++++++
 drivers/pci/dwc/Kconfig                            |  70 ++-
 drivers/pci/dwc/Makefile                           |   6 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  47 +-
 drivers/pci/dwc/pci-exynos.c                       | 227 +-------
 drivers/pci/dwc/pci-imx6.c                         |   5 +-
 drivers/pci/dwc/pci-keystone-dw.c                  |   6 +-
 drivers/pci/dwc/pci-keystone.c                     |  10 +-
 drivers/pci/dwc/pci-keystone.h                     |   6 +-
 drivers/pci/dwc/pci-layerscape.c                   |   5 +-
 drivers/pci/dwc/pcie-armada8k.c                    |   5 +-
 drivers/pci/dwc/pcie-artpec6.c                     | 475 ++++++++++++++---
 drivers/pci/dwc/pcie-designware-ep.c               | 140 +++--
 drivers/pci/dwc/pcie-designware-host.c             |  20 +-
 drivers/pci/dwc/pcie-designware-plat.c             |   5 +-
 drivers/pci/dwc/pcie-designware.c                  |   7 +-
 drivers/pci/dwc/pcie-designware.h                  |  41 +-
 drivers/pci/dwc/pcie-hisi.c                        |   5 +-
 drivers/pci/dwc/pcie-histb.c                       |   5 +-
 drivers/pci/dwc/pcie-kirin.c                       |   5 +-
 drivers/pci/dwc/pcie-qcom.c                        |  14 +-
 drivers/pci/dwc/pcie-spear13xx.c                   |   5 +-
 drivers/pci/ecam.c                                 |  13 +-
 drivers/pci/endpoint/Kconfig                       |   1 +
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/Kconfig             |   1 +
 drivers/pci/endpoint/functions/Makefile            |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |  54 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  78 ++-
 drivers/pci/endpoint/pci-epc-core.c                |  85 ++-
 drivers/pci/endpoint/pci-epc-mem.c                 |  13 +-
 drivers/pci/endpoint/pci-epf-core.c                |  17 +-
 drivers/pci/host-bridge.c                          |   1 +
 drivers/pci/host/Kconfig                           |   2 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-aardvark.c                    |   5 +-
 drivers/pci/host/pci-host-common.c                 |  87 +---
 drivers/pci/host/pci-host-generic.c                |  13 +-
 drivers/pci/host/pci-hyperv.c                      |  12 +-
 drivers/pci/host/pci-mvebu.c                       |   5 +-
 drivers/pci/host/pci-rcar-gen2.c                   |   5 +-
 drivers/pci/host/pci-tegra.c                       | 171 ++----
 drivers/pci/host/pci-thunder-ecam.c                |   5 +-
 drivers/pci/host/pci-thunder-pem.c                 |  13 +-
 drivers/pci/host/pci-v3-semi.c                     |   1 +
 drivers/pci/host/pci-versatile.c                   |  12 +-
 drivers/pci/host/pci-xgene-msi.c                   |  11 +-
 drivers/pci/host/pci-xgene.c                       |  13 +-
 drivers/pci/host/pcie-altera-msi.c                 |  13 +-
 drivers/pci/host/pcie-altera.c                     |  13 +-
 drivers/pci/host/pcie-iproc-bcma.c                 |  10 +-
 drivers/pci/host/pcie-iproc-msi.c                  |  10 +-
 drivers/pci/host/pcie-iproc-platform.c             |  17 +-
 drivers/pci/host/pcie-iproc.c                      |  18 +-
 drivers/pci/host/pcie-iproc.h                      |  12 +-
 drivers/pci/host/pcie-mediatek.c                   |  10 +-
 drivers/pci/host/pcie-rcar.c                       |  12 +-
 drivers/pci/host/pcie-rockchip.c                   |   6 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |   6 +-
 drivers/pci/host/pcie-xilinx.c                     |   6 +-
 drivers/pci/host/vmd.c                             |  10 +-
 drivers/pci/hotplug/Kconfig                        |   1 +
 drivers/pci/hotplug/acpi_pcihp.c                   |  16 +-
 drivers/pci/hotplug/acpiphp.h                      |  16 +-
 drivers/pci/hotplug/acpiphp_core.c                 |  16 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  20 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |  16 +-
 drivers/pci/hotplug/cpci_hotplug.h                 |  16 +-
 drivers/pci/hotplug/cpci_hotplug_core.c            |  16 +-
 drivers/pci/hotplug/cpci_hotplug_pci.c             |  16 +-
 drivers/pci/hotplug/cpcihp_generic.c               |  21 +-
 drivers/pci/hotplug/cpcihp_zt5550.c                |  21 +-
 drivers/pci/hotplug/cpcihp_zt5550.h                |  21 +-
 drivers/pci/hotplug/cpqphp.h                       |  16 +-
 drivers/pci/hotplug/cpqphp_core.c                  |  19 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |  16 +-
 drivers/pci/hotplug/cpqphp_nvram.c                 |  16 +-
 drivers/pci/hotplug/cpqphp_nvram.h                 |  16 +-
 drivers/pci/hotplug/cpqphp_pci.c                   |  34 +-
 drivers/pci/hotplug/cpqphp_sysfs.c                 |  16 +-
 drivers/pci/hotplug/ibmphp.h                       |  16 +-
 drivers/pci/hotplug/ibmphp_core.c                  |  36 +-
 drivers/pci/hotplug/ibmphp_ebda.c                  |  16 +-
 drivers/pci/hotplug/ibmphp_hpc.c                   |  16 +-
 drivers/pci/hotplug/ibmphp_pci.c                   |  76 +--
 drivers/pci/hotplug/ibmphp_res.c                   |  54 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |  16 +-
 drivers/pci/hotplug/pciehp.h                       |  16 +-
 drivers/pci/hotplug/pciehp_core.c                  |  16 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |  16 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  28 +-
 drivers/pci/hotplug/pciehp_pci.c                   |  28 +-
 drivers/pci/hotplug/pcihp_skeleton.c               |  16 +-
 drivers/pci/hotplug/pnv_php.c                      |  45 +-
 drivers/pci/hotplug/rpadlpar.h                     |   6 +-
 drivers/pci/hotplug/rpadlpar_core.c                |   6 +-
 drivers/pci/hotplug/rpadlpar_sysfs.c               |   6 +-
 drivers/pci/hotplug/rpaphp.h                       |  16 +-
 drivers/pci/hotplug/rpaphp_core.c                  |  16 +-
 drivers/pci/hotplug/rpaphp_pci.c                   |  16 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |  16 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |   3 +-
 drivers/pci/hotplug/sgi_hotplug.c                  |  41 +-
 drivers/pci/hotplug/shpchp.h                       |  24 +-
 drivers/pci/hotplug/shpchp_core.c                  |  21 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |  16 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |  16 +-
 drivers/pci/hotplug/shpchp_pci.c                   |  28 +-
 drivers/pci/hotplug/shpchp_sysfs.c                 |  16 +-
 drivers/pci/iov.c                                  |  11 +-
 drivers/pci/irq.c                                  |   7 +-
 drivers/pci/mmap.c                                 |   5 +-
 drivers/pci/msi.c                                  |   8 +-
 drivers/pci/of.c                                   | 571 ++++++++++++++++++++-
 drivers/pci/pci-acpi.c                             |   3 +-
 drivers/pci/pci-driver.c                           |   4 +-
 drivers/pci/pci-mid.c                              |   5 +-
 drivers/pci/pci-stub.c                             |   5 +-
 drivers/pci/pci-sysfs.c                            |  30 +-
 drivers/pci/pci.c                                  | 158 ++++--
 drivers/pci/pci.h                                  |  74 ++-
 drivers/pci/pcie/Kconfig                           |   3 +-
 drivers/pci/pcie/aer/Kconfig                       |   1 +
 drivers/pci/pcie/aer/Kconfig.debug                 |   1 +
 drivers/pci/pcie/aer/aer_inject.c                  |  22 +-
 drivers/pci/pcie/aer/aerdrv.c                      |   7 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |  31 +-
 drivers/pci/pcie/aer/aerdrv_errprint.c             |  27 +-
 drivers/pci/pcie/aer/ecrc.c                        |  16 +-
 drivers/pci/pcie/aspm.c                            |  80 +--
 drivers/pci/pcie/pcie-dpc.c                        | 256 ++++-----
 drivers/pci/pcie/pme.c                             |  11 +-
 drivers/pci/pcie/portdrv_acpi.c                    |   5 +-
 drivers/pci/pcie/portdrv_bus.c                     |   1 +
 drivers/pci/pcie/portdrv_core.c                    |   4 +-
 drivers/pci/pcie/ptm.c                             |  12 +-
 drivers/pci/probe.c                                | 372 +++++++++-----
 drivers/pci/quirks.c                               | 210 ++++----
 drivers/pci/remove.c                               |   1 +
 drivers/pci/rom.c                                  |   9 +-
 drivers/pci/search.c                               |   1 +
 drivers/pci/setup-bus.c                            |  49 +-
 drivers/pci/setup-irq.c                            |   5 +-
 drivers/pci/setup-res.c                            |  40 +-
 drivers/pci/slot.c                                 |   1 +
 drivers/pci/switch/Kconfig                         |   2 +
 drivers/pci/switch/Makefile                        |   1 +
 drivers/pci/switch/switchtec.c                     |  14 +-
 drivers/pci/syscall.c                              |   4 +-
 drivers/pci/vc.c                                   |  23 +-
 drivers/pci/vpd.c                                  |   1 +
 drivers/pci/xen-pcifront.c                         |  23 +-
 drivers/sbus/char/openprom.c                       |   5 +-
 drivers/video/console/vgacon.c                     |  34 +-
 drivers/video/fbdev/intelfb/intelfbhw.c            |   4 +-
 drivers/video/fbdev/nvidia/nv_hw.c                 |  11 +-
 drivers/video/fbdev/nvidia/nv_setup.c              |   3 +-
 drivers/video/fbdev/riva/fbdev.c                   |   2 +-
 drivers/video/fbdev/riva/nv_driver.c               |   7 +-
 drivers/video/fbdev/riva/riva_hw.c                 |  20 +-
 drivers/video/fbdev/riva/riva_hw.h                 |   3 +-
 include/asm-generic/pci_iomap.h                    |   6 +-
 include/linux/of_pci.h                             |   8 +-
 include/linux/pci-aspm.h                           |  35 +-
 include/linux/pci-dma-compat.h                     |  27 +-
 include/linux/pci-ecam.h                           |  13 +-
 include/linux/pci-ep-cfs.h                         |   5 +-
 include/linux/pci-epc.h                            |  48 +-
 include/linux/pci-epf.h                            |   5 +-
 include/linux/pci.h                                | 441 ++++++++--------
 include/linux/pci_hotplug.h                        |  16 +-
 include/linux/pci_ids.h                            |   2 +
 include/linux/switchtec.h                          |   3 +
 include/uapi/linux/pci_regs.h                      |  30 +-
 include/uapi/linux/switchtec_ioctl.h               |   3 +-
 kernel/resource.c                                  |  29 +-
 lib/pci_iomap.c                                    |   1 +
 250 files changed, 4505 insertions(+), 3758 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
 create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
 delete mode 100644 drivers/of/of_pci.c
 delete mode 100644 drivers/of/of_pci_irq.c
 create mode 100644 drivers/pci/cadence/Kconfig
 create mode 100644 drivers/pci/cadence/Makefile
 create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
 create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
 create mode 100644 drivers/pci/cadence/pcie-cadence.c
 create mode 100644 drivers/pci/cadence/pcie-cadence.h
