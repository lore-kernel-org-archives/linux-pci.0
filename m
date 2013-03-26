Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53479 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934764Ab3CZQSp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:18:45 -0400
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
Subject: [PATCHv6 00/17] PCIe support for the Armada 370 and Armada XP SoCs
Date: Tue, 26 Mar 2013 17:18:22 +0100
Message-Id: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This series of patches introduces PCIe support for the Marvell Armada
370 and Armada XP. In the future, we plan to extend the driver to
cover Kirkwood platforms, and possibly other Marvell EBU platforms as
well.

As we are approaching 3.10, I would now like to get formal Acked-by,
or disagreements from the following maintainers/developers :

 * Grant Likely, as the OF maintainer, for patches 1, 2 and 3

   [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT ranges
   [PATCH v5 02/17] of/pci: Add of_pci_get_devfn() function
   [PATCH v5 03/17] of/pci: Add of_pci_parse_bus_range() function

 * Bjorn Helgaas, as the PCI maintainer, for patches 4 and 8

   [PATCH v5 04/17] pci: infrastructure to add drivers in drivers/pci/host
   [PATCH v5 08/17] pci: PCIe driver for Marvell Armada 370/XP systems

 * Russell King, as the ARM maintainer, for patch 5

   [PATCH v5 05/17] arm: pci: add a align_resource hook

 * Arnd Bergmann, Mitch Bradley and Jason Gunthorpe, for patch 8 (the
   PCIe driver itself), and specifically the Device Tree binding.

   [PATCH v5 08/17] pci: PCIe driver for Marvell Armada 370/XP systems

This patch set depends on:

 * The arm-soc/mvebu/cleanup branch in Arnd and Olof arm-soc tree

 * [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/156883.html

For easier testing, the code has been pushed to:

  git://github.com/MISL-EBU-System-SW/mainline-public.git marvell-pcie-v6

This PATCHv6 follows:
 * PATCHv5, sent on March, 21st 2013
 * PATCHv4, sent on March, 8th 2013
 * PATCHv3, sent on February, 12th 2013
 * PATCHv2, sent on January, 28th 2013
 * RFCv1, sent on December, 7th 2012

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

A quick description of the patches:

 * Patches 1 to 3 add PCI-related Device Tree parsing functions. Those
   patches are common with the Nvidia Tegra PCIe patch set from
   Thierry Redding. They are included in this series so that it can be
   tested easily.

 * Patch 4 extends the ARM PCI core to store a per-controller private
   data pointer. This patch is common with the Nvidia Tegra PCIe patch
   set from Thierry Redding. It is included in this series so that it
   can be tested easily.

 * Patch 5 fixes a problem in lib/devres.c that prevents certain
   PCI-related functions from being visible on NO_IOPORT platforms. I
   know this patch isn't acceptable by itself, but the discussion
   about this has been so huge and went in so many directions that in
   the end, I don't know what is the correct way of fixing this. If an
   agreement is found on how to fix this properly, I'm willing to work
   on it if needed.

 * Patch 6 extends the ARM PCI core with an additional hook that a PCI
   controller driver can register and get called to realign PCI
   ressource addresses. This is needed for the support of Marvell PCIe
   interfaces because the address decoding windows for I/O ranges have
   a granularity of 64 KB, while the PCI standard requires only a 4 KB
   alignement. See the patch itself for details.

 * Patch 7 fixes a mistake in the interrupt controller node of the
   Armada 370/XP Device Tree, which was invisible until we started
   using the of_irq_map_raw() function, needed in our PCIe support.

 * Patches 8 and 9 fix some issues in the Armada 370/XP clock gating
   driver, related to PCIe interfaces.

 * Patches 10 and 11 are cleanup/refactoring of the common plat-orion
   address decoding code, in preparation for further changes related
   to PCIe.

 * Patches 12 to 17 introduce a ORION_ADDR_MAP_NO_REMAP define that is
   used by existing Marvell SoC code to say "I don't need this window
   to remap anything". Previously a -1 value was used as the remap
   address to communicate the fact that no remap is needed, but this
   prevents any remap address higher than 2 GB.

 * Patch 18 removes __init from a few address window decoding
   functions that are now needed after boot.

 * Patch 19 introduces in the common plat-orion address decoding code
   functions to allocate/free an address decoding window. Until now,
   the address decoding windows were configured statically. With
   Armada XP having up to 10 PCIe interfaces, we don't want to
   allocate useless address decoding windows statically, so we move to
   a more dynamic model in which address decoding windows are
   configured only for the PCIe interfaces that are actually in use.

 * Patch 20 removes __init from a few PCIe functions that are now
   needed after boot.

 * Patch 21 improves the Armada 370/XP specific address decoding code
   to provide functions that add and remove an address decoding window
   for a given PCIe interface. It relies on the common functions added
   in patch 19.

 * Patch 22 makes the common plat-orion PCIe code available on
   PLAT_ORION platforms such as ARCH_MVEBU.

 * Patch 23 creates the drivers/pci/host directory and makes the
   related minimal changes to Kconfig/Makefile. This patch will
   trivially conflict with the NVidia Tegra PCIe support posted by
   Thierry Redding, which also creates the drivers/pci/host directory.

 * Patch 24 contains the Armada 370/XP PCIe driver itself, that
   implements the necessary operations required by the ARM PCI core,
   and configures the address decoding windows as needed. This driver
   relies on a Device Tree description of the PCIe interfaces.

 * Patch 25 marks the ARCH_MVEBU platform has having PCI available,
   which allows the compilation of the PCIe support.

 * Patches 26 and 27 add the SoC-level Device Tree informations
   related to PCIe for Armada 370 and Armada XP.

 * Patch 28 to 31 add the board-level Device Tree informations related
   to PCIe for the Armada XP DB, Armada 370 DB, PlatHome OpenBlocks
   AX3-4 and GlobalScale Mirabox boards.

 * Patch 32 updates mvebu_defconfig with PCI and USB support.

Thanks,

Thomas

Andrew Murray (1):
  of/pci: Provide support for parsing PCI DT ranges property

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

 .../devicetree/bindings/pci/mvebu-pci.txt          |  201 +++++
 arch/arm/boot/dts/armada-370-db.dts                |   17 +
 arch/arm/boot/dts/armada-370-mirabox.dts           |   16 +
 arch/arm/boot/dts/armada-370.dtsi                  |   45 +
 arch/arm/boot/dts/armada-xp-db.dts                 |   33 +
 arch/arm/boot/dts/armada-xp-gp.dts                 |   21 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   98 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  113 +++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  170 ++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |    9 +
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/include/asm/mach/pci.h                    |   11 +
 arch/arm/kernel/bios32.c                           |    6 +
 arch/arm/mach-mvebu/Kconfig                        |    2 +
 arch/microblaze/pci/pci-common.c                   |  106 +--
 arch/mips/pci/pci.c                                |   44 +-
 arch/powerpc/kernel/pci-common.c                   |   93 +-
 drivers/clk/mvebu/clk-gating-ctrl.c                |   18 +-
 drivers/of/address.c                               |   54 ++
 drivers/of/of_pci.c                                |   59 +-
 drivers/pci/Kconfig                                |    2 +
 drivers/pci/Makefile                               |    3 +
 drivers/pci/host/Kconfig                           |    8 +
 drivers/pci/host/Makefile                          |    4 +
 drivers/pci/host/pci-mvebu.c                       |  935 ++++++++++++++++++++
 include/linux/of_address.h                         |   31 +
 include/linux/of_pci.h                             |    2 +
 27 files changed, 1920 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt
 create mode 100644 drivers/pci/host/Kconfig
 create mode 100644 drivers/pci/host/Makefile
 create mode 100644 drivers/pci/host/pci-mvebu.c

-- 
1.7.9.5

