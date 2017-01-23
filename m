Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWQTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2017 11:19:15 -0500
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with deferred probing or error
Date: Mon, 23 Jan 2017 21:48:09 +0530
Message-Id: <1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Failures to look up an IOMMU when parsing the DT iommus property need to
be handled separately from the .of_xlate() failures to support deferred
probing.

The lack of a registered IOMMU can be caused by the lack of a driver for
the IOMMU, the IOMMU device probe not having been performed yet, having
been deferred, or having failed.

The first case occurs when the device tree describes the bus master and
IOMMU topology correctly but no device driver exists for the IOMMU yet
or the device driver has not been compiled in. Return NULL, the caller
will configure the device without an IOMMU.

The second and third cases are handled by deferring the probe of the bus
master device which will eventually get reprobed after the IOMMU.

The last case is currently handled by deferring the probe of the bus
master device as well. A mechanism to either configure the bus master
device without an IOMMU or to fail the bus master device probe depending
on whether the IOMMU is optional or mandatory would be a good
enhancement.

Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/base/dma-mapping.c | 5 +++--
 drivers/iommu/of_iommu.c   | 5 +++--
 drivers/of/device.c        | 9 +++++++--
 include/linux/of_device.h  | 9 ++++++---
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 449b948..82bd45c 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -353,6 +353,7 @@ int dma_configure(struct device *dev)
 {
 	struct device *bridge = NULL, *dma_dev = dev;
 	enum dev_dma_attr attr;
+	int ret = 0;
 
 	if (dev_is_pci(dev)) {
 		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
@@ -363,7 +364,7 @@ int dma_configure(struct device *dev)
 	}
 
 	if (dma_dev->of_node) {
-		of_dma_configure(dev, dma_dev->of_node);
+		ret = of_dma_configure(dev, dma_dev->of_node);
 	} else if (has_acpi_companion(dma_dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
@@ -373,7 +374,7 @@ int dma_configure(struct device *dev)
 	if (bridge)
 		pci_put_host_bridge_device(bridge);
 
-	return 0;
+	return ret;
 }
 
 void dma_deconfigure(struct device *dev)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 349bd1d..9529d6c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -223,7 +224,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
-	return IS_ERR(ops) ? NULL : ops;
+	return ops;
 }
 
 static int __init of_iommu_init(void)
@@ -234,7 +235,7 @@ static int __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1c843e2..d58595c 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -82,7 +82,7 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-void of_dma_configure(struct device *dev, struct device_node *np)
+int of_dma_configure(struct device *dev, struct device_node *np)
 {
 	u64 dma_addr, paddr, size;
 	int ret;
@@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask + 1;
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
@@ -129,10 +129,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index d20a31a..6dca65c 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-void of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev, struct device_node *np);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
@@ -99,8 +99,11 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	return NULL;
 }
-static inline void of_dma_configure(struct device *dev, struct device_node *np)
-{}
+
+static inline int of_dma_configure(struct device *dev, struct device_node *np)
+{
+	return 0;
+}
 static inline void of_dma_deconfigure(struct device *dev)
 {}
 #endif /* CONFIG_OF */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

