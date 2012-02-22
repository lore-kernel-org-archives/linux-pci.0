Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v1 00/11] generic pci_probe_only flag
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Wed, 22 Feb 2012 11:19:01 -0700
Message-ID: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series moves all architectures to a uniform way of indicating that we
shouldn't touch PCI resource assignments done by firmware.  Previously, we had
a mix of using the PCI_PROBE_ONLY bit in pci_flags or arch-specific variables
like "pci_probe_only" or "use_firmware."  This moves everybody to using the
PCI_PROBE_ONLY bit.

I want to do this to make it easier to move some resource assignment
functionality into the PCI core, while still allowing the architectures
to prevent resource changes.

The core has a very complicated interface for scanning buses and assigning
resources to devices, including these and probably other functions:

    pci_create_root_bus
    pci_scan_root_bus
    pci_add_new_bus
    pci_scan_bus
    pci_scan_slot
    pci_scan_child_bus
    pci_bus_size_bridges
    pci_bus_assign_resources
    pci_assign_unassigned_bridge_resources
    pci_claim_resource
    pci_enable_bridges
    pci_bus_add_devices

When you look at all the users of these interfaces (mostly architecture code
and hotplug drivers) and how many things are similar but not quite the same,
it's amazing that things work at all.  I think we'll be better off if we
can make some of this functionality internal to the core and simplify the
external interface.

These patches are also available in this git repo:
    git://github.com/bjorn-helgaas/linux.git pci-probe-only-v1-2bb44f1

Or you can browse them here:
    https://github.com/bjorn-helgaas/linux/compare/master...pci-probe-only-v1-2bb44f1

---

Bjorn Helgaas (11):
      PCI: make pci_flags always available
      PCI: add pci_clear_flags()
      alpha/PCI: replace pci_probe_only with pci_flags
      arm/PCI: remove arch pci_flags definition
      arm/PCI: use pci_flags PCI_PROBE_ONLY instead of arm-specific flag
      microblaze/PCI: remove unused pci_flags
      mips/PCI: replace pci_probe_only with pci_flags
      mips/PCI: removed unused pci_probe configurability
      powerpc/PCI: replace pci_probe_only with pci_flags
      unicore32/PCI: use pci_flags PCI_PROBE_ONLY instead of arm-specific flag
      PCI: make pci_flags non-weak


 arch/alpha/include/asm/pci.h              |    1 +
 arch/alpha/kernel/pci.c                   |   15 ++++-----
 arch/alpha/kernel/pci_impl.h              |    3 --
 arch/alpha/kernel/sys_marvel.c            |    3 +-
 arch/alpha/kernel/sys_titan.c             |    3 +-
 arch/arm/kernel/bios32.c                  |    7 ++--
 arch/arm/mm/iomap.c                       |    3 --
 arch/microblaze/include/asm/pci-bridge.h  |    1 -
 arch/microblaze/pci/pci-common.c          |   48 +++++------------------------
 arch/mips/include/asm/pci.h               |    3 +-
 arch/mips/pci/pci-bcm1480.c               |    2 +
 arch/mips/pci/pci-ip27.c                  |    2 +
 arch/mips/pci/pci-lantiq.c                |    3 +-
 arch/mips/pci/pci-sb1250.c                |    2 +
 arch/mips/pci/pci-xlr.c                   |    2 +
 arch/mips/pci/pci.c                       |   19 ++++-------
 arch/powerpc/include/asm/ppc-pci.h        |    2 -
 arch/powerpc/kernel/pci-common.c          |    3 --
 arch/powerpc/kernel/pci_64.c              |    5 ---
 arch/powerpc/kernel/rtas_pci.c            |   10 ++++--
 arch/powerpc/kernel/setup_64.c            |    1 +
 arch/powerpc/platforms/iseries/pci.c      |    2 +
 arch/powerpc/platforms/maple/pci.c        |    2 +
 arch/powerpc/platforms/pasemi/pci.c       |    2 +
 arch/powerpc/platforms/powermac/pci.c     |    2 +
 arch/powerpc/platforms/powernv/pci-ioda.c |    5 +--
 arch/powerpc/platforms/powernv/pci.c      |    4 +-
 arch/powerpc/platforms/wsp/wsp_pci.c      |    2 +
 arch/unicore32/kernel/pci.c               |    6 ++--
 drivers/pci/setup-bus.c                   |    3 ++
 include/asm-generic/pci-bridge.h          |    6 ++++
 31 files changed, 67 insertions(+), 105 deletions(-)

-- 
Bjorn
