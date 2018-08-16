Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbeHPQsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 12:48:16 -0400
Date: Thu, 16 Aug 2018 08:49:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v4.19
Message-ID: <20180816134929.GA244466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - Decode AER errors with names similar to "lspci" (Tyler Baicar)

  - Expose AER statistics in sysfs (Rajat Jain)

  - Clear AER status bits selectively based on the type of recovery (Oza
    Pawandeep)

  - Honor "pcie_ports=native" even if HEST sets FIRMWARE_FIRST (Alexandru
    Gagniuc)

  - Don't clear AER status bits if we're using the "Firmware-First"
    strategy where firmware owns the registers (Alexandru Gagniuc)

  - Use sysfs_match_string() to simplify ASPM sysfs parsing (Andy
    Shevchenko)

  - Remove unnecessary includes of <linux/pci-aspm.h> (Bjorn Helgaas)

  - Defer DPC event handling to work queue (Keith Busch)

  - Use threaded IRQ for DPC bottom half (Keith Busch)

  - Print AER status while handling DPC events (Keith Busch)

  - Work around IDT switch ACS Source Validation erratum (James
    Puthukattukaran)

  - Emit diagnostics for all cases of PCIe Link downtraining (Links
    operating slower than they're capable of) (Alexandru Gagniuc)

  - Skip VFs when configuring Max Payload Size (Myron Stowe)

  - Reduce Root Port Max Payload Size if necessary when hot-adding a device
    below it (Myron Stowe)

  - Simplify SHPC existence/permission checks (Bjorn Helgaas)

  - Remove hotplug sample skeleton driver (Lukas Wunner)

  - Convert pciehp to threaded IRQ handling (Lukas Wunner)

  - Improve pciehp tolerance of missed events and initially unstable links
    (Lukas Wunner)

  - Clear spurious pciehp events on resume (Lukas Wunner)

  - Add pciehp runtime PM support, including for Thunderbolt controllers
    (Lukas Wunner)

  - Support interrupts from pciehp bridges in D3hot (Lukas Wunner)

  - Mark fall-through switch cases before enabling -Wimplicit-fallthrough
    (Gustavo A. R. Silva)

  - Move DMA-debug PCI init from arch code to PCI core (Christoph Hellwig)

  - Fix pci_request_irq() usage of IRQF_ONESHOT when no handler is supplied
    (Heiner Kallweit)

  - Unify PCI and DMA direction #defines (Shunyong Yang)

  - Add PCI_DEVICE_DATA() macro (Andy Shevchenko)

  - Check for VPD completion before checking for timeout (Bert Kenward)

  - Limit Netronome NFP5000 config space size to work around erratum (Jakub
    Kicinski)

  - Set IRQCHIP_ONESHOT_SAFE for PCI MSI irqchips (Heiner Kallweit)

  - Document ACPI description of PCI host bridges (Bjorn Helgaas)

  - Add "pci=disable_acs_redir=" parameter to disable ACS redirection for
    peer-to-peer DMA support (we don't have the peer-to-peer support yet;
    this is just one piece) (Logan Gunthorpe)

  - Clean up devm_of_pci_get_host_bridge_resources() resource allocation
    (Jan Kiszka)

  - Fixup resizable BARs after suspend/resume (Christian König)

  - Make "pci=earlydump" generic (Sinan Kaya)

  - Fix ROM BAR access routines to stay in bounds and check for signature
    correctly (Rex Zhu)

  - Add DMA alias quirk for Microsemi Switchtec NTB (Doug Meyer)

  - Expand documentation for pci_add_dma_alias() (Logan Gunthorpe)

  - To avoid bus errors, enable PASID only if entire path supports End-End
    TLP prefixes (Sinan Kaya)

  - Unify slot and bus reset functions and remove hotplug knowledge from
    callers (Sinan Kaya)

  - Add Function-Level Reset quirks for Intel and Samsung NVMe devices to
    fix guest reboot issues (Alex Williamson)

  - Add function 1 DMA alias quirk for Marvell 88SS9183 PCIe SSD Controller
    (Bjorn Helgaas)

  - Remove Xilinx AXI-PCIe host bridge arch dependency (Palmer Dabbelt)

  - Remove Aardvark outbound window configuration (Evan Wang)

  - Fix Aardvark bridge window sizing issue (Zachary Zhang)

  - Convert Aardvark to use pci_host_probe() to reduce code duplication
    (Thomas Petazzoni)

  - Correct the Cadence cdns_pcie_writel() signature (Alan Douglas)

  - Add Cadence support for optional generic PHYs (Alan Douglas)

  - Add Cadence power management ops (Alan Douglas)

  - Remove redundant variable from Cadence driver (Colin Ian King)

  - Add Kirin MSI support (Xiaowei Song)

  - Drop unnecessary root_bus_nr setting from exynos, imx6, keystone,
    armada8k, artpec6, designware-plat, histb, qcom, spear13xx (Shawn Guo)

  - Move link notification settings from DesignWare core to individual
    drivers (Gustavo Pimentel)

  - Add endpoint library MSI-X interfaces (Gustavo Pimentel)

  - Correct signature of endpoint library IRQ interfaces (Gustavo Pimentel)

  - Add DesignWare endpoint library MSI-X callbacks (Gustavo Pimentel)

  - Add endpoint library MSI-X test support (Gustavo Pimentel)

  - Remove unnecessary GFP_ATOMIC from Hyper-V "new child" allocation
    (Jia-Ju Bai)

  - Add more devices to Broadcom PAXC quirk (Ray Jui)

  - Work around corrupted Broadcom PAXC config space to enable SMMU and
    GICv3 ITS (Ray Jui)

  - Disable MSI parsing to work around broken Broadcom PAXC logic in some
    devices (Ray Jui)

  - Hide unconfigured functions to work around a Broadcom PAXC defect (Ray
    Jui)

  - Lower iproc log level to reduce console output during boot (Ray Jui)

  - Fix mobiveil iomem/phys_addr_t type usage (Lorenzo Pieralisi)

  - Fix mobiveil missing include file (Lorenzo Pieralisi)

  - Add mobiveil Kconfig/Makefile support (Lorenzo Pieralisi)

  - Fix mvebu I/O space remapping issues (Thomas Petazzoni)

  - Use generic pci_host_bridge in mvebu instead of ARM-specific API
    (Thomas Petazzoni)

  - Whitelist VMD devices with fast interrupt handlers to avoid sharing
    vectors with slow handlers (Keith Busch)


The following changes since commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76:

  PCI: Fix is_added/is_busmaster race condition (2018-07-31 11:27:54 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.19-changes

for you to fetch changes up to fa687fb9ced47b97bd22297366e788dac1927dd7:

  Merge branch 'remotes/lorenzo/pci/vmd' (2018-08-15 14:59:16 -0500)

----------------------------------------------------------------
pci-v4.19-changes

----------------------------------------------------------------
Alan Douglas (5):
      PCI: cadence: Update cdns_pcie_writel() function signature
      PCI: cadence: Add generic PHY support to host and EP drivers
      dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
      PCI: cadence: Add Power Management ops for host and EP
      PCI: cadence: Add shutdown callback to host driver

Alex Williamson (3):
      PCI: Export pcie_has_flr()
      PCI: Disable Samsung SM961/PM961 NVMe before FLR
      PCI: Delay after FLR of Intel DC P3700 NVMe

Alexandru Gagniuc (3):
      PCI/AER: Honor "pcie_ports=native" even if HEST sets FIRMWARE_FIRST
      PCI: Check for PCIe Link downtraining
      PCI/AER: Don't clear AER bits if error handling is Firmware-First

Andy Shevchenko (2):
      PCI/ASPM: Convert to use sysfs_match_string() helper
      PCI: Add PCI_DEVICE_DATA() macro to fully describe device ID entry

Bert Kenward (1):
      PCI/VPD: Check for VPD access completion before checking for timeout

Bjorn Helgaas (34):
      PCI: shpchp: Separate existence of SHPC and permission to use it
      PCI: Make pci_get_rom_size() static
      PCI/IOV: Tidy pci_sriov_set_totalvfs()
      PCI/AER: Clear only ERR_FATAL status bits during fatal recovery
      PCI: Document ACPI description of PCI host bridges
      PCI/AER: Remove duplicate PCI_EXP_AER_FLAGS definition
      igb: Remove unnecessary include of <linux/pci-aspm.h>
      ath9k: Remove unnecessary include of <linux/pci-aspm.h>
      iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
      PCI: Remove unnecessary include of <linux/pci-aspm.h>
      PCI: Hide ACS quirk declarations inside PCI core
      PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
      Merge branch 'for-linus'
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/notes'
      Merge branch 'pci/peer-to-peer'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/controller/misc'
      Merge branch 'remotes/lorenzo/pci/aardvark'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/mobiveil'
      Merge branch 'remotes/lorenzo/pci/mvebu'
      Merge branch 'remotes/lorenzo/pci/vmd'

Christian König (2):
      PCI: Restore resized BAR state on resume
      PCI: Cleanup PCI_REBAR_CTRL_BAR_SHIFT handling

Christoph Hellwig (2):
      PCI: Call dma_debug_add_bus() for pci_bus_type from PCI core
      PCI/xilinx: Depend on OF instead of the ARCH

Colin Ian King (1):
      PCI: pcie-cadence-ep: Remove redundant variable mmc

Dan Carpenter (1):
      PCI: mobiveil: Integer overflow in IB_WIN_SIZE

Doug Meyer (2):
      switchtec: Use generic PCI Vendor ID and Class Code
      PCI: Add DMA alias quirk for Microsemi Switchtec NTB

Evan Wang (1):
      PCI: aardvark: Remove PCIe outbound window configuration

Gustavo A. R. Silva (1):
      PCI: Mark fall-through switch cases before enabling -Wimplicit-fallthrough

Gustavo Pimentel (12):
      PCI: dwc: Fix EP link notification implementation
      PCI: endpoint: Add MSI-X interfaces
      PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
      PCI: dwc: Add MSI-X callbacks handler
      PCI: dwc: Rework MSI callbacks handler
      PCI: dwc: Add legacy interrupt callback handler
      pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
      pci-epf-test/pci_endpoint_test: Use irq_type module parameter
      pci-epf-test/pci_endpoint_test: Add MSI-X support
      pci_endpoint_test: Add 2 ioctl commands
      tools: PCI: Add MSI-X support
      PCI: endpoint: Add MSI set maximum restriction

Heiner Kallweit (2):
      PCI: Use IRQF_ONESHOT if pci_request_irq() called with no handler
      PCI/MSI: Set IRQCHIP_ONESHOT_SAFE for PCI-MSI irqchips

Jakub Kicinski (1):
      PCI: Limit config space size for Netronome NFP5000

James Puthukattukaran (1):
      PCI: Workaround IDT switch ACS Source Validation erratum

Jan Kiszka (1):
      PCI: Clean up resource allocation in devm_of_pci_get_host_bridge_resources()

Jia-Ju Bai (1):
      PCI: hv: Replace GFP_ATOMIC with GFP_KERNEL in new_pcichild_device()

Keith Busch (8):
      PCI: vmd: White list for fast interrupt handlers
      PCI/AER: Expose internal API for obtaining AER information
      PCI/DPC: Leave interrupts enabled while handling event
      PCI/DPC: Defer event handling to work queue
      PCI/DPC: Remove rp_pio_status from dpc struct
      PCI/DPC: Print AER status in DPC event handling
      PCI/DPC: Use threaded IRQ for bottom half handling
      PCI/DPC: Remove indirection waiting for inactive link

Logan Gunthorpe (7):
      PCI: Expand documentation for pci_add_dma_alias()
      PCI: Make specifying PCI devices in kernel parameters reusable
      PCI: Allow specifying devices using a base bus and path of devfns
      PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support
      PCI: Convert device-specific ACS quirks from NULL termination to ARRAY_SIZE
      PCI: Add device-specific ACS Redirect disable infrastructure
      PCI: Add ACS Redirect disable quirk for Intel Sunrise Point

Lorenzo Pieralisi (3):
      PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base address type
      PCI: mobiveil: Add missing ../pci.h include
      PCI: mobiveil: Add Kconfig/Makefile entries

Lukas Wunner (33):
      PCI: hotplug: Delete skeleton driver
      PCI: hotplug: Don't leak pci_slot on registration failure
      PCI: pciehp: Fix use-after-free on unplug
      PCI: pciehp: Fix unprotected list iteration in IRQ handler
      PCI: pciehp: Drop unnecessary NULL pointer check
      PCI: pciehp: Declare pciehp_unconfigure_device() void
      PCI: pciehp: Document struct slot and struct controller
      PCI: pciehp: Convert to threaded IRQ
      PCI: pciehp: Convert to threaded polling
      PCI: pciehp: Stop blinking on slot enable failure
      PCI: pciehp: Handle events synchronously
      PCI: pciehp: Drop slot workqueue
      PCI: hotplug: Demidlayer registration with the core
      PCI: pciehp: Publish to user space last on probe
      PCI: pciehp: Track enable/disable status
      PCI: pciehp: Enable/disable exclusively from IRQ thread
      PCI: pciehp: Drop enable/disable lock
      PCI: pciehp: Declare pciehp_enable/disable_slot() static
      PCI: pciehp: Tolerate initially unstable link
      PCI: pciehp: Become resilient to missed events
      PCI: pciehp: Always enable occupied slot on probe
      PCI: pciehp: Avoid slot access during reset
      PCI: portdrv: Deduplicate PM callback iterator
      PCI: pciehp: Clear spurious events earlier on resume
      PCI: pciehp: Obey compulsory command delay after resume
      PCI: pciehp: Support interrupts sent from D3hot
      PCI: pciehp: Resume to D0 on enable/disable
      PCI: pciehp: Resume parent to D0 on config space access
      PCI: sysfs: Resume to D0 on function reset
      PCI: Whitelist native hotplug ports for runtime D3
      PCI: Whitelist Thunderbolt ports for runtime D3
      PCI: pciehp: Avoid implicit fallthroughs in switch statements
      PCI: pciehp: Deduplicate presence check on probe & resume

Myron Stowe (2):
      PCI: Skip MPS logic for Virtual Functions (VFs)
      PCI: Match Root Port's MPS to endpoint's MPSS as necessary

Oza Pawandeep (6):
      PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery
      PCI/AER: Factor out ERR_NONFATAL status bit clearing
      PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
      PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL
      PCI/AER: Clear device status bits during ERR_COR handling
      PCI/portdrv: Remove pcie_portdrv_err_handler.slot_reset

Rajat Jain (4):
      PCI/AER: Move internal declarations to drivers/pci/pci.h
      PCI/AER: Define aer_stats structure for AER capable devices
      PCI/AER: Add sysfs attributes to provide AER stats and breakdown
      PCI/AER: Add sysfs attributes for rootport cumulative stats

Ray Jui (5):
      PCI: iproc: Activate PAXC bridge quirk for more devices
      PCI: iproc: Fix up corrupted PAXC root complex config registers
      PCI: iproc: Disable MSI parsing in certain PAXC blocks
      PCI: iproc: Reject unconfigured physical functions from PAXC
      PCI: iproc: Reduce inbound/outbound mapping print level

Rex Zhu (2):
      PCI: Avoid accessing memory outside the ROM BAR
      PCI: Add check code for last image indicator not set

Shawn Guo (9):
      PCI: exynos: Drop unnecessary root_bus_nr setting
      PCI: imx6: Drop unnecessary root_bus_nr setting
      PCI: keystone: Drop unnecessary root_bus_nr setting
      PCI: armada8k: Drop unnecessary root_bus_nr setting
      PCI: artpec6: Drop unnecessary root_bus_nr setting
      PCI: designware-plat: Drop unnecessary root_bus_nr setting
      PCI: histb: Drop unnecessary root_bus_nr setting
      PCI: qcom: Drop unnecessary root_bus_nr setting
      PCI: spear13xx: Drop unnecessary root_bus_nr setting

Shunyong Yang (1):
      PCI: Unify PCI and normal DMA direction definitions

Sinan Kaya (8):
      PCI: Make early dump functionality generic
      PCI: Enable PASID only if entire path supports End-End TLP prefixes
      PCI: Handle error return from pci_reset_bridge_secondary_bus()
      IB/hfi1: Use pci_try_reset_bus() for initiating PCI Secondary Bus Reset
      PCI: Hide pci_reset_bridge_secondary_bus() from drivers
      PCI: Unify try slot and bus reset API
      PCI: Deprecate pci_reset_bus() and pci_reset_slot() functions
      PCI: Rename pci_try_reset_bus() to pci_reset_bus()

Thomas Petazzoni (8):
      PCI: aardvark: Introduce an advk_pcie_valid_device() helper
      PCI: aardvark: Convert to use pci_host_probe()
      PCI: mvebu: Remove redundant platform_set_drvdata() call
      PCI: mvebu: Fix I/O space end address calculation
      PCI: mvebu: Only remap I/O space if configured
      PCI: mvebu: Use resource_size() to remap I/O space
      PCI: mvebu: Convert to use pci_host_bridge directly
      PCI: mvebu: Drop bogus comment above mvebu_pcie_map_registers()

Tyler Baicar (1):
      PCI/AER: Adopt lspci names for AER error decoding

Xiaowei Song (1):
      PCI: kirin: Add MSI support

Zachary Zhang (1):
      PCI: aardvark: Size bridges before resources allocation

 .../ABI/testing/sysfs-bus-pci-devices-aer_stats    | 122 +++++
 Documentation/PCI/00-INDEX                         |   2 +
 Documentation/PCI/acpi-info.txt                    | 187 ++++++++
 .../PCI/endpoint/function/binding/pci-test.txt     |   2 +
 Documentation/PCI/endpoint/pci-endpoint.txt        |   4 +-
 Documentation/PCI/endpoint/pci-test-function.txt   |  29 +-
 Documentation/PCI/endpoint/pci-test-howto.txt      |  30 +-
 Documentation/PCI/pcieaer-howto.txt                |   5 +
 Documentation/admin-guide/kernel-parameters.txt    |  43 +-
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |   5 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |   6 +
 Documentation/ioctl/ioctl-number.txt               |   1 +
 Documentation/misc-devices/pci-endpoint-test.txt   |   6 +
 arch/powerpc/kernel/dma.c                          |   3 -
 arch/sh/drivers/pci/pci.c                          |   2 -
 arch/x86/include/asm/pci-direct.h                  |   4 -
 arch/x86/kernel/pci-dma.c                          |   3 -
 arch/x86/kernel/setup.c                            |   5 -
 arch/x86/pci/common.c                              |   4 -
 arch/x86/pci/early.c                               |  44 --
 drivers/infiniband/hw/hfi1/pcie.c                  |   4 +-
 drivers/misc/pci_endpoint_test.c                   | 290 +++++++++---
 drivers/net/ethernet/intel/igb/igb_main.c          |   1 -
 drivers/net/wireless/ath/ath9k/pci.c               |   1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   1 -
 drivers/net/wireless/ralink/rt2x00/rt2x00pci.h     |   6 -
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |   3 +-
 drivers/pci/ats.c                                  |   3 +
 drivers/pci/controller/Kconfig                     |  12 +-
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   1 -
 drivers/pci/controller/dwc/pci-imx6.c              |   1 -
 drivers/pci/controller/dwc/pci-keystone.c          |   1 -
 drivers/pci/controller/dwc/pcie-armada8k.c         |   1 -
 drivers/pci/controller/dwc/pcie-artpec6.c          |   3 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 210 ++++++++-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  12 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  29 +-
 drivers/pci/controller/dwc/pcie-histb.c            |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c            |  28 ++
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c        |   1 -
 drivers/pci/controller/pci-aardvark.c              |  79 +---
 drivers/pci/controller/pci-hyperv.c                |   2 +-
 drivers/pci/controller/pci-mvebu.c                 | 153 +++----
 drivers/pci/controller/pcie-cadence-ep.c           |  21 +-
 drivers/pci/controller/pcie-cadence-host.c         |  33 ++
 drivers/pci/controller/pcie-cadence.c              | 123 +++++
 drivers/pci/controller/pcie-cadence.h              |  13 +-
 drivers/pci/controller/pcie-iproc.c                | 159 +++++--
 drivers/pci/controller/pcie-iproc.h                |   8 +
 drivers/pci/controller/pcie-mobiveil.c             |   4 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   2 +-
 drivers/pci/controller/vmd.c                       |  13 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  86 +++-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  24 +
 drivers/pci/endpoint/pci-epc-core.c                |  68 ++-
 drivers/pci/hotplug/acpi_pcihp.c                   |  36 +-
 drivers/pci/hotplug/acpiphp_core.c                 |  22 +-
 drivers/pci/hotplug/cpci_hotplug_core.c            |  14 +-
 drivers/pci/hotplug/cpqphp_core.c                  |  16 +-
 drivers/pci/hotplug/ibmphp_core.c                  |  15 +-
 drivers/pci/hotplug/ibmphp_ebda.c                  |  20 -
 drivers/pci/hotplug/pci_hotplug_core.c             | 134 ++++--
 drivers/pci/hotplug/pciehp.h                       | 117 +++--
 drivers/pci/hotplug/pciehp_core.c                  | 127 ++++--
 drivers/pci/hotplug/pciehp_ctrl.c                  | 351 ++++++--------
 drivers/pci/hotplug/pciehp_hpc.c                   | 281 +++++++-----
 drivers/pci/hotplug/pciehp_pci.c                   |   4 +-
 drivers/pci/hotplug/pcihp_skeleton.c               | 348 --------------
 drivers/pci/hotplug/pnv_php.c                      |   5 +-
 drivers/pci/hotplug/rpaphp_core.c                  |   2 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |  13 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |  13 +-
 drivers/pci/hotplug/sgi_hotplug.c                  |   9 +-
 drivers/pci/hotplug/shpchp_core.c                  |  41 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |   2 +
 drivers/pci/iov.c                                  |   4 +-
 drivers/pci/irq.c                                  |   6 +-
 drivers/pci/msi.c                                  |   3 +
 drivers/pci/of.c                                   |  14 +-
 drivers/pci/pci-acpi.c                             |  19 +-
 drivers/pci/pci-driver.c                           |   2 +-
 drivers/pci/pci-sysfs.c                            |   6 +-
 drivers/pci/pci.c                                  | 503 +++++++++++++++------
 drivers/pci/pci.h                                  |  69 +++
 drivers/pci/pcie/aer.c                             | 341 +++++++++++---
 drivers/pci/pcie/aspm.c                            |   8 +-
 drivers/pci/pcie/dpc.c                             | 107 ++---
 drivers/pci/pcie/err.c                             |  21 +-
 drivers/pci/pcie/portdrv.h                         |   2 +
 drivers/pci/pcie/portdrv_core.c                    |  30 +-
 drivers/pci/pcie/portdrv_pci.c                     |  27 +-
 drivers/pci/probe.c                                | 102 ++++-
 drivers/pci/quirks.c                               | 386 +++++++++++++++-
 drivers/pci/remove.c                               |   1 -
 drivers/pci/rom.c                                  |  11 +-
 drivers/pci/switch/switchtec.c                     |  14 +-
 drivers/pci/vpd.c                                  |   7 +-
 drivers/platform/x86/asus-wmi.c                    |  12 +-
 drivers/platform/x86/eeepc-laptop.c                |  12 +-
 drivers/vfio/pci/vfio_pci.c                        |   6 +-
 include/linux/dma-direction.h                      |   6 +-
 include/linux/pci-dma-compat.h                     |   8 +-
 include/linux/pci-epc.h                            |  16 +-
 include/linux/pci-epf.h                            |   1 +
 include/linux/pci.h                                |  41 +-
 include/linux/pci_hotplug.h                        |  15 +-
 include/linux/pci_ids.h                            |   2 +
 include/linux/switchtec.h                          |   4 -
 include/uapi/linux/pci_regs.h                      |   4 +-
 include/uapi/linux/pcitest.h                       |   3 +
 tools/pci/pcitest.c                                |  51 ++-
 tools/pci/pcitest.sh                               |  15 +
 115 files changed, 3571 insertions(+), 1786 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
 create mode 100644 Documentation/PCI/acpi-info.txt
 delete mode 100644 drivers/pci/hotplug/pcihp_skeleton.c
