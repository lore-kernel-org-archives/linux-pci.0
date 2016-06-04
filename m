Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20808 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbcFDAHQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2016 20:07:16 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v12 00/15] PCI: Fixup for 64bit resource with sparc
Date: Fri,  3 Jun 2016 17:06:27 -0700
Message-Id: <20160604000642.28162-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
to 64-bit resources), we have several reports on resource allocation
failure, and we try to fix the problem with resource clip, and find
more problems.

One is from sparc that have problem with clip as we don't parse
mem64 for it.

This patchset try to fix the problem for sparc.

patch 1-2: try to fix the pci mmap for proc path for sparc, that will
make fix for sparc 64bit resource offset handling much simple.

patch 3-10: parse MEM64 for sparc and other system with OF.
So device 64bit resource could find their parent resource.

patch 11-14: MMIO64 handling enhancement
        treat non-pref mmio64 if parent bridges are all pcie.

patch 15: restore old pref allocation logic if hostbridge does not support mmio64.

Khalid Aziz tested on some sparc platforms that have different offset to
mem space start or support 64bit mmio.

-v12: add two pci_mmap_page_range() related patches, and
      only include sparc related patches at first.
      will submit other later.

Hope we can get them into v4.8.

Thanks

Yinghai

Yinghai Lu (15):
  PCI: Let pci_mmap_page_range() take extra resource pointer
  PCI: Let pci_mmap_page_range() take resource address
  sparc/PCI: Use correct offset for bus address to resource
  PCI: Add pci_find_bus_resource()
  sparc/PCI: Reserve legacy mmio after PCI mmio
  sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  sparc/PCI: Keep resource idx order with bridge register number
  powerpc/PCI: Keep resource idx order with bridge register number
  powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
  OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
  PCI: Check pref compatible bit for mem64 resource of PCIe device
  PCI: Only treat non-pref mmio64 as pref if all bridges have MEM_64
  PCI: Add has_mem64 for struct host_bridge
  PCI: Only treat non-pref mmio64 as pref if host bridge has mmio64
  PCI: Restore pref MMIO allocation logic for host bridge without mmio64

 arch/arm/include/asm/pci.h              |   2 -
 arch/arm/kernel/bios32.c                |   3 +-
 arch/cris/arch-v32/drivers/pci/bios.c   |   3 +-
 arch/cris/include/asm/pci.h             |   3 -
 arch/ia64/include/asm/pci.h             |   2 -
 arch/ia64/pci/pci.c                     |   3 +-
 arch/microblaze/include/asm/pci.h       |   3 -
 arch/microblaze/pci/pci-common.c        |  81 +++---------------
 arch/mips/include/asm/pci.h             |   3 -
 arch/mips/pci/pci.c                     |   3 +-
 arch/mn10300/include/asm/pci.h          |   3 -
 arch/mn10300/unit-asb2305/pci-asb2305.c |   3 +-
 arch/parisc/include/asm/pci.h           |   3 -
 arch/parisc/kernel/pci.c                |   3 +-
 arch/powerpc/include/asm/pci.h          |   3 -
 arch/powerpc/kernel/pci-common.c        |  81 +++---------------
 arch/powerpc/kernel/pci_of_scan.c       |  12 ++-
 arch/sh/drivers/pci/pci.c               |   3 +-
 arch/sh/include/asm/pci.h               |   2 -
 arch/sparc/include/asm/pci_64.h         |   4 -
 arch/sparc/kernel/of_device_32.c        |   5 +-
 arch/sparc/kernel/of_device_64.c        |   5 +-
 arch/sparc/kernel/pci.c                 | 147 ++++----------------------------
 arch/sparc/kernel/pci_common.c          |  91 ++++++++++++--------
 arch/sparc/kernel/pci_impl.h            |   5 ++
 arch/unicore32/include/asm/pci.h        |   2 -
 arch/unicore32/kernel/pci.c             |   3 +-
 arch/x86/include/asm/pci.h              |   4 -
 arch/x86/pci/i386.c                     |   3 +-
 arch/xtensa/include/asm/pci.h           |   4 -
 arch/xtensa/kernel/pci.c                |  78 +++--------------
 drivers/of/address.c                    |   4 +-
 drivers/pci/bus.c                       |   4 +-
 drivers/pci/pci-sysfs.c                 |  35 +++++---
 drivers/pci/pci.c                       |  31 ++++---
 drivers/pci/pci.h                       |   4 +-
 drivers/pci/probe.c                     |  40 +++++++++
 drivers/pci/proc.c                      |  65 +++++++++++---
 drivers/pci/setup-bus.c                 |  65 ++++++++++++--
 drivers/pci/setup-res.c                 |  13 ++-
 include/linux/pci.h                     |  10 +++
 41 files changed, 367 insertions(+), 474 deletions(-)

-- 
2.8.3

