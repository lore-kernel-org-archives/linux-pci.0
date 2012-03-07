Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:43040 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031691Ab2CGBAJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2012 20:00:09 -0500
Received: by eaaq10 with SMTP id q10so213220eaa.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2012 17:00:08 -0800 (PST)
Subject: [PATCH v1 0/9] PCI core support for bus-to-resource offsets (fixes)
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 06 Mar 2012 18:00:06 -0700
Message-ID: <20120307005905.27465.71131.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a set of fixes related to my recent "remove device resource fixups"
series.  Patches [1-4] are essential; they fix bugs that prevent machines from
booting.  Patches [5-9] don't fix any current issues, so they could be
deferred.

[1] ("fix bridge I/O window bus-to-resource conversion") fixes a mistake
so bus-to-resource conversion of I/O port addresses will work correctly.

[2-4] ("compute I/O space bus-to-resource" and "convert devtree bus
addresses" for powerpc and sparc) fix an oversight: I forgot to apply
bus-to-resource when reading bus addresses from the OF device tree, so
machines using the device tree don't boot.

[5-6] ("don't export pci_flags" and "move <asm-generic/pci-bridge.h>
include") are simple no-op cleanups.

[7-9] are basically a reimplementation of the "EN1K" (1K granularity
for P2P I/O windows) functionality, and removal of the sparc bridge
window reading code, since it is now functionally equivalent to the
generic code.
---

Bjorn Helgaas (9):
      PCI: fix bridge I/O window bus-to-resource conversion
      powerpc/PCI: compute I/O space bus-to-resource offset consistently
      powerpc/PCI: convert devtree bus addresses to resource
      sparc/PCI: convert devtree bus addresses to resource
      arm/PCI: don't export pci_flags
      unicore32/PCI: move <asm-generic/pci-bridge.h> include to asm/pci.h
      PCI: allow P2P bridge windows starting at PCI bus address zero
      PCI: reimplement P2P bridge 1K I/O windows (Intel P64H2)
      sparc/PCI: replace pci_cfg_fake_ranges() with pci_read_bridge_bases()


 arch/arm/kernel/bios32.c          |    1 
 arch/powerpc/include/asm/pci.h    |    1 
 arch/powerpc/kernel/pci-common.c  |    8 ++
 arch/powerpc/kernel/pci_32.c      |    6 +-
 arch/powerpc/kernel/pci_64.c      |    2 -
 arch/powerpc/kernel/pci_of_scan.c |   12 ++-
 arch/sparc/kernel/pci.c           |  127 +++++--------------------------------
 arch/unicore32/include/asm/pci.h  |    1 
 arch/unicore32/kernel/pci.c       |    1 
 drivers/pci/probe.c               |   30 +++++----
 drivers/pci/quirks.c              |   39 -----------
 drivers/pci/setup-bus.c           |   11 +++
 include/linux/pci.h               |    1 
 include/linux/pci_regs.h          |    3 +
 14 files changed, 66 insertions(+), 177 deletions(-)

-- 
Bjorn
