Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V7 02/11] iommu/of: Prepare for deferred IOMMU configuration
Date: Mon, 23 Jan 2017 21:48:04 +0530
Message-Id: <1485188293-20263-3-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Robin Murphy <robin.murphy@arm.com>

IOMMU configuration represents unchanging properties of the hardware,
and as such should only need happen once in a device's lifetime, but
the necessary interaction with the IOMMU device and driver complicates
exactly when that point should be.

Since the only reasonable tool available for handling the inter-device
dependency is probe deferral, we need to prepare of_iommu_configure()
to run later than it is currently called (i.e. at driver probe rather
than device creation), to handle being retried, and to tell whether a
not-yet present IOMMU should be waited for or skipped (by virtue of
having declared a built-in driver or not).

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index ee49081..349bd1d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -104,12 +104,20 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	int err;
 
 	ops = iommu_get_instance(fwnode);
-	if (!ops || !ops->of_xlate)
+	if ((ops && !ops->of_xlate) ||
+	    (!ops && !of_match_node(&__iommu_of_table, iommu_spec->np)))
 		return NULL;
 
 	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
 	if (err)
 		return ERR_PTR(err);
+	/*
+	 * The otherwise-empty fwspec handily serves to indicate the specific
+	 * IOMMU device we're waiting for, which will be useful if we ever get
+	 * a proper probe-ordering dependency mechanism in future.
+	 */
+	if (!ops)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	err = ops->of_xlate(dev, iommu_spec);
 	if (err)
@@ -186,14 +194,34 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
 	const struct iommu_ops *ops;
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 
 	if (!master_np)
 		return NULL;
 
+	if (fwspec) {
+		if (fwspec->ops)
+			return fwspec->ops;
+
+		/* In the deferred case, start again from scratch */
+		iommu_fwspec_free(dev);
+	}
+
 	if (dev_is_pci(dev))
 		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
 	else
 		ops = of_platform_iommu_init(dev, master_np);
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
+	    dev->bus && !dev->iommu_group) {
+		int err = ops->add_device(dev);
+
+		if (err)
+			ops = ERR_PTR(err);
+	}
 
 	return IS_ERR(ops) ? NULL : ops;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

