Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:34840 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbeIFBJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:09:41 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 14/20] PCI: Create recursive bus walk
Date: Wed,  5 Sep 2018 14:35:40 -0600
Message-Id: <20180905203546.21921-15-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a callback to walking the pci bus needs to walk its own subtree, this
could potentially deadlock if any other task takes the pci bus write
lock. This patch fixes that by providing a recursive safe callback for
when the read lock is already held.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/bus.c   | 14 +++++++++++---
 include/linux/pci.h |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b2518f9..a1106d265bdc 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -376,16 +376,17 @@ EXPORT_SYMBOL(pci_bus_add_devices);
  *  other than 0, we break out.
  *
  */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata)
+void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		    void *userdata)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
 	struct list_head *next;
 	int retval;
 
+	lockdep_assert_held(&pci_bus_sem);
+
 	bus = top;
-	down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -408,6 +409,13 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		if (retval)
 			break;
 	}
+}
+
+void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		  void *userdata)
+{
+	down_read(&pci_bus_sem);
+	__pci_walk_bus(top, cb, userdata);
 	up_read(&pci_bus_sem);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7981c9a2c63c..47cdb30df55e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1319,6 +1319,9 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
+
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
-- 
2.14.4
