Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Feb 2017 12:15:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.11
Message-ID: <20170223181549.GA10177@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - add ASPM L1 substate support

  - enable PCIe Extended Tags when supported

  - configure PCIe MPS settings on iProc, Versatile, X-Gene, and Xilinx

  - increase VPD access timeout

  - add ACS quirks for Intel Union Point, Qualcomm QDF2400 and QDF2432

  - use new pci_irq_alloc_vectors() in more drivers

  - fix MSI affinity memory leak

  - remove unused MSI interfaces and update documentation

  - remove unused AER .link_reset() callback

  - avoid pci_lock / p->pi_lock deadlock seen with perf

  - serialize sysfs enable/disable num_vfs operations

  - move DesignWare IP from drivers/pci/host/ to drivers/pci/dwc/ and
    refactor so we can support both hosts and endpoints

  - add DT ECAM-like support for HiSilicon Hip06/Hip07 controllers

  - add Rockchip system power management support

  - add Thunder-X cn81xx and cn83xx support

  - add Exynos 5440 PCIe PHY support


The following changes since commit a782b5f986c3fa1cfa7f2b57941200c6a5809242:

  PCI: designware: Check for iATU unroll only on platforms that use ATU (2017-01-10 08:43:24 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git c4d052ce970e

for you to fetch changes up to c4d052ce970ea98e9e1cc72461ba3b7a25397657:

  Merge branch 'pci/virtualization' into next (2017-02-21 15:16:28 -0600)

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Add ACS quirk for Intel Union Point

Andrey Smirnov (1):
      PCI: imx6: Fix a typo in error message

Andy Shevchenko (1):
      PCI: Sort the list of devices with D3 delay quirk by ID

Arnd Bergmann (1):
      PCI: rockchip: Mark PM functions as __maybe_unused

Bharat Kumar Gogada (1):
      PCI: xilinx-nwl: Remove mask for messages not supported by AXI

Bhumika Goyal (1):
      PCI: acpiphp_ibm: Make ibm_apci_table_attr __ro_after_init

Bjorn Helgaas (38):
      PCI: Remove res_to_dev_res() debug message
      PCI: Apply _HPX settings only to relevant devices
      PCI: Avoid possible deadlock on pci_lock and p->pi_lock
      PCI: rcar: Use of_device_get_match_data() to simplify probe
      PCI: layerscape: Use of_device_get_match_data() to simplify probe
      PCI: iproc: Use of_device_get_match_data() to simplify probe
      PCI: xilinx: Configure PCIe MPS settings
      PCI: versatile: Configure PCIe MPS settings
      PCI: hisi: Rename config space accessors to remove "acpi"
      PCI: xgene: Configure PCIe MPS settings
      Merge branch 'pci/aer' into next
      Merge branch 'pci/aspm' into next
      Merge branch 'pci/dpc' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/hotplug' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/virtualization' into next
      Merge branch 'pci/vpd' into next
      Merge branch 'for-linus' into pci/host-designware
      Merge branch 'pci/host-designware' into next
      Merge branch 'pci/host-altera' into next
      Merge branch 'pci/host-exynos' into next
      Merge branch 'pci/host-hisi' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-iproc' into next
      Merge branch 'pci/host-layerscape' into next
      Merge branch 'pci/host-mvebu' into next
      Merge branch 'pci/host-rcar' into next
      Merge branch 'pci/host-rockchip' into next
      Merge branch 'pci/host-thunder' into next
      Merge branch 'pci/host-versatile' into next
      Merge branch 'pci/host-xgene' into next
      Merge branch 'pci/host-xilinx' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/virtualization' into next

Christoph Hellwig (8):
      [media] cobalt: use pci_irq_allocate_vectors()
      PCI/MSI: Remove pci_enable_msi_{exact,range}()
      PCI/MSI: Remove unused pci_msi_create_default_irq_domain()
      PCI/MSI: Remove pci_msi_domain_{alloc,free}_irqs()
      PCI/MSI: Check that we have a legacy interrupt line before using it
      PCI/portdrv: Use pci_irq_alloc_vectors()
      PCI/MSI: Document pci_alloc_irq_vectors(), deprecate pci_enable_msi()
      PCI/MSI: Update MSI/MSI-X bits in PCIEBUS-HOWTO

Christophe JAILLET (1):
      PCI/MSI: Return failure when msix_setup_entries() fails

Dan Carpenter (1):
      PCI: xgene: Fix double free on init error

David Daney (1):
      PCI: thunder-pem: Add support for cn81xx and cn83xx SoCs

Dennis Chen (1):
      PCI/MSI: Return -ENOSPC if pci_enable_msi_range() can't get enough vectors

Dexuan Cui (1):
      PCI: hv: Fix wslot_to_devfn() to fix warnings on device removal

Dongdong Liu (3):
      PCI: hisi: Add DT almost-ECAM support for Hip06/Hip07 host controllers
      PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports
      PCI: generic: Call pci_fixup_irqs() only on ARM

Emil Tantilov (1):
      PCI: Lock each enable/disable num_vfs operation in sysfs

Fabio Estevam (1):
      PCI: imx6: Remove redundant "Link never came up" message

Fengguang Wu (1):
      PCI: dwc: Use PTR_ERR_OR_ZERO to simplify code

Gabriel Krisman Bertazi (1):
      PCI: Remove duplicate check for positive return value from probe() functions

Haiyang Zhang (1):
      PCI: hv: Use device serial number as PCI domain

Harunobu Kurokawa (2):
      PCI: rcar: Return -ENODEV from host bridge probe when no card present
      PCI: rcar: Add compatible string for r8a7796

Jaehoon Chung (9):
      PCI: exynos: Rename all pointer names from "exynos_pcie" to "ep"
      PCI: exynos: Replace the *_blk/*_phy/*_elb accessors
      PCI: exynos: Remove unnecessary local variables
      PCI: exynos: Use the bitops BIT() macro to build bitmasks
      PCI: exynos: Remove duplicated code
      Documentation: samsung-phy: Add exynos-pcie-phy binding
      phy: phy-exynos-pcie: Add support for Exynos PCIe PHY
      Documentation: binding: Modify the exynos5440 PCIe binding
      PCI: exynos: Support the PHY generic framework

Jason Gunthorpe (1):
      PCI: mvebu: Handle changes to the bridge windows while enabled

Jon Mason (2):
      PCI: iproc: Configure PCIe MPS settings
      PCI: Add Broadcom Northstar2 PAXC quirk for device class and MPSS

Keith Busch (2):
      PCI/DPC: Decode extended reasons
      PCI/DPC: Wait for Root Port busy to clear

Kishon Vijay Abraham I (15):
      PCI: Move DesignWare IP support to new drivers/pci/dwc/ directory
      PCI: dra7xx: Simplify probe code with devm_gpiod_get_optional()
      PCI: dra7xx: Add support to force RC to work in GEN1 mode
      PCI: dra7xx: Enable MSI and legacy interrupts simultaneously
      PCI: dra7xx: Group PHY API invocations
      PCI: dwc: designware: Move register defines to designware header file
      PCI: dwc: all: Use platform_set_drvdata() to save private data
      PCI: dwc: all: Rename cfg_read/cfg_write to read/write
      PCI: dwc: designware: Get device pointer at the start of dw_pcie_host_init()
      PCI: dwc: all: Split struct pcie_port into host-only and core structures
      PCI: dwc: designware: Parse "num-lanes" property in dw_pcie_setup_rc()
      PCI: dwc: designware: Fix style errors in pcie-designware.c
      PCI: dwc: Split pcie-designware.c into host and core files
      PCI: dwc: Add CONFIG_PCIE_DW_HOST to enable PCI dwc host
      PCI: dwc: Remove dependency of designware on CONFIG_PCI

Lucas Stach (2):
      PCI: imx6: Remove LTSSM disable workaround
      PCI: mvebu: Change delay after reset to the PCIe spec mandated 100ms

Matthew R. Ochs (1):
      PCI: Increase VPD access timeout to 125ms

Michael S. Tsirkin (1):
      PCI/AER: Remove unused .link_reset() callback

Niyas Ahmed S T (1):
      PCI: exynos: Refactor to make it easier to support other SoCs

Prarit Bhargava (1):
      PCI/MSI: Fix msi_desc->affinity memory leak when freeing MSI IRQs

Rahul Krishnan (1):
      PCI: rpadlpar: Remove unnecessary return statement

Rajat Jain (6):
      PCI/ASPM: Add L1 substate capability structure register definitions
      PCI/ASPM: Add support for L1 substates
      PCI/ASPM: Read and set up L1 substate capabilities
      PCI/ASPM: Calculate and save the L1.2 timing parameters
      PCI/ASPM: Configure L1 substate settings
      PCI/ASPM: Add comment about L1 substate latency

Randy Dunlap (1):
      PCI/MSI: Fix msi_capability_init() kernel-doc warnings

Shailendra Verma (1):
      PCI: hisi: Use of_device_get_match_data() to simplify probe

Shawn Lin (5):
      PCI: rockchip: Add system PM support
      PCI: rockchip: Disable RC's ASPM L0s based on DT "aspm-no-l0s"
      PCI: rockchip: Use readl_poll_timeout() instead of open-coding it
      PCI: rockchip: Fix rockchip_pcie_probe() error path to free resource list
      PCI: rockchip: Set vendor ID from local core config space

Sinan Kaya (2):
      PCI: Enable PCIe Extended Tags if supported
      PCI: Add ACS quirk for Qualcomm QDF2400 and QDF2432

Tom Lendacky (1):
      amd-xgbe: Update PCI support to use new IRQ functions

Yadi Hu (1):
      PCI: altera: Extract TLP completion status correctly

Zhou Wang (1):
      PCI/ACPI: Fix bus range comparison in pci_mcfg_lookup()

 Documentation/PCI/MSI-HOWTO.txt                    |   6 +-
 Documentation/PCI/PCIEBUS-HOWTO.txt                |  33 +-
 Documentation/PCI/pci-error-recovery.txt           |  24 +-
 Documentation/PCI/pci.txt                          |  24 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  37 +
 .../devicetree/bindings/pci/mvebu-pci.txt          |   3 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   1 +
 .../devicetree/bindings/pci/rockchip-pcie.txt      |   2 +
 .../bindings/pci/samsung,exynos5440-pcie.txt       |  29 +
 .../devicetree/bindings/phy/samsung-phy.txt        |  17 +
 MAINTAINERS                                        |  22 +-
 arch/x86/kernel/apic/msi.c                         |   2 +-
 drivers/Makefile                                   |   3 +
 drivers/acpi/pci_mcfg.c                            |   5 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |  10 -
 drivers/infiniband/hw/qib/qib_pcie.c               |   8 -
 drivers/media/pci/cobalt/cobalt-driver.c           |   8 +-
 drivers/media/pci/cobalt/cobalt-driver.h           |   2 -
 drivers/media/pci/ngene/ngene-cards.c              |   7 -
 drivers/misc/genwqe/card_base.c                    |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           | 128 ++--
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   8 +-
 drivers/pci/Kconfig                                |   1 +
 drivers/pci/access.c                               |   5 +-
 drivers/pci/dwc/Kconfig                            | 132 ++++
 drivers/pci/dwc/Makefile                           |  24 +
 drivers/pci/{host => dwc}/pci-dra7xx.c             | 247 ++++---
 drivers/pci/dwc/pci-exynos.c                       | 751 +++++++++++++++++++++
 drivers/pci/{host => dwc}/pci-imx6.c               | 162 ++---
 drivers/pci/{host => dwc}/pci-keystone-dw.c        |  87 ++-
 drivers/pci/{host => dwc}/pci-keystone.c           |  56 +-
 drivers/pci/{host => dwc}/pci-keystone.h           |   4 +-
 drivers/pci/{host => dwc}/pci-layerscape.c         | 100 +--
 drivers/pci/{host => dwc}/pcie-armada8k.c          |  87 +--
 drivers/pci/{host => dwc}/pcie-artpec6.c           |  50 +-
 .../pcie-designware-host.c}                        | 441 +++---------
 drivers/pci/{host => dwc}/pcie-designware-plat.c   |  29 +-
 drivers/pci/dwc/pcie-designware.c                  | 233 +++++++
 drivers/pci/dwc/pcie-designware.h                  | 198 ++++++
 drivers/pci/{host => dwc}/pcie-hisi.c              | 139 +++-
 drivers/pci/{host => dwc}/pcie-qcom.c              |  87 ++-
 drivers/pci/{host => dwc}/pcie-spear13xx.c         |  85 ++-
 drivers/pci/host/Kconfig                           | 113 ----
 drivers/pci/host/Makefile                          |  12 -
 drivers/pci/host/pci-exynos.c                      | 629 -----------------
 drivers/pci/host/pci-host-common.c                 |   2 +
 drivers/pci/host/pci-hyperv.c                      |  20 +-
 drivers/pci/host/pci-mvebu.c                       | 103 +--
 drivers/pci/host/pci-thunder-pem.c                 |  25 +-
 drivers/pci/host/pci-versatile.c                   |   4 +-
 drivers/pci/host/pci-xgene.c                       |  11 +-
 drivers/pci/host/pcie-altera.c                     |   2 +-
 drivers/pci/host/pcie-designware.h                 |  86 ---
 drivers/pci/host/pcie-iproc-platform.c             |   7 +-
 drivers/pci/host/pcie-iproc.c                      |   5 +-
 drivers/pci/host/pcie-rcar.c                       |   9 +-
 drivers/pci/host/pcie-rockchip.c                   | 175 +++--
 drivers/pci/host/pcie-xilinx-nwl.c                 |  14 +-
 drivers/pci/host/pcie-xilinx.c                     |   4 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |   2 +-
 drivers/pci/hotplug/rpadlpar_core.c                |   4 +-
 drivers/pci/iov.c                                  |   7 -
 drivers/pci/msi.c                                  | 122 +---
 drivers/pci/pci-driver.c                           |   2 -
 drivers/pci/pci-sysfs.c                            |  23 +-
 drivers/pci/pci.h                                  |   2 +-
 drivers/pci/pcie/Kconfig                           |   8 +
 drivers/pci/pcie/aspm.c                            | 291 +++++++-
 drivers/pci/pcie/pcie-dpc.c                        |  34 +-
 drivers/pci/pcie/portdrv_core.c                    | 161 ++---
 drivers/pci/probe.c                                |  33 +-
 drivers/pci/quirks.c                               |  99 ++-
 drivers/pci/setup-bus.c                            |  11 +-
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-exynos-pcie.c                      | 285 ++++++++
 include/linux/msi.h                                |   6 -
 include/linux/pci.h                                |  19 +-
 include/linux/pci_ids.h                            |   2 +
 include/uapi/linux/pci_regs.h                      |  17 +
 80 files changed, 3357 insertions(+), 2299 deletions(-)
 create mode 100644 drivers/pci/dwc/Kconfig
 create mode 100644 drivers/pci/dwc/Makefile
 rename drivers/pci/{host => dwc}/pci-dra7xx.c (74%)
 create mode 100644 drivers/pci/dwc/pci-exynos.c
 rename drivers/pci/{host => dwc}/pci-imx6.c (82%)
 rename drivers/pci/{host => dwc}/pci-keystone-dw.c (86%)
 rename drivers/pci/{host => dwc}/pci-keystone.c (90%)
 rename drivers/pci/{host => dwc}/pci-keystone.h (95%)
 rename drivers/pci/{host => dwc}/pci-layerscape.c (72%)
 rename drivers/pci/{host => dwc}/pcie-armada8k.c (73%)
 rename drivers/pci/{host => dwc}/pcie-artpec6.c (86%)
 rename drivers/pci/{host/pcie-designware.c => dwc/pcie-designware-host.c} (54%)
 rename drivers/pci/{host => dwc}/pcie-designware-plat.c (82%)
 create mode 100644 drivers/pci/dwc/pcie-designware.c
 create mode 100644 drivers/pci/dwc/pcie-designware.h
 rename drivers/pci/{host => dwc}/pcie-hisi.c (67%)
 rename drivers/pci/{host => dwc}/pcie-qcom.c (91%)
 rename drivers/pci/{host => dwc}/pcie-spear13xx.c (77%)
 delete mode 100644 drivers/pci/host/pci-exynos.c
 delete mode 100644 drivers/pci/host/pcie-designware.h
 create mode 100644 drivers/phy/phy-exynos-pcie.c
