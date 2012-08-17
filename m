Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab2HQXfq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:35:46 -0400
Received: by obbwc20 with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:35:45 -0700 (PDT)
Subject: [PATCH v2 00/16] Clean up drivers/pci/remove.c
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:35:44 -0600
Message-ID: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This started as a simple conversion of list_for_each() to
list_for_each_entry(), so I could remove the pci_dev_b() helper.

In the process, I noticed that drivers/pci/remove.c is getting a little
crufty, so I reworked it to make it more understandable.  This is a long
series of small patches, so it might be easiest to start by looking at the
end product, so you have some idea where I'm heading.

Here's the final version of remove.c:
http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=blob;f=drivers/pci/remove.c/pci/remove.c;h=4f9ca9162895edd8216fda36e055949541d44012;hb=refs/heads/pci/bjorn-cleanup-remove

This is based on v3.6-rc1 and replaces the 6-patch series I posted on Aug 16.

I've booted this on x86, but I don't have facilities to test the
interesting hotplug changes, so any review and/or testing is welcome.

---

Bjorn Helgaas (16):
      PCI: acpiphp: Stop disabling bridges on remove
      PCI: acpiphp: Use common pci_stop_and_remove_bus_device()
      pcmcia: Use common pci_stop_and_remove_bus_device()
      PCI: Don't export stop_bus_device and remove_bus_device interfaces
      PCI: Remove pci_stop_and_remove_behind_bridge()
      PCI: Use list_for_each_entry() for bus->devices traversal
      PCI: Fold stop and remove helpers into their callers
      PCI: Stop and remove devices in one pass
      PCI: Remove unused, commented-out, code
      PCI: Rename local variables to conventional names
      PCI: Leave normal LIST_POISON in deleted list entries
      frv/PCI: Use list_for_each_entry() for bus->devices traversal
      parisc/PCI: Enable PERR/SERR on all devices
      parisc/PCI: Use list_for_each_entry() for bus->devices traversal
      sgi-agp: Use list_for_each_entry() for bus->devices traversal
      PCI: Remove unused pci_dev_b()


 arch/frv/mb93090-mb00/pci-vdk.c    |    4 -
 drivers/char/agp/sgi-agp.c         |    5 +
 drivers/parisc/dino.c              |    6 +-
 drivers/parisc/lba_pci.c           |    7 +-
 drivers/pci/hotplug/acpiphp_glue.c |   46 -------------
 drivers/pci/proc.c                 |   19 -----
 drivers/pci/remove.c               |  131 ++++++------------------------------
 drivers/pci/rom.c                  |   59 ----------------
 drivers/pci/search.c               |    6 +-
 drivers/pcmcia/cardbus.c           |    7 +-
 include/linux/pci.h                |    4 -
 11 files changed, 37 insertions(+), 257 deletions(-)
