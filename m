Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 2/7] platform-msi: Factor out allocation/free of private data
Date: Thu, 15 Oct 2015 16:39:23 +0100
Message-Id: <1444923568-17413-3-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As we're going to have multiple paths to allocate/free the
platform-msi private data, factor this out into separate
utility functions.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/platform-msi.c | 84 ++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 6148c78..92666cd 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -189,21 +189,11 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	return domain;
 }
 
-/**
- * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
- * @dev:		The device for which to allocate interrupts
- * @nvec:		The number of interrupts to allocate
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- *
- * Returns:
- * Zero for success, or an error code in case of failure
- */
-int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
-				   irq_write_msi_msg_t write_msi_msg)
+static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
+					irq_write_msi_msg_t write_msi_msg,
+					struct platform_msi_priv_data **data)
 {
-	struct platform_msi_priv_data *priv_data;
-	int err;
-
+	struct platform_msi_priv_data *datap;
 	/*
 	 * Limit the number of interrupts to 256 per device. Should we
 	 * need to bump this up, DEV_ID_SHIFT should be adjusted
@@ -222,22 +212,51 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (!list_empty(dev_to_msi_list(dev)))
 		return -EBUSY;
 
-	priv_data = kzalloc(sizeof(*priv_data), GFP_KERNEL);
-	if (!priv_data)
+	datap = *data = kzalloc(sizeof(**data), GFP_KERNEL);
+	if (!datap)
 		return -ENOMEM;
 
-	priv_data->devid = ida_simple_get(&platform_msi_devid_ida,
-					  0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
-	if (priv_data->devid < 0) {
-		err = priv_data->devid;
-		goto out_free_data;
+	datap->devid = ida_simple_get(&platform_msi_devid_ida,
+				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
+	if (datap->devid < 0) {
+		int err = datap->devid;
+		kfree(*data);
+		return err;
 	}
 
-	priv_data->write_msg = write_msi_msg;
+	datap->write_msg = write_msi_msg;
+
+	return 0;
+}
+
+static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
+{
+	ida_simple_remove(&platform_msi_devid_ida, data->devid);
+	kfree(data);
+}
+
+/**
+ * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
+ * @dev:		The device for which to allocate interrupts
+ * @nvec:		The number of interrupts to allocate
+ * @write_msi_msg:	Callback to write an interrupt message for @dev
+ *
+ * Returns:
+ * Zero for success, or an error code in case of failure
+ */
+int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
+				   irq_write_msi_msg_t write_msi_msg)
+{
+	struct platform_msi_priv_data *priv_data;
+	int err;
+
+	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg, &priv_data);
+	if (err)
+		return err;
 
 	err = platform_msi_alloc_descs(dev, nvec, priv_data);
 	if (err)
-		goto out_free_id;
+		goto out_free_priv_data;
 
 	err = msi_domain_alloc_irqs(dev->msi_domain, dev, nvec);
 	if (err)
@@ -247,10 +266,8 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
-out_free_id:
-	ida_simple_remove(&platform_msi_devid_ida, priv_data->devid);
-out_free_data:
-	kfree(priv_data);
+out_free_priv_data:
+	platform_msi_free_priv_data(priv_data);
 
 	return err;
 }
@@ -261,16 +278,11 @@ out_free_data:
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	struct msi_desc *desc;
-
-	desc = first_msi_entry(dev);
-	if (desc) {
-		struct platform_msi_priv_data *data;
-
-		data = desc->platform.msi_priv_data;
+	if (!list_empty(dev_to_msi_list(dev))) {
+		struct msi_desc *desc;
 
-		ida_simple_remove(&platform_msi_devid_ida, data->devid);
-		kfree(data);
+		desc = first_msi_entry(dev);
+		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 
 	msi_domain_free_irqs(dev->msi_domain, dev);
-- 
2.1.4

