Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:52986 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2HQXgR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:17 -0400
Received: by mail-ee0-f74.google.com with SMTP id d4so192260eek.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:16 -0700 (PDT)
Subject: [PATCH v2 06/16] PCI: Use list_for_each_entry() for bus->devices
	traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:15 -0600
Message-ID: <20120817233615.10973.98099.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace list_for_each() + pci_dev_b() with the simpler
list_for_each_entry().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |   13 ++++++-------
 drivers/pci/search.c |    6 ++----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index b18dc2e..f17a027 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -114,16 +114,17 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 
 static void __pci_remove_behind_bridge(struct pci_dev *dev)
 {
-	struct list_head *l, *n;
+	struct pci_dev *child, *tmp;
 
 	if (dev->subordinate)
-		list_for_each_safe(l, n, &dev->subordinate->devices)
-			__pci_remove_bus_device(pci_dev_b(l));
+		list_for_each_entry_safe(child, tmp,
+					 &dev->subordinate->devices, bus_list)
+			__pci_remove_bus_device(child);
 }
 
 static void pci_stop_bus_devices(struct pci_bus *bus)
 {
-	struct list_head *l, *n;
+	struct pci_dev *dev, *tmp;
 
 	/*
 	 * VFs could be removed by pci_stop_and_remove_bus_device() in the
@@ -133,10 +134,8 @@ static void pci_stop_bus_devices(struct pci_bus *bus)
 	 * We can iterate the list backwards to get prev valid PF instead
 	 *  of removed VF.
 	 */
-	list_for_each_prev_safe(l, n, &bus->devices) {
-		struct pci_dev *dev = pci_dev_b(l);
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list)
 		pci_stop_bus_device(dev);
-	}
 }
 
 /**
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 993d4a0..f56b237 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -130,16 +130,14 @@ pci_find_next_bus(const struct pci_bus *from)
  * decrement the reference count by calling pci_dev_put().
  * If no device is found, %NULL is returned.
  */
-struct pci_dev * pci_get_slot(struct pci_bus *bus, unsigned int devfn)
+struct pci_dev *pci_get_slot(struct pci_bus *bus, unsigned int devfn)
 {
-	struct list_head *tmp;
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
 	down_read(&pci_bus_sem);
 
-	list_for_each(tmp, &bus->devices) {
-		dev = pci_dev_b(tmp);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->devfn == devfn)
 			goto out;
 	}

