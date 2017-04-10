Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
 lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
 okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
 catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: [PATCH V11 02/11] iommu/of: Prepare for deferred IOMMU configuration
Date: Mon, 10 Apr 2017 16:50:57 +0530
Message-Id: <1491823266-1209-3-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: sricharan@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 8f4e599..c8be889 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -96,6 +96,19 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
+static bool of_iommu_driver_present(struct device_node *np)
+{
+	/*
+	 * If the IOMMU still isn't ready by the time we reach init, assume
+	 * it never will be. We don't want to defer indefinitely, nor attempt
+	 * to dereference __iommu_of_table after it's been freed.
+	 */
+	if (system_state > SYSTEM_BOOTING)
+		return false;
+
+	return of_match_node(&__iommu_of_table, np);
+}
+
 static const struct iommu_ops
 *of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
 {
@@ -104,12 +117,20 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	int err;
 
 	ops = iommu_ops_from_fwnode(fwnode);
-	if (!ops || !ops->of_xlate)
+	if ((ops && !ops->of_xlate) ||
+	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
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
@@ -186,14 +207,34 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
