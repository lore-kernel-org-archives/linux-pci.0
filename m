Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:47239 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758418Ab2CGWcF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2012 17:32:05 -0500
Received: by ggnd2 with SMTP id d2so864603ggn.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Mar 2012 14:32:04 -0800 (PST)
Subject: [PATCH v3 00/34] PCI: generic probe_only flag and core
	bus-to-resource support
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 07 Mar 2012 15:32:03 -0700
Message-ID: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an update to add acks and fold in fixes for some boot failures.
To preserve bisectability, I folded the fixes into the original patches and
rebased these to PCI linux-next commit 823806f, which precedes the addition
of the original patches.

This replaces the following series:

    [PATCH v2 00/18] add PCI bus-to-resource offset support in core
    [PATCH v2 00/12] generic pci_probe_only flag
    [PATCH v1 0/9] PCI core support for bus-to-resource offsets (fixes)

The first 31 patches are currently in the PCI linux-next branch (except that
they include the fixes from the last series).  The fixes are for boot failures
and need to be in linux-next soon.

The last three (P2P windows at address zero, etc.) are new and can be
deferred if necessary.

Here's the overview of the core bus-to-resource series, which is the most
interesting work here:

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
    git://github.com/bjorn-helgaas/linux.git pci-probe_only-and-offset-v3-5eb2c1f

Or you can browse them here:
    https://github.com/bjorn-helgaas/linux/compare/pci-next-823806f...pci-probe_only-and-offset-v3-5eb2c1f

Changes since v2:
  - rebased to jbarnes linux-next branch, commit 823806f
  - fold in v2 of generic pci_probe_only series
  - fix bridge I/O window bus-to-resource (I forgot res.flags init)
  - arm: don't export pci_flags
  - powerpc: drop pci_probe_only on PA Semi
  - powerpc: fix I/O bus-to-resource offset computation
  - powerpc: fix OF address fixups
  - sparc: fix OF address fixups
  - unicore32: move asm-generic/pci-bridge.h #include to asm/pci.h
  - allow P2P bridge windows at bus address zero
  - reimplement P2P bridge 1K I/O windows
  - replace sparc pci_cfg_fake_ranges() with generic pci_read_bridge_bases()

Changes since v1:
  - mips: remove Cobalt legacy IDE fixup
  - show bus address range, not offset, e.g., this:
	pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus address [0x80000000-0xfedfffff])
    instead of this:
	pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus offset 0xeff80000000)

---

Benjamin Herrenschmidt (1):
      powerpc/PCI: make pci_probe_only default to 0

Bjorn Helgaas (33):
      PCI: make pci_flags always available
      PCI: add pci_clear_flags()
      alpha/PCI: replace pci_probe_only with pci_flags
      arm/PCI: remove arch pci_flags definition
      arm/PCI: use pci_flags PCI_PROBE_ONLY instead of arm-specific flag
      microblaze/PCI: remove unused pci_flags
      mips/PCI: replace pci_probe_only with pci_flags
      mips/PCI: removed unused pci_probe configurability
      powerpc/PCI: allow reallocation on PA Semi
      powerpc/PCI: replace pci_probe_only with pci_flags
      unicore32/PCI: use pci_flags PCI_PROBE_ONLY instead of arm-specific flag
      PCI: make pci_flags non-weak
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
      PCI: allow P2P bridge windows starting at PCI bus address zero
      PCI: reimplement P2P bridge 1K I/O windows (Intel P64H2)
      sparc/PCI: replace pci_cfg_fake_ranges() with pci_read_bridge_bases()


 arch/alpha/include/asm/pci.h              |    7 -
 arch/alpha/kernel/pci.c                   |   86 +----------
 arch/alpha/kernel/pci_impl.h              |    3 
 arch/alpha/kernel/sys_marvel.c            |    3 
 arch/alpha/kernel/sys_titan.c             |    3 
 arch/arm/common/it8152.c                  |    4 -
 arch/arm/include/asm/pci.h                |    8 -
 arch/arm/kernel/bios32.c                  |   75 +---------
 arch/arm/mach-cns3xxx/pcie.c              |    4 -
 arch/arm/mach-dove/pcie.c                 |    4 -
 arch/arm/mach-footbridge/dc21285.c        |    8 +
 arch/arm/mach-integrator/pci_v3.c         |    7 +
 arch/arm/mach-iop13xx/pci.c               |    4 -
 arch/arm/mach-ixp2000/pci.c               |    6 +
 arch/arm/mach-ixp23xx/pci.c               |    6 +
 arch/arm/mach-ixp4xx/common-pci.c         |    4 -
 arch/arm/mach-kirkwood/pcie.c             |    4 -
 arch/arm/mach-ks8695/pci.c                |    4 -
 arch/arm/mach-mv78xx0/pcie.c              |    4 -
 arch/arm/mach-orion5x/pci.c               |   14 +-
 arch/arm/mach-sa1100/pci-nanoengine.c     |    8 +
 arch/arm/mach-tegra/pcie.c                |    6 -
 arch/arm/mach-versatile/pci.c             |    6 -
 arch/arm/mm/iomap.c                       |    3 
 arch/arm/plat-iop/pci.c                   |    4 -
 arch/ia64/include/asm/pci.h               |    6 -
 arch/ia64/pci/pci.c                       |   55 -------
 arch/ia64/sn/kernel/io_init.c             |   16 +-
 arch/microblaze/include/asm/pci-bridge.h  |    1 
 arch/microblaze/include/asm/pci.h         |    8 -
 arch/microblaze/pci/pci-common.c          |  117 ++-------------
 arch/mips/include/asm/pci.h               |    9 -
 arch/mips/pci/fixup-cobalt.c              |   61 --------
 arch/mips/pci/pci-bcm1480.c               |    2 
 arch/mips/pci/pci-ip27.c                  |    2 
 arch/mips/pci/pci-lantiq.c                |    3 
 arch/mips/pci/pci-sb1250.c                |    2 
 arch/mips/pci/pci-xlr.c                   |    2 
 arch/mips/pci/pci.c                       |   89 +----------
 arch/mn10300/include/asm/pci.h            |   16 --
 arch/mn10300/unit-asb2305/pci.c           |   62 +-------
 arch/parisc/include/asm/pci.h             |   38 -----
 arch/parisc/kernel/pci.c                  |   52 -------
 arch/powerpc/include/asm/pci.h            |    9 -
 arch/powerpc/include/asm/ppc-pci.h        |    2 
 arch/powerpc/kernel/pci-common.c          |   86 +----------
 arch/powerpc/kernel/pci_32.c              |    6 -
 arch/powerpc/kernel/pci_64.c              |    7 -
 arch/powerpc/kernel/pci_of_scan.c         |   12 +-
 arch/powerpc/kernel/rtas_pci.c            |   10 +
 arch/powerpc/platforms/iseries/pci.c      |    2 
 arch/powerpc/platforms/maple/pci.c        |    2 
 arch/powerpc/platforms/pasemi/pci.c       |    3 
 arch/powerpc/platforms/powermac/pci.c     |    3 
 arch/powerpc/platforms/powernv/pci-ioda.c |    5 -
 arch/powerpc/platforms/powernv/pci.c      |    5 -
 arch/powerpc/platforms/pseries/setup.c    |    3 
 arch/powerpc/platforms/wsp/wsp_pci.c      |    1 
 arch/sh/drivers/pci/pci.c                 |   75 +---------
 arch/sh/include/asm/pci.h                 |    6 -
 arch/sparc/include/asm/pci_32.h           |    8 -
 arch/sparc/include/asm/pci_64.h           |    8 -
 arch/sparc/kernel/leon_pci.c              |   47 +-----
 arch/sparc/kernel/pci.c                   |  167 ++-------------------
 arch/unicore32/include/asm/pci.h          |    1 
 arch/unicore32/kernel/pci.c               |    5 -
 arch/xtensa/kernel/pci.c                  |   17 --
 drivers/parisc/dino.c                     |   27 +--
 drivers/parisc/lba_pci.c                  |   31 +---
 drivers/pci/bus.c                         |   30 ++--
 drivers/pci/probe.c                       |  226 +++++++++++++++++++++++------
 drivers/pci/quirks.c                      |   39 -----
 drivers/pci/setup-bus.c                   |   14 ++
 include/asm-generic/pci-bridge.h          |    6 +
 include/asm-generic/pci.h                 |   24 ---
 include/linux/pci.h                       |   19 ++
 include/linux/pci_regs.h                  |    3 
 77 files changed, 448 insertions(+), 1287 deletions(-)

-- 
Bjorn
