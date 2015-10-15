Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36731 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbbJOPjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 11:39:35 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 1/7] platform-msi: Allow MSIs to be allocated in chunks
Date: Thu, 15 Oct 2015 16:39:22 +0100
Message-Id: <1444923568-17413-2-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MSIs for a given device are normally all allocated in one go.
Make sure the internal code can allocate them one at a time
if required.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/platform-msi.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 5df4575..6148c78 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 
 #define DEV_ID_SHIFT	24
+#define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
 
 /*
  * Internal data structure containing a (made up, but unique) devid
@@ -110,13 +111,16 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_write_msi_msg = platform_msi_write_msg;
 }
 
-static void platform_msi_free_descs(struct device *dev)
+static void platform_msi_free_descs(struct device *dev, int base, int nvec)
 {
 	struct msi_desc *desc, *tmp;
 
 	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		list_del(&desc->list);
-		free_msi_entry(desc);
+		if (desc->platform.msi_index >= base &&
+		    desc->platform.msi_index < (base + nvec)) {
+			list_del(&desc->list);
+			free_msi_entry(desc);
+		}
 	}
 }
 
@@ -124,17 +128,22 @@ static int platform_msi_alloc_descs(struct device *dev, int nvec,
 				    struct platform_msi_priv_data *data)
 
 {
-	int i;
+	struct msi_desc *desc;
+	int i, base = 0;
 
-	for (i = 0; i < nvec; i++) {
-		struct msi_desc *desc;
+	if (!list_empty(dev_to_msi_list(dev))) {
+		desc = list_last_entry(dev_to_msi_list(dev),
+				       struct msi_desc, list);
+		base = desc->platform.msi_index + 1;
+	}
 
+	for (i = 0; i < nvec; i++) {
 		desc = alloc_msi_entry(dev);
 		if (!desc)
 			break;
 
 		desc->platform.msi_priv_data = data;
-		desc->platform.msi_index = i;
+		desc->platform.msi_index = base + i;
 		desc->nvec_used = 1;
 
 		list_add_tail(&desc->list, dev_to_msi_list(dev));
@@ -142,7 +151,7 @@ static int platform_msi_alloc_descs(struct device *dev, int nvec,
 
 	if (i != nvec) {
 		/* Clean up the mess */
-		platform_msi_free_descs(dev);
+		platform_msi_free_descs(dev, base, nvec);
 
 		return -ENOMEM;
 	}
@@ -201,8 +210,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	 * accordingly (which would impact the max number of MSI
 	 * capable devices).
 	 */
-	if (!dev->msi_domain || !write_msi_msg || !nvec ||
-	    nvec > (1 << (32 - DEV_ID_SHIFT)))
+	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
 		return -EINVAL;
 
 	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
@@ -238,7 +246,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	return 0;
 
 out_free_desc:
-	platform_msi_free_descs(dev);
+	platform_msi_free_descs(dev, 0, nvec);
 out_free_id:
 	ida_simple_remove(&platform_msi_devid_ida, priv_data->devid);
 out_free_data:
@@ -266,5 +274,5 @@ void platform_msi_domain_free_irqs(struct device *dev)
 	}
 
 	msi_domain_free_irqs(dev->msi_domain, dev);
-	platform_msi_free_descs(dev);
+	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
 }
-- 
2.1.4

