Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Jun 2018 13:38:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v4.18
Message-ID: <20180607183859.GA37077@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - unify AER decoding for native and ACPI CPER sources (Alexandru Gagniuc)

  - add TLP header info to AER tracepoint (Thomas Tai)

  - add generic pcie_wait_for_link() interface (Oza Pawandeep)

  - handle AER ERR_FATAL by removing and re-enumerating devices, as
    Downstream Port Containment does (Oza Pawandeep)

  - factor out common code between AER and DPC recovery (Oza Pawandeep)

  - stop triggering DPC for ERR_NONFATAL errors (Oza Pawandeep)

  - share ERR_FATAL recovery path between AER and DPC (Oza Pawandeep)

  - disable ASPM L1.2 substate if we don't have LTR (Bjorn Helgaas)

  - respect platform ownership of LTR (Bjorn Helgaas)

  - clear interrupt status in top half to avoid interrupt storm (Oza
    Pawandeep)

  - neaten pci=earlydump output (Andy Shevchenko)

  - avoid errors when extended config space inaccessible (Gilles Buloz)

  - prevent sysfs disable of device while driver attached (Christoph
    Hellwig)

  - use core interface to report PCIe link properties in bnx2x, bnxt_en,
    cxgb4, ixgbe (Bjorn Helgaas)

  - remove unused pcie_get_minimum_link() (Bjorn Helgaas)

  - fix use-before-set error in ibmphp (Dan Carpenter)

  - fix pciehp timeouts caused by Command Completed errata (Bjorn Helgaas)

  - fix refcounting in pnv_php hotplug (Julia Lawall)

  - clear pciehp Presence Detect and Data Link Layer Status Changed on
    resume so we don't miss hotplug events (Mika Westerberg)

  - only request pciehp control if we support it, so platform can use ACPI
    hotplug otherwise (Mika Westerberg)

  - convert SHPC to be builtin only (Mika Westerberg)

  - request SHPC control via _OSC if we support it (Mika Westerberg)

  - simplify SHPC handoff from firmware (Mika Westerberg)

  - fix an SHPC quirk that mistakenly included *all* AMD bridges as well as
    devices from any vendor with device ID 0x7458 (Bjorn Helgaas)

  - assign a bus number even to non-native hotplug bridges to leave space
    for acpiphp additions, to fix a common Thunderbolt xHCI hot-add failure
    (Mika Westerberg)

  - keep acpiphp from scanning native hotplug bridges, to fix common
    Thunderbolt hot-add failures (Mika Westerberg)

  - improve "partially hidden behind bridge" messages from core (Mika
    Westerberg)

  - add macros for PCIe Link Control 2 register (Frederick Lawler)

  - replace IB/hfi1 custom macros with PCI core versions (Frederick Lawler)

  - remove dead microblaze and xtensa code (Bjorn Helgaas)

  - use dev_printk() when possible in xtensa and mips (Bjorn Helgaas)

  - remove unused pcie_port_acpi_setup() and portdrv_acpi.c (Bjorn Helgaas)

  - add managed interface to get PCI host bridge resources from OF (Jan
    Kiszka)

  - add support for unbinding generic PCI host controller (Jan Kiszka)

  - fix memory leaks when unbinding generic PCI host controller (Jan Kiszka)

  - request legacy VGA framebuffer only for VGA devices to avoid false
    device conflicts (Bjorn Helgaas)

  - turn on PCI_COMMAND_IO & PCI_COMMAND_MEMORY in pci_enable_device() like
    everybody else, not in pcibios_fixup_bus() (Bjorn Helgaas)

  - add generic enable function for simple SR-IOV hardware (Alexander
    Duyck)

  - use generic SR-IOV enable for ena, nvme (Alexander Duyck)

  - add ACS quirk for Intel 7th & 8th Gen mobile (Alex Williamson)

  - add ACS quirk for Intel 300 series (Mika Westerberg)

  - enable register clock for Armada 7K/8K (Gregory CLEMENT)

  - reduce Keystone "link already up" log level (Fabio Estevam)

  - move private DT functions to drivers/pci/ (Rob Herring)

  - factor out dwc CONFIG_PCI Kconfig dependencies (Rob Herring)

  - add DesignWare support to the endpoint test driver (Gustavo Pimentel)

  - add DesignWare support for endpoint mode (Gustavo Pimentel)

  - use devm_ioremap_resource() instead of devm_ioremap() in dra7xx and
    artpec6 (Gustavo Pimentel)

  - fix Qualcomm bitwise NOT issue (Dan Carpenter)

  - add Qualcomm runtime PM support (Srinivas Kandagatla)

  - fix DesignWare enumeration below bridges (Koen Vandeputte)

  - use usleep() instead of mdelay() in endpoint test (Jia-Ju Bai)

  - add configfs entries for pci_epf_driver device IDs (Kishon Vijay
    Abraham I)

  - clean up pci_endpoint_test driver (Gustavo Pimentel)

  - update Layerscape maintainer email addresses (Minghuan Lian)

  - add COMPILE_TEST to improve build test coverage (Rob Herring)

  - fix Hyper-V bus registration failure caused by domain/serial number
    confusion (Sridhar Pitchai)

  - improve Hyper-V refcounting and coding style (Stephen Hemminger)

  - avoid potential Hyper-V hang waiting for a response that will never
    come (Dexuan Cui)

  - implement Mediatek chained IRQ handling (Honghui Zhang)

  - fix vendor ID & class type for Mediatek MT7622 (Honghui Zhang)

  - add Mobiveil PCIe host controller driver (Subrahmanya Lingappa)

  - add Mobiveil MSI support (Subrahmanya Lingappa)

  - clean up clocks, MSI, IRQ mappings in R-Car probe failure paths (Marek
    Vasut)

  - poll more frequently (5us vs 5ms) while waiting for R-Car data link
    active (Marek Vasut)

  - use generic OF parsing interface in R-Car (Vladimir Zapolskiy)

  - add R-Car V3H (R8A77980) "compatible" string (Sergei Shtylyov)

  - add R-Car gen3 PHY support (Sergei Shtylyov)

  - improve R-Car PHYRDY polling (Sergei Shtylyov)

  - clean up R-Car macros (Marek Vasut)

  - use runtime PM for R-Car controller clock (Dien Pham)

  - update arm64 defconfig for Rockchip (Shawn Lin)

  - refactor Rockchip code to facilitate both root port and endpoint mode
    (Shawn Lin)

  - add Rockchip endpoint mode driver (Shawn Lin)

  - support VMD "membar shadow" feature (Jon Derrick)

  - support VMD bus number offsets (Jon Derrick)

  - add VMD "no AER source ID" quirk for more device IDs (Jon Derrick)

  - remove unnecessary host controller CONFIG_PCIEPORTBUS Kconfig
    selections (Bjorn Helgaas)

  - clean up quirks.c organization and whitespace (Bjorn Helgaas)


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-changes

for you to fetch changes up to 488ad6d3678beee65bcd74e6a9764bd7cee9d3d3:

  Merge branch 'pci/trivial' (2018-06-06 16:10:51 -0500)


You should see a minor merge conflict in arch/microblaze/include/asm/pci.h
between Christoph's 325ef1857fff ("PCI: remove PCI_DMA_BUS_IS_PHYS") and
these commits from my tree:

  069967f4e2a0 ("microblaze/PCI: Remove pcibios_finish_adding_to_bus() dead
code")
  59f2d3d3e600 ("microblaze/PCI: Remove pcibios_claim_one_bus() dead code")

I plan a second pull request for v4.18 to do some tree reorg and
possibly some consolidation of AER and portdrv files.

----------------------------------------------------------------
pci-v4.18-changes

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Add ACS quirk for Intel 7th & 8th Gen mobile

Alexander Duyck (4):
      PCI/IOV: Add pci_sriov_configure_simple()
      PCI/IOV: Add pci-pf-stub driver for PFs that only enable VFs
      net: ena: Use pci_sriov_configure_simple() to enable VFs
      nvme-pci: Use pci_sriov_configure_simple() to enable VFs

Alexandru Gagniuc (1):
      PCI/AER: Unify error bit printing for native and CPER reporting

Andy Shevchenko (1):
      x86/PCI: Make pci=earlydump output neat

Arnd Bergmann (1):
      PCI: qcom: Include gpio/consumer.h

Bjorn Helgaas (50):
      sparc/PCI: Request legacy VGA framebuffer only for VGA devices
      PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR
      PCI/ACPI: Request LTR control from platform before using it
      PCI/portdrv: Remove unused pcie_port_acpi_setup()
      PCI: Add Qualcomm vendor ID
      PCI: pciehp: Add quirk for Command Completed errata
      PCI: Reorder quirks infrastructure code
      PCI: Clean up whitespace in quirks.c
      PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS
      sparc32/PCI/LEON: Converge device enable path
      sparc32/PCI/PCIC: Converge device enable path
      sparc/PCI: Use dev_printk() when possible
      microblaze/PCI: Remove pcibios_finish_adding_to_bus() dead code
      microblaze/PCI: Remove pcibios_claim_one_bus() dead code
      xtensa/PCI: Remove dead code
      xtensa/PCI: Make variables static
      xtensa/PCI: Use dev_printk() when possible
      MIPS: PCI: Use dev_printk() when possible
      bnx2x: Report PCIe link properties with pcie_print_link_status()
      bnxt_en: Report PCIe link properties with pcie_print_link_status()
      cxgb4: Report PCIe link properties with pcie_print_link_status()
      ixgbe: Report PCIe link properties with pcie_print_link_status()
      PCI: Remove unused pcie_get_minimum_link()
      PCI: shpchp: Use dev_printk() for OSHP-related messages
      PCI/AER: Decode Error Source Requester ID
      PCI: shpchp: Fix AMD POGO identification
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/resource'
      Merge branch 'pci/sparc'
      Merge branch 'pci/virtualization'
      Merge branch 'lorenzo/pci/armada8k'
      Merge branch 'lorenzo/pci/dwc'
      Merge branch 'lorenzo/pci/dwc-fixes'
      Merge branch 'lorenzo/pci/endpoint'
      Merge branch 'lorenzo/pci/host/misc'
      Merge branch 'lorenzo/pci/hv'
      Merge branch 'lorenzo/pci/mediatek'
      Merge branch 'pci/host/mobiveil'
      Merge branch 'pci/host/qcom'
      Merge branch 'lorenzo/pci/rcar'
      Merge branch 'lorenzo/pci/rockchip'
      Merge branch 'lorenzo/pci/vmd'
      Merge branch 'pci/kconfig'
      Merge branch 'pci/trivial'

Borislav Petkov (1):
      PCI/AER: Remove aer_recover_work_func() forward declaration

Christoph Hellwig (1):
      PCI: Prevent sysfs disable of device while driver is attached

Dan Carpenter (2):
      PCI: ibmphp: Fix use-before-set in get_max_bus_speed()
      PCI: qcom: Fix a bitwise vs logical NOT typo

Dexuan Cui (1):
      PCI: hv: Do not wait forever on a device that has disappeared

Dien Pham (1):
      PCI: rcar: Use runtime PM to control controller clock

Fabio Estevam (2):
      PCI: keystone: Do not treat link up message as error
      PCI: imx6: Remove space before tabs

Frederick Lawler (2):
      PCI: Add PCI_EXP_LNKCTL2_TLS* macros
      IB/hfi1: Replace custom hfi1 macros with PCIe macros

Gil Kupfer (1):
      PCI: Add "pci=noats" boot parameter

Gilles Buloz (1):
      PCI: Check whether bridges allow access to extended config space

Gregory CLEMENT (2):
      PCI: armada8k: Remove useless test before clk_disable_unprepare()
      PCI: armada8k: Fix clock resource by adding a register clock

Gustavo Pimentel (13):
      PCI: dwc: Define maximum number of vectors
      PCI: dwc: Replace lower into upper case characters
      PCI: dwc: Small computation improvement
      PCI: dwc: Replace magic number by defines
      misc: pci_endpoint_test: Replace lower into upper case characters
      PCI: endpoint: functions/pci-epf-test: Replace lower into upper case characters
      dt-bindings: PCI: designware: Example update
      PCI: dwc: Add support for EP mode
      dt-bindings: PCI: designware: Add support for EP in DesignWare driver
      misc: pci_endpoint_test: Add DesignWare EP entry
      misc: pci_endpoint_test: Use pci_irq_vector function
      PCI: dwc: artpec6: Use devm_ioremap_resource() instead of devm_ioremap()
      PCI: dwc: dra7xx: Use devm_ioremap_resource() instead of devm_ioremap()

Honghui Zhang (2):
      PCI: mediatek: Set up vendor ID and class type for MT7622
      PCI: mediatek: Implement chained IRQ handling setup

Jakub Kicinski (1):
      PCI/IOV: Allow PF drivers to limit total_VFs to 0

Jan Kiszka (8):
      PCI: Make pci_get_new_domain_nr() static
      PCI: Fix devm_pci_alloc_host_bridge() memory leak
      PCI: Rename of_pci_get_host_bridge_resources() device node parameter
      PCI: Pass struct device to of_pci_get_host_bridge_resources()
      PCI: Use dev_printk() in of_pci_get_host_bridge_resources()
      PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()
      PCI: Add support for unbinding the generic PCI host controller
      PCI: Enable PCI_DOMAINS along with generic PCI host controller

Jia-Ju Bai (1):
      PCI: endpoint: Replace mdelay with usleep_range() in pci_epf_test_write()

Jon Derrick (5):
      PCI: Add Intel VMD devices to pci ids
      PCI: vmd: Assign membar addresses from shadow registers
      PCI: vmd: Add offset to bus numbers if necessary
      x86/PCI: Add additional VMD device root ports to VMD AER quirk
      PCI: vmd: Add an additional VMD device id to driver device id table

Julia Lawall (1):
      PCI: pnv_php: Add missing of_node_put()

Keith Busch (2):
      PCI/AER: Remove unused parameters
      PCI/AER: Replace struct pcie_device with pci_dev

Kishon Vijay Abraham I (1):
      PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry

Koen Vandeputte (1):
      PCI: dwc: Fix enumeration end when reaching root subordinate

Marek Vasut (6):
      PCI: rcar: Clean up the macros
      PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
      PCI: rcar: Pull bus clock enable/disable from rcar_pcie_get_resources()
      PCI: rcar: Add missing irq_dispose_mapping() into failpath
      PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
      PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi() failpath

Mika Westerberg (19):
      PCI: Add ACS quirk for Intel 300 series
      PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
      PCI: pciehp: Request control of native hotplug only if supported
      PCI: pciehp: Rename host->native_hotplug to host->native_pcie_hotplug
      PCI: pciehp: Make pciehp_is_native() stricter
      PCI: shpchp: Convert SHPC to be builtin only
      PCI: shpchp: Request SHPC control via _OSC when adding host bridge
      PCI: shpchp: Rely on previous _OSC results
      PCI: shpchp: Remove acpi_get_hp_hw_control_from_firmware() flags
      PCI: shpchp: Remove get_hp_hw_control_from_firmware() wrapper
      PCI: shpchp: Add shpchp_is_native()
      PCI: hotplug: Add hotplug_is_native()
      ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
      ACPI / hotplug / PCI: Mark stale PCI devices disconnected
      ACPI / hotplug / PCI: Drop unnecessary parentheses
      PCI: Account for all bridges on bus when distributing bus numbers
      PCI: Move resource distribution for single bridge outside loop
      PCI: Improve pci_scan_bridge() and pci_scan_bridge_extend() doc
      PCI: Improve "partially hidden behind bridge" log message

Minghuan Lian (1):
      MAINTAINERS: Update Layerscape PCIe driver maintainers list

Oza Pawandeep (10):
      PCI/DPC: Clear interrupt status in interrupt handler top half
      PCI: Add generic pcie_wait_for_link() interface
      PCI/AER: Handle ERR_FATAL with removal and re-enumeration of devices
      PCI/AER: Rename error recovery interfaces to generic PCI naming
      PCI/AER: Factor out error reporting to drivers/pci/pcie/err.c
      PCI/portdrv: Add generic pcie_port_find_service()
      PCI/portdrv: Add generic pcie_port_find_device()
      PCI/DPC: Disable ERR_NONFATAL handling by DPC
      PCI/AER: Pass service type to pcie_do_fatal_recovery()
      PCI/DPC: Use the generic pcie_do_fatal_recovery() path

Rob Herring (3):
      PCI: Improve host drivers compile test coverage
      PCI: dwc: Move CONFIG_PCI depends to menu
      PCI: Move private DT related functions into private header

Sergei Shtylyov (5):
      PCI: rcar: Poll PHYRDY in rcar_pcie_hw_init()
      PCI: rcar: Remove PHYRDY polling from rcar_pcie_hw_init_h1()
      PCI: rcar: Add R-Car gen3 PHY support
      PCI: rcar: Factor out rcar_pcie_hw_init() call
      DT: pci: rcar-pci: document R8A77980 bindings

Shawn Lin (7):
      PCI: rockchip: Separate common code from RC driver
      PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT
      PCI: rockchip: Split out common function to init controller
      dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to rockchip-pcie-host.txt
      PCI: rockchip: Add EP driver for Rockchip PCIe controller
      dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe EP driver
      arm64: defconfig: update config for Rockchip PCIe

Sridhar Pitchai (1):
      PCI: hv: Make sure the bus domain is really unique

Srinivas Kandagatla (1):
      PCI: qcom: add runtime pm support to pcie_port

Stephen Hemminger (3):
      PCI: hv: Remove unused reason for refcount handler
      PCI: hv: Convert remove_lock to refcount
      PCI: hv: Use list_for_each_entry()

Subrahmanya Lingappa (3):
      PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver DT bindings
      PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver
      PCI: mobiveil: Add MSI support

Thomas Tai (1):
      PCI/AER: Add TLP header information to tracepoint

Vladimir Zapolskiy (1):
      PCI: rcar: Reuse generic pci_parse_request_of_pci_ranges() function

 Documentation/PCI/pci-error-recovery.txt           |   35 +-
 Documentation/admin-guide/kernel-parameters.txt    |    2 +
 .../devicetree/bindings/pci/designware-pcie.txt    |   24 +-
 .../devicetree/bindings/pci/mobiveil-pcie.txt      |   73 +
 .../devicetree/bindings/pci/pci-armada8k.txt       |    5 +-
 Documentation/devicetree/bindings/pci/rcar-pci.txt |    6 +
 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |   62 +
 .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |    0
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |   17 +-
 arch/arm64/configs/defconfig                       |    3 +-
 arch/microblaze/include/asm/pci.h                  |    4 -
 arch/microblaze/pci/pci-common.c                   |   61 -
 arch/mips/pci/pci-legacy.c                         |    8 +-
 arch/sparc/kernel/leon_pci.c                       |   62 +-
 arch/sparc/kernel/pci.c                            |  136 +-
 arch/sparc/kernel/pci_common.c                     |   31 +-
 arch/sparc/kernel/pci_msi.c                        |   10 +-
 arch/sparc/kernel/pcic.c                           |   94 +-
 arch/x86/pci/early.c                               |   19 +-
 arch/x86/pci/fixup.c                               |    4 +
 arch/xtensa/include/asm/pci.h                      |    2 -
 arch/xtensa/kernel/pci.c                           |   69 +-
 drivers/acpi/pci_root.c                            |   17 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |   24 +-
 drivers/iommu/amd_iommu.c                          |   11 +-
 drivers/iommu/intel-iommu.c                        |    3 +-
 drivers/misc/pci_endpoint_test.c                   |   29 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   28 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   23 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   19 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   75 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   47 +-
 drivers/nvme/host/pci.c                            |   20 +-
 drivers/pci/Kconfig                                |   12 +
 drivers/pci/Makefile                               |    1 +
 drivers/pci/ats.c                                  |    3 +
 drivers/pci/dwc/Kconfig                            |   88 +-
 drivers/pci/dwc/pci-dra7xx.c                       |   19 +-
 drivers/pci/dwc/pci-imx6.c                         |    2 +-
 drivers/pci/dwc/pci-keystone.c                     |    2 +-
 drivers/pci/dwc/pcie-armada8k.c                    |   21 +-
 drivers/pci/dwc/pcie-artpec6.c                     |    6 +-
 drivers/pci/dwc/pcie-designware-ep.c               |   19 +-
 drivers/pci/dwc/pcie-designware-host.c             |   80 +-
 drivers/pci/dwc/pcie-designware-plat.c             |  155 +-
 drivers/pci/dwc/pcie-designware.c                  |   22 +-
 drivers/pci/dwc/pcie-designware.h                  |    1 +
 drivers/pci/dwc/pcie-qcom.c                        |   13 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   35 +-
 drivers/pci/endpoint/pci-epf-core.c                |   23 +-
 drivers/pci/host/Kconfig                           |   55 +-
 drivers/pci/host/Makefile                          |    2 +
 drivers/pci/host/pci-aardvark.c                    |    7 +-
 drivers/pci/host/pci-ftpci100.c                    |    6 +-
 drivers/pci/host/pci-host-common.c                 |   13 +
 drivers/pci/host/pci-host-generic.c                |    1 +
 drivers/pci/host/pci-hyperv.c                      |  162 +-
 drivers/pci/host/pci-mvebu.c                       |    2 +
 drivers/pci/host/pci-rcar-gen2.c                   |    2 +
 drivers/pci/host/pci-tegra.c                       |    2 +
 drivers/pci/host/pci-v3-semi.c                     |    5 +-
 drivers/pci/host/pci-versatile.c                   |    5 +-
 drivers/pci/host/pci-xgene.c                       |    5 +-
 drivers/pci/host/pcie-altera.c                     |    7 +-
 drivers/pci/host/pcie-iproc-platform.c             |    5 +-
 drivers/pci/host/pcie-mediatek.c                   |  236 +--
 drivers/pci/host/pcie-mobiveil.c                   |  866 ++++++++++
 drivers/pci/host/pcie-rcar.c                       |  284 ++--
 drivers/pci/host/pcie-rockchip-ep.c                |  642 ++++++++
 drivers/pci/host/pcie-rockchip-host.c              | 1142 +++++++++++++
 drivers/pci/host/pcie-rockchip.c                   | 1684 +++-----------------
 drivers/pci/host/pcie-rockchip.h                   |  338 ++++
 drivers/pci/host/pcie-xilinx-nwl.c                 |    6 +-
 drivers/pci/host/pcie-xilinx.c                     |    6 +-
 drivers/pci/host/vmd.c                             |   91 +-
 drivers/pci/hotplug/Kconfig                        |    5 +-
 drivers/pci/hotplug/acpi_pcihp.c                   |   45 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   84 +-
 drivers/pci/hotplug/ibmphp_core.c                  |    2 +-
 drivers/pci/hotplug/pciehp.h                       |    2 +-
 drivers/pci/hotplug/pciehp_core.c                  |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   84 +-
 drivers/pci/hotplug/pnv_php.c                      |    8 +-
 drivers/pci/hotplug/shpchp.h                       |   12 -
 drivers/pci/hotplug/shpchp_core.c                  |   14 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |    8 +-
 drivers/pci/iov.c                                  |   42 +-
 drivers/pci/of.c                                   |   63 +-
 drivers/pci/pci-acpi.c                             |   55 +-
 drivers/pci/pci-driver.c                           |    2 +-
 drivers/pci/pci-pf-stub.c                          |   54 +
 drivers/pci/pci-sysfs.c                            |   15 +-
 drivers/pci/pci.c                                  |   89 +-
 drivers/pci/pci.h                                  |   45 +
 drivers/pci/pcie/Makefile                          |    2 +-
 drivers/pci/pcie/aer/aerdrv.c                      |   11 +-
 drivers/pci/pcie/aer/aerdrv.h                      |   32 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |  397 +----
 drivers/pci/pcie/aer/aerdrv_errprint.c             |   38 +-
 drivers/pci/pcie/aspm.c                            |    9 +
 drivers/pci/pcie/dpc.c                             |   74 +-
 drivers/pci/pcie/err.c                             |  388 +++++
 drivers/pci/pcie/portdrv.h                         |    5 +-
 drivers/pci/pcie/portdrv_acpi.c                    |   57 -
 drivers/pci/pcie/portdrv_core.c                    |   71 +-
 drivers/pci/probe.c                                |   96 +-
 drivers/pci/quirks.c                               | 1002 ++++++------
 drivers/pci/setup-bus.c                            |   82 +-
 include/linux/acpi.h                               |    3 +-
 include/linux/aer.h                                |    1 +
 include/linux/of_pci.h                             |   34 -
 include/linux/pci-ecam.h                           |    1 +
 include/linux/pci-epc.h                            |    8 +
 include/linux/pci-epf.h                            |    4 +-
 include/linux/pci.h                                |   21 +-
 include/linux/pci_hotplug.h                        |   18 +-
 include/linux/pci_ids.h                            |    9 +
 include/ras/ras_event.h                            |   22 +-
 include/uapi/linux/pci_regs.h                      |    6 +
 120 files changed, 6224 insertions(+), 3898 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
 create mode 100644 drivers/pci/host/pcie-mobiveil.c
 create mode 100644 drivers/pci/host/pcie-rockchip-ep.c
 create mode 100644 drivers/pci/host/pcie-rockchip-host.c
 create mode 100644 drivers/pci/host/pcie-rockchip.h
 create mode 100644 drivers/pci/pci-pf-stub.c
 create mode 100644 drivers/pci/pcie/err.c
 delete mode 100644 drivers/pci/pcie/portdrv_acpi.c
