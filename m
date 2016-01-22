Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:34661 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbcAVOvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jan 2016 09:51:23 -0500
From: Geliang Tang <geliangtang@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: Use list_first_entry_or_null() to simplify code
Date: Fri, 22 Jan 2016 22:50:19 +0800
Message-Id: <50073d35dca3c0ef34dddce4e6e2bf4bda6fdfe5.1453474124.git.geliangtang@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use list_first_entry_or_null() instead of list_empty() + list_entry()
to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/pci/pcie/aer/aer_inject.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 20db790..f5a245f 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -124,16 +124,13 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
 static struct pci_bus_ops *pci_bus_ops_pop(void)
 {
 	unsigned long flags;
-	struct pci_bus_ops *bus_ops = NULL;
+	struct pci_bus_ops *bus_ops;
 
 	spin_lock_irqsave(&inject_lock, flags);
-	if (list_empty(&pci_bus_ops_list))
-		bus_ops = NULL;
-	else {
-		struct list_head *lh = pci_bus_ops_list.next;
-		list_del(lh);
-		bus_ops = list_entry(lh, struct pci_bus_ops, list);
-	}
+	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
+					   struct pci_bus_ops, list);
+	if (bus_ops)
+		list_del(&bus_ops->list);
 	spin_unlock_irqrestore(&inject_lock, flags);
 	return bus_ops;
 }
-- 
2.5.0


