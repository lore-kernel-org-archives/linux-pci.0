Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:52377 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab2HPX0W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 19:26:22 -0400
Received: by obbwc20 with SMTP id wc20so2313314obb.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:21 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 087B6100047
	for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:21 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id A0FA4180640
	for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:20 -0700 (PDT)
Subject: [PATCH 1/6] PCI: Use list_for_each_entry() for bus->devices traversal
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Aug 2012 17:26:20 -0600
Message-ID: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace list_for_each() + pci_dev_b() with the simpler
list_for_each_entry().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/remove.c |   28 ++++++++++++++--------------
 drivers/pci/search.c |    4 +---
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 04a4861..d867056 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -111,22 +111,24 @@ void pci_stop_and_remove_bus_device(struct pci_dev *dev)
 	__pci_remove_bus_device(dev);
 }
 
-static void __pci_remove_behind_bridge(struct pci_dev *dev)
+static void __pci_remove_behind_bridge(struct pci_dev *bridge)
 {
-	struct list_head *l, *n;
+	struct pci_bus *bus = bridge->subordinate;
+	struct pci_dev *dev, *tmp;
 
-	if (dev->subordinate)
-		list_for_each_safe(l, n, &dev->subordinate->devices)
-			__pci_remove_bus_device(pci_dev_b(l));
+	if (bus)
+		list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list)
+			__pci_remove_bus_device(dev);
 }
 
-static void pci_stop_behind_bridge(struct pci_dev *dev)
+static void pci_stop_behind_bridge(struct pci_dev *bridge)
 {
-	struct list_head *l, *n;
+	struct pci_bus *bus = bridge->subordinate;
+	struct pci_dev *dev, *tmp;
 
-	if (dev->subordinate)
-		list_for_each_safe(l, n, &dev->subordinate->devices)
-			pci_stop_bus_device(pci_dev_b(l));
+	if (bus)
+		list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list)
+			pci_stop_bus_device(dev);
 }
 
 /**
@@ -146,7 +148,7 @@ void pci_stop_and_remove_behind_bridge(struct pci_dev *dev)
 
 static void pci_stop_bus_devices(struct pci_bus *bus)
 {
-	struct list_head *l, *n;
+	struct pci_dev *dev, *tmp;
 
 	/*
 	 * VFs could be removed by pci_stop_and_remove_bus_device() in the
@@ -156,10 +158,8 @@ static void pci_stop_bus_devices(struct pci_bus *bus)
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
index 993d4a0..b169390 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -132,14 +132,12 @@ pci_find_next_bus(const struct pci_bus *from)
  */
 struct pci_dev * pci_get_slot(struct pci_bus *bus, unsigned int devfn)
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

