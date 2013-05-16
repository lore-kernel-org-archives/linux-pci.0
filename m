Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60113 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab3EPP5l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 11:57:41 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCHv10 0/9] PCIe support for the Armada 370 and Armada XP SoCs
Date: Thu, 16 May 2013 17:55:15 +0200
Message-Id: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This series of patches introduces PCIe support for the Marvell Armada
370 and Armada XP.

I'd like this code to be merged for 3.11.

For easier testing, the code has been pushed to:

  git://github.com/MISL-EBU-System-SW/mainline-public.git marvell-pcie-v10

This PATCHv10 follows:
 * PATCHv9, sent on May, 16th 2013
 * PATCHv8, sent on April, 9th 2013
 * PATCHv7, sent on March, 27th 2013
 * PATCHv6, sent on March, 26st 2013
 * PATCHv5, sent on March, 21st 2013
 * PATCHv4, sent on March, 8th 2013
 * PATCHv3, sent on February, 12th 2013
 * PATCHv2, sent on January, 28th 2013
 * RFCv1, sent on December, 7th 2012

Changes between v9 and v10:

 * Mark mvebu_pcie_init() as __init, as reported by Ezequiel
   Garcia. platform_driver_probe() is __init_or_module, so when
   !CONFIG_MODULES is used, platform_driver_probe() belongs to the
   __init section.

 * Mark two other small functions as __init, just because they are
   only used during the initialization (mvebu_pcie_enable and
   mvebu_pcie_map_registers). Suggested by Ezequiel Garcia.

Changes between v8 and v9:

 * Rebased on top of 3.10-rc1. Since the PCIe Device Tree informations
   were merged in 3.10-rc1, it allowed to reduce quite significantly
   the size of this patch set.

 * A fix for the PCIe Device Tree information is added as the first
   patch, it adds a missing range entry to let the global PCIe
   memory/IO window addresses be correctly translated. It should be
   merged into the 3.10-rc cycle, to fix the hardware definition of
   the platform.

 * The patch set now integrates the latest version of Andrew Murray
   of/pci patch, that adds the PCI range parsing functions. The one
   I've integrated is:

   [PATCH v9 1/3] of/pci: Provide support for parsing PCI DT ranges property

 * I've fixed the PowerPC64 build problem, which was the reason why
   this driver was not taken for 3.10. In fact, the patch 'pci:
   infrastructure to add drivers in drivers/pci/host' was introducing
   a drivers/pci/host directory, with just an empty
   Makefile. Unfortunately, an empty Makefile doesn't trigger the
   generation of drivers/pci/host/built-in.o. So if you try to build
   the kernel with just this patch applied, and not the PCIe driver
   itself, the Makefile is empty, and the build breaks.

   To solve this, I've simply merged this patch with the PCIe driver
   patch itself. The PCIe driver patch adds the drivers/pci/host/
   directory and the related Kconfig/Makefile bits.

 * Fixed a regression in the driver introduced between the v7 and the
   v8. A #define <something> 1 was changed to #define <something>
   BIT(1), which obviously doesn't work. Changed to BIT(0), which is
   correct.

Changes between v7 and v8:

 * In the patch introducing the drivers/pci/host directory, add an
   empty drivers/pci/host/Makefile to ensure that the kernel still
   build. This Makefile will actually gets its first useful line when
   the Marvell PCIe driver gets added. Noted by Neil Greatorex.

 * Remove bogus (and useless) CFLAGS in drivers/pci/host/Makefile for
   the compilation of the Marvell PCIe driver. Noticed by Bjorn
   Helgaas.

 * Added missing parenthesis in the definition of the
   PCIE_BAR_CTRL_OFF macro. Noticed by Bjorn Helgaas.

 * Make mvebu_pcie_link_up() return 'bool' instead of 'int'. Suggested
   by Bjorn Helgaas.

 * Change mvebu_pcie_link_up(), mvebu_pcie_set_local_bus_nr(),
   mvebu_pcie_setup_wins(), mvebu_pcie_setup_hw(),
   mvebu_pcie_hw_rd_conf(), mvebu_pcie_hw_wr_conf() so that they take
   a 'struct mvebu_pcie_port *' instead of a 'void __iomem *' as first
   argument. The base address of the PCIe interface register are
   available using the 'base' field of 'struct
   mvebu_pcie_port'. Suggested by Bjorn Helgaas.

 * Fixed multi-line comments that should have been one line
   comments. Noticed by Bjorn Helgaas.

 * Fixed a for() loop in mvebu_pcie_setup_wins() to use the more
   conventional 'ii < 3' ending condition instead of 'i <=
   2'. Suggested by Bjorn Helgaas.

 * Add a #define instead of an hardcoded magic value when enabling
   interrupts A-D in mvebu_pcie_setup_hw(). Suggested by Bjorn
   Helgaas.

 * Add a PCIE_CONF_ADDR() to simplify the code in
   mvebu_pcie_hw_rd_conf() and mvebu_pcie_hw_wr_conf(). Suggested by
   Bjorn Helgaas.

 * Clarify the comments in mvebu_pcie_handle_iobase_change() and
   mvebu_pcie_handle_membase_change() so that it is clear we look at
   the new iobase/iolimit (respectively membase/memlimit)
   values. Suggested by Bjorn Helgaas.

 * Replace mvebu_pcie_find_port_by_bus() and
   mvebu_pcie_find_port_by_devfn() by a single mvebu_pcie_find_port()
   function, and simplify the mvebu_pcie_rd_conf() and
   mvebu_pcie_wr_conf() functions. Suggested by Bjorn Helgaas.

 * Fix the computation of the real I/O resource start and end
   addresses, according to the suggestions of Arnd Bergmann and Jason
   Gunthorpe.

 * Remove the MASK/OFFS definition, and use definitions more in the
   style of pci_regs.h. Suggested by Bjorn Helgaas.

 * Integrate the latest version of 'of/pci: Provide support for
   parsing PCI DT ranges property' from Andrew Murray, fixed according
   to the review of Rob Herring.

 * Added the Acked-by tags from Bjorn Helgaas on the PCI patches.

Changes between v6 and v7:

 * Use assigned-addresses in the DT subnodes for the MMIO PCIe
   registers, in order to align with what Thierry is doing on the
   Tegra PCIe driver.

 * Added empty 'ranges;' properties in the subnodes, as requested by
   Arnd. Note that due to this, it is not possible to remove the
   #address-cells and #size-cells properties from the subnodes, as
   Jason Gunthorpe requested, otherwise the DT compiler complains with:

     Warning (ranges_format): /soc/pcie-controller/pcie@1,0 has empty
     "ranges" property but its #address-cells (2) differs from
     /soc/pcie-controller (3)

     Warning (ranges_format): /soc/pcie-controller/pcie@1,0 has empty
     "ranges" property but its #size-cells (1) differs from
     /soc/pcie-controller (2)

 * Use the new RFCv3 patch from Andrew Murray for 'of/pci: Provide
   support for parsing PCI DT ranges property'.

 * Updated the DT binding documentation accordingly.

Changes between v5 and v6:

 * Use pci_create_root_bus() + pci_scan_child_bus() instead of
   pci_scan_root_bus(). This is needed to be able to add MSI support
   later on. Moreover Thierry Reding suggested that
   pci_scan_root_bus() "does a pci_bus_add_devices(), which is called
   again in pci_common_init() in the ARM code". Thanks Thierry for
   pointing out this issue.

Changes between v4 and v5:

 * Rebased on top of 3.9-rc2 + the new mvebu-mbus driver (v3).

 * Changed the names of the PCI DT sub-nodes to match the OF
   specifications: they should be named pcie@DD,FF where DD is the
   device number and FF the function number. Requested by Mitch
   Bradley.

 * Add the device_type = "pci" property at the pcie-controller
   level. Requested by Mitch Bradley.

 * Drop patch 'of/pci: Add of_pci_get_bus() function' because it
   wasn't actually used in the rest of the patch series.

 * Updated the patch 'of/pci: Provide support for parsing PCI DT
   ranges property' to use the latest version proposed by Andrew
   Murray on the devicetree-discuss@ mailing list.

Changes between v3 and v4:

 * Rebased on top of 3.9-rc1.

 * Drop patch "ARM: pci: Allow passing per-controller private data"
   because it was merged in 3.9.

 * Drop patch "lib: devres: don't enclose pcim_*() functions in
   CONFIG_HAS_IOPORT", because it was merged in 3.9.

 * Added CONFIG_PCI_MVEBU=y in mvebu_defconfig, so that the right PCI
   host controller driver is automatically enabled.

 * Instead of using the DT 'ranges' property to encode the PCIe
   register ranges, use a 'reg' property on the main PCIe controller
   DT node together with a 'reg-names' property. Suggested by Jason
   Gunthorpe.

 * Don't select PCI_SW_HOST_BRIDGE and PCI_SW_PCI_PCI_BRIDGE, they
   don't exist anymore. Reported by Bjorn Helgaas.

 * Added support for the Armada XP GP board.

 * Fix the 'ranges' property so that the memory range is an identity
   map between CPU addresses and bus addresses. Suggested by Arnd
   Bergmann.

 * Changed the 'ranges' property to have the I/O region after the
   memory region.

 * Use the new mvebu-mbus driver API to create/remove address decoding
   windows when needed. This remove the need to include
   <mach/addr-map.h>. Requested by Arnd Bergmann.

 * Include directly into the driver the few common PCIe functions we
   were using from arch/arm/plat-orion/pcie.c. This allows to remove
   the inclusion of <plat/pcie.h>. Requested by Arnd Bergmann.

 * Directly set up the address decoding windows when the memory
   base/limit and I/O base/limit are configured in the PCI-to-PCI
   bridge instead of relying on the memory and I/O accesses being
   enabled in the PCI_COMMAND register. Suggested by Bjorn Helgaas.

 * Added some comments on top of the calculations of the I/O
   base/limit and memory base/limit. Suggested by Arnd Bergmann.

 * Changed a bit the way the "realio" resource is created, from
   suggestions given by Arnd Bergmann.

 * Updated the Device Tree binding documentation. Reported by Jason
   Gunthorpe.

 * Instead of using "marvell,armada-370-xp-pcie" as the DT compatible
   string, use two separate compatible strings:
   "marvell,armada-370-pcie" and "marvell,armada-xp-pcie". For now,
   the driver does the same thing for both.

Changes between v2 and v3:

 * Use of_irq_map_pci() instead of of_irq_map_raw(), as suggested by
   Andrew Murray. In order to do this, we moved the interrupt-map and
   interrupt-map-mask DT properties from the main PCIe controller node
   to the DT subnodes representing each PCIe interface.

 * Remove the usage of the emulated host bridge.

 * Move the emulated PCI-to-PCI bridge code into the Marvell PCI
   driver itself, in order to allow a tighter integration. Suggested
   by Bjorn Helgaas and Jason Gunthorpe.

 * Make the allocation of address decoding windows dynamic: it's when
   memory accesses or I/O accesses are enabled at the PCI-to-PCI
   bridge level that we allocate and setup the corresponding address
   decoding window. Requested by Bjorn Helgaas.

 * Fixed the implementation of I/O accesses to use I/O addresses that
   fall within the normal IO_SPACE_LIMIT. This required using the
   "remap" functionality of address decoding windows, and therefore
   some changes in the address decoding window allocator. Follows a
   long discussion about I/O accesses.

 * Set up a correct bus number in the configuration of the PCIe
   interfaces so that we don't have to fake bus numbers
   anymore. Requested by Jason Gunthorpe.

 * Fix the of_pci_get_devfn() implementation according to Stephen
   Warren's comment.

 * Use CFLAGS_ instead of ccflags to add the mach-mvebu and plat-orion
   include paths when building the pci-mvebu driver. This ensures that
   the include paths are only added when building this specific
   driver. Requested by Stephen Warren.

 * Fix the ->resource_align() to only apply on bus 0 (the one on which
   the emulated PCI-to-PCI bridges sit), and to request an alignment
   on the size of the window (and not only 64 KB for I/O windows and 1
   MB for memory windows).

 * Clarified the commit log of "clk: mvebu: create parent-child
   relation for PCIe clocks on Armada 370"

Thanks,

Thomas

Andrew Murray (1):
  of/pci: Provide support for parsing PCI DT ranges property

Thierry Reding (2):
  of/pci: Add of_pci_get_devfn() function
  of/pci: Add of_pci_parse_bus_range() function

Thomas Petazzoni (6):
  arm: mvebu: fix the 'ranges' property to handle PCIe
  clk: mvebu: create parent-child relation for PCIe clocks on Armada
    370
  clk: mvebu: add more PCIe clocks for Armada XP
  pci: PCIe driver for Marvell Armada 370/XP systems
  arm: mvebu: PCIe support is now available on mvebu
  arm: mvebu: update defconfig with PCI and USB support

 .../devicetree/bindings/pci/mvebu-pci.txt          |  220 +++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |    3 +-
 arch/arm/boot/dts/armada-370.dtsi                  |    3 +-
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/mach-mvebu/Kconfig                        |    2 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |   18 +-
 drivers/of/address.c                               |   67 ++
 drivers/of/of_pci.c                                |   59 +-
 drivers/pci/Kconfig                                |    2 +
 drivers/pci/Makefile                               |    3 +
 drivers/pci/host/Kconfig                           |    8 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-mvebu.c                       |  880 ++++++++++++++++++++
 include/linux/of_address.h                         |   48 ++
 include/linux/of_pci.h                             |    2 +
 15 files changed, 1306 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt
 create mode 100644 drivers/pci/host/Kconfig
 create mode 100644 drivers/pci/host/Makefile
 create mode 100644 drivers/pci/host/pci-mvebu.c

-- 
1.7.9.5

