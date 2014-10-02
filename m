Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56321 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbaJBD7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:23 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH V3] Delay allocation of PCI device IRQs from boot time until bus scan time to fix PCI hotplugging
Date: Thu,  2 Oct 2014 04:50:19 +0100
Message-Id: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Matthew Minter <matt@masarand.com>

pci_fixup_irqs is the current method used in most arches to assign IRQs to
PCI devices. This has a number of flaws including it requiring an extra walk
of the PCI bus and most importantly not running for devices which are added
after boot time, this includes hot-added devices on boards that support this.

This patch set modifies the IRQ mapping and swizzling infrastructure
such that functions are registered by the boot code (instead of being
run directly by the boot code) and then run later in the enable_device
path such that it will apply to all devices and not only those inserted
at boot time.

This is cleaner as it unifies how each architecture allocates PCI IRQs as much
as possible (some arches were particularly resistant to these changes so some
work-arounds have been used or the change disabled completely).

The caveat here is that I have been forced to modify some architecture specific
code for various architectures which I cannot test due to not having such boards
available. The code seems correct and the changes in most cases are small and
trivial however I have not tested all the patches for rare arches.

NEW: Since the last version all changes and suggested bug fixes have been implemented
the patch-set has also been rebased onto the latest kernel version to ease merging.

Many Thanks,
Matthew

Note also that I have switched email addresses due to a change in employment
but I am indeed the same person who submitted the previous versions of this patch.

 arch/alpha/kernel/pci.c                 | 16 +++---
 arch/alpha/kernel/sys_nautilus.c        |  1 -
 arch/arm/kernel/bios32.c                | 13 +++--
 arch/cris/arch-v32/drivers/pci/bios.c   | 14 ++---
 arch/frv/mb93090-mb00/pci-frv.h         |  1 -
 arch/frv/mb93090-mb00/pci-irq.c         | 28 ++++++----
 arch/frv/mb93090-mb00/pci-vdk.c         |  1 -
 arch/ia64/pci/pci.c                     |  3 ++
 arch/m68k/platform/coldfire/pci.c       |  8 ++-
 arch/microblaze/pci/pci-common.c        | 10 ++--
 arch/mips/pci/pci.c                     |  9 +++-
 arch/mn10300/unit-asb2305/pci-asb2305.h |  5 +-
 arch/mn10300/unit-asb2305/pci-irq.c     | 25 ++-------
 arch/mn10300/unit-asb2305/pci.c         | 21 +++-----
 arch/parisc/kernel/pci.c                |  8 ++-
 arch/powerpc/kernel/pci-common.c        | 26 ++++-----
 arch/s390/pci/pci.c                     |  7 +++
 arch/sh/drivers/pci/fixups-cayman.c     |  2 +-
 arch/sh/drivers/pci/fixups-dreamcast.c  |  2 +-
 arch/sh/drivers/pci/fixups-r7780rp.c    |  2 +-
 arch/sh/drivers/pci/fixups-rts7751r2d.c |  6 +--
 arch/sh/drivers/pci/fixups-sdk7780.c    |  4 +-
 arch/sh/drivers/pci/fixups-se7751.c     |  2 +-
 arch/sh/drivers/pci/fixups-sh03.c       |  2 +-
 arch/sh/drivers/pci/fixups-snapgear.c   |  2 +-
 arch/sh/drivers/pci/fixups-titan.c      |  4 +-
 arch/sh/drivers/pci/pci.c               | 10 ++--
 arch/sh/drivers/pci/pcie-sh7786.c       |  2 +-
 arch/sparc/kernel/leon_pci.c            | 12 ++++-
 arch/sparc/kernel/pci.c                 | 21 ++++++--
 arch/tile/kernel/pci.c                  | 10 ++--
 arch/tile/kernel/pci_gx.c               | 10 ++--
 arch/unicore32/kernel/pci.c             | 11 ++--
 arch/x86/include/asm/pci_x86.h          |  7 +--
 arch/x86/kernel/x86_init.c              |  1 -
 arch/x86/pci/acpi.c                     |  5 +-
 arch/x86/pci/common.c                   |  2 -
 arch/x86/pci/irq.c                      | 94 ++++++++++++++++++---------------
 drivers/of/of_pci_irq.c                 |  2 +-
 drivers/pci/Makefile                    | 15 +-----
 drivers/pci/host-bridge.c               |  2 +-
 drivers/pci/pci.c                       |  5 +-
 drivers/pci/pci.h                       |  1 +
 drivers/pci/probe.c                     | 12 -----
 drivers/pci/setup-irq.c                 | 34 ++++++------
 include/linux/pci.h                     |  6 ++-
 46 files changed, 265 insertions(+), 219 deletions(-)

