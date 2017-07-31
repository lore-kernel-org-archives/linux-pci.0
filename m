Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdGaQgH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 12:36:07 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@imgtec.com>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthew Minter <matt@masarand.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: [RFT PATCH 0/9] PCI: Remove pci_fixup_irqs()
Date: Mon, 31 Jul 2017 17:37:48 +0100
Message-Id: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_fixup_irqs() function allocates IRQs for all PCI devices present
in a system; those PCI devices possibly belong to different PCI bus trees
(and possibly rooted at different host bridges) and may well be enabled
(ie probed and bound to a driver) by the time pci_fixup_irqs() is called
when probing a given host bridge driver.

Furthermore, current kernel code relying on pci_fixup_irqs() to
assign legacy PCI IRQs to devices does not work at all for
hotplugged devices in that the code carrying out the IRQ fixup
is called at host bridge driver probe time, which just cannot take
into account devices hotplugged after system has booted.

The introduction of map/swizzle functions hook in struct pci_host_bridge
allows to define per-bridge map/swizzle functions, that can be used at
device probe time in PCI core code to allocate IRQs for a given device
(through pci_assign_irq()).

This series converts all arches still relying on pci_fixup_irqs() to
the new pci_scan_root_bus_bridge() API and consequently remove
pci_fixup_irqs() from the kernel in that it is not used anymore.

Compile tested only, I do not have the necessary hardware.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Matthew Minter <matt@masarand.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

Lorenzo Pieralisi (7):
  sh/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping
    hooks
  alpha/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
    mapping hooks
  m68k/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
    mapping hooks
  MIPS/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
    mapping hooks
  tile/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
    mapping hooks
  unicore32/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
    mapping hooks
  sparc/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
    mapping hooks

Matthew Minter (2):
  sh/PCI: Remove __init optimisations from IRQ mapping functions/data
  PCI: Remove pci_fixup_irqs() function

 arch/alpha/kernel/pci.c                 | 27 ++++++++++++++++------
 arch/alpha/kernel/sys_nautilus.c        | 31 +++++++++++++++++++++----
 arch/m68k/coldfire/pci.c                | 36 +++++++++++++++++++++++++----
 arch/mips/pci/pci-legacy.c              | 24 +++++++++++++------
 arch/sh/drivers/pci/fixups-cayman.c     |  2 +-
 arch/sh/drivers/pci/fixups-dreamcast.c  |  2 +-
 arch/sh/drivers/pci/fixups-r7780rp.c    |  2 +-
 arch/sh/drivers/pci/fixups-rts7751r2d.c |  6 ++---
 arch/sh/drivers/pci/fixups-sdk7780.c    |  4 ++--
 arch/sh/drivers/pci/fixups-se7751.c     |  2 +-
 arch/sh/drivers/pci/fixups-sh03.c       |  2 +-
 arch/sh/drivers/pci/fixups-snapgear.c   |  2 +-
 arch/sh/drivers/pci/fixups-titan.c      |  4 ++--
 arch/sh/drivers/pci/pci.c               | 41 ++++++++++++++++++++-------------
 arch/sh/drivers/pci/pcie-sh7786.c       |  2 +-
 arch/sparc/kernel/leon_pci.c            | 24 ++++++++++++++-----
 arch/tile/kernel/pci.c                  | 21 +++++++++++++----
 arch/tile/kernel/pci_gx.c               | 21 +++++++++++++----
 arch/unicore32/kernel/pci.c             | 35 ++++++++++++++++++++++++----
 drivers/pci/setup-irq.c                 | 24 -------------------
 include/linux/pci.h                     |  2 --
 21 files changed, 216 insertions(+), 98 deletions(-)

-- 
2.10.0
