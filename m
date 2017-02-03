Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: <robin.murphy@arm.com>, <will.deacon@arm.com>, <joro@8bytes.org>,
        <lorenzo.pieralisi@arm.com>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <tn@semihalf.com>,
        <hanjun.guo@linaro.org>, <okaya@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org> <1486136933-20328-9-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1486136933-20328-9-git-send-email-sricharan@codeaurora.org>
Subject: RE: [PATCH V8 08/11] drivers: acpi: Handle IOMMU lookup failure with deferred probing or error
Date: Fri, 3 Feb 2017 21:45:47 +0530
Message-ID: <017301d27e38$cc361350$64a239f0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo, Robin,

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Sricharan R
>Sent: Friday, February 03, 2017 9:19 PM
>To: robin.murphy@arm.com; will.deacon@arm.com; joro@8bytes.org; lorenzo.pieralisi@arm.com; iommu@lists.linux-foundation.org;
>linux-arm-kernel@lists.infradead.org; linux-arm-msm@vger.kernel.org; m.szyprowski@samsung.com; bhelgaas@google.com; linux-
>pci@vger.kernel.org; linux-acpi@vger.kernel.org; tn@semihalf.com; hanjun.guo@linaro.org; okaya@codeaurora.org
>Cc: sricharan@codeaurora.org
>Subject: [PATCH V8 08/11] drivers: acpi: Handle IOMMU lookup failure with deferred probing or error
>
>This is an equivalent to the DT's handling of the iommu master's probe
>with deferred probing when the corrsponding iommu is not probed yet.
>The lack of a registered IOMMU can be caused by the lack of a driver for
>the IOMMU, the IOMMU device probe not having been performed yet, having
>been deferred, or having failed.
>
>The first case occurs when the firmware describes the bus master and
>IOMMU topology correctly but no device driver exists for the IOMMU yet
>or the device driver has not been compiled in. Return NULL, the caller
>will configure the device without an IOMMU.
>
>The second and third cases are handled by deferring the probe of the bus
>master device which will eventually get reprobed after the IOMMU.
>
>The last case is currently handled by deferring the probe of the bus
>master device as well. A mechanism to either configure the bus master
>device without an IOMMU or to fail the bus master device probe depending
>on whether the IOMMU is optional or mandatory would be a good
>enhancement.
>
>Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>---
> drivers/acpi/arm64/iort.c  | 25 ++++++++++++++++++++++++-
> drivers/acpi/scan.c        |  7 +++++--
> drivers/base/dma-mapping.c |  2 +-
> include/acpi/acpi_bus.h    |  2 +-
> include/linux/acpi.h       |  7 +++++--
> 5 files changed, 36 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>index bf0ed09..d01bae8 100644
>--- a/drivers/acpi/arm64/iort.c
>+++ b/drivers/acpi/arm64/iort.c
>@@ -550,8 +550,17 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
> 			return NULL;
>
> 		ops = iommu_get_instance(iort_fwnode);
>+		/*
>+		 * If the ops look-up fails, this means that either
>+		 * the SMMU drivers have not been probed yet or that
>+		 * the SMMU drivers are not built in the kernel;
>+		 * Depending on whether the SMMU drivers are built-in
>+		 * in the kernel or not, defer the IOMMU configuration
>+		 * or just abort it.
>+		 */
> 		if (!ops)
>-			return NULL;
>+			return iort_iommu_driver_enabled(node->type) ?
>+			       ERR_PTR(-EPROBE_DEFER) : NULL;
>
> 		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> 	}
>@@ -625,12 +634,26 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>
> 		while (parent) {
> 			ops = iort_iommu_xlate(dev, parent, streamid);
>+			if (IS_ERR_OR_NULL(ops))
>+				return ops;
>
> 			parent = iort_node_get_id(node, &streamid,
> 						  IORT_IOMMU_TYPE, i++);
> 		}
> 	}
>
>+	/*
>+	 * If we have reason to believe the IOMMU driver missed the initial
>+	 * add_device callback for dev, replay it to get things in order.
>+	 */
>+	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
>+	    dev->bus && !dev->iommu_group) {
>+		int err = ops->add_device(dev);
>+
>+		if (err)
>+			ops = ERR_PTR(err);
>+	}
>+

On the last post we discussed that the above replay hunk can be made
common. In trying to do that, i ended up with a patch like below. But not
sure if that should be a part of this series though. I tested with OF devices
and would have to be tested with ACPI devices once. Nothing changes
functionally because of this ideally. Should be split in two patches though.

Regards,
 Sricharan

>From aafbf2c97375a086327504f2367eaf9197c719b1 Mon Sep 17 00:00:00 2001
From: Sricharan R <sricharan@codeaurora.org>
Date: Fri, 3 Feb 2017 15:24:47 +0530
Subject: [PATCH] drivers: iommu: Add iommu_add_device api

The code to call IOMMU driver's add_device is same
for both OF and ACPI cases. So add an api which can
be shared across both the places.

Also, now with probe-deferral the iommu master devices gets
added to the respective iommus during probe time instead
of device creation time. The xlate callbacks of iommu
drivers are also called only at probe time. As a result
the add_iommu_group which gets called when the iommu is
registered to add all devices created before the iommu
becomes dummy. Similar the BUS_NOTIFY_ADD_DEVICE notification
also is not needed. So just cleanup those code.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/acpi/arm64/iort.c | 12 +-------
 drivers/iommu/iommu.c     | 70 ++++++++++++-----------------------------------
 drivers/iommu/of_iommu.c  | 11 +-------
 include/linux/iommu.h     |  8 ++++++
 4 files changed, 27 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ac45623..ab2a554 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -642,17 +642,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
                }
        }

-       /*
-        * If we have reason to believe the IOMMU driver missed the initial
-        * add_device callback for dev, replay it to get things in order.
-        */
-       if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
-           dev->bus && !dev->iommu_group) {
-               int err = ops->add_device(dev);
-
-               if (err)
-                       ops = ERR_PTR(err);
-       }
+       ops = iommu_add_device(dev, ops);

        return ops;
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b752c3d..750552d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1015,41 +1015,6 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
        return group->default_domain;
 }

-static int add_iommu_group(struct device *dev, void *data)
-{
-       struct iommu_callback_data *cb = data;
-       const struct iommu_ops *ops = cb->ops;
-       int ret;
-
-       if (!ops->add_device)
-               return 0;
-
-       WARN_ON(dev->iommu_group);
-
-       ret = ops->add_device(dev);
-
-       /*
-        * We ignore -ENODEV errors for now, as they just mean that the
-        * device is not translated by an IOMMU. We still care about
-        * other errors and fail to initialize when they happen.
-        */
-       if (ret == -ENODEV)
-               ret = 0;
-
-       return ret;
-}
-
-static int remove_iommu_group(struct device *dev, void *data)
-{
-       struct iommu_callback_data *cb = data;
-       const struct iommu_ops *ops = cb->ops;
-
-       if (ops->remove_device && dev->iommu_group)
-               ops->remove_device(dev);
-
-       return 0;
-}
-
 static int iommu_bus_notifier(struct notifier_block *nb,
                              unsigned long action, void *data)
 {
@@ -1059,13 +1024,10 @@ static int iommu_bus_notifier(struct notifier_block *nb,
        unsigned long group_action = 0;

        /*
-        * ADD/DEL call into iommu driver ops if provided, which may
+        * DEL call into iommu driver ops if provided, which may
         * result in ADD/DEL notifiers to group->notifier
         */
-       if (action == BUS_NOTIFY_ADD_DEVICE) {
-               if (ops->add_device)
-                       return ops->add_device(dev);
-       } else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
+       if (action == BUS_NOTIFY_REMOVED_DEVICE) {
                if (ops->remove_device && dev->iommu_group) {
                        ops->remove_device(dev);
                        return 0;
@@ -1107,9 +1069,6 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
        int err;
        struct notifier_block *nb;
-       struct iommu_callback_data cb = {
-               .ops = ops,
-       };

        nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
        if (!nb)
@@ -1121,18 +1080,8 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
        if (err)
                goto out_free;

-       err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
-       if (err)
-               goto out_err;
-
-
        return 0;

-out_err:
-       /* Clean up */
-       bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
-       bus_unregister_notifier(bus, nb);
-
 out_free:
        kfree(nb);

@@ -1253,6 +1202,21 @@ static int __iommu_attach_device(struct iommu_domain *domain,
        return ret;
 }

+const struct iommu_ops *iommu_add_device(struct device *dev,
+                                        const struct iommu_ops *ops)
+{
+       if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
+           dev->bus && !dev->iommu_group) {
+               int err = ops->add_device(dev);
+
+               if (err)
+                       ops = ERR_PTR(err);
+       }
+
+       return ops;
+}
+EXPORT_SYMBOL_GPL(iommu_add_device);
+
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
        struct iommu_group *group;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 2d04663..4b49dc2 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -224,17 +224,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
                ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
        else
                ops = of_platform_iommu_init(dev, master_np);
-       /*
-        * If we have reason to believe the IOMMU driver missed the initial
-        * add_device callback for dev, replay it to get things in order.
-        */
-       if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
-           dev->bus && !dev->iommu_group) {
-               int err = ops->add_device(dev);

-               if (err)
-                       ops = ERR_PTR(err);
-       }
+       ops = iommu_add_device(dev, ops);

        return ops;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index add30c3..1d54a91 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -232,6 +232,8 @@ struct iommu_ops {
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
+extern const struct iommu_ops *iommu_add_device(struct device *dev,
+                                               const struct iommu_ops *ops);
 extern int iommu_attach_device(struct iommu_domain *domain,
                               struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
@@ -405,6 +407,12 @@ static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }

+static inline const struct iommu_ops *iommu_add_device(struct device *dev,
+                                             const struct iommu_ops *ops)
+{
+       return NULL;
+}
+
 static inline int iommu_attach_device(struct iommu_domain *domain,
                                      struct device *dev)
 {
--
1.8.2.1

