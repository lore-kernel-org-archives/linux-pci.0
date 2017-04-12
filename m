Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/27] PCI resource mmap cleanup
Date: Wed, 12 Apr 2017 13:25:49 +0100
Message-Id: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This pursues my previous patch set all the way to its logical conclusion.

It kills off the legacy arch-provided pci_mmap_page_range() completely,
along with its vile 'address converted by pci_resource_to_user()' API
and the various bugs and other strange behaviour that various
architectures had.

In some cases like IA64 I've killed off the odd behaviour *first* in
separately reviewable patches, before the final switch over to the
generic code which should then basically have no functional effect.

To accommodate the ARM64 maintainers' desire *not* to support mmap
through /proc/bus/pci I have separated HAVE_PCI_MMAP from the sysfs
implementation, which (as of the last patch in the series) ends up
present on *all* platforms with an MMU. I still don't think that's a
*good* idea though; it's a generic part of /proc, and nobody ever did
answer my question about what *else* we can delete from /proc on ARM64
"because it's a new platform"...

I would very much like the interesting parts of this to go through the
arch maintainers' trees. I'd suggest that we can pull everything up to
and including patch 19 ("pci: Add I/O BAR support to generic
pci_mmap_resource_range()") through the PCI tree, which includes the
relatively trivial architectures. Then the others can go through the
appropriate arch tree with more careful review and testing.

Once everything's done, then we can apply something like the final
patch ("pci: Kill ARCH_GENERIC_PCI_MMAP_RESOURCE"). But that's mostly
just there for now as a demonstration of the intended end point.

This is in
 git://git.infradead.org/users/dwmw2/random-2.6.git pcimmap
 http://git.infradead.org/users/dwmw2/random-2.6.git/shortlog/refs/heads/pcimmap

David Woodhouse (27):
  pci: Fix pci_mmap_fits() for HAVE_PCI_RESOURCE_TO_USER platforms
  pci: Fix another sanity check bug in /proc/pci mmap
  pci: Only allow WC mmap on prefetchable resources
  xtensa: Do not mmap PCI BARs to userspace as write-through
  pci: Add arch_can_pci_mmap_wc() macro
  pci: Move multiple declarations of pci_mmap_page_range() to
    <linux/pci.h>
  pci: Add arch_can_pci_mmap_io() on architectures which can mmap() I/O
    space
  pci: Use BAR index in sysfs attr->private instead of resource pointer
  pci: Add BAR index argument to pci_mmap_page_range()
  pci: Add pci_mmap_resource_range() and use it for ARM64
  arm: Use generic pci_mmap_resource_range()
  cris: Use generic pci_mmap_resource_range()
  mips: Use generic pci_mmap_resource_range()
  mn10300: Use generic pci_mmap_resource_range()
  parisc: Use generic pci_mmap_resource_range()
  sh: Use generic pci_mmap_resource_range()
  unicore: Use generic pci_mmap_resource_range()
  x86: Use generic pci_mmap_resource_range()
  pci: Add I/O BAR support to generic pci_mmap_resource_range()
  powerpc: Use generic pci_mmap_resource_range()
  microblaze: Use generic pci_mmap_resource_range()
  xtensa: Use generic pci_mmap_resource_range()
  ia64: Remove redundant valid_mmap_phys_addr_range() from
    pci_mmap_page_range()
  ia64: Remove redundant checks for WC in pci_mmap_page_range()
  ia64: Use generic pci_mmap_resource_range()
  sparc: Use generic pci_mmap_resource_range()
  pci: Kill ARCH_GENERIC_PCI_MMAP_RESOURCE

 Documentation/filesystems/sysfs-pci.txt |  12 ++-
 arch/arm/include/asm/pci.h              |   2 -
 arch/arm/kernel/bios32.c                |  19 ----
 arch/cris/arch-v32/drivers/pci/bios.c   |  22 -----
 arch/cris/include/asm/pci.h             |   3 -
 arch/ia64/include/asm/pci.h             |   4 +-
 arch/ia64/pci/pci.c                     |  46 ----------
 arch/microblaze/include/asm/pci.h       |   8 +-
 arch/microblaze/pci/pci-common.c        |  99 ++------------------
 arch/mips/include/asm/pci.h             |   4 -
 arch/mips/pci/pci.c                     |  24 -----
 arch/mn10300/include/asm/pci.h          |   3 -
 arch/mn10300/unit-asb2305/pci-asb2305.c |  23 -----
 arch/parisc/include/asm/pci.h           |   3 -
 arch/parisc/kernel/pci.c                |  28 ------
 arch/powerpc/include/asm/pci.h          |   9 +-
 arch/powerpc/kernel/pci-common.c        | 105 +++-------------------
 arch/sh/drivers/pci/pci.c               |  21 -----
 arch/sh/include/asm/pci.h               |   3 +-
 arch/sparc/include/asm/pci_64.h         |   5 +-
 arch/sparc/kernel/pci.c                 | 155 --------------------------------
 arch/unicore32/include/asm/pci.h        |   2 -
 arch/unicore32/kernel/pci.c             |  23 -----
 arch/x86/include/asm/pci.h              |   6 +-
 arch/x86/pci/i386.c                     |  47 ----------
 arch/xtensa/include/asm/pci.h           |   9 +-
 arch/xtensa/kernel/pci.c                | 112 ++---------------------
 drivers/pci/Makefile                    |   1 +
 drivers/pci/mmap.c                      |  67 ++++++++++++++
 drivers/pci/pci-sysfs.c                 |  76 +++++++---------
 drivers/pci/pci.h                       |   4 +-
 drivers/pci/proc.c                      |  41 ++++++---
 include/linux/pci.h                     |  30 +++++++
 33 files changed, 211 insertions(+), 805 deletions(-)
 create mode 100644 drivers/pci/mmap.c

-- 
2.9.3
