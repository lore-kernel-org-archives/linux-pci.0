Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Thu, 09 Feb 2012 19:36:20 -0700
Message-ID: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's a lot of PCI-related code under arch/, but much of it is not actually
architecture-specific.  This series removes some of that code by moving most
of the bus-to-resource conversions into the core.

We currently read PCI bus addresses from BARs in the core (pci_setup_device()).
Then every arch is responsible for converting those bus addresses to CPU
resources, usually in pcibios_fixup_bus().

We already have a way for architectures to tell the core what the windows
through a host bridge are:

    LIST_HEAD(resources);
    pci_add_resource(&resources, io_space);
    pci_add_resource(&resources, mem_space);
    pci_scan_root_bus(parent, bus, ops, sysdata, &resources);

This series extends that so the arch can also tell the core about address
translation performed by the host bridge:

    LIST_HEAD(resources);
    pci_add_resource_offset(&resources, io_space, io_offset);
    pci_add_resource_offset(&resources, mem_space, mem_offset);
    pci_scan_root_bus(parent, bus, ops, sysdata, &resources);

Given that offset (the difference between bus address and CPU address for
each aperture), the core can do the bus-to-resource conversion immediately
when it reads the BARs.

This removes an opportunity for bugs (some PCI fixups currently see bus
addresses in struct pci_dev resources when they're expecting CPU addresses),
but the main reason to do this is to make our PCI resource handling simpler
and more uniform.

These patches are also available in this git repo:
    git://github.com/bjorn-helgaas/linux.git pci-offset-v2-d15af52258dd

Or you can browse them here:
    https://github.com/bjorn-helgaas/linux/compare/master...pci-offset-v2-d15af52258dd

I'd like to get these into linux-next soon to be ready for the 3.4 merge
window, so please let me know if you see any issues.

Changes since v1:
  - mips: remove Cobalt legacy IDE fixup
  - show bus address range, not offset, e.g., this:
	pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus address [0x80000000-0xfedfffff])
    instead of this:
	pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus offset 0xeff80000000)

---

Bjorn Helgaas (18):
      PCI: don't publish new root bus until it's fully initialized
      PCI: add struct pci_host_bridge and a list of all bridges found
      PCI: add struct pci_host_bridge_window with CPU/bus address offset
      PCI: convert bus addresses to resource when reading BARs
      PCI: add generic pcibios_resource_to_bus()
      alpha/PCI: get rid of device resource fixups
      arm/PCI: get rid of device resource fixups
      ia64/PCI: SN: convert to pci_scan_root_bus() for correct root bus resources
      ia64/PCI: get rid of device resource fixups
      microblaze/PCI: get rid of device resource fixups
      mips/PCI: get rid of device resource fixups
      mn10300/PCI: get rid of device resource fixups
      parisc/PCI: get rid of device resource fixups
      powerpc/PCI: get rid of device resource fixups
      sh/PCI: get rid of device resource fixups
      sparc/PCI: get rid of device resource fixups
      xtensa/PCI: get rid of device resource fixups
      PCI: collapse pcibios_resource_to_bus


 arch/alpha/include/asm/pci.h          |    6 -
 arch/alpha/kernel/pci.c               |   71 +----------
 arch/arm/common/it8152.c              |    4 -
 arch/arm/include/asm/pci.h            |    8 -
 arch/arm/kernel/bios32.c              |   69 +----------
 arch/arm/mach-cns3xxx/pcie.c          |    4 -
 arch/arm/mach-dove/pcie.c             |    4 -
 arch/arm/mach-footbridge/dc21285.c    |    8 +
 arch/arm/mach-integrator/pci_v3.c     |    7 +
 arch/arm/mach-iop13xx/pci.c           |    4 -
 arch/arm/mach-ixp2000/pci.c           |    6 +
 arch/arm/mach-ixp23xx/pci.c           |    6 +
 arch/arm/mach-ixp4xx/common-pci.c     |    4 -
 arch/arm/mach-kirkwood/pcie.c         |    4 -
 arch/arm/mach-ks8695/pci.c            |    4 -
 arch/arm/mach-mv78xx0/pcie.c          |    4 -
 arch/arm/mach-orion5x/pci.c           |   14 +-
 arch/arm/mach-sa1100/pci-nanoengine.c |    8 +
 arch/arm/mach-tegra/pcie.c            |    6 -
 arch/arm/mach-versatile/pci.c         |    6 -
 arch/arm/plat-iop/pci.c               |    4 -
 arch/ia64/include/asm/pci.h           |    6 -
 arch/ia64/pci/pci.c                   |   55 ---------
 arch/ia64/sn/kernel/io_init.c         |   16 ++-
 arch/microblaze/include/asm/pci.h     |    8 -
 arch/microblaze/pci/pci-common.c      |   69 -----------
 arch/mips/include/asm/pci.h           |    6 -
 arch/mips/pci/fixup-cobalt.c          |   61 ----------
 arch/mips/pci/pci.c                   |   70 -----------
 arch/mn10300/include/asm/pci.h        |   16 ---
 arch/mn10300/unit-asb2305/pci.c       |   62 +---------
 arch/parisc/include/asm/pci.h         |   38 ------
 arch/parisc/kernel/pci.c              |   52 --------
 arch/powerpc/include/asm/pci.h        |    8 -
 arch/powerpc/kernel/pci-common.c      |   79 +------------
 arch/sh/drivers/pci/pci.c             |   75 ++----------
 arch/sh/include/asm/pci.h             |    6 -
 arch/sparc/include/asm/pci_32.h       |    8 -
 arch/sparc/include/asm/pci_64.h       |    8 -
 arch/sparc/kernel/leon_pci.c          |   47 +------
 arch/sparc/kernel/pci.c               |   46 +------
 arch/xtensa/kernel/pci.c              |   17 ---
 drivers/parisc/dino.c                 |   27 +---
 drivers/parisc/lba_pci.c              |   31 +----
 drivers/pci/bus.c                     |   30 +++--
 drivers/pci/probe.c                   |  208 ++++++++++++++++++++++++++-------
 include/asm-generic/pci.h             |   24 ----
 include/linux/pci.h                   |   18 +++
 48 files changed, 331 insertions(+), 1011 deletions(-)

-- 
Signature
