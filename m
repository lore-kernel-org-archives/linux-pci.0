Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46928 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757374AbbKFQXQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 11:23:16 -0500
Date: Fri, 6 Nov 2015 10:23:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCI changes for v4.4
Message-ID: <20151106162309.GA28078@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are the PCI changes I intend for v4.4.

There's one silent conflict because I added the Altera host driver, which
uses the pci_msi_create_irq_domain() interface.  That interface was changed
this cycle by be5436c83ac8 ("irqdomain/msi: Use fwnode instead of
of_node").  I included Arnd's suggested resolution at the end of this
email.

Bjorn


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.4-changes

for you to fetch changes up to 7225107e158241b7e22f15b9f4c3db0b3330984d:

  Merge branch 'pci/host-layerscape' into next (2015-11-03 08:39:32 -0600)

----------------------------------------------------------------
PCI changes for the v4.4 merge window:

  Resource management
    Add support for Enhanced Allocation devices (Sean O. Stalley)
    Add Enhanced Allocation register entries (Sean O. Stalley)
    Handle IORESOURCE_PCI_FIXED when sizing resources (David Daney)
    Handle IORESOURCE_PCI_FIXED when assigning resources (David Daney)
    Handle Enhanced Allocation capability for SR-IOV devices (David Daney)
    Clear IORESOURCE_UNSET when reverting to firmware-assigned address (Bjorn Helgaas)
    Make Enhanced Allocation bitmasks more obvious (Bjorn Helgaas)
    Expand Enhanced Allocation BAR output (Bjorn Helgaas)
    Add of_pci_check_probe_only to parse "linux,pci-probe-only" (Marc Zyngier)
    Fix lookup of linux,pci-probe-only property (Marc Zyngier)
    Add sparc mem64 resource parsing for root bus (Yinghai Lu)

  PCI device hotplug
    pciehp: Queue power work requests in dedicated function (Guenter Roeck)

  Driver binding
    Add builtin_pci_driver() to avoid registration boilerplate (Paul Gortmaker)

  Virtualization
    Set SR-IOV NumVFs to zero after enumeration (Alexander Duyck)
    Remove redundant validation of SR-IOV offset/stride registers (Alexander Duyck)
    Remove VFs in reverse order if virtfn_add() fails (Alexander Duyck)
    Reorder pcibios_sriov_disable() (Alexander Duyck)
    Wait 1 second between disabling VFs and clearing NumVFs (Alexander Duyck)
    Fix sriov_enable() error path for pcibios_enable_sriov() failures (Alexander Duyck)
    Enable SR-IOV ARI Capable Hierarchy before reading TotalVFs (Ben Shelton)
    Don't try to restore VF BARs (Wei Yang)

  MSI
    Don't alloc pcibios-irq when MSI is enabled (Joerg Roedel)
    Add msi_controller setup_irqs() method for special multivector setup (Lucas Stach)
    Export all remapped MSIs to sysfs attributes (Romain Bezut)
    Disable MSI on SiS 761 (Ondrej Zary)

  AER
    Clear error status registers during enumeration and restore (Taku Izumi)

  Generic host bridge driver
    Fix lookup of linux,pci-probe-only property (Marc Zyngier)
    Allow multiple hosts with different map_bus() methods (David Daney)
    Pass starting bus number to pci_scan_root_bus() (David Daney)
    Fix address window calculation for non-zero starting bus (David Daney)

  Altera host bridge driver
    Add msi.h to ARM Kbuild (Ley Foon Tan)
    Add Altera PCIe host controller driver (Ley Foon Tan)
    Add Altera PCIe MSI driver (Ley Foon Tan)

  APM X-Gene host bridge driver
    Remove msi_controller assignment (Duc Dang)

  Broadcom iProc host bridge driver
    Fix header comment "Corporation" misspelling (Florian Fainelli)
    Fix code comment to match code (Ray Jui)
    Remove unused struct iproc_pcie.irqs[] (Ray Jui)
    Call pci_fixup_irqs() for ARM64 as well as ARM (Ray Jui)
    Fix PCIe reset logic (Ray Jui)
    Improve link detection logic (Ray Jui)
    Update PCIe device tree bindings (Ray Jui)
    Add outbound mapping support (Ray Jui)

  Freescale i.MX6 host bridge driver
    Return real error code from imx6_add_pcie_port() (Fabio Estevam)
    Add PCIE_PHY_RX_ASIC_OUT_VALID definition (Fabio Estevam)

  Freescale Layerscape host bridge driver
    Remove ls_pcie_establish_link() (Minghuan Lian)
    Ignore PCIe controllers in Endpoint mode (Minghuan Lian)
    Factor out SCFG related function (Minghuan Lian)
    Update ls_add_pcie_port() (Minghuan Lian)
    Remove unused fields from struct ls_pcie (Minghuan Lian)
    Add support for LS1043a and LS2080a (Minghuan Lian)
    Add ls_pcie_msi_host_init() (Minghuan Lian)

  HiSilicon host bridge driver
    Add HiSilicon SoC Hip05 PCIe driver (Zhou Wang)

  Marvell MVEBU host bridge driver
    Return zero for reserved or unimplemented config space (Russell King)
    Use exact config access size; don't read/modify/write (Russell King)
    Use of_get_available_child_count() (Russell King)
    Use for_each_available_child_of_node() to walk child nodes (Russell King)
    Report full node name when reporting a DT error (Russell King)
    Use port->name rather than "PCIe%d.%d" (Russell King)
    Move port parsing and resource claiming to  separate function (Russell King)
    Fix memory leaks and refcount leaks (Russell King)
    Split port parsing and resource claiming from  port setup (Russell King)
    Use gpio_set_value_cansleep() (Russell King)
    Use devm_kcalloc() to allocate an array (Russell King)
    Use gpio_desc to carry around gpio (Russell King)
    Improve clock/reset handling (Russell King)
    Add PCI Express root complex capability block (Russell King)
    Remove code restricting accesses to slot 0 (Russell King)

  NVIDIA Tegra host bridge driver
    Wrap static pgprot_t initializer with __pgprot() (Ard Biesheuvel)

  Renesas R-Car host bridge driver
    Build pci-rcar-gen2.c only on ARM (Geert Uytterhoeven)
    Build pcie-rcar.c only on ARM (Geert Uytterhoeven)
    Make PCI aware of the I/O resources (Phil Edworthy)
    Remove dependency on ARM-specific struct hw_pci (Phil Edworthy)
    Set root bus nr to that provided in DT (Phil Edworthy)
    Fix I/O offset for multiple host bridges (Phil Edworthy)

  ST Microelectronics SPEAr13xx host bridge driver
    Fix dw_pcie_cfg_read/write() usage (Gabriele Paoloni)

  Synopsys DesignWare host bridge driver
    Make "clocks" and "clock-names" optional DT properties (Bhupesh Sharma)
    Use exact access size in dw_pcie_cfg_read() (Gabriele Paoloni)
    Simplify dw_pcie_cfg_read/write() interfaces (Gabriele Paoloni)
    Require config accesses to be naturally aligned (Gabriele Paoloni)
    Make "num-lanes" an optional DT property (Gabriele Paoloni)
    Move calculation of bus addresses to DRA7xx (Gabriele Paoloni)
    Replace ARM pci_sys_data->align_resource with global function pointer (Gabriele Paoloni)
    Factor out MSI msg setup (Lucas Stach)
    Implement multivector MSI IRQ setup (Lucas Stach)
    Make get_msi_addr() return phys_addr_t, not u32 (Lucas Stach)
    Set up high part of MSI target address (Lucas Stach)
    Fix PORT_LOGIC_LINK_WIDTH_MASK (Zhou Wang)
    Revert "PCI: designware: Program ATU with untranslated address" (Zhou Wang)
    Use of_pci_get_host_bridge_resources() to parse DT (Zhou Wang)
    Make driver arch-agnostic (Zhou Wang)

  Miscellaneous
    Make x86 pci_subsys_init() static (Alexander Kuleshov)
    Turn off Request Attributes to avoid Chelsio T5 Completion erratum (Hariprasad Shenai)

----------------------------------------------------------------
Alexander Duyck (6):
      PCI: Set SR-IOV NumVFs to zero after enumeration
      PCI: Remove redundant validation of SR-IOV offset/stride registers
      PCI: Remove VFs in reverse order if virtfn_add() fails
      PCI: Reorder pcibios_sriov_disable()
      PCI: Wait 1 second between disabling VFs and clearing NumVFs
      PCI: Fix sriov_enable() error path for pcibios_enable_sriov() failures

Alexander Kuleshov (1):
      x86/PCI: Make pci_subsys_init() static

Ard Biesheuvel (1):
      PCI: tegra: Wrap static pgprot_t initializer with __pgprot()

Ben Shelton (1):
      PCI: Enable SR-IOV ARI Capable Hierarchy before reading TotalVFs

Bhupesh Sharma (1):
      PCI: designware: Make "clocks" and "clock-names" optional DT properties

Bjorn Helgaas (7):
      PCI: Clear IORESOURCE_UNSET when reverting to firmware-assigned address
      PCI: Make Enhanced Allocation bitmasks more obvious
      PCI: Expand Enhanced Allocation BAR output
      Merge branches 'pci/aer', 'pci/hotplug', 'pci/misc', 'pci/msi', 'pci/resource' and 'pci/virtualization' into next
      Merge branches 'pci/host-altera', 'pci/host-designware', 'pci/host-generic', 'pci/host-imx6', 'pci/host-iproc', 'pci/host-mvebu', 'pci/host-rcar', 'pci/host-tegra' and 'pci/host-xgene' into next
      Merge branch 'pci/host-hisi' into next
      Merge branch 'pci/host-layerscape' into next

David Daney (6):
      PCI: generic: Allow multiple hosts with different map_bus() methods
      PCI: generic: Pass starting bus number to pci_scan_root_bus()
      PCI: generic: Fix address window calculation for non-zero starting bus
      PCI: Handle IORESOURCE_PCI_FIXED when sizing resources
      PCI: Handle IORESOURCE_PCI_FIXED when assigning resources
      PCI: Handle Enhanced Allocation capability for SR-IOV devices

Duc Dang (1):
      PCI/MSI: xgene: Remove msi_controller assignment

Fabio Estevam (2):
      PCI: imx6: Return real error code from imx6_add_pcie_port()
      PCI: imx6: Add PCIE_PHY_RX_ASIC_OUT_VALID definition

Florian Fainelli (1):
      PCI: iproc: Fix header comment "Corporation" misspelling

Gabriele Paoloni (7):
      PCI: spear: Fix dw_pcie_cfg_read/write() usage
      PCI: designware: Use exact access size in dw_pcie_cfg_read()
      PCI: designware: Simplify dw_pcie_cfg_read/write() interfaces
      PCI: designware: Require config accesses to be naturally aligned
      PCI: designware: Make "num-lanes" an optional DT property
      PCI: designware: Move calculation of bus addresses to DRA7xx
      ARM/PCI: Replace pci_sys_data->align_resource with global function pointer

Geert Uytterhoeven (2):
      PCI: rcar: Build pci-rcar-gen2.c only on ARM
      PCI: rcar: Build pcie-rcar.c only on ARM

Guenter Roeck (1):
      PCI: pciehp: Queue power work requests in dedicated function

Hariprasad Shenai (1):
      PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum

Joerg Roedel (1):
      x86/PCI: Don't alloc pcibios-irq when MSI is enabled

Ley Foon Tan (3):
      ARM: Add msi.h to Kbuild
      PCI: altera: Add Altera PCIe host controller driver
      PCI: altera: Add Altera PCIe MSI driver

Lucas Stach (5):
      PCI: Add msi_controller setup_irqs() method for special multivector setup
      PCI: designware: Factor out MSI msg setup
      PCI: designware: Implement multivector MSI IRQ setup
      PCI: designware: Make get_msi_addr() return phys_addr_t, not u32
      PCI: designware: Set up high part of MSI target address

Marc Zyngier (4):
      of/pci: Add of_pci_check_probe_only to parse "linux,pci-probe-only"
      PCI: generic: Fix lookup of linux,pci-probe-only property
      powerpc/PCI: Fix lookup of linux,pci-probe-only property
      arm64: dts: Drop linux,pci-probe-only from the Seattle DTS

Minghuan Lian (7):
      PCI: layerscape: Remove ls_pcie_establish_link()
      PCI: layerscape: Ignore PCIe controllers in Endpoint mode
      PCI: layerscape: Factor out SCFG related function
      PCI: layerscape: Update ls_add_pcie_port()
      PCI: layerscape: Remove unused fields from struct ls_pcie
      PCI: layerscape: Add support for LS1043a and LS2080a
      PCI: layerscape: Add ls_pcie_msi_host_init()

Ondrej Zary (1):
      PCI: Disable MSI on SiS 761

Paul Gortmaker (1):
      PCI: Add builtin_pci_driver() to avoid registration boilerplate

Phil Edworthy (4):
      PCI: rcar: Make PCI aware of the I/O resources
      PCI: rcar: Remove dependency on ARM-specific struct hw_pci
      PCI: rcar: Set root bus nr to that provided in DT
      PCI: rcar: Fix I/O offset for multiple host bridges

Ray Jui (7):
      PCI: iproc: Fix code comment to match code
      PCI: iproc: Remove unused struct iproc_pcie.irqs[]
      PCI: iproc: Call pci_fixup_irqs() for ARM64 as well as ARM
      PCI: iproc: Fix PCIe reset logic
      PCI: iproc: Improve link detection logic
      PCI: iproc: Update PCIe device tree bindings
      PCI: iproc: Add outbound mapping support

Romain Bezut (1):
      PCI/MSI: Export all remapped MSIs to sysfs attributes

Russell King (15):
      PCI: mvebu: Return zero for reserved or unimplemented config space
      PCI: mvebu: Use exact config access size; don't read/modify/write
      PCI: mvebu: Use of_get_available_child_count()
      PCI: mvebu: Use for_each_available_child_of_node() to walk child nodes
      PCI: mvebu: Report full node name when reporting a DT error
      PCI: mvebu: Use port->name rather than "PCIe%d.%d"
      PCI: mvebu: Move port parsing and resource claiming to  separate function
      PCI: mvebu: Fix memory leaks and refcount leaks
      PCI: mvebu: Split port parsing and resource claiming from  port setup
      PCI: mvebu: Use gpio_set_value_cansleep()
      PCI: mvebu: Use devm_kcalloc() to allocate an array
      PCI: mvebu: Use gpio_desc to carry around gpio
      PCI: mvebu: Improve clock/reset handling
      PCI: mvebu: Add PCI Express root complex capability block
      PCI: mvebu: Remove code restricting accesses to slot 0

Sean O. Stalley (2):
      PCI: Add Enhanced Allocation register entries
      PCI: Add support for Enhanced Allocation devices

Taku Izumi (1):
      PCI/AER: Clear error status registers during enumeration and restore

Wei Yang (1):
      PCI: Don't try to restore VF BARs

Yinghai Lu (1):
      sparc/PCI: Add mem64 resource parsing for root bus

Zhen Lei (1):
      PCI: Remove unnecessary "if" statement

Zhou Wang (5):
      PCI: designware: Fix PORT_LOGIC_LINK_WIDTH_MASK
      Revert "PCI: designware: Program ATU with untranslated address"
      PCI: designware: Use of_pci_get_host_bridge_resources() to parse DT
      PCI: designware: Make driver arch-agnostic
      PCI: hisi: Add HiSilicon SoC Hip05 PCIe driver

 .../bindings/arm/hisilicon/hisilicon.txt           |  17 +
 .../devicetree/bindings/pci/altera-pcie-msi.txt    |  28 +
 .../devicetree/bindings/pci/altera-pcie.txt        |  49 ++
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  20 +
 .../devicetree/bindings/pci/designware-pcie.txt    |  12 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  44 ++
 .../devicetree/bindings/pci/host-generic-pci.txt   |   5 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |  14 +-
 MAINTAINERS                                        |  23 +
 arch/arm/include/asm/Kbuild                        |   1 +
 arch/arm/include/asm/mach/pci.h                    |   6 -
 arch/arm/kernel/bios32.c                           |  12 +-
 arch/arm64/boot/dts/amd/amd-overdrive.dts          |   1 -
 arch/powerpc/platforms/pseries/setup.c             |  14 +-
 arch/sparc/kernel/pci.c                            |   7 +-
 arch/sparc/kernel/pci_common.c                     |  17 +-
 arch/sparc/kernel/pci_impl.h                       |   1 +
 arch/x86/pci/common.c                              |   8 +
 arch/x86/pci/legacy.c                              |   2 +-
 drivers/of/of_pci.c                                |  26 +
 drivers/pci/host/Kconfig                           |  33 +-
 drivers/pci/host/Makefile                          |   3 +
 drivers/pci/host/pci-dra7xx.c                      |   7 +
 drivers/pci/host/pci-exynos.c                      |   5 +-
 drivers/pci/host/pci-host-generic.c                |  41 +-
 drivers/pci/host/pci-imx6.c                        |   5 +-
 drivers/pci/host/pci-keystone-dw.c                 |   8 +-
 drivers/pci/host/pci-keystone.h                    |   2 +-
 drivers/pci/host/pci-layerscape.c                  | 199 +++++--
 drivers/pci/host/pci-mvebu.c                       | 473 ++++++++++++-----
 drivers/pci/host/pci-tegra.c                       |   4 +-
 drivers/pci/host/pci-xgene.c                       |  22 -
 drivers/pci/host/pcie-altera-msi.c                 | 312 +++++++++++
 drivers/pci/host/pcie-altera.c                     | 579 +++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 | 375 ++++++-------
 drivers/pci/host/pcie-designware.h                 |  20 +-
 drivers/pci/host/pcie-hisi.c                       | 198 +++++++
 drivers/pci/host/pcie-iproc-platform.c             |  27 +
 drivers/pci/host/pcie-iproc.c                      | 163 +++++-
 drivers/pci/host/pcie-iproc.h                      |  20 +-
 drivers/pci/host/pcie-rcar.c                       |  86 +--
 drivers/pci/host/pcie-spear13xx.c                  |  24 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |  75 +--
 drivers/pci/iov.c                                  | 101 ++--
 drivers/pci/msi.c                                  |  34 +-
 drivers/pci/pci-driver.c                           |   8 +-
 drivers/pci/pci.c                                  | 225 +++++++-
 drivers/pci/pci.h                                  |   1 +
 drivers/pci/pcie/aer/aerdrv_core.c                 |  28 +
 drivers/pci/probe.c                                |   6 +
 drivers/pci/quirks.c                               |  58 +++
 drivers/pci/setup-bus.c                            |  50 +-
 drivers/pci/setup-res.c                            |   7 +
 include/linux/aer.h                                |   5 +
 include/linux/msi.h                                |   2 +
 include/linux/of_pci.h                             |   3 +
 include/linux/pci.h                                |  12 +
 include/uapi/linux/pci_regs.h                      |  43 +-
 58 files changed, 2894 insertions(+), 677 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-altera-msi.c
 create mode 100644 drivers/pci/host/pcie-altera.c
 create mode 100644 drivers/pci/host/pcie-hisi.c


From: Arnd Bergmann <arnd@arndb.de>

PCI: altera: use fwnode API for pci_msi_create_irq_domain()

There is a new conflict between Thomas Gleixner's IRQ tree that contains
a patch from Marc Zyngier to change the prototype for
pci_msi_create_irq_domain(), and Bjorn Helgaas' PCI tree that contains
a new driver for the Altera PCI MSI host, with the old interface,
as gcc now warns in linux-next:

  drivers/pci/host/pcie-altera-msi.c: In function 'altera_allocate_domains':
  drivers/pci/host/pcie-altera-msi.c:191:46: warning: passing argument 1 of 'pci_msi_create_irq_domain' from incompatible pointer type [-Wincompatible-pointer-types]
    msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
  include/linux/msi.h:286:20: note: expected 'struct fwnode_handle *' but argument is of type 'struct device_node *'

Change the new driver use the modified API.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: af1169b48b17 ("PCI: altera: Add Altera PCIe MSI driver")
Fixes: be5436c83ac8 ("irqdomain/msi: Use fwnode instead of of_node")

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 2c37e8620c37..99177f4ccde2 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -181,6 +181,8 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int altera_allocate_domains(struct altera_msi *msi)
 {
+	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
+
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
@@ -188,7 +190,7 @@ static int altera_allocate_domains(struct altera_msi *msi)
 		return -ENOMEM;
 	}
 
-	msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
 				&altera_msi_domain_info, msi->inner_domain);
 	if (!msi->msi_domain) {
 		dev_err(&msi->pdev->dev, "failed to create MSI domain\n");


