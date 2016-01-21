Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48477 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965200AbcAUQVr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Jan 2016 11:21:47 -0500
Date: Thu, 21 Jan 2016 10:21:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.5
Message-ID: <20160121162141.GA10488@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.5.  With respect to your
current head (30f05309bde4), there's one trivial conflict in
include/linux/pci_ids.h (PCI_VENDOR_ID_NETRONOME added both via
David Miller and me).

Bjorn


The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.5-changes

for you to fetch changes up to 9662e32c810ad3e6ce49832d5f585a54f8fbdbdb:

  Merge branch 'pci/trivial' into next (2016-01-20 11:48:25 -0600)

----------------------------------------------------------------
PCI changes for the v4.5 merge window:

  Enumeration
    Simplify config space size computation (Bjorn Helgaas)
    Avoid iterating through ROM outside the resource window (Edward O'Callaghan)
    Support PCIe devices with short cfg_size (Jason S. McMullan)
    Add Netronome vendor and device IDs (Jason S. McMullan)
    Limit config space size for Netronome NFP6000 family (Jason S. McMullan)
    Add Netronome NFP4000 PF device ID (Simon Horman)
    Limit config space size for Netronome NFP4000 (Simon Horman)
    Print warnings for all invalid expansion ROM headers (Vladis Dronov)

  Resource management
    Fix minimum allocation address overwrite (Christoph Biedl)

  PCI device hotplug
    acpiphp_ibm: Fix null dereferences on null ibm_slot (Colin Ian King)
    pciehp: Always protect pciehp_disable_slot() with hotplug mutex (Guenter Roeck)
    shpchp: Constify hpc_ops structure (Julia Lawall)
    ibmphp: Remove unneeded NULL test (Julia Lawall)

  Power management
    Make ASPM sysfs link_state_store() consistent with link_state_show() (Andy Lutomirski)

  Virtualization
    Add function 1 DMA alias quirk for Lite-On/Plextor M6e/Marvell 88SS9183 (Tim Sander)

  MSI
    Remove empty pci_msi_init_pci_dev() (Bjorn Helgaas)
    Mark PCIe/PCI (MSI) IRQ cascade handlers as IRQF_NO_THREAD (Grygorii Strashko)
    Initialize MSI capability for all architectures (Guilherme G. Piccoli)
    Relax msi_domain_alloc() to support parentless MSI irqdomains (Liu Jiang)

  ARM Versatile host bridge driver
    Remove unused pci_sys_data structures (Lorenzo Pieralisi)

  Broadcom iProc host bridge driver
    Hide CONFIG_PCIE_IPROC (Arnd Bergmann)
    Do not use 0x in front of %pap (Dmitry V. Krivenok)
    Update iProc PCIe device tree binding (Ray Jui)
    Add PAXC interface support (Ray Jui)
    Add iProc PCIe MSI device tree binding (Ray Jui)
    Add iProc PCIe MSI support (Ray Jui)

  Freescale i.MX6 host bridge driver
    Use gpio_set_value_cansleep() (Fabio Estevam)
    Add support for active-low reset GPIO (Petr Štetiar)

  HiSilicon host bridge driver
    Add support for HiSilicon Hip06 PCIe host controllers (Gabriele Paoloni)

  Intel VMD host bridge driver
    Export irq_domain_set_info() for module use (Keith Busch)
    x86/PCI: Allow DMA ops specific to a PCI domain (Keith Busch)
    Use 32 bit PCI domain numbers (Keith Busch)
    Add driver for Intel Volume Management Device (VMD) (Keith Busch)

  Qualcomm host bridge driver
    Document PCIe devicetree bindings (Stanimir Varbanov)
    Add Qualcomm PCIe controller driver (Stanimir Varbanov)
    dts: apq8064: add PCIe devicetree node (Stanimir Varbanov)
    dts: ifc6410: enable PCIe DT node for this board (Stanimir Varbanov)

  Renesas R-Car host bridge driver
    Add support for R-Car H3 to pcie-rcar (Harunobu Kurokawa)
    Allow DT to override default window settings (Phil Edworthy)
    Convert to DT resource parsing API (Phil Edworthy)
    Revert "PCI: rcar: Build pcie-rcar.c only on ARM" (Phil Edworthy)
    Remove unused pci_sys_data struct from pcie-rcar (Phil Edworthy)
    Add runtime PM support to pcie-rcar (Phil Edworthy)
    Add Gen2 PHY setup to pcie-rcar (Phil Edworthy)
    Add gen2 fallback compatibility string for pci-rcar-gen2 (Simon Horman)
    Add gen2 fallback compatibility string for pcie-rcar (Simon Horman)

  Synopsys DesignWare host bridge driver
    Simplify control flow (Bjorn Helgaas)
    Make config accessor override checking symmetric (Bjorn Helgaas)
    Ensure ATU is enabled before IO/conf space accesses (Stanimir Varbanov)

  Miscellaneous
    Add of_pci_get_host_bridge_resources() stub (Arnd Bergmann)
    Check for PCI_HEADER_TYPE_BRIDGE equality, not bitmask (Bjorn Helgaas)
    Fix all whitespace issues (Bogicevic Sasa)
    x86/PCI: Simplify pci_bios_{read,write} (Geliang Tang)
    Use to_pci_dev() instead of open-coding it (Geliang Tang)
    Use kobj_to_dev() instead of open-coding it (Geliang Tang)
    Use list_for_each_entry() to simplify code (Geliang Tang)
    Fix typos in <linux/msi.h> (Thomas Petazzoni)
    x86/PCI: Clarify AMD Fam10h config access restrictions comment (Tomasz Nowicki)

----------------------------------------------------------------
Andy Lutomirski (1):
      PCI/ASPM: Make sysfs link_state_store() consistent with link_state_show()

Arnd Bergmann (2):
      PCI: iproc: Hide CONFIG_PCIE_IPROC
      PCI: host: Add of_pci_get_host_bridge_resources() stub

Bjorn Helgaas (12):
      PCI/MSI: Remove empty pci_msi_init_pci_dev()
      PCI: Check for PCI_HEADER_TYPE_BRIDGE equality, not bitmask
      PCI: Simplify config space size computation
      Merge branches 'pci/aspm', 'pci/hotplug', 'pci/misc' and 'pci/msi' into next
      PCI: designware: Simplify control flow
      Merge branches 'pci/host-generic', 'pci/host-imx6', 'pci/host-iproc' and 'pci/host-rcar' into next
      PCI: designware: Make config accessor override checking symmetric
      Merge branches 'pci/host', 'pci/host-designware', 'pci/host-hisi', 'pci/host-qcom' and 'pci/host-rcar' into next
      Merge branches 'pci/hotplug' and 'pci/resource' into next
      Merge branch 'pci/host-vmd' into next
      Merge branches 'pci/iommu' and 'pci/misc' into next
      Merge branch 'pci/trivial' into next

Bogicevic Sasa (1):
      PCI: Fix all whitespace issues

Christoph Biedl (1):
      PCI: Fix minimum allocation address overwrite

Colin Ian King (1):
      PCI: acpiphp_ibm: Fix null dereferences on null ibm_slot

Dmitry V. Krivenok (1):
      PCI: iproc: Do not use 0x in front of %pap

Edward O'Callaghan (1):
      PCI: Avoid iterating through memory outside the resource window

Fabio Estevam (1):
      PCI: imx6: Use gpio_set_value_cansleep()

Gabriele Paoloni (1):
      PCI: hisi: Add support for HiSilicon Hip06 PCIe host controllers

Geliang Tang (4):
      x86/PCI: Simplify pci_bios_{read,write}
      PCI: Use to_pci_dev() instead of open-coding it
      PCI: Use kobj_to_dev() instead of open-coding it
      PCI: hotplug: Use list_for_each_entry() to simplify code

Grygorii Strashko (1):
      PCI: host: Mark PCIe/PCI (MSI) IRQ cascade handlers as IRQF_NO_THREAD

Guenter Roeck (1):
      PCI: pciehp: Always protect pciehp_disable_slot() with hotplug mutex

Guilherme G. Piccoli (1):
      PCI/MSI: Initialize MSI capability for all architectures

Harunobu Kurokawa (1):
      PCI: rcar: Add support for R-Car H3 to pcie-rcar

Jason S. McMullan (3):
      PCI: Support PCIe devices with short cfg_size
      PCI: Add Netronome vendor and device IDs
      PCI: Limit config space size for Netronome NFP6000 family

Julia Lawall (2):
      PCI: shpchp: Constify hpc_ops structure
      PCI: ibmphp: Remove unneeded NULL test

Keith Busch (4):
      irqdomain: Export irq_domain_set_info() for module use
      x86/PCI: Allow DMA ops specific to a PCI domain
      PCI/AER: Use 32 bit PCI domain numbers
      x86/PCI: Add driver for Intel Volume Management Device (VMD)

Liu Jiang (1):
      genirq/MSI: Relax msi_domain_alloc() to support parentless MSI irqdomains

Lorenzo Pieralisi (1):
      PCI: generic,versatile: Remove unused pci_sys_data structures

Petr Štetiar (1):
      PCI: imx6: Add support for active-low reset GPIO

Phil Edworthy (6):
      PCI: rcar: Allow DT to override default window settings
      PCI: rcar: Convert to DT resource parsing API
      Revert "PCI: rcar: Build pcie-rcar.c only on ARM"
      PCI: rcar: Remove unused pci_sys_data struct from pcie-rcar
      PCI: rcar: Add runtime PM support to pcie-rcar
      PCI: rcar: Add Gen2 PHY setup to pcie-rcar

Ray Jui (4):
      PCI: iproc: Update iProc PCIe device tree binding
      PCI: iproc: Add PAXC interface support
      PCI: iproc: Add iProc PCIe MSI device tree binding
      PCI: iproc: Add iProc PCIe MSI support

Simon Horman (4):
      PCI: rcar: Add gen2 fallback compatibility string for pci-rcar-gen2
      PCI: rcar: Add gen2 fallback compatibility string for pcie-rcar
      PCI: Add Netronome NFP4000 PF device ID
      PCI: Limit config space size for Netronome NFP4000

Stanimir Varbanov (5):
      PCI: designware: Ensure ATU is enabled before IO/conf space accesses
      PCI: qcom: Document PCIe devicetree bindings
      PCI: qcom: Add Qualcomm PCIe controller driver
      ARM: dts: apq8064: add PCIe devicetree node
      ARM: dts: ifc6410: enable PCIe DT node for this board

Thomas Petazzoni (1):
      PCI/MSI: Fix typos in <linux/msi.h>

Tim Sander (1):
      PCI: Add function 1 DMA alias quirk for Lite-On/Plextor M6e/Marvell 88SS9183

Tomasz Nowicki (1):
      x86/PCI: Clarify AMD Fam10h config access restrictions comment

Vladis Dronov (1):
      PCI: Print warnings for all invalid expansion ROM headers

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  40 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |   8 +-
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  17 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          | 233 +++++++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  14 +-
 MAINTAINERS                                        |  14 +
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  26 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  36 +
 arch/powerpc/kernel/eeh_driver.c                   |   2 +-
 arch/powerpc/kernel/pci_of_scan.c                  |   3 -
 arch/x86/Kconfig                                   |  13 +
 arch/x86/include/asm/device.h                      |  10 +
 arch/x86/include/asm/hw_irq.h                      |   5 +
 arch/x86/include/asm/pci_x86.h                     |  10 +-
 arch/x86/pci/Makefile                              |   2 +
 arch/x86/pci/common.c                              |  38 ++
 arch/x86/pci/pcbios.c                              | 108 ++-
 arch/x86/pci/vmd.c                                 | 723 ++++++++++++++++++++
 drivers/pci/access.c                               |   8 +-
 drivers/pci/bus.c                                  |   6 +-
 drivers/pci/host/Kconfig                           |  36 +-
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pci-dra7xx.c                      |   3 +-
 drivers/pci/host/pci-exynos.c                      |   3 +-
 drivers/pci/host/pci-host-generic.c                |   9 -
 drivers/pci/host/pci-imx6.c                        |  25 +-
 drivers/pci/host/pci-rcar-gen2.c                   |  77 ++-
 drivers/pci/host/pci-tegra.c                       |   2 +-
 drivers/pci/host/pci-versatile.c                   |   5 +-
 drivers/pci/host/pcie-designware.c                 |  62 +-
 drivers/pci/host/pcie-hisi.c                       |  76 ++-
 drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
 drivers/pci/host/pcie-iproc-msi.c                  | 675 +++++++++++++++++++
 drivers/pci/host/pcie-iproc-platform.c             |  25 +-
 drivers/pci/host/pcie-iproc.c                      | 230 ++++++-
 drivers/pci/host/pcie-iproc.h                      |  42 +-
 drivers/pci/host/pcie-qcom.c                       | 616 +++++++++++++++++
 drivers/pci/host/pcie-rcar.c                       | 206 ++++--
 drivers/pci/host/pcie-spear13xx.c                  |   3 +-
 drivers/pci/host/pcie-xilinx.c                     |   3 +-
 drivers/pci/hotplug/acpi_pcihp.c                   |  10 +-
 drivers/pci/hotplug/acpiphp.h                      |   2 +-
 drivers/pci/hotplug/acpiphp_core.c                 |  14 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   2 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |  19 +-
 drivers/pci/hotplug/cpci_hotplug.h                 |  14 +-
 drivers/pci/hotplug/cpci_hotplug_core.c            |  16 +-
 drivers/pci/hotplug/cpci_hotplug_pci.c             |  10 +-
 drivers/pci/hotplug/cpcihp_generic.c               |  12 +-
 drivers/pci/hotplug/cpcihp_zt5550.c                |  14 +-
 drivers/pci/hotplug/cpqphp.h                       |  14 +-
 drivers/pci/hotplug/cpqphp_core.c                  |  32 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  | 200 +++---
 drivers/pci/hotplug/cpqphp_nvram.c                 |  92 +--
 drivers/pci/hotplug/cpqphp_pci.c                   |  84 +--
 drivers/pci/hotplug/cpqphp_sysfs.c                 |   6 +-
 drivers/pci/hotplug/ibmphp.h                       |  12 +-
 drivers/pci/hotplug/ibmphp_core.c                  |  54 +-
 drivers/pci/hotplug/ibmphp_ebda.c                  | 532 ++++++++-------
 drivers/pci/hotplug/ibmphp_hpc.c                   | 388 ++++++-----
 drivers/pci/hotplug/ibmphp_pci.c                   | 730 ++++++++++-----------
 drivers/pci/hotplug/ibmphp_res.c                   | 514 +++++++--------
 drivers/pci/hotplug/pci_hotplug_core.c             |  14 +-
 drivers/pci/hotplug/pciehp.h                       |   8 +-
 drivers/pci/hotplug/pciehp_core.c                  |  16 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   2 +
 drivers/pci/hotplug/pcihp_skeleton.c               |  31 +-
 drivers/pci/hotplug/rpadlpar_core.c                |   7 +-
 drivers/pci/hotplug/rpaphp.h                       |   8 +-
 drivers/pci/hotplug/rpaphp_core.c                  |   9 +-
 drivers/pci/hotplug/rpaphp_pci.c                   |   2 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |   2 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |   7 +-
 drivers/pci/hotplug/sgi_hotplug.c                  |   6 +-
 drivers/pci/hotplug/shpchp.h                       |  14 +-
 drivers/pci/hotplug/shpchp_core.c                  |  35 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |   4 +-
 drivers/pci/hotplug/shpchp_sysfs.c                 |  10 +-
 drivers/pci/msi.c                                  |   4 -
 drivers/pci/pci-label.c                            |   4 +-
 drivers/pci/pci-sysfs.c                            |  58 +-
 drivers/pci/pci.c                                  |   4 +-
 drivers/pci/pci.h                                  |   2 -
 drivers/pci/pcie/aer/aer_inject.c                  |  16 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |  10 +-
 drivers/pci/pcie/aspm.c                            |  16 +-
 drivers/pci/probe.c                                |  33 +-
 drivers/pci/quirks.c                               |  16 +
 drivers/pci/rom.c                                  |  23 +-
 drivers/pci/setup-bus.c                            |   2 +-
 include/linux/msi.h                                |   4 +-
 include/linux/of_pci.h                             |   7 +
 include/linux/pci.h                                |   2 -
 include/linux/pci_ids.h                            |   7 +
 kernel/irq/irqdomain.c                             |   1 +
 kernel/irq/msi.c                                   |   8 +-
 96 files changed, 4684 insertions(+), 1896 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 arch/x86/pci/vmd.c
 create mode 100644 drivers/pci/host/pcie-iproc-msi.c
 create mode 100644 drivers/pci/host/pcie-qcom.c
