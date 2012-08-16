Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:57211 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab2HPXdn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 19:33:43 -0400
Received: by eekd4 with SMTP id d4so157745eek.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:33:41 -0700 (PDT)
Subject: [PATCH 4/6] parisc/PCI: Use list_for_each_entry() for bus->devices
	traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-parisc@vger.kernel.org
Date: Thu, 16 Aug 2012 17:26:36 -0600
Message-ID: <20120816232635.3662.73917.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
References: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace list_for_each() + pci_dev_b() with the simpler
list_for_each_entry().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-parisc@vger.kernel.org
---
 drivers/parisc/dino.c    |    6 ++----
 drivers/parisc/lba_pci.c |    7 ++-----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index ffddc4f..4581ee0 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -477,14 +477,12 @@ dino_card_setup(struct pci_bus *bus, void __iomem *base_addr)
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
index 4ce57c9..fdd63a6 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -629,7 +629,6 @@ truncate_pat_collision(struct resource *root, struct resource *new)
 static void
 lba_fixup_bus(struct pci_bus *bus)
 {
-	struct list_head *ln;
 	struct pci_dev *dev;
 #ifdef FBB_SUPPORT
 	u16 status;
@@ -711,10 +710,9 @@ lba_fixup_bus(struct pci_bus *bus)
 
 	}
 
-	list_for_each(ln, &bus->devices) {
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
-		dev = pci_dev_b(ln);
 		DBG("lba_fixup_bus() %s\n", pci_name(dev));
 
 		/* Virtualize Device/Bridge Resources. */
@@ -771,8 +769,7 @@ lba_fixup_bus(struct pci_bus *bus)
 	}
 
 	/* Lastly enable FBB/PERR/SERR on all devices too */
-	list_for_each(ln, &bus->devices) {
-		dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		(void) pci_read_config_word(dev, PCI_COMMAND, &status);
 		status |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR | fbb_enable;
 		(void) pci_write_config_word(dev, PCI_COMMAND, status);

