Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:54886 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab2JPHLb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2012 03:11:31 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>,
	<kernel.openeuler@huawei.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 2/3] PCI: introduce pci_next_fn to get next func number
Date: Tue, 16 Oct 2012 15:10:19 +0800
Message-ID: <1350371420-7888-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1350371420-7888-1-git-send-email-wangyijing@huawei.com>
References: <1350371420-7888-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_next_fn function to get next fn number.Since
this function maybe used by PCI module(eg. pciehp),so export it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/pci.h   |    1 +
 drivers/pci/probe.c |   67 +++++++++++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d6eb3d9..fe411f4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -212,6 +212,7 @@ extern int pci_resource_bar(struct pci_dev *dev, int resno,
 			    enum pci_bar_type *type);
 extern int pci_bus_add_child(struct pci_bus *bus);
 extern void pci_configure_ari(struct pci_dev *dev);
+extern int pci_next_fn(struct pci_bus *parent, int devfn);
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bb7ecf6..435ee60 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1345,33 +1345,49 @@ struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned next_ari_fn(struct pci_dev *dev, unsigned fn)
+/**
+ * pci_next_fn - get next fn number for device
+ * @bus: PCI bus on which desired PCI Function device resides
+ * @devfn: encodes number of pci device
+ *
+ * return next_fn if success, if can not find next fn or fail,
+ * 0 is returned.
+ */
+int pci_next_fn(struct pci_bus *bus, int devfn)
 {
 	u16 cap;
-	unsigned pos, next_fn;
-
+	unsigned pos, next_fn = 0;
+	struct pci_dev *dev;
+
+	if (!bus || devfn < 0)
+		goto out;
+
+	dev = pci_get_slot(bus, devfn);
 	if (!dev)
-		return 0;
+		goto out;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
-	if (!pos)
-		return 0;
-	pci_read_config_word(dev, pos + 4, &cap);
-	next_fn = cap >> 8;
-	if (next_fn <= fn)
-		return 0;
+	if (!pci_ari_enabled(bus)) {
+		if (!dev->multifunction)
+			goto release;
+		else
+			next_fn = (PCI_FUNC(devfn) + 1) % 8;
+	} else {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
+		if (!pos)
+			goto release;
+		pci_read_config_word(dev, pos + 4, &cap);
+		next_fn = cap >> 8;
+		if (next_fn <= PCI_FUNC(devfn)) {
+			next_fn = 0;
+			goto release;
+		}
+	}
+release:
+	pci_dev_put(dev);
+out:
 	return next_fn;
 }
-
-static unsigned next_trad_fn(struct pci_dev *dev, unsigned fn)
-{
-	return (fn + 1) % 8;
-}
-
-static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
-{
-	return 0;
-}
+EXPORT_SYMBOL(pci_next_fn);
 
 static int only_one_child(struct pci_bus *bus)
 {
@@ -1402,7 +1418,6 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
 	unsigned fn, nr = 0;
 	struct pci_dev *dev;
-	unsigned (*next_fn)(struct pci_dev *, unsigned) = no_next_fn;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
@@ -1413,12 +1428,8 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	if (!dev->is_added)
 		nr++;
 
-	if (pci_ari_enabled(bus))
-		next_fn = next_ari_fn;
-	else if (dev->multifunction)
-		next_fn = next_trad_fn;
-
-	for (fn = next_fn(dev, 0); fn > 0; fn = next_fn(dev, fn)) {
+	for (fn = pci_next_fn(bus, PCI_DEVFN(PCI_SLOT(devfn), 0)); fn > 0;
+			fn = pci_next_fn(bus, PCI_DEVFN(PCI_SLOT(devfn), fn))) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
 			if (!dev->is_added)
-- 
1.7.1


