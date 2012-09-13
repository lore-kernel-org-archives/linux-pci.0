Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39282 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534Ab2IMQCp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2012 12:02:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so4170633pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 13 Sep 2012 09:02:45 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/2] PCI: remove host bridge hotplug unsafe interface pci_get_next_bus()
Date: Fri, 14 Sep 2012 00:00:10 +0800
Message-Id: <1347552010-6718-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1347552010-6718-1-git-send-email-jiang.liu@huawei.com>
References: <1347552010-6718-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAErSpo4=cakjCQ_Z_nUa2xZQr9KV72kxtsgrW0cjeFN=ktb8zQ@mail.gmail.com>
References: <CAErSpo4=cakjCQ_Z_nUa2xZQr9KV72kxtsgrW0cjeFN=ktb8zQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove host bridge hotplug unsafe interface pci_get_next_bus(), it has
been replaced by pci_{get|put}_root_buses().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/search.c |   25 -------------------------
 include/linux/pci.h  |    4 ----
 2 files changed, 29 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 8b20a33..7aadd45 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -116,30 +116,6 @@ struct pci_bus * pci_find_bus(int domain, int busnr)
 	return bus;
 }
 
-/**
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
 struct pci_bus **
 pci_get_root_buses(int *bus_num)
 {
@@ -396,7 +372,6 @@ EXPORT_SYMBOL(pci_dev_present);
 
 /* For boot time work */
 EXPORT_SYMBOL(pci_find_bus);
-EXPORT_SYMBOL(pci_find_next_bus);
 /* For everyone */
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bc1ab5f..ea78235 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -756,7 +756,6 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
-struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 struct pci_bus ** pci_get_root_buses(int *bus_num);
 void pci_put_root_buses(struct pci_bus **buses, int count);
 
@@ -1401,9 +1400,6 @@ static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
 static inline void pci_unblock_cfg_access(struct pci_dev *dev)
 { }
 
-static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
-{ return NULL; }
-
 static inline struct pci_bus ** pci_get_root_buses(int *bus_num)
 {
 	*bus_num = 0;
-- 
1.7.9.5

