Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbdEHO4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 May 2017 10:56:49 -0400
Date: Mon, 8 May 2017 09:56:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] PCI changes for v4.12
Message-ID: <20170508145642.GA8466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - add framework for supporting PCIe devices in Endpoint mode (Kishon
    Vijay Abraham I)

  - use non-postable PCI config space mappings when possible (Lorenzo
    Pieralisi)

  - clean up and unify mmap of PCI BARs (David Woodhouse)

  - export and unify Function Level Reset support (Christoph Hellwig)

  - avoid FLR for Intel 82579 NICs (Sasha Neftin)

  - add pci_request_irq() and pci_free_irq() helpers (Christoph Hellwig)

  - short-circuit config access failures for disconnected devices (Keith
    Busch)

  - remove D3 sleep delay when possible (Adrian Hunter)
  
  - freeze PME scan before suspending devices (Lukas Wunner)

  - stop disabling MSI/MSI-X in pci_device_shutdown() (Prarit Bhargava)

  - disable boot interrupt quirk for ASUS M2N-LR (Stefan Assmann)

  - add arch-specific alignment control to improve device passthrough by
    avoiding multiple BARs in a page (Yongji Xie)

  - add sysfs sriov_drivers_autoprobe to control VF driver binding (Bodong
    Wang)

  - allow slots below PCI-to-PCIe "reverse bridges" (Bjorn Helgaas)

  - fix crashes when unbinding host controllers that don't support removal
    (Brian Norris)

  - add driver for MicroSemi Switchtec management interface (Logan
    Gunthorpe)

  - add driver for Faraday Technology FTPCI100 host bridge (Linus Walleij)

  - add i.MX7D support (Andrey Smirnov)

  - use generic MSI support for Aardvark (Thomas Petazzoni)

  - make Rockchip driver modular (Brian Norris)

  - advertise 128-byte Read Completion Boundary support for Rockchip (Shawn
    Lin)

  - advertise PCI_EXP_LNKSTA_SLC for Rockchip root port (Shawn Lin)

  - convert atomic_t to refcount_t in HV driver (Elena Reshetova)

  - add CPU IRQ affinity in HV driver (K. Y. Srinivasan)

  - fix PCI bus removal in HV driver (Long Li)

  - add support for ThunderX2 DMA alias topology (Jayachandran C)

  - add ThunderX pass2.x 2nd node MCFG quirk (Tomasz Nowicki)

  - add ITE 8893 bridge DMA alias quirk (Jarod Wilson)

  - restrict Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices (Manish
    Jaggi)


You should see a few trivial merge conflicts:

  - pci_enable_msix() was removed by Christoph Hellwig via David Miller;
    conflicts with my change to make pci_msi_shutdown() and
    pci_enable_msix() static

  - CONFIG_PANEL removed from drivers/misc/Makefile by Andy Shevchenko via
    Greg KH; conflicts with CONFIG_PCI_ENDPOINT_TEST addition by Kishon
    Vijay Abraham I

  - CONFIG_ASPEED_LPC_CTRL added to drivers/misc/Makefile by Cyril Bur via
    Greg KH; conflicts with CONFIG_PCI_ENDPOINT_TEST addition by Kishon
    Vijay Abraham I


The following changes since commit 794a8604fe6e4a311373cde57a86ad4aab9d32b8:

  PCI: dwc: Fix dw_pcie_ops NULL pointer dereference (2017-04-04 08:24:25 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.12-changes

for you to fetch changes up to 3146c8f4de9b0858794a902f273aec13f168596e:

  Merge branch 'pci/remove' into next (2017-04-28 10:38:13 -0500)

----------------------------------------------------------------
pci-v4.12-changes

----------------------------------------------------------------
Adrian Hunter (1):
      PCI/PM: Don't sleep at all when d3_delay or d3cold_delay is zero

Andrey Smirnov (4):
      PCI: imx6: Add code to support i.MX7D
      PCI: imx6: Allow probe deferral by reset GPIO
      PCI: imx6: Do not wait for speed change on i.MX7
      PCI: imx6: Do not switch speed if Gen2 is disabled

Bjorn Helgaas (28):
      PCI/MSI: Make pci_msi_shutdown() and pci_msix_shutdown() static
      PCI/MSI: Use dev_printk() when possible
      PCI: rockchip: Unindent rockchip_pcie_set_power_limit()
      PCI: dwc: Unindent dw_handle_msi_irq() loop
      PCI: Include PCI-to-PCIe bridges as "Downstream Ports"
      PCI: Factor pci_reassigndev_resource_alignment()
      PCI: Don't reassign resources that are already aligned
      PCI/ACPI: Tidy up MCFG quirk whitespace
      Merge branch 'pci/host-designware' into next
      Merge branch 'pci/host-faraday' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-iproc' into next
      Merge branch 'pci/host-mvebu' into next
      Merge branch 'pci/host-rockchip' into next
      Merge branch 'pci/host-thunder' into next
      Merge branch 'pci/switchtec' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/iommu' into next
      Merge branch 'pci/ioremap' into next
      Merge branch 'pci/irq' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/pm' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/resource-mmap' into next
      Merge branch 'pci/virtualization' into next
      Merge branch 'pci/remove' into next

Bodong Wang (1):
      PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding

Brian Norris (7):
      PCI: rockchip: Handle regulator_get_current_limit() failure correctly
      PCI: rockchip: Make 'return 0' more obvious in probe()
      PCI: Fix typo pci_cfg_access_lock() comment
      PCI: rockchip: Add remove() support
      PCI: Export pci_remap_iospace() and pci_unmap_iospace()
      PCI: rockchip: Modularize
      PCI: Don't allow unbinding host controllers that aren't prepared

Christoph Hellwig (9):
      genirq: Fix indentation in remove_irq()
      genirq: Return the IRQ name from free_irq()
      PCI/irq: Add pci_request_irq() and pci_free_irq() helpers
      nvme/pci: Switch to pci_request_irq()
      PCI: Export pcie_flr()
      PCI: Call pcie_flr() from reset_intel_82599_sfp_virtfn()
      PCI: Call pcie_flr() from reset_chelsio_generic_dev()
      IB/hfi1: Use pcie_flr() instead of duplicating it
      ixgbe: Use pcie_flr() instead of duplicating it

Colin Ian King (1):
      PCI: imx6: Fix spelling mistake: "contol" -> "control"

Dan Carpenter (1):
      PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()

David Woodhouse (22):
      PCI: Fix pci_mmap_fits() for HAVE_PCI_RESOURCE_TO_USER platforms
      PCI: Fix another sanity check bug in /proc/pci mmap
      PCI: Only allow WC mmap on prefetchable resources
      xtensa/PCI: Do not mmap PCI BARs to userspace as write-through
      PCI: Add arch_can_pci_mmap_wc() macro
      PCI: Move multiple declarations of pci_mmap_page_range() to <linux/pci.h>
      PCI: Add arch_can_pci_mmap_io() on architectures which can mmap() I/O space
      PCI: Use BAR index in sysfs attr->private instead of resource pointer
      PCI: Add BAR index argument to pci_mmap_page_range()
      PCI: Add pci_mmap_resource_range() and use it for ARM64
      ARM/PCI: Use generic pci_mmap_resource_range()
      cris/PCI: Use generic pci_mmap_resource_range()
      MIPS: PCI: Use generic pci_mmap_resource_range()
      mn10300/PCI: Use generic pci_mmap_resource_range()
      parisc: Use generic pci_mmap_resource_range()
      sh/PCI: Use generic pci_mmap_resource_range()
      unicore32/PCI: Use generic pci_mmap_resource_range()
      x86/PCI: Use generic pci_mmap_resource_range()
      PCI: Add I/O BAR support to generic pci_mmap_resource_range()
      ia64: Remove redundant valid_mmap_phys_addr_range() from pci_mmap_page_range()
      ia64: Remove redundant checks for WC in pci_mmap_page_range()
      ia64: Use generic pci_mmap_resource_range()

Elena Reshetova (1):
      PCI: hv: Convert hv_pci_dev.refs from atomic_t to refcount_t

Jarod Wilson (1):
      PCI: Add bridge DMA alias quirk for ITE 8893 bridge

Jayachandran C (2):
      PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
      PCI: Avoid generating invalid ThunderX2 DMA aliases

Jon Mason (1):
      PCI: iproc: Add PCI_DOMAIN dependency to PCI Kconfig

K. Y. Srinivasan (2):
      PCI: hv: Specify CPU_AFFINITY_ALL for MSI affinity when >= 32 CPUs
      PCI: hv: Allocate interrupt descriptors with GFP_ATOMIC

Keerthy (1):
      PCI: dwc: dra7xx: Push request_irq() call to the bottom of probe

Keith Busch (5):
      PCI: Export PCI device config accessors
      PCI: Add device disconnected state
      PCI: Don't attempt config access to disconnected devices
      PCI/MSI: Skip disabling disconnected devices
      PCI: Short-circuit pci_device_is_present() for disconnected devices

Kishon Vijay Abraham I (29):
      PCI: dwc: designware: Add new *ops* for CPU addr fixup
      PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
      PCI: dwc: artpec6: Populate cpu_addr_fixup ops
      PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
      PCI: dwc: all: Modify dbi accessors to access data of 4/2/1 bytes
      PCI: dwc: designware: Move _unroll configurations to a separate function
      PCI: endpoint: Add EP core layer to enable EP controller and EP functions
      Documentation: PCI: Guide to use PCI Endpoint Core Layer
      PCI: endpoint: Introduce configfs entry for configuring EP functions
      Documentation: PCI: Guide to use PCI endpoint configfs
      PCI: endpoint: Create configfs entry for EPC device and EPF driver
      Documentation: PCI: Add specification for the *PCI test* function device
      PCI: endpoint: functions: Add an EP function to test PCI
      Documentation: PCI: Add binding documentation for pci-test endpoint function
      PCI: dwc: designware: Add EP mode support
      dt-bindings: PCI: Add DT bindings for PCI designware EP mode
      PCI: dwc: dra7xx: Facilitate wrapper and MSI interrupts to be enabled independently
      PCI: dwc: dra7xx: Add EP mode support
      dt-bindings: PCI: dra7xx: Add DT bindings for PCI dra7xx EP mode
      PCI: dwc: dra7xx: Workaround for errata id i870
      dt-bindings: PCI: dra7xx: Add DT bindings to enable unaligned access
      PCI: Add device IDs for DRA74x and DRA72x
      misc: Add host side PCI driver for PCI test function device
      Documentation: misc-devices: Add Documentation for pci-endpoint-test driver
      tools: PCI: Add a userspace tool to test PCI endpoint
      tools: PCI: Add sample test script to invoke pcitest
      Documentation: PCI: Add userguide for PCI endpoint test function
      MAINTAINERS: Add PCI Endpoint maintainer
      ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP

Linus Walleij (2):
      PCI: Add DT bindings for Faraday Technology PCI Host Bridge
      PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver

Logan Gunthorpe (4):
      MicroSemi Switchtec management interface driver
      switchtec: Add user interface documentation
      switchtec: Add sysfs attributes to the Switchtec driver
      switchtec: Add IOCTLs to the Switchtec driver

Long Li (2):
      PCI: hv: Properly handle PCI bus remove
      PCI: hv: Lock PCI bus on device eject

Lorenzo Pieralisi (21):
      PCI: Remove __weak tag from pci_remap_iospace()
      linux/io.h: Add pci_remap_cfgspace() interface
      ARM64: Implement pci_remap_cfgspace() interface
      ARM: Implement pci_remap_cfgspace() interface
      devres: fix devm_ioremap_*() offset parameter kerneldoc description
      PCI: Implement devm_pci_remap_cfgspace()
      PCI: ECAM: Map config region with pci_remap_cfgspace()
      PCI: xilinx: Update PCI config space remap function
      PCI: xilinx-nwl: Update PCI config space remap function
      PCI: spear13xx: Update PCI config space remap function
      PCI: rockchip: Update PCI config space remap function
      PCI: qcom: Update PCI config space remap function
      PCI: iproc-platform: Update PCI config space remap function
      PCI: designware: Update PCI config space remap function
      PCI: armada8k: Update PCI config space remap function
      PCI: xgene: Update PCI config space remap function
      PCI: tegra: Update PCI config space remap function
      PCI: hisi: Update PCI config space remap function
      PCI: layerscape: Update PCI config space remap function
      PCI: keystone-dw: Update PCI config space remap function
      PCI: versatile: Update PCI config space remap function

Lukas Wunner (1):
      PCI: Freeze PME scan before suspending devices

Manish Jaggi (1):
      PCI: Apply Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices

Marc Gonzalez (3):
      PCI: Include pci.h for struct pci_ops definition
      PCI: Improve __pci_read_base() robustness
      PCI: Change pci_host_common_probe() visibility

Matthias Kaehlcke (1):
      PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant

Prarit Bhargava (1):
      PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Russell King (1):
      PCI: mvebu: Avoid changing the SCC bit in the Link Status register

Sasha Neftin (1):
      PCI: Avoid FLR for Intel 82579 NICs

Shawn Lin (2):
      PCI: rockchip: Advertise 128-byte Read Completion Boundary support
      PCI: rockchip: Set PCI_EXP_LNKSTA_SLC in the Root Port

Stefan Assmann (1):
      PCI: Disable boot interrupt quirk for ASUS M2N-LR

Thomas Petazzoni (3):
      PCI: aardvark: Move to MSI handling using generic MSI support
      PCI: mvebu: Remove useless MSI enabling code
      of/pci: Remove unused MSI controller helpers

Tomasz Nowicki (1):
      PCI/ACPI: Add ThunderX pass2.x 2nd node MCFG quirk

Yongji Xie (5):
      PCI: Ignore requested alignment for IOV BARs
      PCI: Fix calculation of bridge window's size and alignment
      PCI: Add pcibios_default_alignment() for arch-specific alignment control
      powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned
      PCI: Don't resize resources when realigning all devices in system

 Documentation/ABI/testing/sysfs-bus-pci            |   22 +
 Documentation/ABI/testing/sysfs-class-switchtec    |   96 ++
 Documentation/PCI/00-INDEX                         |   10 +
 .../PCI/endpoint/function/binding/pci-test.txt     |   17 +
 Documentation/PCI/endpoint/pci-endpoint-cfs.txt    |  105 ++
 Documentation/PCI/endpoint/pci-endpoint.txt        |  215 +++
 Documentation/PCI/endpoint/pci-test-function.txt   |   66 +
 Documentation/PCI/endpoint/pci-test-howto.txt      |  179 +++
 Documentation/PCI/pci-iov-howto.txt                |   12 +
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 +-
 .../devicetree/bindings/pci/faraday,ftpci100.txt   |  129 ++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   14 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   42 +-
 Documentation/driver-model/devres.txt              |    6 +-
 Documentation/filesystems/sysfs-pci.txt            |   15 +-
 Documentation/ioctl/ioctl-number.txt               |    1 +
 Documentation/misc-devices/pci-endpoint-test.txt   |   35 +
 Documentation/switchtec.txt                        |   80 +
 MAINTAINERS                                        |   20 +
 arch/arm/include/asm/io.h                          |   10 +
 arch/arm/include/asm/pci.h                         |    3 +-
 arch/arm/kernel/bios32.c                           |   19 -
 arch/arm/mach-omap2/clockdomains7xx_data.c         |    2 +-
 arch/arm/mm/ioremap.c                              |    7 +
 arch/arm/mm/nommu.c                                |   12 +
 arch/arm64/include/asm/io.h                        |   10 +
 arch/arm64/include/asm/pci.h                       |    2 +
 arch/cris/arch-v32/drivers/pci/bios.c              |   22 -
 arch/cris/include/asm/pci.h                        |    4 +-
 arch/ia64/include/asm/pci.h                        |    5 +-
 arch/ia64/pci/pci.c                                |   46 -
 arch/microblaze/include/asm/pci.h                  |    6 +-
 arch/microblaze/pci/pci-common.c                   |    2 +-
 arch/mips/include/asm/pci.h                        |    5 +-
 arch/mips/pci/pci.c                                |   24 -
 arch/mn10300/include/asm/pci.h                     |    4 +-
 arch/mn10300/unit-asb2305/pci-asb2305.c            |   23 -
 arch/parisc/include/asm/pci.h                      |    4 +-
 arch/parisc/kernel/pci.c                           |   28 -
 arch/powerpc/include/asm/machdep.h                 |    2 +
 arch/powerpc/include/asm/pci.h                     |    9 +-
 arch/powerpc/kernel/pci-common.c                   |   11 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    7 +
 arch/sh/drivers/pci/pci.c                          |   21 -
 arch/sh/include/asm/pci.h                          |    4 +-
 arch/sparc/include/asm/pci_64.h                    |    5 +-
 arch/sparc/kernel/pci.c                            |    6 +-
 arch/unicore32/include/asm/pci.h                   |    3 +-
 arch/unicore32/kernel/pci.c                        |   23 -
 arch/x86/include/asm/pci.h                         |    7 +-
 arch/x86/pci/i386.c                                |   47 -
 arch/xtensa/include/asm/pci.h                      |    7 +-
 arch/xtensa/kernel/pci.c                           |   24 +-
 drivers/Makefile                                   |    2 +
 drivers/acpi/pci_mcfg.c                            |   14 +-
 drivers/infiniband/hw/hfi1/chip.c                  |    4 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |    1 -
 drivers/infiniband/hw/hfi1/pcie.c                  |   30 -
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/pci_endpoint_test.c                   |  534 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   16 +-
 drivers/nvme/host/pci.c                            |   30 +-
 drivers/of/of_pci.c                                |   45 -
 drivers/pci/Kconfig                                |    2 +
 drivers/pci/Makefile                               |    3 +-
 drivers/pci/access.c                               |   61 +-
 drivers/pci/dwc/Kconfig                            |   36 +-
 drivers/pci/dwc/Makefile                           |    5 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  293 +++-
 drivers/pci/dwc/pci-exynos.c                       |   14 +-
 drivers/pci/dwc/pci-imx6.c                         |  199 ++-
 drivers/pci/dwc/pci-keystone-dw.c                  |    2 +-
 drivers/pci/dwc/pci-layerscape.c                   |    3 +-
 drivers/pci/dwc/pcie-armada8k.c                    |    3 +-
 drivers/pci/dwc/pcie-artpec6.c                     |   12 +-
 drivers/pci/dwc/pcie-designware-ep.c               |  342 +++++
 drivers/pci/dwc/pcie-designware-host.c             |   39 +-
 drivers/pci/dwc/pcie-designware-plat.c             |    1 +
 drivers/pci/dwc/pcie-designware.c                  |  258 +++-
 drivers/pci/dwc/pcie-designware.h                  |  135 +-
 drivers/pci/dwc/pcie-hisi.c                        |    9 +-
 drivers/pci/dwc/pcie-qcom.c                        |    2 +-
 drivers/pci/dwc/pcie-spear13xx.c                   |    3 +-
 drivers/pci/ecam.c                                 |    6 +-
 drivers/pci/endpoint/Kconfig                       |   31 +
 drivers/pci/endpoint/Makefile                      |    7 +
 drivers/pci/endpoint/functions/Kconfig             |   12 +
 drivers/pci/endpoint/functions/Makefile            |    5 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |  510 +++++++
 drivers/pci/endpoint/pci-ep-cfs.c                  |  509 +++++++
 drivers/pci/endpoint/pci-epc-core.c                |  580 +++++++
 drivers/pci/endpoint/pci-epc-mem.c                 |  143 ++
 drivers/pci/endpoint/pci-epf-core.c                |  359 +++++
 drivers/pci/host/Kconfig                           |   10 +-
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-aardvark.c                    |  173 +--
 drivers/pci/host/pci-ftpci100.c                    |  563 +++++++
 drivers/pci/host/pci-host-generic.c                |    1 +
 drivers/pci/host/pci-hyperv.c                      |   46 +-
 drivers/pci/host/pci-mvebu.c                       |   22 +-
 drivers/pci/host/pci-tegra.c                       |    4 +-
 drivers/pci/host/pci-thunder-ecam.c                |    1 +
 drivers/pci/host/pci-thunder-pem.c                 |    1 +
 drivers/pci/host/pci-versatile.c                   |    4 +-
 drivers/pci/host/pci-xgene.c                       |    5 +-
 drivers/pci/host/pcie-iproc-platform.c             |    3 +-
 drivers/pci/host/pcie-rockchip.c                   |   91 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |    2 +-
 drivers/pci/host/pcie-xilinx.c                     |    2 +-
 drivers/pci/hotplug/pciehp_pci.c                   |    6 +
 drivers/pci/iov.c                                  |    1 +
 drivers/pci/irq.c                                  |   61 +-
 drivers/pci/mmap.c                                 |   99 ++
 drivers/pci/msi.c                                  |   17 +-
 drivers/pci/pci-driver.c                           |   24 +-
 drivers/pci/pci-sysfs.c                            |  104 +-
 drivers/pci/pci.c                                  |  252 ++-
 drivers/pci/pci.h                                  |   19 +-
 drivers/pci/pcie/pcie-dpc.c                        |    5 +
 drivers/pci/probe.c                                |    4 +-
 drivers/pci/proc.c                                 |   41 +-
 drivers/pci/quirks.c                               |   82 +-
 drivers/pci/search.c                               |    4 +
 drivers/pci/setup-bus.c                            |    4 +-
 drivers/pci/setup-res.c                            |    2 +-
 drivers/pci/switch/Kconfig                         |   13 +
 drivers/pci/switch/Makefile                        |    1 +
 drivers/pci/switch/switchtec.c                     | 1600 ++++++++++++++++++++
 include/linux/interrupt.h                          |    2 +-
 include/linux/io.h                                 |   21 +
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |    4 +
 include/linux/mod_devicetable.h                    |   10 +
 include/linux/of_pci.h                             |   11 -
 include/linux/pci-ecam.h                           |    3 +-
 include/linux/pci-ep-cfs.h                         |   41 +
 include/linux/pci-epc.h                            |  144 ++
 include/linux/pci-epf.h                            |  162 ++
 include/linux/pci.h                                |   84 +-
 include/linux/pci_ids.h                            |    2 +
 include/uapi/linux/Kbuild                          |    1 +
 include/uapi/linux/pci_regs.h                      |    2 +-
 include/uapi/linux/pcitest.h                       |   19 +
 include/uapi/linux/switchtec_ioctl.h               |  132 ++
 kernel/irq/manage.c                                |   15 +-
 lib/devres.c                                       |    6 +-
 tools/pci/pcitest.c                                |  186 +++
 tools/pci/pcitest.sh                               |   56 +
 148 files changed, 8937 insertions(+), 1004 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-switchtec
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint.txt
 create mode 100644 Documentation/PCI/endpoint/pci-test-function.txt
 create mode 100644 Documentation/PCI/endpoint/pci-test-howto.txt
 create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.txt
 create mode 100644 Documentation/switchtec.txt
 create mode 100644 drivers/misc/pci_endpoint_test.c
 create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
 create mode 100644 drivers/pci/endpoint/Kconfig
 create mode 100644 drivers/pci/endpoint/Makefile
 create mode 100644 drivers/pci/endpoint/functions/Kconfig
 create mode 100644 drivers/pci/endpoint/functions/Makefile
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-test.c
 create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c
 create mode 100644 drivers/pci/endpoint/pci-epc-core.c
 create mode 100644 drivers/pci/endpoint/pci-epc-mem.c
 create mode 100644 drivers/pci/endpoint/pci-epf-core.c
 create mode 100644 drivers/pci/host/pci-ftpci100.c
 create mode 100644 drivers/pci/mmap.c
 create mode 100644 drivers/pci/switch/Kconfig
 create mode 100644 drivers/pci/switch/Makefile
 create mode 100644 drivers/pci/switch/switchtec.c
 create mode 100644 include/linux/pci-ep-cfs.h
 create mode 100644 include/linux/pci-epc.h
 create mode 100644 include/linux/pci-epf.h
 create mode 100644 include/uapi/linux/pcitest.h
 create mode 100644 include/uapi/linux/switchtec_ioctl.h
 create mode 100644 tools/pci/pcitest.c
 create mode 100644 tools/pci/pcitest.sh
