Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V8 09/11] arm64: dma-mapping: Remove the notifier trick to handle early setting of dma_ops
Date: Fri,  3 Feb 2017 21:18:51 +0530
Message-Id: <1486136933-20328-10-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With arch_setup_dma_ops now being called late during device's probe after
the device's IOMMU is probed, the notifier trick required to handle the
early setup of dma_ops before the IOMMU group gets created is not
required. So removing the notifiers here.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[rm: clean up even more]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

[*] Rebased the series against linux-next. Please note that there is an
    conflict while applying this patch against iommu-next because of the
    patch [1] "arm64: dma-mapping: Only swizzle DMA ops for IOMMU_DOMAIN_DMA"
    not there

    [1] https://www.spinics.net/lists/arm-kernel/msg556209.html

 arch/arm64/mm/dma-mapping.c | 142 ++++++--------------------------------------
 1 file changed, 18 insertions(+), 124 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 6e295e8..3653c4c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -814,34 +814,26 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	.mapping_error = iommu_dma_mapping_error,
 };
 
-/*
- * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
- * everything it needs to - the device is only partially created and the
- * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
- * need this delayed attachment dance. Once IOMMU probe ordering is sorted
- * to move the arch_setup_dma_ops() call later, all the notifier bits below
- * become unnecessary, and will go away.
- */
-struct iommu_dma_notifier_data {
-	struct list_head list;
-	struct device *dev;
-	const struct iommu_ops *ops;
-	u64 dma_base;
-	u64 size;
-};
-static LIST_HEAD(iommu_dma_masters);
-static DEFINE_MUTEX(iommu_dma_notifier_lock);
+static int __init __iommu_dma_init(void)
+{
+	return iommu_dma_init();
+}
+arch_initcall(__iommu_dma_init);
 
-static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
-			   u64 dma_base, u64 size)
+static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				  const struct iommu_ops *ops)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain;
+
+	if (!ops)
+		return;
 
 	/*
-	 * If the IOMMU driver has the DMA domain support that we require,
-	 * then the IOMMU core will have already configured a group for this
-	 * device, and allocated the default domain for that group.
+	 * The IOMMU core code allocates the default DMA domain, which the
+	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
+	domain = iommu_get_domain_for_dev(dev);
+
 	if (!domain)
 		goto out_err;
 
@@ -852,109 +844,11 @@ static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
 		dev->archdata.dma_ops = &iommu_dma_ops;
 	}
 
-	return true;
+	return;
+
 out_err:
 	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
-		 dev_name(dev));
-	return false;
-}
-
-static void queue_iommu_attach(struct device *dev, const struct iommu_ops *ops,
-			      u64 dma_base, u64 size)
-{
-	struct iommu_dma_notifier_data *iommudata;
-
-	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
-	if (!iommudata)
-		return;
-
-	iommudata->dev = dev;
-	iommudata->ops = ops;
-	iommudata->dma_base = dma_base;
-	iommudata->size = size;
-
-	mutex_lock(&iommu_dma_notifier_lock);
-	list_add(&iommudata->list, &iommu_dma_masters);
-	mutex_unlock(&iommu_dma_notifier_lock);
-}
-
-static int __iommu_attach_notifier(struct notifier_block *nb,
-				   unsigned long action, void *data)
-{
-	struct iommu_dma_notifier_data *master, *tmp;
-
-	if (action != BUS_NOTIFY_BIND_DRIVER)
-		return 0;
-
-	mutex_lock(&iommu_dma_notifier_lock);
-	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
-		if (data == master->dev && do_iommu_attach(master->dev,
-				master->ops, master->dma_base, master->size)) {
-			list_del(&master->list);
-			kfree(master);
-			break;
-		}
-	}
-	mutex_unlock(&iommu_dma_notifier_lock);
-	return 0;
-}
-
-static int __init register_iommu_dma_ops_notifier(struct bus_type *bus)
-{
-	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
-	int ret;
-
-	if (!nb)
-		return -ENOMEM;
-
-	nb->notifier_call = __iommu_attach_notifier;
-
-	ret = bus_register_notifier(bus, nb);
-	if (ret) {
-		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
-			bus->name);
-		kfree(nb);
-	}
-	return ret;
-}
-
-static int __init __iommu_dma_init(void)
-{
-	int ret;
-
-	ret = iommu_dma_init();
-	if (!ret)
-		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
-	if (!ret)
-		ret = register_iommu_dma_ops_notifier(&amba_bustype);
-#ifdef CONFIG_PCI
-	if (!ret)
-		ret = register_iommu_dma_ops_notifier(&pci_bus_type);
-#endif
-	return ret;
-}
-arch_initcall(__iommu_dma_init);
-
-static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				  const struct iommu_ops *ops)
-{
-	struct iommu_group *group;
-
-	if (!ops)
-		return;
-	/*
-	 * TODO: As a concession to the future, we're ready to handle being
-	 * called both early and late (i.e. after bus_add_device). Once all
-	 * the platform bus code is reworked to call us late and the notifier
-	 * junk above goes away, move the body of do_iommu_attach here.
-	 */
-	group = iommu_group_get(dev);
-	if (group) {
-		do_iommu_attach(dev, ops, dma_base, size);
-		iommu_group_put(group);
-	} else {
-		queue_iommu_attach(dev, ops, dma_base, size);
-	}
+		dev_name(dev));
 }
 
 void arch_teardown_dma_ops(struct device *dev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

