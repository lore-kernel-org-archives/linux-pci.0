Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:38916 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab2IYI04 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:56 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 28/29] PCI: kill pci_find_next_bus
Date: Tue, 25 Sep 2012 01:26:29 -0700
Message-Id: <1348561590-28067-29-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/search.c |   37 +++++++------------------------------
 include/linux/pci.h  |    4 ----
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index f072b54..630e788 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -79,44 +79,22 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
  */
 struct pci_bus * pci_find_bus(int domain, int busnr)
 {
-	struct pci_bus *bus = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 	struct pci_bus *tmp_bus;
 
-	while ((bus = pci_find_next_bus(bus)) != NULL)  {
-		if (pci_domain_nr(bus) != domain)
+	for_each_pci_host_bridge(host_bridge) {
+		if (pci_domain_nr(host_bridge->bus) != domain)
 			continue;
-		tmp_bus = pci_do_find_bus(bus, busnr);
-		if (tmp_bus)
+		tmp_bus = pci_do_find_bus(host_bridge->bus, busnr);
+		if (tmp_bus) {
+			put_device(&host_bridge->dev);
 			return tmp_bus;
+		}
 	}
 	return NULL;
 }
 
 /**
- * pci_find_next_bus - begin or continue searching for a PCI bus
- * @from: Previous PCI bus found, or %NULL for new search.
- *
- * Iterates through the list of known PCI busses.  A new search is
- * initiated by passing %NULL as the @from argument.  Otherwise if
- * @from is not %NULL, searches continue from next device on the
- * global list.
- */
-struct pci_bus * 
-pci_find_next_bus(const struct pci_bus *from)
-{
-	struct list_head *n;
-	struct pci_bus *b = NULL;
-
-	WARN_ON(in_interrupt());
-	down_read(&pci_bus_sem);
-	n = from ? from->node.next : pci_root_buses.next;
-	if (n != &pci_root_buses)
-		b = pci_bus_b(n);
-	up_read(&pci_bus_sem);
-	return b;
-}
-
-/**
  * pci_get_slot - locate PCI device for a given PCI slot
  * @bus: PCI bus on which desired PCI device resides
  * @devfn: encodes number of PCI slot in which the desired PCI 
@@ -355,7 +333,6 @@ EXPORT_SYMBOL(pci_dev_present);
 
 /* For boot time work */
 EXPORT_SYMBOL(pci_find_bus);
-EXPORT_SYMBOL(pci_find_next_bus);
 /* For everyone */
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1e45d6f..c7ca6e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -758,7 +758,6 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
-struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from);
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
@@ -1400,9 +1399,6 @@ static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
 static inline void pci_unblock_cfg_access(struct pci_dev *dev)
 { }
 
-static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
-{ return NULL; }
-
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
 { return NULL; }
-- 
1.7.7

