Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35926 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936029AbcHBRjP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 13:39:15 -0400
Date: Tue, 2 Aug 2016 12:39:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.8
Message-ID: <20160802173908.GA14580@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.8.  Highlights:

  - ARM64 support for ACPI host bridges
  - New drivers for Axis ARTPEC-6 and Marvell Aardvark
  - New pci_alloc_irq_vectors() interface for MSI-X, MSI, legacy INTx
  - pci_resource_to_user() cleanup (more to come)

Bjorn


The following changes since commit 5e385a6ef31fbbf2acbda770aecc2bc2ff933d17:

  genirq: Add a helper to spread an affinity mask for MSI/MSI-X vectors (2016-07-04 12:25:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.8-changes

for you to fetch changes up to 9454c23852ca6d7aec89fd6fd46a046c323caac3:

  Merge branch 'pci/msi-affinity' into next (2016-08-01 12:34:01 -0500)

----------------------------------------------------------------
PCI changes for the v4.8 merge window:

  Enumeration
    Move ecam.h to linux/include/pci-ecam.h (Jayachandran C)
    Add parent device field to ECAM struct pci_config_window (Jayachandran C)
    Add generic MCFG table handling (Tomasz Nowicki)
    Refactor pci_bus_assign_domain_nr() for CONFIG_PCI_DOMAINS_GENERIC (Tomasz Nowicki)
    Factor DT-specific pci_bus_find_domain_nr() code out (Tomasz Nowicki)

  Resource management
    Add devm_request_pci_bus_resources() (Bjorn Helgaas)
    Unify pci_resource_to_user() declarations (Bjorn Helgaas)
    Implement pci_resource_to_user() with pcibios_resource_to_bus() (microblaze, powerpc, sparc) (Bjorn Helgaas)
    Request host bridge window resources (designware, iproc, rcar, xgene, xilinx, xilinx-nwl) (Bjorn Helgaas)
    Make PCI I/O space optional on ARM32 (Bjorn Helgaas)
    Ignore write combining when mapping I/O port space (Bjorn Helgaas)
    Claim bus resources on MIPS PCI_PROBE_ONLY set-ups (Bjorn Helgaas)
    Remove unicore32 pci=firmware command line parameter handling (Bjorn Helgaas)
    Support I/O resources when parsing host bridge resources (Jayachandran C)
    Add helpers to request/release memory and I/O regions (Johannes Thumshirn)
    Use pci_(request|release)_mem_regions (NVMe, lpfc, GenWQE, ethernet/intel, alx) (Johannes Thumshirn)
    Extend pci=resource_alignment to specify device/vendor IDs (Koehrer Mathias (ETAS/ESW5))
    Add generic pci_bus_claim_resources() (Lorenzo Pieralisi)
    Claim bus resources on ARM32 PCI_PROBE_ONLY set-ups (Lorenzo Pieralisi)
    Remove ARM32 and ARM64 arch-specific pcibios_enable_device() (Lorenzo Pieralisi)
    Add pci_unmap_iospace() to unmap I/O resources (Sinan Kaya)
    Remove powerpc __pci_mmap_set_pgprot() (Yinghai Lu)

  PCI device hotplug
    Allow additional bus numbers for hotplug bridges (Keith Busch)
    Ignore interrupts during D3cold (Lukas Wunner)

  Power management
    Enforce type casting for pci_power_t (Andy Shevchenko)
    Don't clear d3cold_allowed for PCIe ports (Mika Westerberg)
    Put PCIe ports into D3 during suspend (Mika Westerberg)
    Power on bridges before scanning new devices (Mika Westerberg)
    Runtime resume bridge before rescan (Mika Westerberg)
    Add runtime PM support for PCIe ports (Mika Westerberg)
    Remove redundant check of pcie_set_clkpm (Shawn Lin)

  Virtualization
    Add function 1 DMA alias quirk for Marvell 88SE9182 (Aaron Sierra)
    Add DMA alias quirk for Adaptec 3805 (Alex Williamson)
    Mark Atheros AR9485 and QCA9882 to avoid bus reset (Chris Blake)
    Add ACS quirk for Solarflare SFC9220 (Edward Cree)

  MSI
    Fix PCI_MSI dependencies (Arnd Bergmann)
    Add pci_msix_desc_addr() helper (Christoph Hellwig)
    Switch msix_program_entries() to use pci_msix_desc_addr() (Christoph Hellwig)
    Make the "entries" argument to pci_enable_msix() optional (Christoph Hellwig)
    Provide sensible IRQ vector alloc/free routines (Christoph Hellwig)
    Spread interrupt vectors in pci_alloc_irq_vectors() (Christoph Hellwig)

  Error Handling
    Bind DPC to Root Ports as well as Downstream Ports (Keith Busch)
    Remove DPC tristate module option (Keith Busch)
    Convert Downstream Port Containment driver to use devm_* functions (Mika Westerberg)

  Generic host bridge driver
    Select IRQ_DOMAIN (Arnd Bergmann)
    Claim bus resources on PCI_PROBE_ONLY set-ups (Lorenzo Pieralisi)

  ACPI host bridge driver
    Add ARM64 acpi_pci_bus_find_domain_nr() (Tomasz Nowicki)
    Add ARM64 ACPI support for legacy IRQs parsing and consolidation with DT code (Tomasz Nowicki)
    Implement ARM64 AML accessors for PCI_Config region (Tomasz Nowicki)
    Support ARM64 ACPI-based PCI host controller (Tomasz Nowicki)

  Altera host bridge driver
    Check link status before retrain link (Ley Foon Tan)
    Poll for link up status after retraining the link (Ley Foon Tan)

  Axis ARTPEC-6 host bridge driver
    Add PCI_MSI_IRQ_DOMAIN dependency (Arnd Bergmann)
    Add DT binding for Axis ARTPEC-6 PCIe controller (Niklas Cassel)
    Add Axis ARTPEC-6 PCIe controller driver (Niklas Cassel)

  Intel VMD host bridge driver
    Use lock save/restore in interrupt enable path (Jon Derrick)
    Select device dma ops to override (Keith Busch)
    Initialize list item in IRQ disable (Keith Busch)
    Use x86_vector_domain as parent domain (Keith Busch)
    Separate MSI and MSI-X vector sharing (Keith Busch)

  Marvell Aardvark host bridge driver
    Add DT binding for the Aardvark PCIe controller (Thomas Petazzoni)
    Add Aardvark PCI host controller driver (Thomas Petazzoni)
    Add Aardvark PCIe support for Armada 3700 (Thomas Petazzoni)

  Microsoft Hyper-V host bridge driver
    Fix interrupt cleanup path (Cathy Avery)
    Don't leak buffer in hv_pci_onchannelcallback() (Vitaly Kuznetsov)
    Handle all pending messages in hv_pci_onchannelcallback() (Vitaly Kuznetsov)

  NVIDIA Tegra host bridge driver
    Program PADS_REFCLK_CFG* always, not just on legacy SoCs (Stephen Warren)
    Program PADS_REFCLK_CFG* registers with per-SoC values (Stephen Warren)
    Use lower-case hex consistently for register definitions (Thierry Reding)
    Use generic pci_remap_iospace() rather than ARM32-specific one (Thierry Reding)
    Stop setting pcibios_min_mem (Thierry Reding)

  Renesas R-Car host bridge driver
    Drop gen2 dummy I/O port region (Bjorn Helgaas)

  TI DRA7xx host bridge driver
    Fix return value in case of error (Christophe JAILLET)

  Xilinx AXI host bridge driver
    Fix return value in case of error (Christophe JAILLET)

  Miscellaneous
    Make bus_attr_resource_alignment static (Ben Dooks)
    Include <asm/dma.h> for isa_dma_bridge_buggy (Ben Dooks)
    MAINTAINERS: Add file patterns for PCI device tree bindings (Geert Uytterhoeven)
    Make host bridge drivers explicitly non-modular (Paul Gortmaker)

----------------------------------------------------------------
Aaron Sierra (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9182

Alex Williamson (1):
      PCI: Add DMA alias quirk for Adaptec 3805

Andrea Gelmini (1):
      PCI: Fix comment typo

Andy Shevchenko (1):
      PCI / PM: Enforce type casting for pci_power_t

Arnd Bergmann (3):
      PCI: generic: Select IRQ_DOMAIN
      PCI/MSI: irqchip: Fix PCI_MSI dependencies
      PCI: artpec: Add PCI_MSI_IRQ_DOMAIN dependency

Ben Dooks (2):
      PCI: Make bus_attr_resource_alignment static
      PCI: Include <asm/dma.h> for isa_dma_bridge_buggy

Bjorn Helgaas (44):
      PCI: Add devm_request_pci_bus_resources()
      PCI: Ignore write combining when mapping I/O port space
      microblaze/PCI: Remove useless __pci_mmap_set_pgprot()
      PCI: Unify pci_resource_to_user() declarations
      microblaze/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      powerpc/pci: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      sparc/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      PCI: Document connection between pci_power_t and hardware PM capability
      PCI: designware: Free bridge resource list on failure
      PCI: designware: Request host bridge window resources
      PCI: designware: Simplify host bridge window iteration
      PCI: iproc: Request host bridge window resources
      PCI: xgene: Free bridge resource list on failure
      PCI: xgene: Request host bridge window resources
      PCI: xilinx: Free bridge resource list on failure
      PCI: xilinx: Request host bridge window resources
      PCI: xilinx-nwl: Free bridge resource list on failure
      PCI: xilinx-nwl: Request host bridge window resources
      PCI: xilinx-nwl: Use dev_printk() when possible
      PCI: altera: Request host bridge window resources with core function
      PCI: altera: Simplify host bridge window iteration
      PCI: generic: Request host bridge window resources with core function
      PCI: generic: Simplify host bridge window iteration
      PCI: mvebu: Request host bridge window resources with core function
      ARM: Make PCI I/O space optional
      MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups
      unicore32/PCI: Remove pci=firmware command line parameter handling
      PCI: rcar: Drop gen2 dummy I/O port region
      PCI: rcar Gen2: Request host bridge window resources
      PCI: rcar: Request host bridge window resources with core function
      PCI: rcar: Simplify host bridge window iteration
      PCI: tegra: Remove top-level resource from hierarchy
      PCI: tegra: Request host bridge window resources with core function
      PCI: versatile: Request host bridge window resources with core function
      PCI: versatile: Simplify host bridge window iteration
      PCI: altera: Reorder read/write functions
      Merge branches 'pci/host-artpec' and 'pci/host-generic' into pci/demodularize-hosts
      Merge branch 'pci/arm64-acpi' into next
      Merge branches 'pci/aspm', 'pci/dpc', 'pci/hotplug', 'pci/misc', 'pci/msi', 'pci/pm' and 'pci/virtualization' into next
      Merge branch 'pci/resource' into next
      Merge branches 'pci/demodularize-hosts' and 'pci/host-request-windows' into next
      Merge branch 'pci/host-tegra' into next
      Merge branches 'pci/host-aardvark', 'pci/host-altera', 'pci/host-dra7xx', 'pci/host-hv', 'pci/host-vmd' and 'pci/host-xilinx' into next
      Merge branch 'pci/msi-affinity' into next

Cathy Avery (1):
      PCI: hv: Fix interrupt cleanup path

Chris Blake (1):
      PCI: Mark Atheros AR9485 and QCA9882 to avoid bus reset

Christoph Hellwig (5):
      PCI: Add pci_msix_desc_addr() helper
      PCI: Switch msix_program_entries() to use pci_msix_desc_addr()
      PCI: Make the "entries" argument to pci_enable_msix() optional
      PCI: Provide sensible IRQ vector alloc/free routines
      PCI: Spread interrupt vectors in pci_alloc_irq_vectors()

Christophe JAILLET (2):
      PCI: xilinx: Fix return value in case of error
      PCI: dra7xx: Fix return value in case of error

Edward Cree (1):
      PCI: Add ACS quirk for Solarflare SFC9220

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for PCI device tree bindings

Jayachandran C (3):
      PCI: Move ecam.h to linux/include/pci-ecam.h
      PCI: Add parent device field to ECAM struct pci_config_window
      PCI/ACPI: Support I/O resources when parsing host bridge resources

Johannes Thumshirn (6):
      PCI: Add helpers to request/release memory and I/O regions
      NVMe: Use pci_(request|release)_mem_regions
      lpfc: Use pci_(request|release)_mem_regions
      GenWQE: Use pci_(request|release)_mem_regions
      ethernet/intel: Use pci_(request|release)_mem_regions
      alx: Use pci_(request|release)_mem_regions

Jon Derrick (1):
      x86/PCI: VMD: Use lock save/restore in interrupt enable path

Keith Busch (7):
      x86/PCI: VMD: Select device dma ops to override
      x86/PCI: VMD: Initialize list item in IRQ disable
      x86/PCI: VMD: Use x86_vector_domain as parent domain
      x86/PCI: VMD: Separate MSI and MSI-X vector sharing
      PCI: Bind DPC to Root Ports as well as Downstream Ports
      PCI: Remove DPC tristate module option
      PCI: Allow additional bus numbers for hotplug bridges

Koehrer Mathias (ETAS/ESW5) (1):
      PCI: Extending pci=resource_alignment to specify device/vendor IDs

Ley Foon Tan (2):
      PCI: altera: Check link status before retrain link
      PCI: altera: Poll for link up status after retraining the link

Lorenzo Pieralisi (5):
      PCI: Add generic pci_bus_claim_resources()
      PCI: generic: Claim bus resources on PCI_PROBE_ONLY set-ups
      ARM/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups
      ARM64/PCI: Remove arch-specific pcibios_enable_device()
      ARM/PCI: Remove arch-specific pcibios_enable_device()

Lukas Wunner (1):
      PCI: pciehp: Ignore interrupts during D3cold

Mika Westerberg (7):
      PCI: Don't clear d3cold_allowed for PCIe ports
      PCI: Put PCIe ports into D3 during suspend
      PCI: Power on bridges before scanning new devices
      ACPI / hotplug / PCI: Runtime resume bridge before rescan
      PCI: Add runtime PM support for PCIe ports
      PCI: Convert Downstream Port Containment driver to use devm_* functions
      PCI: Fix whitespace in struct dpc_dev

Niklas Cassel (2):
      PCI: Add DT binding for Axis ARTPEC-6 PCIe controller
      PCI: artpec: Add Axis ARTPEC-6 PCIe controller driver

Paul Gortmaker (14):
      PCI: armada8k: Make explicitly non-modular
      PCI: artpec6: Make explicitly non-modular
      PCI: designware-plat: Make it explicitly non-modular
      PCI: generic: Make explicitly non-modular
      PCI: hisi: Make explicitly non-modular
      PCI: keystone: Make explicitly non-modular
      PCI: layerscape: Make explicitly non-modular
      PCI: mvebu: Make explicitly non-modular
      PCI: rcar: Make explicitly non-modular
      PCI: rcar-gen2: Make explicitly non-modular
      PCI: tegra: Make explicitly non-modular
      PCI: thunder-ecam: Make explicitly non-modular
      PCI: thunder-pem: Make explicitly non-modular
      PCI: xgene: Make explicitly non-modular

Shawn Lin (1):
      PCI/ASPM: Remove redundant check of pcie_set_clkpm

Sinan Kaya (1):
      PCI: Add pci_unmap_iospace() to unmap I/O resources

Stephen Warren (2):
      PCI: tegra: Program PADS_REFCLK_CFG* always, not just on legacy SoCs
      PCI: tegra: Program PADS_REFCLK_CFG* registers with per-SoC values

Thierry Reding (3):
      PCI: tegra: Use lower-case hex consistently for register definitions
      PCI: tegra: Use generic pci_remap_iospace() rather than ARM32-specific one
      PCI: tegra: Stop setting pcibios_min_mem

Thomas Petazzoni (3):
      dt-bindings: add DT binding for the Aardvark PCIe controller
      PCI: aardvark: Add Aardvark PCI host controller driver
      arm64: dts: marvell: Add Aardvark PCIe support for Armada 3700

Tomasz Nowicki (7):
      PCI/ACPI: Add generic MCFG table handling
      PCI: Refactor pci_bus_assign_domain_nr() for CONFIG_PCI_DOMAINS_GENERIC
      PCI: Factor DT-specific pci_bus_find_domain_nr() code out
      ARM64: PCI: Add acpi_pci_bus_find_domain_nr()
      ARM64: PCI: ACPI support for legacy IRQs parsing and consolidation with DT code
      ARM64: PCI: Implement AML accessors for PCI_Config region
      ARM64: PCI: Support ACPI-based PCI host controller

Vitaly Kuznetsov (2):
      PCI: hv: Don't leak buffer in hv_pci_onchannelcallback()
      PCI: hv: Handle all pending messages in hv_pci_onchannelcallback()

Yinghai Lu (1):
      powerpc/pci: Remove __pci_mmap_set_pgprot()

 Documentation/PCI/MSI-HOWTO.txt                    |  469 ++-------
 .../devicetree/bindings/pci/aardvark-pci.txt       |   56 ++
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   46 +
 Documentation/kernel-parameters.txt                |    9 +
 MAINTAINERS                                        |   17 +
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/include/asm/mach/pci.h                    |    1 +
 arch/arm/kernel/bios32.c                           |   45 +-
 arch/arm64/Kconfig                                 |    6 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    5 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   25 +
 arch/arm64/kernel/pci.c                            |  159 +++-
 arch/microblaze/include/asm/pci.h                  |    3 -
 arch/microblaze/pci/pci-common.c                   |   73 +-
 arch/mips/include/asm/pci.h                        |   10 -
 arch/mips/pci/pci.c                                |   19 +-
 arch/powerpc/include/asm/pci.h                     |    3 -
 arch/powerpc/kernel/pci-common.c                   |   79 +-
 arch/sparc/include/asm/pci_64.h                    |    3 -
 arch/sparc/kernel/pci.c                            |   20 +-
 arch/unicore32/kernel/pci.c                        |    9 +-
 arch/x86/pci/common.c                              |    2 +-
 arch/x86/pci/vmd.c                                 |   41 +-
 drivers/acpi/Kconfig                               |    3 +
 drivers/acpi/Makefile                              |    1 +
 drivers/acpi/pci_mcfg.c                            |   92 ++
 drivers/acpi/pci_root.c                            |   35 +
 drivers/irqchip/Kconfig                            |   18 +-
 drivers/misc/genwqe/card_base.c                    |   18 +-
 drivers/net/ethernet/atheros/alx/main.c            |   12 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    6 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |   11 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    9 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    9 +-
 drivers/nvme/host/pci.c                            |   15 +-
 drivers/pci/Kconfig                                |    2 +-
 drivers/pci/bus.c                                  |   31 +-
 drivers/pci/ecam.c                                 |    6 +-
 drivers/pci/host/Kconfig                           |   49 +-
 drivers/pci/host/Makefile                          |    2 +
 drivers/pci/host/pci-aardvark.c                    | 1001 ++++++++++++++++++++
 drivers/pci/host/pci-dra7xx.c                      |    4 +-
 drivers/pci/host/pci-host-common.c                 |   44 +-
 drivers/pci/host/pci-host-generic.c                |   13 +-
 drivers/pci/host/pci-hyperv.c                      |   30 +-
 drivers/pci/host/pci-keystone.c                    |   10 +-
 drivers/pci/host/pci-layerscape.c                  |   10 +-
 drivers/pci/host/pci-mvebu.c                       |   28 +-
 drivers/pci/host/pci-rcar-gen2.c                   |   27 +-
 drivers/pci/host/pci-tegra.c                       |   99 +-
 drivers/pci/host/pci-thunder-ecam.c                |   11 +-
 drivers/pci/host/pci-thunder-pem.c                 |   14 +-
 drivers/pci/host/pci-versatile.c                   |   29 +-
 drivers/pci/host/pci-xgene.c                       |   24 +-
 drivers/pci/host/pcie-altera.c                     |   83 +-
 drivers/pci/host/pcie-armada8k.c                   |   14 +-
 drivers/pci/host/pcie-artpec6.c                    |  280 ++++++
 drivers/pci/host/pcie-designware-plat.c            |   10 +-
 drivers/pci/host/pcie-designware.c                 |   34 +-
 drivers/pci/host/pcie-hisi.c                       |   13 +-
 drivers/pci/host/pcie-iproc.c                      |    4 +
 drivers/pci/host/pcie-rcar.c                       |   44 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |   20 +-
 drivers/pci/host/pcie-xilinx.c                     |   22 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |    4 +
 drivers/pci/hotplug/pciehp_hpc.c                   |    4 +
 drivers/pci/msi.c                                  |  266 ++++--
 drivers/pci/pci-driver.c                           |    5 +-
 drivers/pci/pci-sysfs.c                            |    5 +
 drivers/pci/pci.c                                  |  281 +++++-
 drivers/pci/pci.h                                  |   11 +
 drivers/pci/pcie/Kconfig                           |    5 +-
 drivers/pci/pcie/aspm.c                            |    2 +-
 drivers/pci/pcie/pcie-dpc.c                        |   19 +-
 drivers/pci/pcie/portdrv_core.c                    |    3 +
 drivers/pci/pcie/portdrv_pci.c                     |   52 +-
 drivers/pci/probe.c                                |   22 +-
 drivers/pci/proc.c                                 |    9 +-
 drivers/pci/quirks.c                               |   17 +-
 drivers/pci/remove.c                               |    2 +
 drivers/pci/setup-bus.c                            |   68 ++
 drivers/scsi/lpfc/lpfc_init.c                      |   15 +-
 drivers/usb/host/xhci-pci.c                        |    2 +-
 include/linux/pci-acpi.h                           |    2 +
 drivers/pci/ecam.h => include/linux/pci-ecam.h     |    4 +-
 include/linux/pci.h                                |   93 +-
 87 files changed, 3014 insertions(+), 1176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
 create mode 100644 drivers/acpi/pci_mcfg.c
 create mode 100644 drivers/pci/host/pci-aardvark.c
 create mode 100644 drivers/pci/host/pcie-artpec6.c
 rename drivers/pci/ecam.h => include/linux/pci-ecam.h (95%)
