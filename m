Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150622151411.GO7710@google.com>
References: <20150622151411.GO7710@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Jun 2015 10:15:06 -0500
Message-ID: <CAErSpo74i4FcMkdBu8xkLR6EyATVP0YoGyVhd_teiEAZd-RExw@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-kernel]

On Mon, Jun 22, 2015 at 10:14 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi Linus,
>
> Here are the PCI changes for v4.2.
>
> Bjorn
>
>
>
> The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:
>
>   Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.2-changes
>
> for you to fetch changes up to 207b074f82c6790f008bfe055c37b47047eb2122:
>
>   Merge branches 'pci/host-xgene' and 'pci/hotplug' into next (2015-06-18 17:56:45 -0500)
>
> ----------------------------------------------------------------
> PCI changes for the v4.2 merge window:
>
>   Enumeration
>     - Move pci_ari_enabled() to global header (Alex Williamson)
>     - Account for ARI in _PRT lookups (Alex Williamson)
>     - Remove unused pci_scan_bus_parented() (Yijing Wang)
>
>   Resource management
>     - Use host bridge _CRS info on systems with >32 bit addressing (Bjorn Helgaas)
>     - Use host bridge _CRS info on Foxconn K8M890-8237A (Bjorn Helgaas)
>     - Fix pci_address_to_pio() conversion of CPU address to I/O port (Zhichang Yuan)
>     - Add pci_bus_addr_t (Yinghai Lu)
>
>   PCI device hotplug
>     - Wait for pciehp command completion where necessary (Alex Williamson)
>     - Drop pointless ACPI-based "slot detection" check (Rafael J. Wysocki)
>     - Check ignore_hotplug for all downstream devices (Rafael J. Wysocki)
>     - Propagate the "ignore hotplug" setting to parent (Rafael J. Wysocki)
>     - Inline pciehp "handle event" functions into the ISR (Bjorn Helgaas)
>     - Clean up pciehp debug logging (Bjorn Helgaas)
>
>   Power management
>     - Remove redundant PCIe port type checking (Yijing Wang)
>     - Add dev->has_secondary_link to track downstream PCIe links (Yijing Wang)
>     - Use dev->has_secondary_link to find downstream links for ASPM (Yijing Wang)
>     - Drop __pci_disable_link_state() useless "force" parameter (Bjorn Helgaas)
>     - Simplify Clock Power Management setting (Bjorn Helgaas)
>
>   Virtualization
>     - Add ACS quirks for Intel 9-series PCH root ports (Alex Williamson)
>     - Add function 1 DMA alias quirk for Marvell 9120 (Sakari Ailus)
>
>   MSI
>     - Disable MSI at enumeration even if kernel doesn't support MSI (Michael S. Tsirkin)
>     - Remove unused pci_msi_off() (Bjorn Helgaas)
>     - Rename msi_set_enable(), msix_clear_and_set_ctrl() (Michael S.  Tsirkin)
>     - Export pci_msi_set_enable(), pci_msix_clear_and_set_ctrl() (Michael S. Tsirkin)
>     - Drop pci_msi_off() calls during probe (Michael S. Tsirkin)
>
>   APM X-Gene host bridge driver
>     - Add APM X-Gene v1 PCIe MSI/MSIX termination driver (Duc Dang)
>     - Add APM X-Gene PCIe MSI DTS nodes (Duc Dang)
>     - Disable Configuration Request Retry Status for v1 silicon (Duc Dang)
>     - Allow config access to Root Port even when link is down (Duc Dang)
>
>   Broadcom iProc host bridge driver
>     - Allow override of device tree IRQ mapping function (Hauke Mehrtens)
>     - Add BCMA PCIe driver (Hauke Mehrtens)
>     - Directly add PCI resources (Hauke Mehrtens)
>     - Free resource list after registration (Hauke Mehrtens)
>
>   Freescale i.MX6 host bridge driver
>     - Add speed change timeout message (Troy Kisky)
>     - Rename imx6_pcie_start_link() to imx6_pcie_establish_link() (Bjorn Helgaas)
>
>   Freescale Layerscape host bridge driver
>     - Use dw_pcie_link_up() consistently (Bjorn Helgaas)
>     - Factor out ls_pcie_establish_link() (Bjorn Helgaas)
>
>   Marvell MVEBU host bridge driver
>     - Remove mvebu_pcie_scan_bus() (Yijing Wang)
>
>   NVIDIA Tegra host bridge driver
>     - Remove tegra_pcie_scan_bus() (Yijing Wang)
>
>   Synopsys DesignWare host bridge driver
>     - Consolidate outbound iATU programming functions (Jisheng Zhang)
>     - Use iATU0 for cfg and IO, iATU1 for MEM (Jisheng Zhang)
>     - Add support for x8 links (Zhou Wang)
>     - Wait for link to come up with consistent style (Bjorn Helgaas)
>     - Use pci_scan_root_bus() for simplicity (Yijing Wang)
>
>   TI DRA7xx host bridge driver
>     - Use dw_pcie_link_up() consistently (Bjorn Helgaas)
>
>   Miscellaneous
>     - Include <linux/pci.h>, not <asm/pci.h> (Bjorn Helgaas)
>     - Remove unnecessary #includes of <asm/pci.h> (Bjorn Helgaas)
>     - Remove unused pcibios_select_root() (again) (Bjorn Helgaas)
>     - Remove unused pci_dma_burst_advice() (Bjorn Helgaas)
>     - xen/pcifront: Don't use deprecated function pci_scan_bus_parented() (Arnd Bergmann)
>
> ----------------------------------------------------------------
> Alex Williamson (4):
>       PCI: Add ACS quirks for Intel 9-series PCH root ports
>       PCI: Move pci_ari_enabled() to global header
>       ACPI / PCI: Account for ARI in _PRT lookups
>       PCI: pciehp: Wait for hotplug command completion where necessary
>
> Arnd Bergmann (1):
>       xen/pcifront: Don't use deprecated function pci_scan_bus_parented()
>
> Bjorn Helgaas (24):
>       PCI/MSI: Remove unused pci_msi_off()
>       PCI/ASPM: Drop __pci_disable_link_state() useless "force" parameter
>       PCI: imx6: Rename imx6_pcie_start_link() to imx6_pcie_establish_link()
>       PCI: Include <linux/pci.h>, not <asm/pci.h>
>       PCI: Remove unnecessary #includes of <asm/pci.h>
>       PCI: Remove unused pcibios_select_root() (again)
>       PCI: Remove unused pci_dma_burst_advice()
>       x86/PCI: Use host bridge _CRS info on Foxconn K8M890-8237A
>       PCI: dra7xx: Use dw_pcie_link_up() consistently
>       PCI: layerscape: Use dw_pcie_link_up() consistently
>       PCI: layerscape: Factor out ls_pcie_establish_link()
>       PCI: designware: Wait for link to come up with consistent style
>       PCI/ASPM: Simplify Clock Power Management setting
>       Merge branches 'pci/aspm', 'pci/enumeration', 'pci/hotplug', 'pci/misc', 'pci/msi', 'pci/resource' and 'pci/virtualization' into next
>       PCI: imx6: Use "u32", not "uint32_t"
>       PCI: imx6: Add #define PCIE_RC_LCSR
>       Merge branches 'pci/host-designware', 'pci/host-designware-common', 'pci/host-generic', 'pci/host-imx6', 'pci/host-iproc' and 'pci/host-xgene' into next
>       x86/PCI: Use host bridge _CRS info on systems with >32 bit addressing
>       Merge branch 'pci/resource' into next
>       PCI: pciehp: Clean up debug logging
>       PCI: pciehp: Make queue_interrupt_event() void
>       PCI: pciehp: Rename queue_interrupt_event() to pciehp_queue_interrupt_event()
>       PCI: pciehp: Inline the "handle event" functions into the ISR
>       Merge branches 'pci/host-xgene' and 'pci/hotplug' into next
>
> Duc Dang (4):
>       PCI: xgene: Add APM X-Gene v1 PCIe MSI/MSIX termination driver
>       arm64: dts: Add APM X-Gene PCIe MSI nodes
>       PCI: xgene: Disable Configuration Request Retry Status for v1 silicon
>       PCI: xgene: Allow config access to Root Port even when link is down
>
> Hauke Mehrtens (4):
>       PCI: iproc: Allow override of device tree IRQ mapping function
>       PCI: iproc: Add BCMA PCIe driver
>       PCI: iproc: Directly add PCI resources
>       PCI: iproc: Free resource list after registration
>
> Jisheng Zhang (2):
>       PCI: designware: Consolidate outbound iATU programming functions
>       PCI: designware: Use iATU0 for cfg and IO, iATU1 for MEM
>
> Michael S. Tsirkin (6):
>       PCI/MSI: Rename msi_set_enable(), msix_clear_and_set_ctrl()
>       PCI/MSI: Export pci_msi_set_enable(), pci_msix_clear_and_set_ctrl()
>       PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI
>       virtio_pci: drop pci_msi_off() call during probe
>       ntb: Drop pci_msi_off() call during probe
>       PCI/MSI: Drop pci_msi_off() calls from quirks
>
> Rafael J. Wysocki (4):
>       PCI: pciehp: Drop pointless ACPI-based "slot detection" check
>       PCI: pciehp: Drop pointless label from pciehp_probe()
>       ACPI / hotplug / PCI: Check ignore_hotplug for all downstream devices
>       PCI: Propagate the "ignore hotplug" setting to parent
>
> Sakari Ailus (1):
>       PCI: Add function 1 DMA alias quirk for Marvell 9120
>
> Troy Kisky (1):
>       PCI: imx6: Add speed change timeout message
>
> Yijing Wang (8):
>       PCI/ASPM: Remove redundant PCIe port type checking
>       PCI: Add dev->has_secondary_link to track downstream PCIe links
>       PCI/ASPM: Use dev->has_secondary_link to find downstream links
>       PCI: mvebu: Remove mvebu_pcie_scan_bus()
>       PCI: tegra: Remove tegra_pcie_scan_bus()
>       PCI: designware: Use pci_scan_root_bus() for simplicity
>       PCI: Use dev->has_secondary_link to find downstream PCIe links
>       PCI: Remove unused pci_scan_bus_parented()
>
> Yinghai Lu (1):
>       PCI: Add pci_bus_addr_t
>
> Zhichang Yuan (1):
>       of/pci: Fix pci_address_to_pio() conversion of CPU address to I/O port
>
> Zhou Wang (1):
>       PCI: designware: Add support for x8 links
>
>  Documentation/DMA-API-HOWTO.txt                    |  29 +-
>  Documentation/DMA-API.txt                          |  30 +-
>  .../devicetree/bindings/pci/xgene-pci-msi.txt      |  68 +++
>  MAINTAINERS                                        |   8 +
>  arch/alpha/include/asm/pci.h                       |  16 -
>  arch/alpha/kernel/core_irongate.c                  |   1 -
>  arch/alpha/kernel/sys_eiger.c                      |   1 -
>  arch/alpha/kernel/sys_nautilus.c                   |   1 -
>  arch/arm/include/asm/pci.h                         |  10 -
>  arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 +
>  arch/frv/include/asm/pci.h                         |  10 -
>  arch/ia64/include/asm/pci.h                        |  32 --
>  arch/microblaze/include/asm/pci.h                  |  23 -
>  arch/mips/include/asm/pci.h                        |  10 -
>  arch/mips/pci/fixup-cobalt.c                       |   1 -
>  arch/mips/pci/ops-mace.c                           |   1 -
>  arch/mips/pci/pci-lantiq.c                         |   1 -
>  arch/mn10300/include/asm/pci.h                     |  13 -
>  arch/parisc/include/asm/pci.h                      |  19 -
>  arch/powerpc/include/asm/pci.h                     |  30 --
>  arch/powerpc/kernel/prom.c                         |   1 -
>  arch/powerpc/kernel/prom_init.c                    |   1 -
>  arch/powerpc/platforms/52xx/mpc52xx_pci.c          |   2 +-
>  arch/s390/kernel/suspend.c                         |   2 +-
>  arch/sh/drivers/pci/ops-sh5.c                      |   1 -
>  arch/sh/drivers/pci/pci-sh5.c                      |   1 -
>  arch/sh/include/asm/pci.h                          |  18 -
>  arch/sparc/include/asm/pci_32.h                    |  10 -
>  arch/sparc/include/asm/pci_64.h                    |  19 -
>  arch/unicore32/include/asm/pci.h                   |  10 -
>  arch/x86/include/asm/pci.h                         |   7 -
>  arch/x86/kernel/x86_init.c                         |   1 -
>  arch/x86/pci/acpi.c                                |  17 +-
>  drivers/acpi/pci_irq.c                             |   2 +-
>  drivers/net/ethernet/sun/cassini.c                 |   1 -
>  drivers/ntb/ntb_hw.c                               |   2 -
>  drivers/of/address.c                               |   2 +-
>  drivers/pci/Kconfig                                |   4 +
>  drivers/pci/bus.c                                  |  10 +-
>  drivers/pci/host/Kconfig                           |  20 +
>  drivers/pci/host/Makefile                          |   2 +
>  drivers/pci/host/pci-dra7xx.c                      |  19 +-
>  drivers/pci/host/pci-exynos.c                      |  34 +-
>  drivers/pci/host/pci-imx6.c                        |  88 +--
>  drivers/pci/host/pci-keystone.c                    |  16 +-
>  drivers/pci/host/pci-layerscape.c                  |  25 +-
>  drivers/pci/host/pci-mvebu.c                       |  18 +-
>  drivers/pci/host/pci-tegra.c                       |  16 -
>  drivers/pci/host/pci-xgene-msi.c                   | 596 +++++++++++++++++++++
>  drivers/pci/host/pci-xgene.c                       |  66 ++-
>  drivers/pci/host/pcie-designware.c                 | 154 +++---
>  drivers/pci/host/pcie-iproc-bcma.c                 | 110 ++++
>  drivers/pci/host/pcie-iproc-platform.c             |  12 +-
>  drivers/pci/host/pcie-iproc.c                      |   6 +-
>  drivers/pci/host/pcie-iproc.h                      |   4 +-
>  drivers/pci/host/pcie-spear13xx.c                  |  17 +-
>  drivers/pci/hotplug/Makefile                       |   3 -
>  drivers/pci/hotplug/acpiphp_glue.c                 |   5 +-
>  drivers/pci/hotplug/pciehp.h                       |  23 +-
>  drivers/pci/hotplug/pciehp_acpi.c                  | 137 -----
>  drivers/pci/hotplug/pciehp_core.c                  |  54 +-
>  drivers/pci/hotplug/pciehp_ctrl.c                  | 154 +-----
>  drivers/pci/hotplug/pciehp_hpc.c                   | 145 ++---
>  drivers/pci/msi.c                                  |  53 +-
>  drivers/pci/pci.c                                  |  44 +-
>  drivers/pci/pci.h                                  |  32 +-
>  drivers/pci/pcie/aer/aerdrv_core.c                 |   3 +-
>  drivers/pci/pcie/aspm.c                            |  57 +-
>  drivers/pci/probe.c                                |  69 ++-
>  drivers/pci/quirks.c                               |   6 +-
>  drivers/pci/vc.c                                   |   3 +-
>  drivers/pci/xen-pcifront.c                         |  16 +-
>  drivers/virtio/virtio_pci_common.c                 |   3 -
>  include/asm-generic/pci.h                          |  13 -
>  include/linux/pci.h                                |  44 +-
>  include/linux/types.h                              |  12 +-
>  76 files changed, 1396 insertions(+), 1125 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
>  create mode 100644 drivers/pci/host/pcie-iproc-bcma.c
>  delete mode 100644 drivers/pci/hotplug/pciehp_acpi.c
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
Please read the FAQ at  http://www.tux.org/lkml/
