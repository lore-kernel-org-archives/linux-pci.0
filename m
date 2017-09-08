Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Sep 2017 11:32:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.14
Message-ID: <20170908163229.GD29570@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - add enhanced Downstream Port Containment support, which prints more
    details about Root Port Programmed I/O errors (Dongdong Liu)

  - add Layerscape ls1088a and ls2088a support (Hou Zhiqiang)

  - add MediaTek MT2712 and MT7622 support (Ryder Lee)

  - add MediaTek MT2712 and MT7622 MSI support (Honghui Zhang)

  - add Qualcom IPQ8074 support (Varadarajan Narayanan)

  - add R-Car r8a7743/5 device tree support (Biju Das)

  - add Rockchip per-lane PHY support for better power management (Shawn
    Lin)

  - fix IRQ mapping for hot-added devices by replacing the pci_fixup_irqs()
    boot-time design with a host bridge hook called at probe-time (Lorenzo
    Pieralisi, Matthew Minter)

  - fix race when enabling two devices that results in upstream bridge not
    being enabled correctly (Srinath Mannam)

  - fix pciehp power fault infinite loop (Keith Busch)

  - fix SHPC bridge MSI hotplug events by enabling bus mastering (Aleksandr
    Bezzubikov)

  - fix a VFIO issue by correcting PCIe capability sizes (Alex Williamson)

  - fix an INTD issue on Xilinx and possibly other drivers by unifying INTx
    IRQ domain support (Paul Burton)

  - avoid IOMMU stalls by marking AMD Stoney GPU ATS as broken (Joerg Roedel)

  - allow APM X-Gene device assignment to guests by adding an ACS quirk
    (Feng Kan)

  - fix driver crashes by disabling Extended Tags on Broadcom HT2100
    (Extended Tags support is required for PCIe Receivers but not
    Requesters, and we now enable them by default when Requesters support
    them) (Sinan Kaya)

  - fix MSIs for devices that use phantom RIDs for DMA by assuming MSIs use
    the real Requester ID (not a phantom RID) (Robin Murphy)

  - prevent assignment of Intel VMD children to guests (which may be
    supported eventually, but isn't yet) by not associating an IOMMU with
    them (Jon Derrick)

  - fix Intel VMD suspend/resume by releasing IRQs on suspend (Scott Bauer)

  - fix a Function-Level Reset issue with Intel 750 NVMe by waiting longer
    (up to 60sec instead of 1sec) for device to become ready (Sinan Kaya)

  - fix a Function-Level Reset issue on iProc Stingray by working around
    hardware defects in the CRS implementation (Oza Pawandeep)

  - fix an issue with Intel NVMe P3700 after an iProc reset by adding a
    delay during shutdown (Oza Pawandeep)

  - fix a Microsoft Hyper-V lockdep issue by polling instead of blocking in
    compose_msi_msg() (Stephen Hemminger)

  - fix a wireless LAN driver timeout by clearing DesignWare MSI interrupt
    status after it is handled, not before (Faiz Abbas)

  - fix DesignWare ATU enable checking (Jisheng Zhang)

  - reduce Layerscape dependencies on the bootloader by doing more
    initialization in the driver (Hou Zhiqiang)

  - improve Intel VMD performance allowing allocation of more IRQ vectors
    than present CPUs (Keith Busch)

  - improve endpoint framework support for initial DMA mask, different BAR
    sizes, configurable page sizes, MSI, test driver, etc (Kishon Vijay
    Abraham I, Stan Drozd)

  - rework CRS support to add periodic messages while we poll during
    enumeration and after Function-Level Reset and prepare for possible
    other uses of CRS (Sinan Kaya)

  - clean up Root Port AER handling by removing unnecessary code and moving
    error handler methods to struct pcie_port_service_driver (Christoph
    Hellwig)

  - clean up error handling paths in various drivers (Bjorn Andersson,
    Fabio Estevam, Gustavo A. R.  Silva, Harunobu Kurokawa, Jeffy Chen, 
    Lorenzo Pieralisi, Sergei Shtylyov)

  - clean up SR-IOV resource handling by disabling VF decoding before
    updating the corresponding resource structs (Gavin Shan)

  - clean up DesignWare-based drivers by unifying quirks to update Class
    Code and Interrupt Pin and related handling of write-protected
    registers (Hou Zhiqiang)

  - clean up by adding empty generic pcibios_align_resource() and
    pcibios_fixup_bus() and removing empty arch-specific implementations
    (Palmer Dabbelt)

  - request exclusive reset control for several drivers to allow cleanup
    elsewhere (Philipp Zabel)

  - constify various structures (Arvind Yadav, Bhumika Goyal)

  - convert from full_name() to %pOF (Rob Herring)

  - remove unused variables from iProc, HiSi, Altera, Keystone (Shawn Lin)


You should see a merge conflict in drivers/pci/probe.c between 62ce94a7a5a5
("PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken") from my
tree and a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if
unsupported"), which was merged via the networking tree.

It's pretty trivial, but my resolution is at
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=v4.14-merge


The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-changes

for you to fetch changes up to cf2d804110d3c20dc6865ade514c44179de34855:

  Merge branch 'pci/virtualization' into next (2017-09-07 13:24:41 -0500)

----------------------------------------------------------------
pci-v4.14-changes

----------------------------------------------------------------
Aleksandr Bezzubikov (1):
      PCI: shpchp: Enable bridge bus mastering if MSI is enabled

Alex Williamson (1):
      PCI: Fix PCIe capability sizes

Arvind Yadav (4):
      PCI: Constify sysfs attribute_group structures
      PCI: Constify label attribute_group structures
      PCI: Constify hotplug attribute_group structures
      PCI: Constify hotplug pci_device_id structures

Bhumika Goyal (4):
      PCI: Constify bin_attribute structures
      PCI: hisi: Constify dw_pcie_host_ops structure
      PCI: kirin: Constify dw_pcie_host_ops structure
      PCI: Constify endpoint pci_epf_type device_type

Biju Das (1):
      PCI: rcar: Add device tree support for r8a7743/5

Bjorn Andersson (3):
      PCI: dwc: designware: Handle ->host_init() failures
      PCI: qcom: Don't unroll init if ->init() fails
      PCI: qcom: Allow ->post_init() to fail

Bjorn Helgaas (49):
      PCI: Inline and remove pcibios_update_irq()
      PCI: dra7xx: Use PCI_NUM_INTX
      PCI: keystone: Remove duplicate MAX_*_IRQS defs
      PCI: keystone: Use PCI_NUM_INTX
      PCI: Always check for non-CRS response before timeout
      PCI/AER: Reformat AER register definitions
      PCI: Fix typos and whitespace errors
      PCI: iproc: Rename PCI_EXP_CAP to IPROC_PCI_EXP_CAP
      PCI: iproc: Clean up whitespace
      PCI: xgene: Define XGENE_PCI_EXP_CAP and use generic PCI_EXP_RTCTL offset
      PCI: xgene: Clean up whitespace
      Merge branch 'pci/irq-intx' into next
      Merge branch 'pci/host-aardvark' into next
      Merge branch 'pci/host-altera' into next
      Merge branch 'pci/host-armada' into next
      Merge branch 'pci/host-artpec6' into next
      Merge branch 'pci/host-designware' into next
      Merge branch 'pci/host-dra7xx' into next
      Merge branch 'pci/host-exynos' into next
      Merge branch 'pci/host-faraday' into next
      Merge branch 'pci/host-hisi' into next
      Merge branch 'pci/host-hv' into next
      Merge branch 'pci/host-imx6' into next
      Merge branch 'pci/host-iproc' into next
      Merge branch 'pci/host-keystone' into next
      Merge branch 'pci/host-kirin' into next
      Merge branch 'pci/host-layerscape' into next
      Merge branch 'pci/host-mediatek' into next
      Merge branch 'pci/host-mvebu' into next
      Merge branch 'pci/host-qcom' into next
      Merge branch 'pci/host-rcar' into next
      Merge branch 'pci/host-rockchip' into next
      Merge branch 'pci/host-spear13xx' into next
      Merge branch 'pci/host-tegra' into next
      Merge branch 'pci/host-vmd' into next
      Merge branch 'pci/host-xgene' into next
      Merge branch 'pci/host-xilinx' into next
      Merge branch 'pci/endpoint' into next
      Merge branch 'pci/aer' into next
      Merge branch 'pci/dpc' into next
      Merge branch 'pci/enumeration' into next
      Merge branch 'pci/hotplug' into next
      Merge branch 'pci/irq-fixups' into next
      Merge branch 'pci/misc' into next
      Merge branch 'pci/msi' into next
      Merge branch 'pci/pm' into next
      Merge branch 'pci/resource' into next
      Merge branch 'pci/trivial' into next
      Merge branch 'pci/virtualization' into next

Carlos Palminha (1):
      PCI: dwc: designware: Make dw_pcie_prog_*_atu_unroll() static

Christoph Hellwig (1):
      PCI/portdrv: Move error handler methods to struct pcie_port_service_driver

Dongdong Liu (2):
      PCI/DPC: Add eDPC support
      PCI/DPC: Add local struct device pointers

Fabio Estevam (13):
      PCI: mvebu: Remove unneeded gpiod NULL check
      PCI: armada8k: Check the return value from clk_prepare_enable()
      PCI: qcom: Use gpiod_set_value_cansleep() to allow reset via expanders
      PCI: rockchip: Use gpiod_set_value_cansleep() to allow reset via expanders
      PCI: exynos: Fix platform_get_irq() error handling
      PCI: dra7xx: Fix platform_get_irq() error handling
      PCI: armada8k: Fix platform_get_irq() error handling
      PCI: artpec6: Fix platform_get_irq() error handling
      PCI: spear13xx: Fix platform_get_irq() error handling
      PCI: altera: Fix platform_get_irq() error handling
      PCI: rockchip: Fix platform_get_irq() error handling
      PCI: xilinx-nwl: Fix platform_get_irq() error handling
      PCI: xgene: Fix platform_get_irq() error handling

Faiz Abbas (1):
      PCI: dwc: Clear MSI interrupt status after it is handled, not before

Feng Kan (1):
      PCI: Add ACS quirk for APM X-Gene devices

Gavin Shan (1):
      PCI: Disable VF decoding before pcibios_sriov_disable() updates resources

Gustavo A. R. Silva (1):
      PCI: dra7xx: Propagate platform_get_irq() errors in dra7xx_pcie_probe()

Harunobu Kurokawa (1):
      PCI: rcar: Fix memory leak when no PCIe card is inserted

Honghui Zhang (5):
      PCI: mediatek: Rename port->index and mtk_pcie_parse_ports()
      PCI: mediatek: Add a structure to abstract the controller generations
      PCI: mediatek: Use bus->sysdata to get host private data
      PCI: mediatek: Add MSI support for MT2712 and MT7622
      PCI: mediatek: Use PCI_NUM_INTX

Hou Zhiqiang (12):
      PCI: layerscape: Call dw_pcie_setup_rc() from ls_pcie_host_init()
      PCI: layerscape: Move STRFMR1 access out from the DBI write-enable bracket
      PCI: layerscape: Add class code and multifunction fixups for ls1021a
      PCI: layerscape: Move generic init functions earlier in file
      PCI: layerscape: Refactor ls1021_pcie_host_init()
      PCI: layerscape: Disable outbound windows configured by bootloader
      PCI: dwc: Add accessors for write permission of DBI read-only registers
      PCI: dwc: Enable write permission for Class Code, Interrupt Pin updates
      PCI: layerscape: Remove unnecessary class code fixup
      PCI: artpec6: Stop enabling writes to DBI read-only registers
      PCI: layerscape: Add support for ls2088a
      PCI: layerscape: Add support for ls1088a

Jeffy Chen (3):
      PCI: rockchip: Disable vpcie0v9 if resume_noirq fails
      PCI: rockchip: Remove IRQ domain if probe fails
      PCI: rockchip: Umap IO space if probe fails

Jisheng Zhang (1):
      PCI: dwc: designware: Test PCIE_ATU_ENABLE bit specifically

Joerg Roedel (1):
      PCI: Mark AMD Stoney GPU ATS as broken

Jon Derrick (4):
      MAINTAINERS: Add Jonathan Derrick as VMD maintainer
      x86/PCI: Move VMD quirk to x86 fixups
      x86/PCI: Use is_vmd() rather than relying on the domain number
      iommu/vt-d: Prevent VMD child devices from being remapping targets

Keith Busch (4):
      PCI: vmd: Reserve IRQ pre-vector for better affinity
      PCI: vmd: Assign vector zero to all bridges
      PCI: pciehp: Report power fault only once until we clear it
      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs

Kishon Vijay Abraham I (16):
      PCI: endpoint: Use of_dma_configure() to set initial DMA mask
      PCI: endpoint: Add an API to get matching "pci_epf_device_id"
      PCI: endpoint: Make ->remove() callback optional
      PCI: endpoint: Add support for configurable page size
      PCI: endpoint: Add "volatile" to pci_epf_test_reg
      PCI: endpoint: Do not reset *command* inadvertently
      PCI: endpoint: Add support to use _any_ BAR to map PCI_ENDPOINT_TEST regs
      PCI: endpoint: Add support to poll early for host commands
      PCI: dwc: designware: Provide page_size to pci_epc_mem
      PCI: dra7xx: Reset all BARs during initialization
      PCI: designware-ep: Do not disable BARs during initialization
      misc: pci_endpoint_test: Add support for PCI_ENDPOINT_TEST regs to be mapped to any BAR
      misc: pci_endpoint_test: Add support to provide aligned buffer addresses
      misc: pci_endpoint_test: Add support to not enable MSI interrupts
      misc: pci_endpoint_test: Avoid using hard-coded BAR sizes
      misc: pci_endpoint_test: Enable/Disable MSI using module param

Lorenzo Pieralisi (10):
      MIPS: PCI: Fix pcibios_scan_bus() NULL check code path
      sh/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      alpha/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      m68k/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      MIPS: PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      tile/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      unicore32/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      sparc/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks
      microblaze/PCI: Remove pcibios_setup_bus_{self/devices} dead code
      PCI: rcar: Fix error exit path

Matthew Minter (2):
      sh/PCI: Remove __init optimisations from IRQ mapping functions/data
      PCI: Remove unused pci_fixup_irqs() function

Oza Pawandeep (3):
      PCI: iproc: Factor out memory-mapped config access address calculation
      PCI: iproc: Work around Stingray CRS defects
      PCI: iproc: Add 500ms delay during device shutdown

Palmer Dabbelt (3):
      PCI: Add a generic weak pcibios_fixup_bus()
      PCI: Add a generic weak pcibios_align_resource()
      ARC: Remove empty kernel/pcibios.c

Paul Burton (11):
      PCI: Move enum pci_interrupt_pin to linux/pci.h
      PCI: Add pci_irqd_intx_xlate()
      PCI: aardvark: Use PCI_NUM_INTX
      PCI: altera: Use size=4 IRQ domain for legacy INTx
      PCI: faraday: Use PCI_NUM_INTX
      PCI: xilinx: Translate INTx range to hwirqs 0-3
      PCI: xilinx-nwl: Translate INTx range to hwirqs 0-3
      PCI: xilinx: Unify INTx & MSI interrupt decode
      PCI: xilinx: Don't enable config completion interrupts
      PCI: xilinx: Allow build on MIPS platforms
      PCI: rockchip: Use PCI_NUM_INTX

Philipp Zabel (5):
      PCI: imx6: Explicitly request exclusive reset control
      PCI: tegra: Explicitly request exclusive reset control
      PCI: qcom: Explicitly request exclusive reset control
      PCI: rockchip: Explicitly request exclusive reset control
      PCI: mediatek: Explicitly request exclusive reset control

Piotr Gregor (1):
      PCI/PM: Expand description of pci_set_power_state()

Rob Herring (1):
      PCI: Convert to using %pOF instead of full_name()

Robin Murphy (1):
      PCI/MSI: Assume MSIs use real Requester ID, not an alias

Ryder Lee (6):
      PCI: mediatek: Use readl_poll_timeout() to wait for Gen2 training
      PCI: mediatek: Switch to use platform_get_resource_byname()
      dt-bindings: PCI: Rename MediaTek binding
      dt-bindings: PCI: Cleanup MediaTek binding text
      PCI: mediatek: Add controller support for MT2712 and MT7622
      dt-bindings: PCI: Add support for MT2712 and MT7622

Scott Bauer (1):
      PCI: vmd: Free up IRQs on suspend path

Sergei Shtylyov (1):
      PCI: faraday: Fix of_irq_get() error check

Shawn Lin (21):
      PCI: iproc: Remove unused struct iproc_pcie *pcie
      PCI: hisi: Remove unused variable driver
      PCI: altera: Remove unused num_of_vectors variable
      PCI: keystone-dw: Remove unused ks_pcie, pci variables
      dt-bindings: PCI: rockchip: Add vpcie12v-supply for Rockchip PCIe controller
      PCI: rockchip: Control optional 12v power supply
      PCI: rockchip: Factor out rockchip_pcie_get_phys()
      PCI: rockchip: Add per-lane PHY support
      phy: rockchip-pcie: Reconstruct driver to support per-lane PHYs
      PCI: rockchip: Idle inactive PHY(s)
      arm64: dts: rockchip: convert PCIe to use per-lane PHYs for rk3339
      dt-bindings: PCI: rockchip: Convert to per-lane PHY model
      dt-bindings: phy-rockchip-pcie: Convert to per-lane PHY model
      PCI: rockchip: Factor out rockchip_pcie_setup_irq()
      PCI: rockchip: Factor out rockchip_pcie_enable_clocks()
      PCI: rockchip: Factor out rockchip_pcie_disable_clocks()
      PCI: rockchip: Factor out rockchip_pcie_deinit_phys()
      PCI: rockchip: Clean up PHY if driver probe or resume fails
      PCI: endpoint: Remove the ->remove() callback
      PCI: Correct kernel-doc of pci_vpd_srdt_size(), pci_vpd_srdt_tag()
      PCI: Remove unused "res" variable from pci_resource_io()

Sinan Kaya (5):
      PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
      PCI: Add pci_bus_crs_vendor_id() to detect CRS response data
      PCI: Factor out pci_bus_wait_crs()
      PCI: Wait up to 60 seconds for device to become ready after FLR
      PCI: Warn periodically while waiting for non-CRS ("device ready") status

Srinath Mannam (1):
      PCI: Avoid race while enabling upstream bridges

Stan Drozd (1):
      tools: PCI: Add a missing option help line

Stephen Hemminger (1):
      PCI: hv: Do not sleep in compose_msi_msg()

Varadarajan Narayanan (3):
      PCI: qcom: Use block IP version for operations
      dt-bindings: PCI: qcom: Add support for IPQ8074
      PCI: qcom: Add support for IPQ8074 PCIe controller

 CREDITS                                            |   2 +-
 .../devicetree/bindings/pci/83xx-512x-pci.txt      |   6 +-
 .../devicetree/bindings/pci/altera-pcie.txt        |  18 +-
 .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   2 +-
 .../devicetree/bindings/pci/designware-pcie.txt    |  24 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   2 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |   4 +-
 .../devicetree/bindings/pci/kirin-pcie.txt         |   8 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |   4 +-
 .../bindings/pci/mediatek,mt7623-pcie.txt          | 130 ----
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 284 ++++++++
 .../devicetree/bindings/pci/mvebu-pci.txt          |   2 +-
 .../devicetree/bindings/pci/pci-armada8k.txt       |   2 +-
 .../devicetree/bindings/pci/pci-keystone.txt       |  15 +-
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   7 +-
 .../devicetree/bindings/pci/qcom,pcie.txt          |  27 +-
 .../devicetree/bindings/pci/ralink,rt3883-pci.txt  |   2 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   7 +-
 .../devicetree/bindings/pci/rockchip-pcie.txt      |  28 +-
 .../bindings/pci/samsung,exynos5440-pcie.txt       |  22 +-
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |   6 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   8 +-
 .../devicetree/bindings/pci/versatile.txt          |   2 +-
 .../devicetree/bindings/pci/xgene-pci-msi.txt      |   5 +-
 .../devicetree/bindings/pci/xgene-pci.txt          |   8 +-
 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   7 +-
 .../devicetree/bindings/phy/rockchip-pcie-phy.txt  |   7 +-
 MAINTAINERS                                        |   3 +-
 arch/alpha/kernel/pci.c                            |  27 +-
 arch/alpha/kernel/sys_nautilus.c                   |  31 +-
 arch/arc/kernel/Makefile                           |   1 -
 arch/arc/kernel/pcibios.c                          |  22 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   8 +-
 arch/arm64/kernel/pci.c                            |  17 -
 arch/cris/arch-v32/drivers/pci/bios.c              |   4 -
 arch/ia64/pci/pci.c                                |   7 -
 arch/m68k/coldfire/pci.c                           |  36 +-
 arch/microblaze/include/asm/pci.h                  |   3 -
 arch/microblaze/pci/pci-common.c                   | 145 ----
 arch/mips/pci/pci-legacy.c                         |  30 +-
 arch/s390/pci/pci.c                                |   4 -
 arch/sh/drivers/pci/fixups-cayman.c                |   2 +-
 arch/sh/drivers/pci/fixups-dreamcast.c             |   2 +-
 arch/sh/drivers/pci/fixups-r7780rp.c               |   2 +-
 arch/sh/drivers/pci/fixups-rts7751r2d.c            |   6 +-
 arch/sh/drivers/pci/fixups-sdk7780.c               |   4 +-
 arch/sh/drivers/pci/fixups-se7751.c                |   2 +-
 arch/sh/drivers/pci/fixups-sh03.c                  |   2 +-
 arch/sh/drivers/pci/fixups-snapgear.c              |   2 +-
 arch/sh/drivers/pci/fixups-titan.c                 |   4 +-
 arch/sh/drivers/pci/pci.c                          |  49 +-
 arch/sh/drivers/pci/pcie-sh7786.c                  |   2 +-
 arch/sparc/kernel/leon_pci.c                       |  30 +-
 arch/sparc/kernel/pci.c                            |  10 -
 arch/sparc/kernel/pcic.c                           |   6 -
 arch/tile/kernel/pci.c                             |  39 +-
 arch/tile/kernel/pci_gx.c                          |  35 +-
 arch/unicore32/kernel/pci.c                        |  35 +-
 arch/x86/pci/fixup.c                               |  17 +
 drivers/iommu/intel-iommu.c                        |   7 +
 drivers/misc/pci_endpoint_test.c                   | 132 +++-
 drivers/pci/dwc/Kconfig                            |  12 +-
 drivers/pci/dwc/pci-dra7xx.c                       |  26 +-
 drivers/pci/dwc/pci-exynos.c                       |  12 +-
 drivers/pci/dwc/pci-imx6.c                         |  11 +-
 drivers/pci/dwc/pci-keystone-dw.c                  |  14 +-
 drivers/pci/dwc/pci-keystone.c                     |  10 +-
 drivers/pci/dwc/pci-keystone.h                     |   4 +-
 drivers/pci/dwc/pci-layerscape.c                   | 102 +--
 drivers/pci/dwc/pcie-armada8k.c                    |  12 +-
 drivers/pci/dwc/pcie-artpec6.c                     |  14 +-
 drivers/pci/dwc/pcie-designware-ep.c               |   9 +-
 drivers/pci/dwc/pcie-designware-host.c             |  17 +-
 drivers/pci/dwc/pcie-designware-plat.c             |   4 +-
 drivers/pci/dwc/pcie-designware.c                  |  14 +-
 drivers/pci/dwc/pcie-designware.h                  |  30 +-
 drivers/pci/dwc/pcie-hisi.c                        |   5 +-
 drivers/pci/dwc/pcie-kirin.c                       |   6 +-
 drivers/pci/dwc/pcie-qcom.c                        | 409 ++++++++---
 drivers/pci/dwc/pcie-spear13xx.c                   |   8 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  99 ++-
 drivers/pci/endpoint/pci-epc-core.c                |  11 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |  59 +-
 drivers/pci/endpoint/pci-epf-core.c                |  25 +-
 drivers/pci/host/Kconfig                           |   7 +-
 drivers/pci/host/pci-aardvark.c                    |   5 +-
 drivers/pci/host/pci-ftpci100.c                    |   6 +-
 drivers/pci/host/pci-hyperv.c                      |   8 +-
 drivers/pci/host/pci-mvebu.c                       |  11 +-
 drivers/pci/host/pci-tegra.c                       |   9 +-
 drivers/pci/host/pci-xgene-msi.c                   |   2 +-
 drivers/pci/host/pci-xgene.c                       |  41 +-
 drivers/pci/host/pcie-altera-msi.c                 |   6 +-
 drivers/pci/host/pcie-altera.c                     |  13 +-
 drivers/pci/host/pcie-iproc-msi.c                  |   2 -
 drivers/pci/host/pcie-iproc-platform.c             |   8 +
 drivers/pci/host/pcie-iproc.c                      | 400 +++++++----
 drivers/pci/host/pcie-iproc.h                      |   1 +
 drivers/pci/host/pcie-mediatek.c                   | 756 +++++++++++++++++++--
 drivers/pci/host/pcie-rcar.c                       |  12 +-
 drivers/pci/host/pcie-rockchip.c                   | 426 ++++++++----
 drivers/pci/host/pcie-xilinx-nwl.c                 |  11 +-
 drivers/pci/host/pcie-xilinx.c                     |  62 +-
 drivers/pci/host/vmd.c                             |  19 +-
 drivers/pci/hotplug/cpcihp_zt5550.c                |   2 +-
 drivers/pci/hotplug/cpqphp_core.c                  |   2 +-
 drivers/pci/hotplug/ibmphp_core.c                  |   2 +-
 drivers/pci/hotplug/ibmphp_ebda.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   8 +
 drivers/pci/hotplug/pnv_php.c                      |   4 +-
 drivers/pci/hotplug/rpadlpar_core.c                |   4 +-
 drivers/pci/hotplug/rpadlpar_sysfs.c               |   2 +-
 drivers/pci/hotplug/rpaphp_core.c                  |   2 +-
 drivers/pci/hotplug/rpaphp_pci.c                   |   4 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |   4 +-
 drivers/pci/hotplug/shpchp_core.c                  |   2 +-
 drivers/pci/hotplug/shpchp_hpc.c                   |   2 +
 drivers/pci/iov.c                                  |   7 +-
 drivers/pci/msi.c                                  |  27 +-
 drivers/pci/pci-label.c                            |   4 +-
 drivers/pci/pci-sysfs.c                            |  21 +-
 drivers/pci/pci.c                                  |  71 +-
 drivers/pci/pci.h                                  |   1 +
 drivers/pci/pcie/aer/aerdrv.c                      |  25 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   4 +-
 drivers/pci/pcie/pcie-dpc.c                        | 187 ++++-
 drivers/pci/pcie/portdrv_pci.c                     | 105 +--
 drivers/pci/probe.c                                | 121 +++-
 drivers/pci/quirks.c                               |  64 +-
 drivers/pci/setup-irq.c                            |  32 +-
 drivers/pci/setup-res.c                            |  13 +
 drivers/phy/rockchip/phy-rockchip-pcie.c           | 131 +++-
 include/linux/aer.h                                |   5 +-
 include/linux/pci-epc.h                            |   8 +-
 include/linux/pci-epf.h                            |  11 +-
 include/linux/pci.h                                |  62 +-
 include/linux/pcieport_if.h                        |   6 +-
 include/uapi/linux/pci_regs.h                      |  42 +-
 tools/pci/pcitest.c                                |   1 +
 139 files changed, 3434 insertions(+), 1637 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 delete mode 100644 arch/arc/kernel/pcibios.c
