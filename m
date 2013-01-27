Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47481 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3A0Fhj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:37:39 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 05/22] PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
Date: Sat, 26 Jan 2013 21:36:26 -0800
Message-Id: <1359265003-16166-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

use bus_find_device to loop host_bridges.

-v2: fixes compiling error when CONFIG_PCI is not defined that Fengguang Wu found.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/search.c |   24 ++++++++++++++++++++++++
 include/linux/pci.h  |    9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index d0627fa..db0c3a9 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -178,6 +178,30 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
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
+EXPORT_SYMBOL_GPL(pci_get_next_host_bridge);
+
 static int match_pci_dev_by_id(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9da06ec..67879cb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -375,6 +375,8 @@ struct pci_host_bridge {
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
+#define for_each_pci_host_bridge(d) while ((d = pci_get_next_host_bridge(d)) != NULL)
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
@@ -763,6 +765,7 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
+struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from);
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
 				struct pci_dev *from);
 struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
@@ -1418,6 +1421,12 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
 { return NULL; }
 
+static inline struct pci_host_bridge *pci_get_next_host_bridge(
+			struct pci_host_bridge *host_bridge)
+{
+	return NULL;
+}
+
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
 #define dev_num_vf(d) (0)
-- 
1.7.10.4

