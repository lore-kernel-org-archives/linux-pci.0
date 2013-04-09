Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52900 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934864Ab3DIVGq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 17:06:46 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [PATCHv8 00/19] PCIe support for the Armada 370 and Armada XP SoCs
Date: Tue,  9 Apr 2013 23:06:21 +0200
Message-Id: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This series of patches introduces PCIe support for the Marvell Armada
370 and Armada XP. In the future, we plan to extend the driver to
cover Kirkwood platforms, and possibly other Marvell EBU platforms as
well.

Here is the current status of the different patches:

 * Patches 1-5 are awaiting a formal Acked-by from the Device Tree
   maintainers. Patches 1-3 are the new version of the OF PCI range
   parsing functions from Andrew Murray, which he worked on after the
   comments from Rob Herring. Patches 4 and 5 are much more trivial
   and have been around since many versions of this series.

 * Patch 6 and 10, that are touching drivers/pci/ have been formally
   Acked-by Bjorn Helgaas, the PCI maintainer.

 * Patch 7, which is touching arch/arm/kernel, has been merged by
   Russell King already, see
   http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7683/1.

 * Patches 8 and 9 are touching drivers/clk, and are awaiting an
   Acked-by from Mike Turquette. However, they are fairly trivial
   patches, so they shouldn't cause too much problem.

 * All the other patches touch mvebu-specific things, either
   mach-mvebu or the related Device Tree files or defconfig, so it's
   up to the Marvell maintainers to pick them up.

This patch set depends on:

 * The arm-soc/mvebu/cleanup branch in Arnd and Olof arm-soc tree

 * [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/156883.html

For easier testing, the code has been pushed to:

  git://github.com/MISL-EBU-System-SW/mainline-public.git marvell-pcie-v8

This PATCHv8 follows:
 * PATCHv7, sent on March, 27th 2013
 * PATCHv6, sent on March, 26st 2013
 * PATCHv5, sent on March, 21st 2013
 * PATCHv4, sent on March, 8th 2013
 * PATCHv3, sent on February, 12th 2013
 * PATCHv2, sent on January, 28th 2013
 * RFCv1, sent on December, 7th 2012

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

Andrew Murray (3):
  of/pci: Unify pci_process_bridge_OF_ranges from Microblaze and
    PowerPC
  of/pci: Provide support for parsing PCI DT ranges property
  of/pci: mips: convert to common of_pci_range_parser

Thierry Reding (2):
  of/pci: Add of_pci_get_devfn() function
  of/pci: Add of_pci_parse_bus_range() function

Thomas Petazzoni (14):
  pci: infrastructure to add drivers in drivers/pci/host
  arm: pci: add a align_resource hook
  clk: mvebu: create parent-child relation for PCIe clocks on Armada
    370
  clk: mvebu: add more PCIe clocks for Armada XP
  pci: PCIe driver for Marvell Armada 370/XP systems
  arm: mvebu: PCIe support is now available on mvebu
  arm: mvebu: add PCIe Device Tree informations for Armada 370
  arm: mvebu: add PCIe Device Tree informations for Armada XP
  arm: mvebu: PCIe Device Tree informations for OpenBlocks AX3-4
  arm: mvebu: PCIe Device Tree informations for Armada XP DB
  arm: mvebu: PCIe Device Tree informations for Armada 370 Mirabox
  arm: mvebu: PCIe Device Tree informations for Armada 370 DB
  arm: mvebu: PCIe Device Tree informations for Armada XP GP
  arm: mvebu: update defconfig with PCI and USB support

 .../devicetree/bindings/pci/mvebu-pci.txt          |  220 +++++
 arch/arm/boot/dts/armada-370-db.dts                |   17 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |   16 +
 arch/arm/boot/dts/armada-370.dtsi                  |   51 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |   33 +
 arch/arm/boot/dts/armada-xp-gp.dts                 |   21 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  104 +++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  122 +++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  188 +++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |    9 +
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/include/asm/mach/pci.h                    |   11 +
 arch/arm/kernel/bios32.c                           |    6 +
 arch/arm/mach-mvebu/Kconfig                        |    2 +
 arch/microblaze/include/asm/pci-bridge.h           |    5 +-
 arch/microblaze/pci/pci-common.c                   |  192 -----
 arch/mips/pci/pci.c                                |   50 +-
 arch/powerpc/include/asm/pci-bridge.h              |    5 +-
 arch/powerpc/kernel/pci-common.c                   |  192 -----
 drivers/clk/mvebu/clk-gating-ctrl.c                |   18 +-
 drivers/of/address.c                               |   63 ++
 drivers/of/of_pci.c                                |  227 ++++-
 drivers/pci/Kconfig                                |    2 +
 drivers/pci/Makefile                               |    3 +
 drivers/pci/host/Kconfig                           |    8 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-mvebu.c                       |  879 ++++++++++++++++++++
 include/linux/of_address.h                         |   42 +
 include/linux/of_pci.h                             |    6 +
 29 files changed, 2059 insertions(+), 437 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt
 create mode 100644 drivers/pci/host/Kconfig
 create mode 100644 drivers/pci/host/Makefile
 create mode 100644 drivers/pci/host/pci-mvebu.c

-- 
1.7.9.5

