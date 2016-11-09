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
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT agnostic
Date: Wed,  9 Nov 2016 14:19:36 +0000
Message-Id: <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The of_iommu_{set/get}_ops() API is used to associate a device
tree node with a specific set of IOMMU operations. The same
kernel interface is required on systems booting with ACPI, where
devices are not associated with a device tree node, therefore
the interface requires generalization.

The struct device fwnode member represents the fwnode token
associated with the device and the struct it points at is firmware
specific; regardless, it is initialized on both ACPI and DT systems
and makes an ideal candidate to use it to associate a set of IOMMU
operations to a given device, through its struct device.fwnode member
pointer.

Convert the DT specific of_iommu_{set/get}_ops() interface to
use struct device.fwnode as a look-up token, making the interface
usable on ACPI systems.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Tomasz Nowicki <tn@semihalf.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/iommu.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/of_iommu.c | 39 ---------------------------------------
 include/linux/iommu.h    | 14 ++++++++++++++
 include/linux/of_iommu.h | 12 ++++++++++--
 4 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f196..5c97c01 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1615,6 +1615,48 @@ int iommu_request_dm_for_dev(struct device *dev)
 	return ret;
 }
 
+struct iommu_fwentry {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	const struct iommu_ops *ops;
+};
+static LIST_HEAD(iommu_fwentry_list);
+static DEFINE_SPINLOCK(iommu_fwentry_lock);
+
+void fwnode_iommu_set_ops(struct fwnode_handle *fwnode,
+			  const struct iommu_ops *ops)
+{
+	struct iommu_fwentry *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
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
+	spin_lock(&iommu_fwentry_lock);
+	list_add_tail(&iommu->list, &iommu_fwentry_list);
+	spin_unlock(&iommu_fwentry_lock);
+}
+
+const struct iommu_ops *fwnode_iommu_get_ops(struct fwnode_handle *fwnode)
+{
+	struct iommu_fwentry *node;
+	const struct iommu_ops *ops = NULL;
+
+	spin_lock(&iommu_fwentry_lock);
+	list_for_each_entry(node, &iommu_fwentry_list, list)
+		if (node->fwnode == fwnode) {
+			ops = node->ops;
+			break;
+		}
+	spin_unlock(&iommu_fwentry_lock);
+	return ops;
+}
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5b82862..0f57ddc 100644
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
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..15d5478 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -351,6 +351,9 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
+void fwnode_iommu_set_ops(struct fwnode_handle *fwnode,
+			  const struct iommu_ops *ops);
+const struct iommu_ops *fwnode_iommu_get_ops(struct fwnode_handle *fwnode);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -580,6 +583,17 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
+static inline void fwnode_iommu_set_ops(struct fwnode_handle *fwnode,
+					const struct iommu_ops *ops)
+{
+}
+
+static inline
+const struct iommu_ops *fwnode_iommu_get_ops(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index e80b9c7..7681007 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -31,8 +31,16 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 #endif	/* CONFIG_OF_IOMMU */
 
-void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
-const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
+static inline void of_iommu_set_ops(struct device_node *np,
+				    const struct iommu_ops *ops)
+{
+	fwnode_iommu_set_ops(&np->fwnode, ops);
+}
+
+static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
+{
+	return fwnode_iommu_get_ops(&np->fwnode);
+}
 
 extern struct of_device_id __iommu_of_table;
 
-- 
2.10.0

