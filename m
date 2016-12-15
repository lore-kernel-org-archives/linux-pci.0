Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbcLOUY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Dec 2016 15:24:28 -0500
Date: Thu, 15 Dec 2016 14:24:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.10
Message-ID: <20161215202423.GA24490@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - Add support for PCI on ARM64 boxes with ACPI.  We already had this for
    theoretical spec-compliant hardware; now we're adding quirks for the
    actual hardware (Cavium, HiSilicon, Qualcomm, X-Gene).

  - Add runtime PM support for hotplug ports. 

  - Enable runtime suspend for Intel UHCI that uses platform-specific
    wakeup signaling.

  - Add yet another host bridge registration interface.  We hope this is
    extensible enough to subsume the others.

  - Expose device revision in sysfs for DRM.

  - To avoid device conflicts, make sure any VF BAR updates are done before
    enabling the VF.

  - Avoid unnecessary link retrains for ASPM.

  - Allow INTx masking on Mellanox devices that support it.

  - Allow access to non-standard VPD for Chelsio devices.

  - Update Broadcom iProc support for PAXB v2, PAXC v2, inbound DMA, etc.

  - Update Rockchip support for max-link-speed.

  - Add NVIDIA Tegra210 support.

  - Add Layerscape LS1046a support.

  - Update R-Car compatibility strings.

  - Add Qualcomm MSM8996 support.

  - Remove some uninformative bootup messages.


The following changes since commit 31a3a7b5b26f75fbe82de10ca99f2b673f6c26b4:

  PCI: rockchip: Add three new resets as required properties (2016-11-10 11:14:37 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.10-changes

for you to fetch changes up to b08d2e61a6f9ebf5210a047868362a5a4ff37144:

  Merge branch 'pci/host-vmd' into next (2016-12-12 11:25:13 -0600)

----------------------------------------------------------------
pci-v4.10-changes

----------------------------------------------------------------
Alan Stern (2):
      PCI: Check for PME in targeted sleep state
      USB: UHCI: report non-PME wakeup signalling for Intel hardware

Alexey Kardashevskiy (1):
      PCI: Enable access to non-standard VPD for Chelsio devices (cxgb3)

Andy Gospodarek (1):
      PCI: iproc: Skip check for legacy IRQ on PAXC buses

Arnd Bergmann (2):
      PCI: Add pci_register_host_bridge() interface
      PCI: tegra: Use new pci_register_host_bridge() interface

Ashok Raj (2):
      PCI: pciehp: Prioritize data-link event over presence detect
      PCI: pciehp: Leave power indicator on when enabling already-enabled slot

Bjorn Helgaas (45):
      net/mlx4_core: Use device ID defines
      PCI: Warn on possible RW1C corruption for sub-32 bit config writes
      PCI: Ignore BAR updates on virtual functions
      PCI: Update BARs using property bits appropriate for type
      PCI: Separate VF BAR updates from standard BAR updates
      PCI: Don't update VF BARs while VF memory space is enabled
      PCI: Remove pci_resource_bar() and pci_iov_resource_bar()
      PCI: Decouple IORESOURCE_ROM_ENABLE and PCI_ROM_ADDRESS_ENABLE
      PCI: Add comments about ROM BAR updating
      ACPI: Add acpi_resource_consumer() to find device that claims a resource
      arm64: PCI: Add local struct device pointers
      arm64: PCI: Search ACPI namespace to ensure ECAM space is reserved
      arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows
      PCI: thunder-pem: Factor out resource lookup
      PCI: Explain ARM64 ACPI/MCFG quirk Kconfig and build strategy
      PCI/PME: Drop unused support for PMEs from Root Complex Event Collectors
      PCI/PME: Log PME IRQ when claiming Root Port
      PCI/AER: Remove unused version macros
      PCI/AER: Log errors with PCI device, not PCIe service device
      PCI/AER: Log AER IRQ when claiming Root Port
      PCI: Remove service driver load/unload messages
      PCI: hotplug: Remove hotplug core message
      PCI: pciehp: Remove loading message
      PCI: Expand "VPD access disabled" quirk message
      Merge branch 'pci/aspm' into next
      Merge branch 'pci/ecam' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/hotplug' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/pm' into next
      Merge branch 'pci/virtualization' into next
      Merge branch 'pci/host' into next
      Merge branch 'pci/host-altera' into next
      Merge branch 'pci/host-hisi' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-iproc' into next
      Merge branch 'pci/host-layerscape' into next
      Merge branch 'pci/host-qcom' into next
      Merge branch 'pci/host-rcar' into next
      Merge branch 'pci/host-rockchip' into next
      Merge branch 'pci/host-spear' into next
      Merge branch 'pci/host-tegra' into next
      Merge branch 'pci/host-vmd' into next

Borislav Petkov (1):
      PCI: vmd: Fix suspend handlers defined-but-not-used warning

Brian Norris (1):
      PCI: rockchip: Correct the use of FTS mask

Christopher Covington (1):
      PCI: Add MCFG quirks for Qualcomm QDF2432 host controller

David Daney (1):
      PCI/ASPM: Don't retrain link if ASPM not possible

Dexuan Cui (3):
      PCI: hv: Use the correct buffer size in new_pcichild_device()
      PCI: hv: Fix hv_pci_remove() for hot-remove
      PCI: hv: Delete the device earlier from hbus->children for hot-remove

Dongdong Liu (2):
      PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
      PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers

Duc Dang (1):
      PCI: Add MCFG quirks for X-Gene host controller

Emil Velikov (1):
      PCI: Create revision file in sysfs

Fabio Estevam (2):
      MAINTAINERS: Update Richard Zhu's email address
      MAINTAINERS: Add devicetree binding to PCI i.MX6 entry

Gavin Shan (1):
      PCI: Do any VF BAR updates before enabling the BARs

Geliang Tang (1):
      PCI: spear: Use builtin_platform_driver() to simplify the code

Jan Beulich (1):
      PCI/MSI: Check for NULL affinity mask in pci_irq_get_affinity()

Jon Derrick (1):
      PCI: vmd: Use SRCU as a local RCU to prevent delaying global RCU

Julia Lawall (1):
      PCI/ASPM: Use permission-specific DEVICE_ATTR variants

Long Li (1):
      PCI: hv: Allocate physically contiguous hypercall params buffer

Lukas Wunner (10):
      PCI: Don't acquire ref on parent in pci_bridge_d3_update()
      PCI: Autosense device removal in pci_bridge_d3_update()
      PCI: Speed up algorithm in pci_bridge_d3_update()
      PCI: Activate runtime PM on a PCIe port only if it can suspend
      PCI: Consolidate conditions to allow runtime PM on PCIe ports
      PCI: Unfold conditions to block runtime PM on PCIe ports
      ACPI / hotplug / PCI: Use cached copy of PCI_EXP_SLTCAP_HPC bit
      ACPI / hotplug / PCI: Make device_is_managed_by_native_pciehp() public
      PCI: pciehp: Add runtime PM support for PCIe hotplug ports
      x86/platform/intel-mid: Constify mid_pci_platform_pm

Mingkai Hu (1):
      PCI: layerscape: Add LS1046a support

Noa Osherovich (4):
      PCI: Add Mellanox device IDs
      PCI: Convert broken INTx masking quirks from HEADER to FINAL
      PCI: Convert Mellanox broken INTx quirks to be for listed devices only
      PCI: Support INTx masking on ConnectX-4 with firmware x.14.1100+

Quentin Lambert (1):
      PCI: cpqphp: Add missing call to pci_disable_device()

Ray Jui (13):
      PCI: iproc: Improve core register population
      PCI: iproc: Do not reset PAXC when initializing the driver
      PCI: iproc: Add BCMA type
      PCI: iproc: Fix exception with multi-function devices
      PCI: iproc: Add PAXCv2 related binding
      PCI: iproc: Add PAXC v2 support
      PCI: iproc: Remove redundant outbound properties
      PCI: iproc: Make outbound mapping code more generic
      PCI: iproc: Add optional dma-ranges
      PCI: iproc: Add inbound DMA mapping support
      PCI: iproc: Add PAXBv2 binding info
      PCI: iproc: Add support for the next-gen PAXB controller
      PCI: iproc: Fix incorrect MSI address alignment

Shawn Lin (11):
      Documentation/devicetree: Add PCIe max-link-speed property
      of/pci: Add of_pci_get_max_link_speed() to parse max-link-speed from DT
      PCI: rockchip: Provide captured slot power limit and scale
      PCI: rockchip: Mark RC as common clock architecture
      PCI: rockchip: Add Kconfig COMPILE_TEST
      PCI: rockchip: Fix negotiated lanes calculation
      PCI: rockchip: Specify the link capability
      PCI: rockchip: Remove the pointer to L1 substate cap
      PCI: rockchip: Clean up bit definitions for PCIE_RC_CONFIG_LCS
      PCI: rockchip: Split out rockchip_cfg_atu()
      PCI: rockchip: Move the deassert of pm/aclk/pclk after phy_init()

Simon Horman (3):
      PCI: rcar-gen2: Use gen2 fallback compatibility last
      PCI: rcar: Use gen2 fallback compatibility last
      PCI: rcar: Add gen3 fallback compatibility string for pcie-rcar

Srinivas Kandagatla (1):
      PCI: qcom: Add support for MSM8996 PCIe controller

Thierry Reding (8):
      PCI: Allow driver-specific data in host bridge
      PCI: Export host bridge registration interface
      dt-bindings: pci: tegra: Add Tegra210 support
      PCI: tegra: Implement PCA enable workaround
      PCI: tegra: Add Tegra210 support
      PCI: tegra: Enable the driver on 64-bit ARM
      arm64: tegra: Add PCIe host bridge on Tegra210
      arm64: tegra: Enable PCIe on Jetson TX1

Tobias Klauser (1):
      PCI: hv: Make unnecessarily global IRQ masking functions static

Tomasz Nowicki (5):
      arm64: PCI: Manage controller-specific data on per-controller basis
      PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
      PCI/ACPI: Check for platform-specific MCFG quirks
      PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
      PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller

Wang Sheng-Hui (1):
      PCI: Move config space size macros to pci_regs.h

Wei Yongjun (5):
      PCI: altera: Use builtin_platform_driver() to simplify the code
      PCI: altera: Remove redundant error message in altera_pcie_parse_dt()
      PCI: layerscape: Remove redundant error message from ls_pcie_probe()
      PCI: hisi: Remove redundant error message from hisi_pcie_probe()
      PCI: vmd: Remove unnecessary pci_set_drvdata()

 Documentation/ABI/testing/sysfs-bus-pci            |   7 +
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  43 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |   1 +
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 110 +++
 Documentation/devicetree/bindings/pci/pci.txt      |   6 +
 .../devicetree/bindings/pci/qcom,pcie.txt          |  14 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   1 +
 Documentation/filesystems/sysfs-pci.txt            |   2 +
 MAINTAINERS                                        |   3 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |  26 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  63 ++
 arch/arm64/kernel/pci.c                            |  67 +-
 drivers/acpi/pci_mcfg.c                            | 190 ++++-
 drivers/acpi/resource.c                            |  57 ++
 drivers/net/ethernet/mellanox/mlx4/main.c          |  84 +-
 drivers/of/of_pci.c                                |  21 +
 drivers/pci/access.c                               |  16 +-
 drivers/pci/bus.c                                  |   2 +-
 drivers/pci/ecam.c                                 |  12 +
 drivers/pci/host/Kconfig                           |  16 +-
 drivers/pci/host/Makefile                          |  19 +-
 drivers/pci/host/pci-hyperv.c                      | 100 ++-
 drivers/pci/host/pci-layerscape.c                  |  20 +-
 drivers/pci/host/pci-rcar-gen2.c                   |   2 +-
 drivers/pci/host/pci-tegra.c                       | 160 ++--
 drivers/pci/host/pci-thunder-ecam.c                |   9 +-
 drivers/pci/host/pci-thunder-pem.c                 |  94 +-
 drivers/pci/host/pci-xgene.c                       | 126 ++-
 drivers/pci/host/pcie-altera.c                     |  10 +-
 drivers/pci/host/pcie-hisi.c                       | 107 ++-
 drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
 drivers/pci/host/pcie-iproc-msi.c                  |   1 +
 drivers/pci/host/pcie-iproc-platform.c             |  28 +-
 drivers/pci/host/pcie-iproc.c                      | 949 ++++++++++++++++++---
 drivers/pci/host/pcie-iproc.h                      |  45 +-
 drivers/pci/host/pcie-qcom.c                       | 177 +++-
 drivers/pci/host/pcie-rcar.c                       |   5 +-
 drivers/pci/host/pcie-rockchip.c                   | 284 +++---
 drivers/pci/host/pcie-spear13xx.c                  |   6 +-
 drivers/pci/host/vmd.c                             |  30 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  31 +-
 drivers/pci/hotplug/cpqphp_core.c                  |   3 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |  10 +-
 drivers/pci/hotplug/pciehp_core.c                  |   9 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   8 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  21 +-
 drivers/pci/iov.c                                  |  70 +-
 drivers/pci/msi.c                                  |   3 +-
 drivers/pci/pci-acpi.c                             | 100 +++
 drivers/pci/pci-mid.c                              |   2 +-
 drivers/pci/pci-sysfs.c                            |   2 +
 drivers/pci/pci.c                                  | 138 ++-
 drivers/pci/pci.h                                  |  19 +-
 drivers/pci/pcie/aer/aerdrv.c                      |  18 +-
 drivers/pci/pcie/aspm.c                            |  22 +-
 drivers/pci/pcie/pme.c                             |  29 +-
 drivers/pci/pcie/portdrv_core.c                    |   3 -
 drivers/pci/pcie/portdrv_pci.c                     |  13 +-
 drivers/pci/probe.c                                | 245 +++---
 drivers/pci/quirks.c                               | 182 +++-
 drivers/pci/remove.c                               |   2 +-
 drivers/pci/rom.c                                  |   5 +
 drivers/pci/setup-res.c                            |  48 +-
 drivers/usb/host/uhci-pci.c                        |   4 +
 drivers/vfio/pci/vfio_pci_config.c                 |   2 -
 include/linux/acpi.h                               |   7 +
 include/linux/of_pci.h                             |   7 +
 include/linux/pci-acpi.h                           |   4 +-
 include/linux/pci-ecam.h                           |   9 +
 include/linux/pci.h                                |  17 +
 include/linux/pci_hotplug.h                        |   2 +
 include/linux/pci_ids.h                            |  27 +-
 include/uapi/linux/pci_regs.h                      |   8 +
 73 files changed, 3101 insertions(+), 883 deletions(-)
