Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeDFTCC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Apr 2018 15:02:02 -0400
Date: Fri, 6 Apr 2018 14:02:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v4.17
Message-ID: <20180406190200.GA184924@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - move pci_uevent_ers() out of pci.h (Michael Ellerman)

  - skip ASPM common clock warning if BIOS already configured it (Sinan
    Kaya)

  - fix ASPM Coverity warning about threshold_ns (Gustavo A. R. Silva)

  - remove last user of pci_get_bus_and_slot() and the function itself
    (Sinan Kaya)

  - add decoding for 16 GT/s link speed (Jay Fang)

  - add interfaces to get max link speed and width (Tal Gilboa)

  - add pcie_bandwidth_capable() to compute max supported link bandwidth
    (Tal Gilboa)

  - add pcie_bandwidth_available() to compute bandwidth available to device
    (Tal Gilboa)

  - add pcie_print_link_status() to log link speed and whether it's limited
    (Tal Gilboa)

  - use PCI core interfaces to report when device performance may be
    limited by its slot instead of doing it in each driver (Tal Gilboa)

  - fix possible cpqphp NULL pointer dereference (Shawn Lin)

  - rescan more of the hierarchy on ACPI hotplug to fix Thunderbolt/xHCI
    hotplug (Mika Westerberg)

  - add support for PCI I/O port space that's neither directly accessible
    via CPU in/out instructions nor directly mapped into CPU physical
    memory space.  This is fairly intrusive and includes minor changes to
    interfaces used for I/O space on most platforms (Zhichang Yuan, John
    Garry)

  - add support for HiSilicon Hip06/Hip07 LPC I/O space (Zhichang Yuan,
    John Garry)

  - use PCI_EXP_DEVCTL2_COMP_TIMEOUT in rapidio/tsi721 (Bjorn Helgaas)

  - remove possible NULL pointer dereference in of_pci_bus_find_domain_nr()
    (Shawn Lin)

  - report quirk timings with dev_info (Bjorn Helgaas)

  - report quirks that take longer than 10ms (Bjorn Helgaas)

  - add and use Altera Vendor ID (Johannes Thumshirn)

  - tidy Makefiles and comments (Bjorn Helgaas)

  - don't set up INTx if MSI or MSI-X is enabled to align cris, frv, ia64,
    and mn10300 with x86 (Bjorn Helgaas)

  - move pcieport_if.h to drivers/pci/pcie/ to encapsulate it (Frederick
    Lawler)

  - merge pcieport_if.h into portdrv.h (Bjorn Helgaas)

  - move workaround for BIOS PME issue from portdrv to PCI core (Bjorn
    Helgaas)

  - completely disable portdrv with "pcie_ports=compat" (Bjorn Helgaas)

  - remove portdrv link order dependency (Bjorn Helgaas)

  - remove support for unused VC portdrv service (Bjorn Helgaas)

  - simplify portdrv feature permission checking (Bjorn Helgaas)

  - remove "pcie_hp=nomsi" parameter (use "pci=nomsi" instead) (Bjorn
    Helgaas)

  - remove unnecessary "pcie_ports=auto" parameter (Bjorn Helgaas)

  - use cached AER capability offset (Frederick Lawler)

  - don't enable DPC if BIOS hasn't granted AER control (Mika Westerberg)

  - rename pcie-dpc.c to dpc.c (Bjorn Helgaas)

  - use generic pci_mmap_resource_range() instead of powerpc and xtensa
    arch-specific versions (David Woodhouse)

  - support arbitrary PCI host bridge offsets on sparc (Yinghai Lu)

  - remove System and Video ROM reservations on sparc (Bjorn Helgaas)

  - probe for device reset support during enumeration instead of runtime
    (Bjorn Helgaas)

  - add ACS quirk for Ampere (née APM) root ports (Feng Kan)

  - add function 1 DMA alias quirk for Marvell 88SE9220 (Thomas
    Vincent-Cross)

  - protect device restore with device lock (Sinan Kaya)

  - handle failure of FLR gracefully (Sinan Kaya)

  - handle CRS (config retry status) after device resets (Sinan Kaya)

  - skip various config reads for SR-IOV VFs as an optimization (KarimAllah
    Ahmed)

  - consolidate VPD code in vpd.c (Bjorn Helgaas)

  - add Tegra dependency on PCI_MSI_IRQ_DOMAIN (Arnd Bergmann)

  - add DT support for R-Car r8a7743 (Biju Das)

  - fix a PCI_EJECT vs PCI_BUS_RELATIONS race condition in Hyper-V host
    bridge driver that causes a general protection fault (Dexuan Cui)

  - fix Hyper-V host bridge hang in MSI setup on 1-vCPU VMs with SR-IOV
    (Dexuan Cui)

  - fix Hyper-V host bridge hang when ejecting a VF before setting up MSI
    (Dexuan Cui)

  - make several structures static (Fengguang Wu)

  - increase number of MSI IRQs supported by Synopsys DesignWare bridges
    from 32 to 256 (Gustavo Pimentel)

  - implemented multiplexed IRQ domain API and remove obsolete MSI IRQ API
    from DesignWare drivers (Gustavo Pimentel)

  - add Tegra power management support (Manikanta Maddireddy)

  - add Tegra loadable module support (Manikanta Maddireddy)

  - handle 64-bit BARs correctly in endpoint support (Niklas Cassel)

  - support optional regulator for HiSilicon STB (Shawn Guo)

  - use regulator bulk API for Qualcomm apq8064 (Srinivas Kandagatla)

  - support power supplies for Qualcomm msm8996 (Srinivas Kandagatla)


You should see these merge conflicts:

  1) Conflicts in:
       drivers/pci/quirks.c
       drivers/pci/vpd.c
     from these commits:
       7dcf688d4c78 ("PCI/cxgb4: Extend T3 PCI quirk to T4+ devices")
       996058573b22 ("PCI/VPD: Move VPD quirks to vpd.c")
     The body of the quirk updated by 7dcf688d4c78 needs to move to vpd.c.

  2) Conflicts in:
       drivers/net/ethernet/mellanox/mlx5/core/en_main.c
     from these commits:
       0608d4dbaf4e ("net/mlx5e: Unify slow PCI heuristic")
       33523a361307 ("net/mlx5e: Use pcie_bandwidth_available() to compute bandwidth")
     0608d4dbaf4e moved usage of mlx5e_get_pci_bw(), and 33523a361307
     replaced that usage with pcie_bandwidth_available().

My resolution is at https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v4.17-merge


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.17-changes

for you to fetch changes up to 5f764419098671cfffcfc44f8a5220afd3e37864:

  Merge remote-tracking branch 'lorenzo/pci/cadence' into next (2018-04-06 08:41:08 -0500)

----------------------------------------------------------------
pci-v4.17-changes

----------------------------------------------------------------
Arnd Bergmann (1):
      PCI: tegra: Add PCI_MSI_IRQ_DOMAIN kconfig dependency

Biju Das (1):
      dt-bindings: PCI: rcar: Add device tree support for r8a7743

Bjorn Helgaas (53):
      rapidio/tsi721: use PCI_EXP_DEVCTL2_COMP_TIMEOUT macro
      PCI: Probe for device reset support during enumeration
      PCI: Remove redundant probes for device reset support
      PCI/portdrv: Merge pcieport_if.h into portdrv.h
      PCI/PM: Move pcie_clear_root_pme_status() to core
      PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver
      PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled
      PCI/VPD: Move VPD access code to vpd.c
      PCI/VPD: Move VPD sysfs code to vpd.c
      PCI/VPD: Move VPD quirks to vpd.c
      PCI/VPD: Move VPD structures to vpd.c
      PCI: Report quirk timings with pci_info() instead of pr_debug()
      PCI: Report quirks that take more than 10ms
      PCI: Tidy Makefiles
      PCI: Tidy comments
      sparc/PCI: Stop reserving System ROM and Video ROM in PCI space
      PCI/PM: Clear PCIe PME Status bit for Root Complex Event Collectors
      PCI/portdrv: Disable port driver in compat mode
      PCI/portdrv: Remove pcie_port_bus_type link order dependency
      PCI/portdrv: Remove unused PCIE_PORT_SERVICE_VC
      PCI/portdrv: Simplify PCIe feature permission checking
      PCI/portdrv: Remove unnecessary include of <linux/pci-aspm.h>
      PCI/portdrv: Remove "pcie_hp=nomsi" kernel parameter
      PCI/portdrv: Remove unnecessary "pcie_ports=auto" parameter
      PCI/portdrv: Encapsulate pcie_ports_auto inside the port driver
      PCI/portdrv: Rename and reverse sense of pcie_ports_auto
      PCI/DPC: Rename from pcie-dpc.c to dpc.c
      fm10k: Report PCIe link properties with pcie_print_link_status()
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/deprecate-get-bus-and-slot'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/lpc'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/resource-mmap'
      Merge branch 'pci/sparc'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/vpd'
      Merge branch 'lorenzo/pci/altera'
      Merge branch 'lorenzo/pci/dwc'
      Merge branch 'lorenzo/pci/dwc-msi'
      Merge branch 'lorenzo/pci/endpoint'
      Merge branch '6c994c504fa2'
      Merge branch 'lorenzo/pci/hv'
      Merge branch 'lorenzo/pci/mediatek'
      Merge branch 'lorenzo/pci/rcar'
      Merge branch 'lorenzo/pci/tegra'
      Merge branch 'lorenzo/pci/xgene'
      Merge branch 'lorenzo/pci/xilinx'
      Merge remote-tracking branch 'lorenzo/pci/cadence' into next

Bjørn Mork (1):
      PCI: Always define the of_node helpers

Colin Ian King (1):
      PCI: rcar-gen2: Remove duplicated bit-wise or of RCAR_PCI_INT_SIGRETABORT

David Woodhouse (2):
      powerpc/pci: Use generic pci_mmap_resource_range()
      xtensa/PCI: Use generic pci_mmap_resource_range()

Dexuan Cui (5):
      PCI: hv: Serialize the present and eject work items
      PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
      PCI: hv: Fix a comment typo in _hv_pcifront_read_config()
      PCI: hv: Remove the bogus test in hv_eject_device_work()
      PCI: hv: Only queue new work items in hv_pci_devices_present() if necessary

Fabio Estevam (1):
      PCI: xgene: Fix the xgene_msi_probe() return code

Feng Kan (1):
      PCI: Add ACS quirk for Ampere root ports

Fengguang Wu (4):
      PCI: kirin: Make struct kirin_pcie_driver static
      PCI: faraday: Make struct faraday_pci_variant static
      PCI: rcar: Remove unnecessary semicolon
      PCI: v3-semi: Remove unnecessary semicolon

Frederick Lawler (2):
      PCI/portdrv: Move pcieport_if.h to drivers/pci/pcie/
      PCI/AER: Use cached AER Capability offset

Gabriele Paoloni (2):
      PCI: Remove __weak tag from pci_register_io_range()
      PCI: Add fwnode handler as input param of pci_register_io_range()

Gustavo A. R. Silva (2):
      PCI: altera: Fix bool initialization in tlp_read_packet()
      PCI/ASPM: Declare threshold_ns as u32, not u64

Gustavo Pimentel (3):
      PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API
      PCI: dwc: Remove old MSI IRQs API
      PCI: dwc: Expand maximum number of MSI IRQs from 32 to 256

Jay Fang (1):
      PCI: Add decoding for 16 GT/s link speed

Johannes Thumshirn (2):
      PCI: Add Altera vendor ID
      mcb: Add Altera PCI ID to mcb-pci

John Garry (4):
      ACPI / scan: Rename acpi_is_serial_bus_slave() for more general use
      ACPI / scan: Do not enumerate Indirect IO host children
      HISI LPC: Add ACPI support
      MAINTAINERS: Add John Garry as maintainer for HiSilicon LPC driver

KarimAllah Ahmed (3):
      PCI/IOV: Skip INTx config reads for VFs
      PCI/IOV: Skip BAR sizing for VFs
      PCI/IOV: Use VF0 cached config registers for other VFs

Lorenzo Pieralisi (2):
      PCI: pcie-xilinx-nwl: Fix mask value to disable MSIs
      MAINTAINERS: Add missing /drivers/pci/cadence directory entry

Manikanta Maddireddy (3):
      PCI: tegra: Free resources on probe failure
      PCI: tegra: Add loadable kernel module support
      PCI: tegra: Add power management support

Mathieu Malaterre (1):
      PCI/IOV: Add missing prototypes for powerpc pcibios interfaces

Michael Ellerman (1):
      PCI/AER: Move pci_uevent_ers() out of pci.h

Mika Westerberg (2):
      ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
      PCI/DPC: Do not enable DPC if AER control is not allowed by the BIOS

Niklas Cassel (13):
      PCI: designware-ep: Fix typo in error message
      PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
      PCI: endpoint: Simplify epc->ops->set_bar()/pci_epc_set_bar()
      PCI: endpoint: Setting BAR_5 to 64-bits wide is invalid
      PCI: endpoint: Setting 64-bit/prefetch bit is invalid when IO is set
      PCI: endpoint: Setting a BAR size > 4 GB is invalid if 64-bit flag is not set
      PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs properly
      PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64 if a 64-bit BAR was set-up
      PCI: endpoint: Handle 64-bit BARs properly
      PCI: endpoint: Make epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar
      PCI: endpoint: Make sure that BAR_5 does not have 64-bit flag set when clearing
      PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs properly
      misc: pci_endpoint_test: Handle 64-bit BARs properly

Rob Herring (3):
      PCI: kirin: Remove unnecessary asm/compiler.h include
      PCI: iproc: Remove dependency on ARM specific struct pci_sys_data
      PCI: kirin: Fix missing dependency on PCI_MSI_IRQ_DOMAIN

Rolf Evers-Fischer (3):
      PCI: endpoint: Simplify name allocation for EPF device
      PCI: endpoint: Fix kernel panic after put_device()
      PCI: endpoint: Remove goto labels in pci_epf_create()

Ryder Lee (1):
      dt-bindings: PCI: MediaTek: fix dtc warnings

Shawn Guo (2):
      PCI: histb: Fix error path of histb_pcie_host_enable()
      PCI: histb: Add an optional regulator for PCIe port power control

Shawn Lin (2):
      PCI: cpqphp: Fix possible NULL pointer dereference
      PCI: Fix NULL pointer dereference in of_pci_bus_find_domain_nr()

Sinan Kaya (9):
      drm/i915: Deprecate pci_get_bus_and_slot()
      PCI: Remove pci_get_bus_and_slot() function
      PCI: Protect restore with device lock to be consistent
      PCI: Handle FLR failure and allow other reset types
      PCI: Rename pci_flr_wait() to pci_dev_wait() and make it generic
      PCI/ASPM: Don't warn if already in common clock mode
      PCI: Wait for device to become ready after a power management reset
      PCI: Add a return type for pci_reset_bridge_secondary_bus()
      PCI: Wait for device to become ready after secondary bus reset

Srinivas Kandagatla (2):
      PCI: qcom: Add missing supplies required for msm8996
      PCI: qcom: Use regulator bulk api for apq8064 supplies

Tal Gilboa (8):
      PCI: Add pcie_get_speed_cap() to find max supported link speed
      PCI: Add pcie_get_width_cap() to find max supported link width
      PCI: Add pcie_bandwidth_capable() to compute max supported link bandwidth
      PCI: Add pcie_bandwidth_available() to compute bandwidth available to device
      PCI: Add pcie_print_link_status() to log link speed and whether it's limited
      net/mlx4_core: Report PCIe link properties with pcie_print_link_status()
      net/mlx5: Report PCIe link properties with pcie_print_link_status()
      net/mlx5e: Use pcie_bandwidth_available() to compute bandwidth

Thomas Vincent-Cross (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Ulf Magnusson (1):
      PCI: vmd: Fix malformed Kconfig default

Yinghai Lu (1):
      sparc/PCI: Support arbitrary host bridge address offset

Zhichang Yuan (4):
      lib: Add generic PIO mapping method
      PCI: Apply the new generic I/O management on PCI IO hosts
      of: Add missing I/O range exception for indirect-IO devices
      HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings

 Documentation/admin-guide/kernel-parameters.txt    |  19 +-
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
 .../bindings/pci/hisilicon-histb-pcie.txt          |   1 +
 .../devicetree/bindings/pci/mediatek-pcie.txt      |  11 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          |   4 +
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   6 +-
 MAINTAINERS                                        |   8 +
 arch/ia64/pci/pci.c                                |   4 +-
 arch/powerpc/include/asm/pci.h                     |   9 +-
 arch/powerpc/kernel/pci-common.c                   | 106 +---
 arch/sparc/kernel/pci.c                            |   6 +-
 arch/sparc/kernel/pci_common.c                     |  54 +-
 arch/sparc/kernel/pci_impl.h                       |   4 +
 arch/xtensa/include/asm/pci.h                      |   7 +-
 arch/xtensa/kernel/pci.c                           |  94 +---
 drivers/acpi/pci_root.c                            |  21 +-
 drivers/acpi/scan.c                                |  33 +-
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/hisi_lpc.c                             | 615 +++++++++++++++++++++
 drivers/char/xillybus/xillybus_pcie.c              |   1 -
 drivers/fpga/altera-cvp.c                          |   2 -
 drivers/gpu/drm/i915/i915_drv.c                    |   5 +-
 drivers/mcb/mcb-pci.c                              |   1 +
 drivers/misc/pci_endpoint_test.c                   |  12 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |  87 +--
 drivers/net/ethernet/mellanox/mlx4/main.c          |  81 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  32 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   4 +
 drivers/of/address.c                               |  96 +++-
 drivers/pci/Makefile                               |  69 +--
 drivers/pci/access.c                               | 380 +------------
 drivers/pci/ats.c                                  |  10 +-
 drivers/pci/bus.c                                  |   2 -
 drivers/pci/cadence/pcie-cadence-ep.c              |  15 +-
 drivers/pci/dwc/Kconfig                            |   1 +
 drivers/pci/dwc/pci-exynos.c                       |  18 -
 drivers/pci/dwc/pci-imx6.c                         |  18 -
 drivers/pci/dwc/pci-keystone-dw.c                  |  91 +--
 drivers/pci/dwc/pci-keystone.c                     |   1 +
 drivers/pci/dwc/pci-keystone.h                     |   4 +-
 drivers/pci/dwc/pci-layerscape.c                   |   3 +-
 drivers/pci/dwc/pcie-artpec6.c                     |  18 -
 drivers/pci/dwc/pcie-designware-ep.c               |  36 +-
 drivers/pci/dwc/pcie-designware-host.c             | 396 +++++++------
 drivers/pci/dwc/pcie-designware-plat.c             |  16 -
 drivers/pci/dwc/pcie-designware.h                  |  30 +-
 drivers/pci/dwc/pcie-histb.c                       |  43 +-
 drivers/pci/dwc/pcie-kirin.c                       |   3 +-
 drivers/pci/dwc/pcie-qcom.c                        |  91 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  28 +-
 drivers/pci/endpoint/pci-epc-core.c                |  32 +-
 drivers/pci/endpoint/pci-epf-core.c                |  56 +-
 drivers/pci/host-bridge.c                          |   2 +-
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pci-ftpci100.c                    |   4 +-
 drivers/pci/host/pci-hyperv.c                      | 112 +++-
 drivers/pci/host/pci-rcar-gen2.c                   |   1 -
 drivers/pci/host/pci-tegra.c                       | 354 +++++++++---
 drivers/pci/host/pci-v3-semi.c                     |   2 +-
 drivers/pci/host/pci-xgene-msi.c                   |   2 +-
 drivers/pci/host/pcie-altera.c                     |   2 +-
 drivers/pci/host/pcie-iproc-bcma.c                 |   3 +-
 drivers/pci/host/pcie-iproc.c                      |  19 +-
 drivers/pci/host/pcie-iproc.h                      |   4 -
 drivers/pci/host/pcie-rcar.c                       |   2 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |   4 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |  23 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |  12 +-
 drivers/pci/hotplug/pciehp.h                       |   3 +-
 drivers/pci/iov.c                                  |  50 +-
 drivers/pci/mmap.c                                 |   2 +-
 drivers/pci/msi.c                                  |   3 +-
 drivers/pci/pci-acpi.c                             |   3 +-
 drivers/pci/pci-driver.c                           |  96 +++-
 drivers/pci/pci-label.c                            |   5 +-
 drivers/pci/pci-stub.c                             |   3 +-
 drivers/pci/pci-sysfs.c                            | 111 +---
 drivers/pci/pci.c                                  | 377 +++++++++----
 drivers/pci/pci.h                                  |  45 +-
 drivers/pci/pcie/Makefile                          |  19 +-
 drivers/pci/pcie/aer/aer_inject.c                  |   4 +-
 drivers/pci/pcie/aer/aerdrv.c                      |  10 +-
 drivers/pci/pcie/aer/aerdrv.h                      |   4 +-
 drivers/pci/pcie/aer/aerdrv_acpi.c                 |   1 -
 drivers/pci/pcie/aer/aerdrv_core.c                 |  11 +-
 drivers/pci/pcie/aer/aerdrv_errprint.c             |   3 -
 drivers/pci/pcie/aer/ecrc.c                        |   8 +-
 drivers/pci/pcie/aspm.c                            |  23 +-
 drivers/pci/pcie/{pcie-dpc.c => dpc.c}             |   3 +-
 drivers/pci/pcie/pme.c                             |   1 -
 drivers/pci/pcie/portdrv.h                         |  87 ++-
 drivers/pci/pcie/portdrv_acpi.c                    |   5 +-
 drivers/pci/pcie/portdrv_bus.c                     |  56 --
 drivers/pci/pcie/portdrv_core.c                    |  84 ++-
 drivers/pci/pcie/portdrv_pci.c                     |  61 +-
 drivers/pci/probe.c                                |  75 ++-
 drivers/pci/proc.c                                 |   4 +-
 drivers/pci/quirks.c                               | 171 +-----
 drivers/pci/rom.c                                  |   4 +-
 drivers/pci/search.c                               |   8 +-
 drivers/pci/setup-bus.c                            |   6 +-
 drivers/pci/setup-irq.c                            |   4 +-
 drivers/pci/setup-res.c                            |  10 +-
 drivers/pci/slot.c                                 |   2 +-
 drivers/pci/syscall.c                              |   9 +-
 drivers/pci/vpd.c                                  | 576 ++++++++++++++++++-
 drivers/pci/xen-pcifront.c                         |   4 +-
 drivers/rapidio/devices/tsi721.c                   |   5 +-
 include/acpi/acpi_bus.h                            |   2 +-
 include/asm-generic/io.h                           |   4 +-
 include/linux/logic_pio.h                          | 123 +++++
 include/linux/pci-epc.h                            |  11 +-
 include/linux/pci-epf.h                            |   2 +
 include/linux/pci.h                                |  94 ++--
 include/linux/pci_ids.h                            |   3 +
 include/linux/pcieport_if.h                        |  71 ---
 include/uapi/linux/pci_regs.h                      |   7 +-
 lib/Kconfig                                        |  16 +
 lib/Makefile                                       |   2 +
 lib/logic_pio.c                                    | 280 ++++++++++
 121 files changed, 3484 insertions(+), 2361 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 create mode 100644 drivers/bus/hisi_lpc.c
 rename drivers/pci/pcie/{pcie-dpc.c => dpc.c} (99%)
 delete mode 100644 drivers/pci/pcie/portdrv_bus.c
 create mode 100644 include/linux/logic_pio.h
 delete mode 100644 include/linux/pcieport_if.h
 create mode 100644 lib/logic_pio.c
