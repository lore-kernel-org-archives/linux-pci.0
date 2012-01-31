Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v3 0/14] PCI: allocate pci bus num range for unassigned bridge busn
Date: Mon, 30 Jan 2012 23:42:38 -0800
Message-Id: <1327995772-11388-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

25b9b3c: PCI: Seperate child bus scanning to two passes overall
58fe568: PCI: kill pci_fixup_parent_subordinate_busnr()
72a276a: PCI: Allocate bus range instead of use max blindly
3e65251: PCI: Strict checking of valid range for bridge
a06b7d3: PCI: Probe safe range that we can use for unassigned bridge.
f7d1b3e: PCI: Add pci_bus_extend/shrink_top()
941553d: PCI, parisc: Register busn_res for root buses
44ade6c: PCI, powerpc: Register busn_res for root buses
c96df0d: PCI, ia64: Register busn_res for root buses
370ff8b: PCI, x86: Register busn_res for root buses
12aa505: PCI: Add busn_res tracking in core
5729f35: PCI: Add busn_res operation functions
b7283c2: PCI: Add iobusn_resource
443e84a: Make %pR could handle bus resource with domain

Set up iobusn_resource tree, and register bus number range to it.
Later when need to find bus range, will try to allocate from the tree

Need to test on arches other than x86. esp for ia64 and powerpc that support
  more than on peer root buses.

could be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-busn-alloc

-v2: according to Jesse, split to more small patches.
-v3: address some request from Bjorn. like make use %pR for busn_res debug print
	out, and move the comment change with code change.

Thanks

Yinghai

 arch/ia64/pci/pci.c              |    2 +
 arch/powerpc/kernel/pci-common.c |    7 +-
 arch/x86/include/asm/topology.h  |    3 +-
 arch/x86/pci/acpi.c              |    8 +-
 arch/x86/pci/bus_numa.c          |    8 +-
 arch/x86/pci/common.c            |   11 +-
 drivers/parisc/dino.c            |    2 +
 drivers/parisc/lba_pci.c         |    3 +
 drivers/pci/probe.c              |  410 ++++++++++++++++++++++++++++++--------
 drivers/pci/remove.c             |    1 +
 include/linux/ioport.h           |    1 +
 include/linux/pci.h              |    8 +
 kernel/resource.c                |    8 +
 lib/vsprintf.c                   |   28 +++-
 14 files changed, 402 insertions(+), 98 deletions(-)
