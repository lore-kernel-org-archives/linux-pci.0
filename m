Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56926 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab2IYP7W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 11:59:22 -0400
Received: by pbbrr4 with SMTP id rr4so332674pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 08:59:22 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
Date: Tue, 25 Sep 2012 23:56:19 +0800
Message-Id: <1348588579-16970-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1348561590-28067-13-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-13-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

use bus_find_device to loop host_bridges.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/search.c |   22 ++++++++++++++++++++++
 include/linux/pci.h  |    3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bf969ba..5e82905 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -178,6 +178,28 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 }
 EXPORT_SYMBOL(pci_get_domain_bus_and_slot);
 
+static int match_pci_host_bridge(struct device *dev, void *data)
+{
+	return 1;
+}
+
+struct pci_bus *pci_get_next_root_bus(struct pci_bus *bus)
+{
+	struct device *dev;
+
+	WARN_ON(in_interrupt());
+	dev = bus_find_device(&pci_host_bridge_bus_type,
+			      bus ? bus->bridge : NULL,
+			      NULL,
+			      match_pci_host_bridge);
+	if (bus)
+		put_device(bus->bridge);
+	if (dev)
+		return to_pci_host_bridge(dev)->bus;
+
+	return NULL;
+}
+
 static int match_pci_dev_by_id(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index be1de01..54e8fa1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -394,6 +394,8 @@ struct pci_host_bridge {
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
+#define for_each_pci_root_bus(bus) while (bus = pci_get_next_root_bus(bus))
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
@@ -757,6 +759,7 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
+struct pci_bus *pci_get_next_root_bus(struct pci_bus *from);
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 				struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
-- 
1.7.9.5

