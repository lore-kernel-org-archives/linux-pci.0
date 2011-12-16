Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:35495 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760936Ab1LPWjq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:39:46 -0500
Received: by lagu2 with SMTP id u2so115360lag.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:39:44 -0800 (PST)
Subject: [PATCH 6/6] parisc/PCI: use list_for_each_entry() for bus->devices
	traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Fri, 16 Dec 2011 15:32:00 -0700
Message-ID: <20111216223200.5963.79616.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

Note that parisc lba_fixup_bus() previously enabled FBB/PERR/SERR
repeatedly on the same device instead of doing it on all devices on
the bus.

CC: linux-parisc@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/parisc/dino.c    |    6 ++----
 drivers/parisc/lba_pci.c |    7 +++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 7ff10c1..6f5bf3e 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -478,14 +478,12 @@ dino_card_setup(struct pci_bus *bus, void __iomem *base_addr)
 	if (ccio_allocate_resource(dino_dev->hba.dev, res, _8MB,
 				F_EXTEND(0xf0000000UL) | _8MB,
 				F_EXTEND(0xffffffffUL) &~ _8MB, _8MB) < 0) {
-		struct list_head *ln, *tmp_ln;
+		struct pci_dev *dev, *tmp;
 
 		printk(KERN_ERR "Dino: cannot attach bus %s\n",
 		       dev_name(bus->bridge));
 		/* kill the bus, we can't do anything with it */
-		list_for_each_safe(ln, tmp_ln, &bus->devices) {
-			struct pci_dev *dev = pci_dev_b(ln);
-
+		list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
 			list_del(&dev->bus_list);
 		}
 			
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index d5f3d75..f0b00f8 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -630,7 +630,7 @@ truncate_pat_collision(struct resource *root, struct resource *new)
 static void
 lba_fixup_bus(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 #ifdef FBB_SUPPORT
 	u16 status;
 #endif
@@ -712,9 +712,8 @@ lba_fixup_bus(struct pci_bus *bus)
 
 	}
 
-	list_for_each(ln, &bus->devices) {
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
-		struct pci_dev *dev = pci_dev_b(ln);
 
 		DBG("lba_fixup_bus() %s\n", pci_name(dev));
 
@@ -793,7 +792,7 @@ lba_fixup_bus(struct pci_bus *bus)
 	}
 
 	/* Lastly enable FBB/PERR/SERR on all devices too */
-	list_for_each(ln, &bus->devices) {
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		(void) pci_read_config_word(dev, PCI_COMMAND, &status);
 		status |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR | fbb_enable;
 		(void) pci_write_config_word(dev, PCI_COMMAND, status);

