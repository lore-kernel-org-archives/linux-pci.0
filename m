Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab2HQXg6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:58 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:57 -0700 (PDT)
Subject: [PATCH v2 14/16] parisc/PCI: Use list_for_each_entry() for
	bus->devices traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	linux-parisc@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:56 -0600
Message-ID: <20120817233656.10973.65389.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
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

