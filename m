Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752827AbcKGXwC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Nov 2016 18:52:02 -0500
Subject: [PATCH] PCI: Don't attempt to claim shadow copies of ROM
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vecu Bosseur <vecu.bosseur@gmail.com>
Date: Mon, 07 Nov 2016 17:51:58 -0600
Message-ID: <20161107235158.32425.50331.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we're using a shadow copy of a PCI device ROM, the shadow copy is in RAM
and the device never sees accesses to it and doesn't respond to it.  We
don't have to route the shadow range to the PCI device, and the device
doesn't have to claim the range.

Previously we treated the shadow copy as though it were the ROM BAR, and we
failed to claim it because the region wasn't routed to the device:

  pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
  pci_bus 0000:01: Allocating resources
  pci 0000:01:00.0: can't claim BAR 6 [mem 0x000c0000-0x000dffff]: no compatible bridge window

The failure path of pcibios_allocate_dev_rom_resource() cleared out the
resource start address, which caused the following ioremap() warning:

  WARNING: CPU: 0 PID: 116 at /build/linux-akdJXO/linux-4.8.0/arch/x86/mm/ioremap.c:121 __ioremap_caller+0x1ec/0x370
  ioremap on RAM at 0x0000000000000000 - 0x000000000001ffff

Handle a shadow copy as RAM, without inserting it into the iomem tree.

This fixes a regression caused by 0c0e0736acad ("PCI: Set ROM shadow
location in arch code, not in PCI core"), which appeared in v4.6.  The
effect is failure to initialize video devices, reported on AMD Turks but
likely to affect others as well.

Fixes: 0c0e0736acad ("PCI: Set ROM shadow location in arch code, not in PCI core")
Reported-and-tested-by: Vecu Bosseur <vecu.bosseur@gmail.com>
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1627496
Link: https://bugzilla.kernel.org/show_bug.cgi?id=175391
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1352272
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.6+
---
 drivers/pci/setup-res.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 66c4d8f..9526e34 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -121,6 +121,14 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 		return -EINVAL;
 	}
 
+	/*
+	 * If we have a shadow copy in RAM, the PCI device doesn't respond
+	 * to the shadow range, so we don't need to claim it, and upstream
+	 * bridges don't need to route the range to the device.
+	 */
+	if (res->flags & IORESOURCE_ROM_SHADOW)
+		return 0;
+
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
 		dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible bridge window\n",

