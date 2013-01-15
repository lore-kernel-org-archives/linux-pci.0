Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4737 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab3AODOz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 22:14:55 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yu Zhao <yu.zhao@intel.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v3 3/7] PCI: introduce pci_next_fn to simplify code
Date: Tue, 15 Jan 2013 11:12:18 +0800
Message-ID: <1358219542-16880-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are several next_fn functions(no_next_fn,next_trad_fn,next_ari_fn)
now, introduce pci_next_fun to simplify the code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/probe.c |   65 +++++++++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7b9e691..abc6e31 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1349,34 +1349,44 @@ struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned next_ari_fn(struct pci_dev *dev, unsigned fn)
+/**
+ * pci_next_fn - get next fn number for device
+ * @bus: PCI bus on which desired PCI Function device resides
+ * @dev: pci device
+ * @fn: fn number of pci device
+ *
+ * return next_fn if success, if can not find next fn or fail,
+ * 0 is returned.
+ */
+int pci_next_fn(struct pci_bus *bus, struct pci_dev *dev,
+		unsigned fn)
 {
 	u16 cap;
-	unsigned pos, next_fn;
-
-	if (!dev)
-		return 0;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
-	if (!pos)
-		return 0;
-	pci_read_config_word(dev, pos + 4, &cap);
-	next_fn = cap >> 8;
-	if (next_fn <= fn)
-		return 0;
+	int pos, next_fn = 0;
+
+	if (!bus)
+		goto out;
+
+	if (!pci_ari_enabled(bus)) {
+		if (dev && !dev->multifunction)
+			goto out;
+		else
+			next_fn = (fn + 1) % 8;
+	} else {
+		if (!dev)
+			goto out;
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
+		if (!pos)
+			goto out;
+		pci_read_config_word(dev, pos + 4, &cap);
+		next_fn = cap >> 8;
+		if (next_fn <= fn)
+			next_fn = 0;
+	}
+out:
 	return next_fn;
 }
 
-static unsigned next_trad_fn(struct pci_dev *dev, unsigned fn)
-{
-	return (fn + 1) % 8;
-}
-
-static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
-{
-	return 0;
-}
-
 static int only_one_child(struct pci_bus *bus)
 {
 	struct pci_dev *parent = bus->self;
@@ -1406,7 +1416,6 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
 	unsigned fn, nr = 0;
 	struct pci_dev *dev;
-	unsigned (*next_fn)(struct pci_dev *, unsigned) = no_next_fn;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
@@ -1417,12 +1426,8 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	if (!dev->is_added)
 		nr++;
 
-	if (pci_ari_enabled(bus))
-		next_fn = next_ari_fn;
-	else if (dev->multifunction)
-		next_fn = next_trad_fn;
-
-	for (fn = next_fn(dev, 0); fn > 0; fn = next_fn(dev, fn)) {
+	for (fn = pci_next_fn(bus, dev, 0); fn > 0;
+			fn = pci_next_fn(bus, dev, fn)) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
 			if (!dev->is_added)
-- 
1.7.1


