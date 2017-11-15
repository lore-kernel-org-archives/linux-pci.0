Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Nov 2017 12:58:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.15
Message-ID: <20171115185855.GA11685@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - detach driver before tearing down procfs/sysfs (Alex Williamson)

  - disable PCIe services during shutdown (Sinan Kaya)

  - fix ASPM oops on systems with no Root Ports (Ard Biesheuvel)

  - fix ASPM LTR_L1.2_THRESHOLD programming (Bjorn Helgaas)

  - fix ASPM Common_Mode_Restore_Time computation (Bjorn Helgaas)

  - fix portdrv MSI/MSI-X vector allocation (Dongdong Liu, Bjorn Helgaas)

  - report non-fatal AER errors only to the affected endpoint (Gabriele
    Paoloni)

  - distribute bus numbers, MMIO, and I/O space among hotplug bridges to
    allow more devices to be hot-added (Mika Westerberg)

  - fix pciehp races during initialization and surprise link down (Mika
    Westerberg)

  - handle surprise-removed devices in PME handling (Qiang)

  - support resizable BARs for large graphics devices (Christian König)

  - expose SR-IOV offset, stride, and VF device ID via sysfs (Filippo
    Sironi)

  - create SR-IOV virtfn/physfn sysfs links before attaching driver (Stuart
    Hayes)

  - fix SR-IOV "ARI Capable Hierarchy" restore issue (Tony Nguyen)

  - enforce Kconfig IOV/REALLOC dependency (Sascha El-Sharkawy)

  - avoid slot reset if bridge itself is broken (Jan Glauber)

  - clean up pci_reset_function() path (Jan H. Schönherr)

  - make pci_map_rom() fail if the option ROM is invalid (Changbin Du)

  - convert timers to timer_setup() (Kees Cook)

  - move PCI_QUIRKS to PCI bus Kconfig menu (Randy Dunlap)

  - constify pci_dev_type and intel_mid_pci_ops (Bhumika Goyal)

  - remove unnecessary pci_dev, pci_bus, resource, pcibios_set_master()
    declarations (Bjorn Helgaas)

  - fix endpoint framework overflows and BUG()s (Dan Carpenter)

  - fix endpoint framework issues (Kishon Vijay Abraham I)

  - avoid broken Cavium CN8xxx bus reset behavior (David Daney)

  - extend Cavium ACS capability quirks (Vadim Lomovtsev)

  - support Synopsys DesignWare RC in ECAM mode (Ard Biesheuvel)

  - turn off dra7xx clocks cleanly on shutdown (Keerthy)

  - fix Faraday probe error path (Wei Yongjun)

  - support HiSilicon STB SoC PCIe host controller (Jianguo Sun)

  - fix Hyper-V interrupt affinity issue (Dexuan Cui)

  - remove useless ACPI warning for Hyper-V pass-through devices (Vitaly
    Kuznetsov)

  - support multiple MSI on iProc (Sandor Bodo-Merle)

  - support Layerscape LS1012a and LS1046a PCIe host controllers (Hou
    Zhiqiang)

  - fix Layerscape default error response (Minghuan Lian)

  - support MSI on Tango host controller (Marc Gonzalez)

  - support Tegra186 PCIe host controller (Manikanta Maddireddy)

  - use generic accessors on Tegra when possible (Thierry Reding)

  - support V3 Semiconductor PCI host controller (Linus Walleij)


There's a trivial merge conflict in drivers/pci/host/pcie-tango.c from the
SPDX changes.  My resolution is at
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v4.15-merge


The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.15-changes

for you to fetch changes up to 91f3140fdef61074515470243370d92a45f0b516:

  Merge branch 'pci/host-xilinx' into next (2017-11-14 12:11:38 -0600)

----------------------------------------------------------------
pci-v4.15-changes

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Detach driver before procfs & sysfs teardown on device remove

Andy Shevchenko (1):
      PCI: Add for_each_pci_bridge() helper

Ard Biesheuvel (3):
      PCI/ASPM: Deal with missing root ports in link state handling
      PCI: generic: Add support for Synopsys DesignWare RC in ECAM mode
      dt-bindings: PCI: designware: Add binding for Designware PCIe in ECAM mode

Bhumika Goyal (2):
      PCI: Constify pci_dev_type structure
      x86/pci/intel_mid_pci: Constify intel_mid_pci_ops and make it __initconst

Bjorn Helgaas (41):
      PCI/portdrv: Consolidate comments
      PCI/portdrv: Factor out Interrupt Message Number lookup
      PCI/portdrv: Compute MSI/MSI-X IRQ vectors after final allocation
      PCI: Document reset method return values
      PCI: Remove redundant pcibios_set_master() declarations
      PCI: Remove redundant pci_dev, pci_bus, resource declarations
      PCI: Remove unused declarations
      alpha/PCI: Make pdev_save_srm_config() static
      PCI: altera: Rename altera_pcie_link_is_up() to altera_pcie_link_up()
      PCI: xilinx: Rename xilinx_pcie_link_is_up() to xilinx_pcie_link_up()
      PCI: xgene: Rename xgene_pcie_probe_bridge() to xgene_pcie_probe()
      PCI/ASPM: Account for downstream device's Port Common_Mode_Restore_Time
      PCI/ASPM: Use correct capability pointer to program LTR_L1.2_THRESHOLD
      PCI/ASPM: Reformat ASPM register definitions
      PCI/ASPM: Add L1 Substates definitions
      Merge branch 'pci/acpi' into next
      Merge branch 'pci/aer' into next
      Merge branch 'pci/aspm' into next
      Merge branch 'pci/endpoint' into next
      Merge branch 'pci/hotplug' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/portdrv' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/switchtec' into next
      Merge branch 'pci/virtualization' into next
      Merge branch 'pci/host-altera' into next
      Merge branch 'pci/host-dra7xx' into next
      Merge branch 'pci/host-faraday' into next
      Merge branch 'pci/host-generic' into next
      Merge branch 'pci/host-hisi' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/host-iproc' into next
      Merge branch 'pci/host-layerscape' into next
      Merge branch 'pci/host-rcar' into next
      Merge branch 'pci/host-tango' into next
      Merge branch 'pci/host-tegra' into next
      Merge branch 'pci/host-thunder' into next
      Merge branch 'pci/host-v3-semi' into next
      Merge branch 'pci/host-xgene' into next
      Merge branch 'pci/host-xilinx' into next

Changbin Du (2):
      PCI: Move pci_map_rom() error path
      PCI: Fail pci_map_rom() if the option ROM is invalid

Christian König (4):
      PCI: Add PCI resource type mask #define
      PCI: Add resizable BAR infrastructure
      PCI: Add pci_resize_resource() for resizing BARs
      x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)

Colin Ian King (1):
      switchtec: Make struct event_regs static

Dan Carpenter (2):
      misc: pci_endpoint_test: Prevent some integer overflows
      misc: pci_endpoint_test: Avoid triggering a BUG()

David Daney (2):
      PCI: Mark Cavium CN8xxx to avoid bus reset
      PCI: Avoid bus reset if bridge itself is broken

Dexuan Cui (1):
      PCI: hv: Use effective affinity mask

Dongdong Liu (1):
      PCI/portdrv: Add #defines for AER and DPC Interrupt Message Number masks

Filippo Sironi (2):
      PCI: Cache the VF device ID in the SR-IOV structure
      PCI: Expose SR-IOV offset, stride, and VF device ID via sysfs

Gabriele Paoloni (1):
      PCI/AER: Report non-fatal errors only to the affected endpoint

Geert Uytterhoeven (1):
      dt-bindings: PCI: rcar: Correct example to match reality

Hou Zhiqiang (6):
      irqchip/ls-scfg-msi: Add LS1012a MSI support
      arm64: dts: ls1012a: Add MSI controller DT node
      PCI: layerscape: Add support for ls1012a
      arm64: dts: ls1012a: Add PCIe controller DT node
      arm64: dts: ls1046a: Add PCIe controller DT nodes
      PCI: Disable MSI for Freescale Layerscape PCIe RC mode

Jan Glauber (1):
      PCI: Avoid slot reset if bridge itself is broken

Jan H. Schönherr (2):
      PCI: Remove reset argument from pci_iov_{add,remove}_virtfn()
      PCI: Remove unused function __pci_reset_function()

Jianguo Sun (1):
      PCI: hisi: Add HiSilicon STB SoC PCIe controller driver

Keerthy (1):
      PCI: dra7xx: Add shutdown handler to cleanly turn off clocks

Kees Cook (3):
      PCI: pciehp: Convert timers to use timer_setup()
      PCI: cpqphp: Convert timers to use timer_setup()
      PCI: shpchp: Convert timers to use timer_setup()

Kishon Vijay Abraham I (3):
      misc: pci_endpoint_test: Fix failure path return values in probe
      misc: pci_endpoint_test: Fix pci_endpoint_test not releasing resources on remove
      misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi()

Linus Walleij (2):
      PCI: v3: Update the device tree bindings
      PCI: v3-semi: Add V3 Semiconductor PCI host driver

Manikanta Maddireddy (2):
      dt-bindings: pci: tegra: Document Tegra186 PCIe DT
      PCI: tegra: Add Tegra186 PCIe support

Marc Gonzalez (3):
      of/pci: Add of_pci_dma_range_parser_init() for dma-ranges parsing support
      PCI: Use of_pci_dma_range_parser_init() to reduce duplication
      PCI: tango: Add MSI controller support

Markus Elfring (1):
      PCI: ibmphp: Use common error handling code in unconfigure_boot_device()

Mika Westerberg (7):
      PCI: Move pci_hp_add_bridge() to drivers/pci/probe.c
      PCI: Open-code the two pass loop when scanning bridges
      PCI: Do not allocate more buses than available in parent
      PCI: Distribute available buses to hotplug-capable bridges
      PCI: Distribute available resources to hotplug-capable bridges
      PCI: pciehp: Fix race condition handling surprise link down
      PCI: pciehp: Do not clear Presence Detect Changed during initialization

Minghuan Lian (1):
      PCI: layerscape: Change default error response behavior

Qiang (1):
      PCI/PME: Handle invalid data when reading Root Status

Randy Dunlap (2):
      PCI: Move PCI_QUIRKS to the PCI bus menu
      PCI: Fix kernel-doc build warning

Sandor Bodo-Merle (1):
      PCI: iproc: Allow allocation of multiple MSIs

Sascha El-Sharkawy (1):
      PCI: Add Kconfig PCI_IOV dependency for PCI_REALLOC_ENABLE_AUTO

Sinan Kaya (1):
      PCI/portdrv: Turn off PCIe services during shutdown

Stuart Hayes (1):
      PCI: Create SR-IOV virtfn/physfn links before attaching driver

Thierry Reding (1):
      PCI: tegra: Use generic accessors where possible

Tony Nguyen (1):
      PCI: Restore ARI Capable Hierarchy before setting numVFs

Vadim Lomovtsev (2):
      PCI: Set Cavium ACS capability quirk flags to assert RR/CR/SV/UF
      PCI: Apply Cavium ThunderX ACS quirk to more Root Ports

Vitaly Kuznetsov (1):
      ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI handle

Wei Yongjun (1):
      PCI: faraday: Fix wrong pointer passed to PTR_ERR()

 .../interrupt-controller/fsl,ls-scfg-msi.txt       |   1 +
 .../bindings/pci/designware-pcie-ecam.txt          |  42 +
 .../bindings/pci/hisilicon-histb-pcie.txt          |  68 ++
 .../devicetree/bindings/pci/layerscape-pci.txt     |   1 +
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 134 ++-
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  10 +-
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  75 +-
 MAINTAINERS                                        |  15 +
 arch/alpha/include/asm/pci.h                       |   5 -
 arch/alpha/kernel/pci.c                            |  11 +-
 arch/alpha/kernel/pci_impl.h                       |   8 -
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  31 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  75 ++
 arch/cris/include/asm/pci.h                        |   9 -
 arch/frv/include/asm/pci.h                         |   4 -
 arch/ia64/include/asm/pci.h                        |   4 -
 arch/mips/include/asm/pci.h                        |   4 -
 arch/mn10300/include/asm/pci.h                     |   4 -
 arch/mn10300/unit-asb2305/pci-asb2305.h            |   3 -
 arch/parisc/include/asm/pci.h                      |   8 -
 arch/powerpc/include/asm/pci.h                     |   2 -
 arch/powerpc/kernel/eeh_driver.c                   |   4 +-
 arch/sh/include/asm/pci.h                          |   4 -
 arch/sparc/include/asm/pci_32.h                    |   2 -
 arch/x86/include/asm/pci.h                         |   2 -
 arch/x86/pci/fixup.c                               |  85 ++
 arch/x86/pci/intel_mid_pci.c                       |   2 +-
 arch/xtensa/include/asm/pci.h                      |   2 -
 drivers/irqchip/irq-ls-scfg-msi.c                  |   1 +
 drivers/misc/pci_endpoint_test.c                   |  33 +-
 drivers/of/address.c                               |  19 +-
 drivers/pci/Kconfig                                |  17 +-
 drivers/pci/Makefile                               |   3 -
 drivers/pci/dwc/Kconfig                            |  10 +
 drivers/pci/dwc/Makefile                           |   1 +
 drivers/pci/dwc/pci-dra7xx.c                       |  17 +
 drivers/pci/dwc/pci-layerscape.c                   |  12 +
 drivers/pci/dwc/pcie-histb.c                       | 470 ++++++++++
 drivers/pci/host/Kconfig                           |   6 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-ftpci100.c                    |  22 +-
 drivers/pci/host/pci-host-generic.c                |  43 +
 drivers/pci/host/pci-hyperv.c                      |   8 +-
 drivers/pci/host/pci-rcar-gen2.c                   |  20 +-
 drivers/pci/host/pci-tegra.c                       | 158 +++-
 drivers/pci/host/pci-v3-semi.c                     | 959 +++++++++++++++++++++
 drivers/pci/host/pci-xgene.c                       |  24 +-
 drivers/pci/host/pcie-altera.c                     |   8 +-
 drivers/pci/host/pcie-iproc-msi.c                  |  19 +-
 drivers/pci/host/pcie-iproc.c                      |  20 +-
 drivers/pci/host/pcie-rcar.c                       |  20 +-
 drivers/pci/host/pcie-tango.c                      | 205 ++++-
 drivers/pci/host/pcie-xilinx.c                     |   6 +-
 drivers/pci/hotplug-pci.c                          |  29 -
 drivers/pci/hotplug/acpiphp_glue.c                 |  15 +-
 drivers/pci/hotplug/cpci_hotplug_pci.c             |   7 +-
 drivers/pci/hotplug/cpqphp.h                       |   2 +-
 drivers/pci/hotplug/cpqphp_core.c                  |   3 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |  19 +-
 drivers/pci/hotplug/ibmphp_pci.c                   |  19 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   7 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  25 +-
 drivers/pci/hotplug/pciehp_pci.c                   |  11 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |   9 +-
 drivers/pci/hotplug/shpchp_pci.c                   |   6 +-
 drivers/pci/iov.c                                  |  34 +-
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/pci/pci-sysfs.c                            |  35 +-
 drivers/pci/pci.c                                  | 154 +++-
 drivers/pci/pci.h                                  |  11 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   9 +-
 drivers/pci/pcie/aspm.c                            |  46 +-
 drivers/pci/pcie/pme.c                             |   5 +-
 drivers/pci/pcie/portdrv_core.c                    | 171 ++--
 drivers/pci/pcie/portdrv_pci.c                     |   1 +
 drivers/pci/probe.c                                | 187 +++-
 drivers/pci/quirks.c                               |  42 +-
 drivers/pci/remove.c                               |   2 +-
 drivers/pci/rom.c                                  |  19 +-
 drivers/pci/setup-bus.c                            | 299 ++++++-
 drivers/pci/setup-res.c                            |  58 ++
 drivers/pci/switch/switchtec.c                     |   2 +-
 drivers/pcmcia/cardbus.c                           |   5 +-
 include/linux/of_address.h                         |  10 +-
 include/linux/pci.h                                |  16 +-
 include/uapi/linux/pci_regs.h                      |  44 +-
 init/Kconfig                                       |   9 -
 87 files changed, 3456 insertions(+), 574 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
 create mode 100644 drivers/pci/dwc/pcie-histb.c
 create mode 100644 drivers/pci/host/pci-v3-semi.c
 delete mode 100644 drivers/pci/hotplug-pci.c
