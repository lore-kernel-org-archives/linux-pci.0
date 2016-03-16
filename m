Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39675 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966783AbcCPPR1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Mar 2016 11:17:27 -0400
Date: Wed, 16 Mar 2016 10:17:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.6
Message-ID: <20160316151721.GA25064@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.6.

Bjorn


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.6-changes

for you to fetch changes up to 6e6f498b039aa5558c7377fbbe65f7421d34cea4:

  Merge branch 'pci/resource' into next (2016-03-15 08:56:28 -0500)

----------------------------------------------------------------
PCI changes for the v4.6 merge window:

  Enumeration
    Disable IO/MEM decoding for devices with non-compliant BARs (Bjorn Helgaas)
    Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs (Bjorn Helgaas

  Resource management
    Mark shadow copy of VGA ROM as IORESOURCE_PCI_FIXED (Bjorn Helgaas)
    Don't assign or reassign immutable resources (Bjorn Helgaas)
    Don't enable/disable ROM BAR if we're using a RAM shadow copy (Bjorn Helgaas)
    Set ROM shadow location in arch code, not in PCI core (Bjorn Helgaas)
    Remove arch-specific IORESOURCE_ROM_SHADOW size from sysfs (Bjorn Helgaas)
    ia64: Use ioremap() instead of open-coded equivalent (Bjorn Helgaas)
    ia64: Keep CPU physical (not virtual) addresses in shadow ROM resource (Bjorn Helgaas)
    MIPS: Keep CPU physical (not virtual) addresses in shadow ROM resource (Bjorn Helgaas)
    Remove unused IORESOURCE_ROM_COPY and IORESOURCE_ROM_BIOS_COPY (Bjorn Helgaas)
    Don't leak memory if sysfs_create_bin_file() fails (Bjorn Helgaas)
    rcar: Remove PCI_PROBE_ONLY handling (Lorenzo Pieralisi)
    designware: Remove PCI_PROBE_ONLY handling (Lorenzo Pieralisi)

  Virtualization
    Wait for up to 1000ms after FLR reset (Alex Williamson)
    Support SR-IOV on any function type (Kelly Zytaruk)
    Add ACS quirk for all Cavium devices (Manish Jaggi)

  AER
    Rename pci_ops_aer to aer_inj_pci_ops (Bjorn Helgaas)
    Restore pci_ops pointer while calling original pci_ops (David Daney)
    Fix aer_inject error codes (Jean Delvare)
    Use dev_warn() in aer_inject (Jean Delvare)
    Log actual error causes in aer_inject (Jean Delvare)
    Log aer_inject error injections (Jean Delvare)

  VPD
    Prevent VPD access for buggy devices (Babu Moger)
    Move pci_read_vpd() and pci_write_vpd() close to other VPD code (Bjorn Helgaas)
    Move pci_vpd_release() from header file to pci/access.c (Bjorn Helgaas)
    Remove struct pci_vpd_ops.release function pointer (Bjorn Helgaas)
    Rename VPD symbols to remove unnecessary "pci22" (Bjorn Helgaas)
    Fold struct pci_vpd_pci22 into struct pci_vpd (Bjorn Helgaas)
    Sleep rather than busy-wait for VPD access completion (Bjorn Helgaas)
    Update VPD definitions (Hannes Reinecke)
    Allow access to VPD attributes with size 0 (Hannes Reinecke)
    Determine actual VPD size on first access (Hannes Reinecke)

  Generic host bridge driver
    Move structure definitions to separate header file (David Daney)
    Add pci_host_common_probe(), based on gen_pci_probe() (David Daney)
    Expose pci_host_common_probe() for use by other drivers (David Daney)

  Altera host bridge driver
    Fix altera_pcie_link_is_up() (Ley Foon Tan)

  Cavium ThunderX host bridge driver
    Add PCIe host driver for ThunderX processors (David Daney)
    Add driver for ThunderX-pass{1,2} on-chip devices (David Daney)

  Freescale i.MX6 host bridge driver
    Add DT bindings to configure PHY Tx driver settings (Justin Waters)
    Move imx6_pcie_reset_phy() near other PHY handling functions (Lucas Stach)
    Move PHY reset into imx6_pcie_establish_link() (Lucas Stach)
    Remove broken Gen2 workaround (Lucas Stach)
    Move link up check into imx6_pcie_wait_for_link() (Lucas Stach)

  Freescale Layerscape host bridge driver
    Add "fsl,ls2085a-pcie" compatible ID (Yang Shi)

  Intel VMD host bridge driver
    Attach VMD resources to parent domain's resource tree (Jon Derrick)
    Set bus resource start to 0 (Keith Busch)

  Microsoft Hyper-V host bridge driver
    Add fwnode_handle to x86 pci_sysdata (Jake Oshins)
    Look up IRQ domain by fwnode_handle (Jake Oshins)
    Add paravirtual PCI front-end for Microsoft Hyper-V VMs (Jake Oshins)

  NVIDIA Tegra host bridge driver
    Add pci_ops.{add,remove}_bus() callbacks (Thierry Reding)
    Implement ->{add,remove}_bus() callbacks (Thierry Reding)
    Remove unused struct tegra_pcie.num_ports field (Thierry Reding)
    Track bus -> CPU mapping (Thierry Reding)
    Remove misleading PHYS_OFFSET (Thierry Reding)

  Renesas R-Car host bridge driver
    Depend on ARCH_RENESAS, not ARCH_SHMOBILE (Simon Horman)

  Synopsys DesignWare host bridge driver
    ARC: Add PCI support (Joao Pinto)
    Add generic dw_pcie_wait_for_link() (Joao Pinto)
    Add default link up check if sub-driver doesn't override (Joao Pinto)
    Add driver for prototyping kits based on ARC SDP (Joao Pinto)

  TI Keystone host bridge driver
    Defer probing if devm_phy_get() returns -EPROBE_DEFER (Shawn Lin)

  Xilinx AXI host bridge driver
    Use of_pci_get_host_bridge_resources() to parse DT (Bharat Kumar Gogada)
    Remove dependency on ARM-specific struct hw_pci (Bharat Kumar Gogada)
    Don't call pci_fixup_irqs() on Microblaze (Bharat Kumar Gogada)
    Update Zynq binding with Microblaze node (Bharat Kumar Gogada)
    microblaze: Support generic Xilinx AXI PCIe Host Bridge IP driver (Bharat Kumar Gogada)

  Xilinx NWL host bridge driver
    Add support for Xilinx NWL PCIe Host Controller (Bharat Kumar Gogada)

  Miscellaneous
    Check device_attach() return value always (Bjorn Helgaas)
    Move pci_set_flags() from asm-generic/pci-bridge.h to linux/pci.h (Bjorn Helgaas)
    Remove includes of empty asm-generic/pci-bridge.h (Bjorn Helgaas)
    ARM64: Remove generated include of asm-generic/pci-bridge.h (Bjorn Helgaas)
    Remove empty asm-generic/pci-bridge.h (Bjorn Helgaas)
    Remove includes of asm/pci-bridge.h (Bjorn Helgaas)
    Consolidate PCI DMA constants and interfaces in linux/pci-dma-compat.h (Bjorn Helgaas)
    unicore32: Remove unused HAVE_ARCH_PCI_SET_DMA_MASK definition (Bjorn Helgaas)
    Cleanup pci/pcie/Kconfig whitespace (Andreas Ziegler)
    Include pci/hotplug Kconfig directly from pci/Kconfig (Bjorn Helgaas)
    Include pci/pcie/Kconfig directly from pci/Kconfig (Bogicevic Sasa)
    frv: Remove stray pci_{alloc,free}_consistent() declaration (Christoph Hellwig)
    Move pci_dma_* helpers to common code (Christoph Hellwig)
    Add PCI_CLASS_SERIAL_USB_DEVICE definition (Heikki Krogerus)
    Add QEMU top-level IDs for (sub)vendor & device (Robin H. Johnson)
    Fix broken URL for Dell biosdevname (Naga Venkata Sai Indubhaskar Jupudi)

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Wait for up to 1000ms after FLR reset

Andreas Ziegler (1):
      PCI: Cleanup pci/pcie/Kconfig whitespace

Babu Moger (1):
      PCI: Prevent VPD access for buggy devices

Bharat Kumar Gogada (6):
      PCI: xilinx: Use of_pci_get_host_bridge_resources() to parse DT
      PCI: xilinx: Remove dependency on ARM-specific struct hw_pci
      PCI: xilinx: Don't call pci_fixup_irqs() on Microblaze
      PCI: xilinx: Update Zynq binding with Microblaze node
      microblaze/PCI: Support generic Xilinx AXI PCIe Host Bridge IP driver
      PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller

Bjorn Helgaas (43):
      PCI/AER: Rename pci_ops_aer to aer_inj_pci_ops
      PCI: Check device_attach() return value always
      PCI/PME: Remove redundant port lookup
      PCI/PME: Restructure pcie_pme_suspend() to prevent compiler warning
      PCI: Move pci_set_flags() from asm-generic/pci-bridge.h to linux/pci.h
      PCI: Remove includes of empty asm-generic/pci-bridge.h
      ARM64: PCI: Remove generated include of asm-generic/pci-bridge.h
      PCI: Remove empty asm-generic/pci-bridge.h
      PCI: Remove includes of asm/pci-bridge.h
      Merge branches 'pci/aer', 'pci/misc' and 'pci/virtualization' into next
      Merge branches 'pci/host-designware', 'pci/host-imx6', 'pci/host-layerscape' and 'pci/host-rcar' into next
      PCI: Disable IO/MEM decoding for devices with non-compliant BARs
      PCI: Use bitfield instead of bool for struct pci_vpd_pci22.busy
      PCI: Move pci_read_vpd() and pci_write_vpd() close to other VPD code
      PCI: Move pci_vpd_release() from header file to pci/access.c
      PCI: Remove struct pci_vpd_ops.release function pointer
      PCI: Rename VPD symbols to remove unnecessary "pci22"
      PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
      PCI: Consolidate PCI DMA constants and interfaces in linux/pci-dma-compat.h
      unicore32: Remove unused HAVE_ARCH_PCI_SET_DMA_MASK definition
      x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs
      PCI: Mark shadow copy of VGA ROM as IORESOURCE_PCI_FIXED
      PCI: Don't assign or reassign immutable resources
      PCI: Don't enable/disable ROM BAR if we're using a RAM shadow copy
      PCI: Set ROM shadow location in arch code, not in PCI core
      PCI: Include pci/hotplug Kconfig directly from pci/Kconfig
      PCI: Sleep rather than busy-wait for VPD access completion
      PCI: Remove arch-specific IORESOURCE_ROM_SHADOW size from sysfs
      PCI: Clean up pci_map_rom() whitespace
      ia64/PCI: Use temporary struct resource * to avoid repetition
      ia64/PCI: Use ioremap() instead of open-coded equivalent
      ia64/PCI: Keep CPU physical (not virtual) addresses in shadow ROM resource
      MIPS: Loongson 3: Use temporary struct resource * to avoid repetition
      MIPS: Loongson 3: Keep CPU physical (not virtual) addresses in shadow ROM resource
      PCI: Remove unused IORESOURCE_ROM_COPY and IORESOURCE_ROM_BIOS_COPY
      PCI: Simplify sysfs ROM cleanup
      PCI: Don't leak memory if sysfs_create_bin_file() fails
      PCI: Simplify pci_create_attr() control flow
      Merge branches 'pci/aer', 'pci/enumeration', 'pci/kconfig', 'pci/misc', 'pci/virtualization' and 'pci/vpd' into next
      Merge branches 'pci/host-altera', 'pci/host-imx6', 'pci/host-keystone', 'pci/host-rcar', 'pci/host-tegra', 'pci/host-thunder', 'pci/host-vmd', 'pci/host-xilinx' and 'pci/host-xilinx-nwl' into next
      Merge branch 'pci/host-designware' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/resource' into next

Bogicevic Sasa (1):
      PCI: Include pci/pcie/Kconfig directly from pci/Kconfig

Christoph Hellwig (2):
      frv/PCI: Remove stray pci_{alloc,free}_consistent() declaration
      PCI: Move pci_dma_* helpers to common code

David Daney (6):
      PCI/AER: Restore pci_ops pointer while calling original pci_ops
      PCI: generic: Move structure definitions to separate header file
      PCI: generic: Add pci_host_common_probe(), based on gen_pci_probe()
      PCI: generic: Expose pci_host_common_probe() for use by other drivers
      PCI: thunder: Add PCIe host driver for ThunderX processors
      PCI: thunder: Add driver for ThunderX-pass{1,2} on-chip devices

Geliang Tang (1):
      PCI/AER: Use list_first_entry_or_null() to simplify code

Hannes Reinecke (3):
      PCI: Update VPD definitions
      PCI: Allow access to VPD attributes with size 0
      PCI: Determine actual VPD size on first access

Heikki Krogerus (1):
      PCI: Add PCI_CLASS_SERIAL_USB_DEVICE definition

Jake Oshins (3):
      PCI: Add fwnode_handle to x86 pci_sysdata
      PCI: Look up IRQ domain by fwnode_handle
      PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs

Jean Delvare (4):
      PCI/AER: Fix aer_inject error codes
      PCI/AER: Use dev_warn() in aer_inject
      PCI/AER: Log actual error causes in aer_inject
      PCI/AER: Log aer_inject error injections

Jisheng Zhang (1):
      PCI: designware: Explain why we don't program ATU for some platforms

Joao Pinto (4):
      ARC: Add PCI support
      PCI: designware: Add generic dw_pcie_wait_for_link()
      PCI: designware: Add default link up check if sub-driver doesn't override
      PCI: designware: Add driver for prototyping kits based on ARC SDP

Jon Derrick (1):
      x86/PCI: VMD: Attach VMD resources to parent domain's resource tree

Justin Waters (1):
      PCI: imx6: Add DT bindings to configure PHY Tx driver settings

Keith Busch (2):
      x86/PCI: VMD: Document code for maintainability
      x86/PCI: VMD: Set bus resource start to 0

Kelly Zytaruk (1):
      PCI: Support SR-IOV on any function type

Ley Foon Tan (1):
      PCI: altera: Fix altera_pcie_link_is_up()

Lorenzo Pieralisi (2):
      PCI: rcar: Remove PCI_PROBE_ONLY handling
      PCI: designware: Remove PCI_PROBE_ONLY handling

Lucas Stach (4):
      PCI: imx6: Move imx6_pcie_reset_phy() near other PHY handling functions
      PCI: imx6: Move PHY reset into imx6_pcie_establish_link()
      PCI: imx6: Remove broken Gen2 workaround
      PCI: imx6: Move link up check into imx6_pcie_wait_for_link()

Manish Jaggi (1):
      PCI: Add ACS quirk for all Cavium devices

Naga Venkata Sai Indubhaskar Jupudi (1):
      PCI: Fix broken URL for Dell biosdevname

Robin H. Johnson (1):
      PCI: Add QEMU top-level IDs for (sub)vendor & device

Shawn Lin (1):
      PCI: keystone: Defer probing if devm_phy_get() returns -EPROBE_DEFER

Simon Horman (1):
      PCI: rcar: Depend on ARCH_RENESAS, not ARCH_SHMOBILE

Thierry Reding (5):
      PCI: Add pci_ops.{add,remove}_bus() callbacks
      PCI: tegra: Implement ->{add,remove}_bus() callbacks
      PCI: tegra: Remove unused struct tegra_pcie.num_ports field
      PCI: tegra: Track bus -> CPU mapping
      PCI: tegra: Remove misleading PHYS_OFFSET

Yang Shi (1):
      PCI: layerscape: Add "fsl,ls2085a-pcie" compatible ID

 .../devicetree/bindings/pci/designware-pcie.txt    |   17 +
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |    7 +
 .../devicetree/bindings/pci/pci-thunder-ecam.txt   |   30 +
 .../devicetree/bindings/pci/pci-thunder-pem.txt    |   43 +
 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 +
 .../devicetree/bindings/pci/xilinx-pcie.txt        |   32 +-
 MAINTAINERS                                        |   17 +
 arch/alpha/include/asm/pci.h                       |    8 -
 arch/arc/Kconfig                                   |   26 +
 arch/arc/include/asm/dma.h                         |    5 +
 arch/arc/include/asm/io.h                          |    9 +
 arch/arc/include/asm/pci.h                         |   28 +
 arch/arc/kernel/Makefile                           |    1 +
 arch/arc/kernel/pcibios.c                          |   22 +
 arch/arc/plat-axs10x/Kconfig                       |    1 +
 arch/arm/Kconfig                                   |    1 -
 arch/arm/include/asm/pci.h                         |    4 -
 arch/arm64/Kconfig                                 |    2 -
 arch/arm64/include/asm/Kbuild                      |    3 -
 arch/arm64/include/asm/pci.h                       |    2 -
 arch/arm64/kernel/pci.c                            |    2 -
 arch/avr32/include/asm/pci.h                       |    2 -
 arch/blackfin/Kconfig                              |    2 -
 arch/blackfin/include/asm/pci.h                    |    1 -
 arch/cris/include/asm/pci.h                        |    3 -
 arch/frv/include/asm/pci.h                         |    7 -
 arch/ia64/Kconfig                                  |    4 -
 arch/ia64/include/asm/pci.h                        |    2 -
 arch/ia64/pci/fixup.c                              |   21 +-
 arch/ia64/sn/kernel/io_acpi_init.c                 |   22 +-
 arch/ia64/sn/kernel/io_init.c                      |   51 +-
 arch/m32r/Kconfig                                  |    2 -
 arch/m68k/include/asm/pci.h                        |    1 -
 arch/microblaze/Kconfig                            |    3 +
 arch/microblaze/include/asm/pci.h                  |    2 -
 arch/microblaze/pci/pci-common.c                   |   56 +-
 arch/mips/Kconfig                                  |    4 -
 arch/mips/include/asm/pci.h                        |    4 -
 arch/mips/pci/fixup-loongson3.c                    |   19 +-
 arch/mn10300/include/asm/pci.h                     |    3 -
 arch/parisc/include/asm/pci.h                      |    3 -
 arch/powerpc/Kconfig                               |    4 -
 arch/powerpc/include/asm/pci-bridge.h              |    1 -
 arch/powerpc/include/asm/pci.h                     |    2 -
 arch/s390/Kconfig                                  |    2 -
 arch/s390/include/asm/pci.h                        |    1 -
 arch/sh/Kconfig                                    |    4 -
 arch/sh/include/asm/pci.h                          |    3 -
 arch/sparc/include/asm/pci.h                       |    3 -
 arch/tile/Kconfig                                  |    4 -
 arch/tile/include/asm/pci.h                        |    3 -
 arch/unicore32/include/asm/pci.h                   |    3 -
 arch/unicore32/include/mach/hardware.h             |    5 -
 arch/x86/Kconfig                                   |    4 -
 arch/x86/include/asm/pci.h                         |   18 +-
 arch/x86/pci/common.c                              |    1 -
 arch/x86/pci/fixup.c                               |   28 +-
 arch/x86/pci/vmd.c                                 |   35 +-
 arch/xtensa/Kconfig                                |    2 -
 arch/xtensa/include/asm/pci.h                      |    3 -
 drivers/ata/pata_macio.c                           |    2 +-
 drivers/char/agp/uninorth-agp.c                    |    1 -
 drivers/gpu/drm/bochs/bochs_drv.c                  |    4 +-
 drivers/gpu/drm/cirrus/cirrus_drv.c                |    5 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |    1 -
 drivers/ide/pdc202xx_new.c                         |    1 -
 drivers/ide/pmac.c                                 |    1 -
 drivers/macintosh/macio_asic.c                     |    1 -
 drivers/misc/cxl/pci.c                             |    1 -
 drivers/net/ethernet/sun/sungem.c                  |    1 -
 drivers/net/ethernet/toshiba/spider_net.c          |    1 -
 drivers/of/of_pci.c                                |    1 -
 drivers/parisc/Kconfig                             |    2 -
 drivers/pci/Kconfig                                |   10 +
 drivers/pci/Makefile                               |    1 +
 drivers/pci/access.c                               |  239 +-
 drivers/pci/bus.c                                  |    7 +-
 drivers/pci/host/Kconfig                           |   46 +-
 drivers/pci/host/Makefile                          |    6 +
 drivers/pci/host/pci-dra7xx.c                      |   11 +-
 drivers/pci/host/pci-exynos.c                      |   13 +-
 drivers/pci/host/pci-host-common.c                 |  194 ++
 drivers/pci/host/pci-host-common.h                 |   47 +
 drivers/pci/host/pci-host-generic.c                |  181 +-
 drivers/pci/host/pci-hyperv.c                      | 2346 ++++++++++++++++++++
 drivers/pci/host/pci-imx6.c                        |  166 +-
 drivers/pci/host/pci-keystone.c                    |   13 +-
 drivers/pci/host/pci-layerscape.c                  |    1 +
 drivers/pci/host/pci-tegra.c                       |   85 +-
 drivers/pci/host/pci-thunder-ecam.c                |  403 ++++
 drivers/pci/host/pci-thunder-pem.c                 |  346 +++
 drivers/pci/host/pcie-altera.c                     |    3 +-
 drivers/pci/host/pcie-designware-plat.c            |  138 ++
 drivers/pci/host/pcie-designware.c                 |   44 +-
 drivers/pci/host/pcie-designware.h                 |    6 +
 drivers/pci/host/pcie-qcom.c                       |   12 +-
 drivers/pci/host/pcie-rcar.c                       |   14 +-
 drivers/pci/host/pcie-spear13xx.c                  |   14 +-
 drivers/pci/host/pcie-xilinx-nwl.c                 |  881 ++++++++
 drivers/pci/host/pcie-xilinx.c                     |  191 +-
 drivers/pci/iov.c                                  |    4 -
 drivers/pci/pci-label.c                            |    2 +-
 drivers/pci/pci-sysfs.c                            |   94 +-
 drivers/pci/pci.c                                  |   40 +-
 drivers/pci/pci.h                                  |   16 +-
 drivers/pci/pcie/Kconfig                           |    7 +-
 drivers/pci/pcie/aer/aer_inject.c                  |   90 +-
 drivers/pci/pcie/pme.c                             |   11 +-
 drivers/pci/probe.c                                |   45 +-
 drivers/pci/quirks.c                               |   46 +-
 drivers/pci/remove.c                               |    5 +-
 drivers/pci/rom.c                                  |   83 +-
 drivers/pci/setup-bus.c                            |    1 -
 drivers/pci/setup-res.c                            |    6 +
 drivers/scsi/mac53c94.c                            |    2 +-
 drivers/scsi/mesh.c                                |    2 +-
 drivers/usb/core/hcd-pci.c                         |    1 -
 drivers/usb/gadget/udc/amd5536udc.c                |    2 +-
 drivers/usb/gadget/udc/goku_udc.c                  |    2 +-
 drivers/usb/gadget/udc/net2280.c                   |    8 +-
 drivers/usb/gadget/udc/pch_udc.c                   |    8 +-
 drivers/video/fbdev/aty/aty128fb.c                 |    1 -
 drivers/video/fbdev/aty/radeon_base.c              |    1 -
 drivers/video/fbdev/imsttfb.c                      |    1 -
 drivers/video/fbdev/matrox/matroxfb_base.h         |    1 -
 drivers/video/fbdev/offb.c                         |    4 -
 drivers/virtio/virtio_pci_common.c                 |    2 +-
 include/asm-generic/pci-bridge.h                   |   74 -
 include/linux/ioport.h                             |    4 +-
 include/{asm-generic => linux}/pci-dma-compat.h    |   29 +
 include/linux/pci.h                                |   79 +-
 include/linux/pci_ids.h                            |    5 +
 sound/pci/intel8x0.c                               |    4 +-
 sound/ppc/pmac.c                                   |    1 -
 134 files changed, 5642 insertions(+), 1145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
 create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c
 create mode 100644 drivers/pci/host/pci-host-common.c
 create mode 100644 drivers/pci/host/pci-host-common.h
 create mode 100644 drivers/pci/host/pci-hyperv.c
 create mode 100644 drivers/pci/host/pci-thunder-ecam.c
 create mode 100644 drivers/pci/host/pci-thunder-pem.c
 create mode 100644 drivers/pci/host/pcie-designware-plat.c
 create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
 delete mode 100644 include/asm-generic/pci-bridge.h
 rename include/{asm-generic => linux}/pci-dma-compat.h (80%)
