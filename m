Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 05/13] drivers: iommu: make iommu_fwspec OF agnostic
Date: Wed, 20 Jul 2016 12:23:27 +0100
Message-Id: <1469013815-24380-6-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The iommu_fwspec structure, used to hold per device iommu configuration
data is not OF specific and therefore can be moved to a generic
and OF independent compilation unit.

In particular, the iommu_fwspec handling hinges on the device_node
pointer to identify the IOMMU device associated with the iommu_fwspec
structure, that is easily converted to a more generic fwnode_handle
pointer that can cater for OF and non-OF (ie ACPI) systems.

Create the files and related Kconfig entry to decouple iommu_fwspec
structure from the OF iommu kernel layer.

Given that the current iommu_fwspec implementation relies on
the arch specific struct device.archdata.iommu field in its
implementation, by making the code standalone and independent
of the OF layer this patch makes sure that the iommu_fwspec
kernel code can be selected only on arches implementing the
struct device.archdata.iommu field by adding an explicit
arch dependency in its config entry.

Current drivers using the iommu_fwspec for streamid translation
are converted to the new iommu_fwspec API by simply converting
the device_node to its fwnode_handle pointer.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/Kconfig        |   4 ++
 drivers/iommu/Makefile       |   1 +
 drivers/iommu/arm-smmu-v3.c  |  13 +++--
 drivers/iommu/iommu-fwspec.c | 114 +++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/of_iommu.c     |  52 --------------------
 include/linux/iommu-fwspec.h |  60 +++++++++++++++++++++++
 include/linux/of_iommu.h     |  24 +++------
 7 files changed, 196 insertions(+), 72 deletions(-)
 create mode 100644 drivers/iommu/iommu-fwspec.c
 create mode 100644 include/linux/iommu-fwspec.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d1c66af..2b26bfb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -67,6 +67,10 @@ config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
 
+config IOMMU_FWSPEC
+       def_bool y
+       depends on ARM64 && IOMMU_API
+
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c6edb31..dd85337 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
+obj-$(CONFIG_IOMMU_FWSPEC) += iommu-fwspec.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 98e6441..052a26c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iommu-fwspec.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -1739,9 +1740,13 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ret;
 }
 
-static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+static struct arm_smmu_device *
+arm_smmu_get_by_fwnode(struct fwnode_handle *handle)
 {
-	struct platform_device *smmu_pdev = of_find_device_by_node(np);
+	struct platform_device *smmu_pdev = NULL;
+
+	if (is_of_node(handle))
+		smmu_pdev = of_find_device_by_node(to_of_node(handle));
 
 	if (!smmu_pdev)
 		return NULL;
@@ -1780,7 +1785,7 @@ static int arm_smmu_add_device(struct device *dev)
 		master = fwspec->iommu_priv;
 		smmu = master->smmu;
 	} else {
-		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 		if (!smmu)
 			return -ENODEV;
 		master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -1892,7 +1897,7 @@ out_unlock:
 
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
-	int ret = iommu_fwspec_init(dev, args->np);
+	int ret = iommu_fwspec_init(dev, &args->np->fwnode);
 
 	if (!ret)
 		ret = iommu_fwspec_add_ids(dev, &args->args[0], 1);
diff --git a/drivers/iommu/iommu-fwspec.c b/drivers/iommu/iommu-fwspec.c
new file mode 100644
index 0000000..0600c17
--- /dev/null
+++ b/drivers/iommu/iommu-fwspec.c
@@ -0,0 +1,114 @@
+/*
+ * Firmware handling helpers for IOMMU
+ *
+ * Copyright (c) 2016 ARM Ltd.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/iommu.h>
+#include <linux/iommu-fwspec.h>
+#include <linux/of_iommu.h>
+#include <linux/slab.h>
+
+struct fwspec_iommu_node {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	const struct iommu_ops *ops;
+};
+static LIST_HEAD(fwnode_iommu_list);
+static DEFINE_SPINLOCK(fwspec_iommu_lock);
+
+void fwspec_iommu_set_ops(struct fwnode_handle *fwnode,
+			  const struct iommu_ops *ops)
+{
+	struct fwspec_iommu_node *iommu =
+				kzalloc(sizeof(*iommu), GFP_KERNEL);
+
+	if (WARN_ON(!iommu))
+		return;
+
+	INIT_LIST_HEAD(&iommu->list);
+	iommu->fwnode = fwnode;
+	iommu->ops = ops;
+	spin_lock(&fwspec_iommu_lock);
+	list_add_tail(&iommu->list, &fwnode_iommu_list);
+	spin_unlock(&fwspec_iommu_lock);
+}
+
+const struct iommu_ops *fwspec_iommu_get_ops(struct fwnode_handle *fwnode)
+{
+	struct fwspec_iommu_node *node;
+	const struct iommu_ops *ops = NULL;
+
+	spin_lock(&fwspec_iommu_lock);
+	list_for_each_entry(node, &fwnode_iommu_list, list)
+		if (node->fwnode == fwnode) {
+			ops = node->ops;
+			break;
+		}
+	spin_unlock(&fwspec_iommu_lock);
+	return ops;
+}
+
+int iommu_fwspec_init(struct device *dev,
+		      struct fwnode_handle *iommu_fwnode)
+{
+	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	const struct iommu_ops *ops;
+
+	if (fwspec)
+		return 0;
+
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	if (is_of_node(iommu_fwnode))
+		ops = of_iommu_get_ops(to_of_node(iommu_fwnode));
+	else
+		ops = fwspec_iommu_get_ops(iommu_fwnode);
+
+	fwspec->iommu_fwnode = iommu_fwnode;
+	fwspec->iommu_ops = ops;
+
+	dev->archdata.iommu = fwspec;
+	return 0;
+}
+
+void iommu_fwspec_free(struct device *dev)
+{
+	kfree(dev->archdata.iommu);
+}
+
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+{
+	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	size_t size;
+
+	if (!fwspec)
+		return -EINVAL;
+
+	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + 1]);
+	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	while (num_ids--)
+		fwspec->ids[fwspec->num_ids++] = *ids++;
+
+	dev->archdata.iommu = fwspec;
+	return 0;
+}
+
+inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 4618e89..1fe1f62 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -216,55 +216,3 @@ void __init of_iommu_init(void)
 				of_node_full_name(np));
 	}
 }
-
-int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
-{
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
-
-	if (fwspec)
-		return 0;
-
-	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
-
-	fwspec->iommu_np = of_node_get(iommu_np);
-	fwspec->iommu_ops = of_iommu_get_ops(iommu_np);
-	dev->archdata.iommu = fwspec;
-	return 0;
-}
-
-void iommu_fwspec_free(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
-
-	if (fwspec) {
-		of_node_put(fwspec->iommu_np);
-		kfree(fwspec);
-	}
-}
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
-{
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
-	size_t size;
-
-	if (!fwspec)
-		return -EINVAL;
-
-	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + 1]);
-	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
-
-	while (num_ids--)
-		fwspec->ids[fwspec->num_ids++] = *ids++;
-
-	dev->archdata.iommu = fwspec;
-	return 0;
-}
-
-inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
-{
-	return dev->archdata.iommu;
-}
diff --git a/include/linux/iommu-fwspec.h b/include/linux/iommu-fwspec.h
new file mode 100644
index 0000000..3a572c6
--- /dev/null
+++ b/include/linux/iommu-fwspec.h
@@ -0,0 +1,60 @@
+#ifndef __IOMMU_FWSPEC_H
+#define __IOMMU_FWSPEC_H
+
+#include <linux/device.h>
+#include <linux/iommu.h>
+
+struct iommu_fwspec {
+	const struct iommu_ops	*iommu_ops;
+	struct fwnode_handle	*iommu_fwnode;
+	void			*iommu_priv;
+	unsigned int		num_ids;
+	u32			ids[];
+};
+
+#ifdef CONFIG_IOMMU_FWSPEC
+int iommu_fwspec_init(struct device *dev,
+		      struct fwnode_handle *iommu_fwnode);
+void iommu_fwspec_free(struct device *dev);
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
+struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
+
+void fwspec_iommu_set_ops(struct fwnode_handle *fwnode,
+			  const struct iommu_ops *ops);
+const struct iommu_ops *fwspec_iommu_get_ops(struct fwnode_handle *fwnode);
+#else /* CONFIG_IOMMU_FWSPEC */
+static inline int iommu_fwspec_init(struct device *dev,
+				    struct fwnode_handle *iommu_fwnode)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_fwspec_free(struct device *dev)
+{
+}
+
+static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
+				       int num_ids)
+{
+	return -ENODEV;
+}
+
+static inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void fwspec_iommu_set_ops(struct fwnode_handle *fwnode,
+					const struct iommu_ops *ops)
+{
+}
+
+static inline const struct iommu_ops *
+fwspec_iommu_get_ops(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_IOMMU_FWSPEC */
+
+#endif /* __IOMMU_FWSPEC_H */
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 308791f..2362232 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -15,13 +15,8 @@ extern void of_iommu_init(void);
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
-struct iommu_fwspec {
-	const struct iommu_ops	*iommu_ops;
-	struct device_node	*iommu_np;
-	void			*iommu_priv;
-	unsigned int		num_ids;
-	u32			ids[];
-};
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
+const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
 
 #else
 
@@ -39,17 +34,14 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
-struct iommu_fwspec;
-
-#endif	/* CONFIG_OF_IOMMU */
+static inline void of_iommu_set_ops(struct device_node *np,
+				    const struct iommu_ops *ops)
+{ }
 
-int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
-void iommu_fwspec_free(struct device *dev);
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
+static inline const struct iommu_ops *
+of_iommu_get_ops(struct device_node *np) { return NULL; }
 
-void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
-const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
+#endif	/* CONFIG_OF_IOMMU */
 
 extern struct of_device_id __iommu_of_table;
 
-- 
2.6.4

