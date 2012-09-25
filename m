Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35490 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab2IYI0l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:41 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 12/29] PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
Date: Tue, 25 Sep 2012 01:26:13 -0700
Message-Id: <1348561590-28067-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

use bus_find_device to loop host_bridges.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/search.c |   23 +++++++++++++++++++++++
 include/linux/pci.h  |    3 +++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bf969ba..f072b54 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -178,6 +178,29 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 }
 EXPORT_SYMBOL(pci_get_domain_bus_and_slot);
 
+static int match_pci_host_bridge(struct device *dev, void *data)
+{
+	return 1;
+}
+
+struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from)
+{
+	struct device *dev;
+	struct device *dev_start = NULL;
+	struct pci_host_bridge *bridge = NULL;
+
+	WARN_ON(in_interrupt());
+	if (from)
+		dev_start = &from->dev;
+	dev = bus_find_device(&pci_host_bridge_bus_type, dev_start, NULL,
+			      match_pci_host_bridge);
+	if (dev)
+		bridge = to_pci_host_bridge(dev);
+	if (from)
+		put_device(&from->dev);
+	return bridge;
+}
+
 static int match_pci_dev_by_id(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cc8b558..1e45d6f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -394,6 +394,8 @@ struct pci_host_bridge {
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
+#define for_each_pci_host_bridge(d) while (d = pci_get_next_host_bridge(d))
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
@@ -758,6 +760,7 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
+struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from);
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 				struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
-- 
1.7.7

