Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36182 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbbJWFFN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:13 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Subject: [PATCH V4] Delay allocation of PCI device IRQs from boot time until bus scan time to fix PCI hotplugging
Date: Fri, 23 Oct 2015 06:03:33 +0100
Message-Id: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi again everyone, this is the extremely long awaited version 4 of this patchset.

It has been rebased to the head of the lastest mainline kernel as of a few days
ago as well as a huge number of small restructures have been included.

I have tried to include every suggested change from last round's reviewing
but appologise in advance if I missed one, there were dozens of comments which
I have tried to implement or fix. If I have indeed missed anything please let
me know, it was likely not my rejecting the feedback but just missing it while
reading through all the feedback I got.

The most notable change is this version should be bisectable as I have kept
all the old mechanisms working untill all arches have been converted to the
new code paths though I have not tested actually booting all the intermediate
versions.

I have only been able to test this on an ACPI enabled amd64 computer (my own
desktop) as I am now working on it only in free time without any resources
from a lab so testing on other arches is very much appreciated.

I shall also note that my time to work on this in the future is very limited
so any help anyone can provide in making any further changes which may be
needed if another version is required would be appreciated as to avoid more
potentially very long delays due to my limited availability.

Unlike the previous version, it should in theory be safe to apply patches
1 to 6 separately to the rest of the set, then the architecture specific
patch sets could be applied in any order over time and the last patch to tidy
up the old code can be applied last of all.

I am sorry for all the silly whitespace fixes, found in the last version
their inclusion was due to my misconfigured editor applying them automatically
then me failing to see them while reading over the diffs.

As always, comments and testers are appreciated but I am not sure I will be
able to produce another version in the near future so any help with changes
is also very much appreciated if there are issues.

This time I have also uploaded the patch set to github to aid any testers who
do not wish to attempt to merge the patches from this email chain:

https://github.com/Vality/linux/tree/pci-fixes

Note that the changes are all in my pci-fixes branch so make sure to check
out that before building.

Many thanks,
Matthew

Patch description (same as v3) follows:

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

arch/alpha/kernel/pci.c                 |  7 ++++++-
arch/alpha/kernel/sys_nautilus.c        |  1 -
arch/arm/kernel/bios32.c                |  9 +++++++--
arch/cris/arch-v32/drivers/pci/bios.c   | 12 ++++++++----
arch/frv/mb93090-mb00/pci-frv.h         |  1 -
arch/frv/mb93090-mb00/pci-irq.c         | 24 ++++++++++++------------
arch/frv/mb93090-mb00/pci-vdk.c         |  1 -
arch/m68k/coldfire/pci.c                |  8 +++++++-
arch/microblaze/pci/pci-common.c        |  9 ++++++---
arch/mips/pci/pci.c                     |  9 +++++++--
arch/mn10300/unit-asb2305/pci-asb2305.h |  5 +----
arch/mn10300/unit-asb2305/pci-irq.c     | 24 ++++--------------------
arch/mn10300/unit-asb2305/pci.c         | 19 ++++++-------------
arch/powerpc/kernel/pci-common.c        | 25 ++++++++++++-------------
arch/sh/drivers/pci/fixups-cayman.c     |  2 +-
arch/sh/drivers/pci/fixups-dreamcast.c  |  2 +-
arch/sh/drivers/pci/fixups-r7780rp.c    |  2 +-
arch/sh/drivers/pci/fixups-rts7751r2d.c |  6 +++---
arch/sh/drivers/pci/fixups-sdk7780.c    |  4 ++--
arch/sh/drivers/pci/fixups-se7751.c     |  2 +-
arch/sh/drivers/pci/fixups-sh03.c       |  2 +-
arch/sh/drivers/pci/fixups-snapgear.c   |  2 +-
arch/sh/drivers/pci/fixups-titan.c      |  4 ++--
arch/sh/drivers/pci/pci.c               | 10 +++++++---
arch/sh/drivers/pci/pcie-sh7786.c       |  2 +-
arch/sparc/kernel/leon_pci.c            | 12 ++++++++++--
arch/sparc/kernel/pci.c                 | 23 +++++++++++++++++++----
arch/tile/kernel/pci.c                  | 10 +++++++---
arch/tile/kernel/pci_gx.c               | 10 +++++++---
arch/unicore32/kernel/pci.c             | 11 ++++++++---
arch/x86/include/asm/pci_x86.h          |  7 ++++---
arch/x86/kernel/x86_init.c              |  1 -
arch/x86/pci/acpi.c                     | 15 ---------------
arch/x86/pci/irq.c                      | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
drivers/of/of_pci_irq.c                 |  2 +-
drivers/pci/Makefile                    | 16 ++--------------
drivers/pci/host/pci-host-generic.c     |  5 ++++-
drivers/pci/host/pci-versatile.c        |  7 +++++--
drivers/pci/host/pcie-iproc.c           | 12 ++++++++----
drivers/pci/pci.c                       |  2 ++
drivers/pci/pci.h                       |  1 +
drivers/pci/setup-irq.c                 | 34 ++++++++++++++++------------------
include/linux/pci.h                     |  5 +++--
43 files changed, 246 insertions(+), 210 deletions(-)
