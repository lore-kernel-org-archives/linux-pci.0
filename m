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
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 05/14] drivers: iommu: make iommu_fwspec OF agnostic
Date: Fri,  9 Sep 2016 15:23:34 +0100
Message-Id: <20160909142343.13314-6-lorenzo.pieralisi@arm.com>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
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
 drivers/iommu/arm-smmu-v3.c  |  16 ++++--
 drivers/iommu/arm-smmu.c     |  17 +++---
 drivers/iommu/iommu-fwspec.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/of_iommu.c     |  93 --------------------------------
 include/linux/iommu-fwspec.h |  70 ++++++++++++++++++++++++
 include/linux/of_iommu.h     |  38 ++++---------
 8 files changed, 234 insertions(+), 131 deletions(-)
 create mode 100644 drivers/iommu/iommu-fwspec.c
 create mode 100644 include/linux/iommu-fwspec.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 101cb17..873bd41 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -70,6 +70,10 @@ config OF_IOMMU
 config HAVE_IOMMU_FWSPEC
 	bool
 
+config IOMMU_FWSPEC
+       def_bool y
+       depends on IOMMU_API
+
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 195f7b9..bbbc6d6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
+obj-$(CONFIG_IOMMU_FWSPEC) += iommu-fwspec.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index be293b5..a7e9de9 100644
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
@@ -1720,13 +1721,18 @@ static struct platform_driver arm_smmu_driver;
 
 static int arm_smmu_match_node(struct device *dev, void *data)
 {
-	return dev->of_node == data;
+	struct fwnode_handle *fwnode;
+
+	fwnode = dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
+
+	return fwnode == data;
 }
 
-static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+static struct arm_smmu_device *
+arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
-						np, arm_smmu_match_node);
+						fwnode, arm_smmu_match_node);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
@@ -1762,7 +1768,7 @@ static int arm_smmu_add_device(struct device *dev)
 		master = fwspec->iommu_priv;
 		smmu = master->smmu;
 	} else {
-		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 		if (!smmu)
 			return -ENODEV;
 		master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -1874,7 +1880,7 @@ out_unlock:
 
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
-	int ret = iommu_fwspec_init(dev, args->np);
+	int ret = iommu_fwspec_init(dev, &args->np->fwnode);
 
 	if (!ret)
 		ret = iommu_fwspec_add_ids(dev, &args->args[0], 1);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2e20cdc..d453c55 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -517,7 +517,7 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 		it.cur_count = 1;
 	}
 
-	err = iommu_fwspec_init(dev, smmu_dev->of_node);
+	err = iommu_fwspec_init(dev, &smmu_dev->of_node->fwnode);
 	if (err)
 		return err;
 
@@ -1368,13 +1368,18 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 
 static int arm_smmu_match_node(struct device *dev, void *data)
 {
-	return dev->of_node == data;
+	struct fwnode_handle *fwnode;
+
+	fwnode = dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
+
+	return fwnode == data;
 }
 
-static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+static struct arm_smmu_device *
+arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
-						np, arm_smmu_match_node);
+						fwnode, arm_smmu_match_node);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
@@ -1392,7 +1397,7 @@ static int arm_smmu_add_device(struct device *dev)
 		if (ret)
 			goto out_free;
 	} else if (fwspec) {
-		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	} else {
 		return -ENODEV;
 	}
@@ -1524,7 +1529,7 @@ out_unlock:
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	u32 fwid = 0;
-	int ret = iommu_fwspec_init(dev, args->np);
+	int ret = iommu_fwspec_init(dev, &args->np->fwnode);
 
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/iommu-fwspec.c b/drivers/iommu/iommu-fwspec.c
new file mode 100644
index 0000000..be19102
--- /dev/null
+++ b/drivers/iommu/iommu-fwspec.c
@@ -0,0 +1,126 @@
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
+	if (is_of_node(fwnode))
+		of_node_get(to_of_node(fwnode));
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
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
+	const struct iommu_ops *ops;
+
+	if (fwspec)
+		return 0;
+
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	if (is_of_node(iommu_fwnode)) {
+		ops = of_iommu_get_ops(to_of_node(iommu_fwnode));
+		of_node_get(to_of_node(iommu_fwnode));
+	} else {
+		ops = fwspec_iommu_get_ops(iommu_fwnode);
+	}
+
+	fwspec->iommu_fwnode = iommu_fwnode;
+	fwspec->iommu_ops = ops;
+
+	arch_set_iommu_fwspec(dev, fwspec);
+	return 0;
+}
+
+void iommu_fwspec_free(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
+
+	if (fwspec) {
+		if (is_of_node(fwspec->iommu_fwnode))
+			of_node_put(to_of_node(fwspec->iommu_fwnode));
+
+		kfree(fwspec);
+	}
+}
+
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+{
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
+	size_t size;
+
+	if (!fwspec)
+		return -EINVAL;
+
+	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + 1]);
+	fwspec = krealloc(fwspec, size, GFP_KERNEL);
+	if (!fwspec)
+		return -ENOMEM;
+
+	while (num_ids--)
+		fwspec->ids[fwspec->num_ids++] = *ids++;
+
+	arch_set_iommu_fwspec(dev, fwspec);
+	return 0;
+}
+
+inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
+{
+	return arch_get_iommu_fwspec(dev);
+}
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 38669b8..ab3c069 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -96,45 +96,6 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
 
-struct of_iommu_node {
-	struct list_head list;
-	struct device_node *np;
-	const struct iommu_ops *ops;
-};
-static LIST_HEAD(of_iommu_list);
-static DEFINE_SPINLOCK(of_iommu_lock);
-
-void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
-{
-	struct of_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
-
-	if (WARN_ON(!iommu))
-		return;
-
-	of_node_get(np);
-	INIT_LIST_HEAD(&iommu->list);
-	iommu->np = np;
-	iommu->ops = ops;
-	spin_lock(&of_iommu_lock);
-	list_add_tail(&iommu->list, &of_iommu_list);
-	spin_unlock(&of_iommu_lock);
-}
-
-const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
-{
-	struct of_iommu_node *node;
-	const struct iommu_ops *ops = NULL;
-
-	spin_lock(&of_iommu_lock);
-	list_for_each_entry(node, &of_iommu_list, list)
-		if (node->np == np) {
-			ops = node->ops;
-			break;
-		}
-	spin_unlock(&of_iommu_lock);
-	return ops;
-}
-
 static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct of_phandle_args *iommu_spec = data;
@@ -226,57 +187,3 @@ static int __init of_iommu_init(void)
 	return 0;
 }
 postcore_initcall_sync(of_iommu_init);
-
-int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
-{
-	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
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
-	arch_set_iommu_fwspec(dev, fwspec);
-	return 0;
-}
-
-void iommu_fwspec_free(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
-
-	if (fwspec) {
-		of_node_put(fwspec->iommu_np);
-		kfree(fwspec);
-	}
-}
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
-{
-	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
-	size_t size;
-	int i;
-
-	if (!fwspec)
-		return -EINVAL;
-
-	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
-	fwspec = krealloc(fwspec, size, GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
-
-	for (i = 0; i < num_ids; i++)
-		fwspec->ids[fwspec->num_ids + i] = ids[i];
-
-	fwspec->num_ids += num_ids;
-	arch_set_iommu_fwspec(dev, fwspec);
-	return 0;
-}
-
-inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
-{
-	return arch_get_iommu_fwspec(dev);
-}
diff --git a/include/linux/iommu-fwspec.h b/include/linux/iommu-fwspec.h
new file mode 100644
index 0000000..f88b635
--- /dev/null
+++ b/include/linux/iommu-fwspec.h
@@ -0,0 +1,70 @@
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
+
+#ifdef CONFIG_HAVE_IOMMU_FWSPEC
+#include <asm/iommu-fwspec.h>
+#else /* !CONFIG_HAVE_IOMMU_FWSPEC */
+static inline void arch_set_iommu_fwspec(struct device *dev,
+					 struct iommu_fwspec *fwspec) {}
+
+static inline struct iommu_fwspec *
+arch_get_iommu_fwspec(struct device *dev) { return NULL; }
+#endif
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
index 358db49..4b02861 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/iommu.h>
+#include <linux/iommu-fwspec.h>
 #include <linux/of.h>
 
 #ifdef CONFIG_OF_IOMMU
@@ -14,14 +15,6 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
-struct iommu_fwspec {
-	const struct iommu_ops	*iommu_ops;
-	struct device_node	*iommu_np;
-	void			*iommu_priv;
-	unsigned int		num_ids;
-	u32			ids[];
-};
-
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -36,28 +29,19 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 {
 	return NULL;
 }
-
-struct iommu_fwspec;
-
 #endif	/* CONFIG_OF_IOMMU */
 
-int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
-void iommu_fwspec_free(struct device *dev);
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
-
-#ifdef CONFIG_HAVE_IOMMU_FWSPEC
-#include <asm/iommu-fwspec.h>
-#else /* !CONFIG_HAVE_IOMMU_FWSPEC */
-static inline void arch_set_iommu_fwspec(struct device *dev,
-					 struct iommu_fwspec *fwspec) {}
-
-static inline struct iommu_fwspec *
-arch_get_iommu_fwspec(struct device *dev) { return NULL; }
-#endif
+static inline void of_iommu_set_ops(struct device_node *np,
+				    const struct iommu_ops *ops)
+{
+	fwspec_iommu_set_ops(&np->fwnode, ops);
+}
 
-void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
-const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
+static inline const struct iommu_ops *
+of_iommu_get_ops(struct device_node *np)
+{
+	return fwspec_iommu_get_ops(&np->fwnode);
+}
 
 extern struct of_device_id __iommu_of_table;
 
-- 
2.10.0

