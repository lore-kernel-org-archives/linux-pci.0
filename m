Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 02/11] drivers: acpi: iort: add support for IOMMU registration
Date: Thu, 14 Apr 2016 18:25:34 +0100
Message-Id: <1460654743-7896-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IORT table provide entries for IOMMU (aka SMMU in ARM world)
components that allow creating the kernel data structures required to
probe and initialize the IOMMU devices.

This patch provides support in the IORT kernel code to register IOMMU
components.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iort.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 3119683..98db580 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -19,10 +19,13 @@
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
 #include <linux/export.h>
+#include <linux/iommu.h>
 #include <linux/iort.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -30,6 +33,45 @@ struct iort_its_msi_chip {
 	u32			translation_id;
 };
 
+struct iort_iommu_node {
+	struct list_head list;
+	struct iommu_ops *ops;
+	struct acpi_iort_node *node;
+	struct fwnode_handle	*fwnode;
+};
+static LIST_HEAD(iort_iommu_list);
+static DEFINE_SPINLOCK(iort_iommu_lock);
+
+/**
+ * iort_iommu_set_node - Create iort_mmu_node and use it to register
+ *			 iommu structures on iort_iommu_list.
+ *
+ * @ops: IOMMU operations
+ * @node: IORT table node associated with the IOMMU
+ * @fwnode: fwnode_handle associated with the IOMMU
+ *
+ * Returns: 0 on success
+ *          -ENOMEM on failure
+ */
+int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
+			struct fwnode_handle *fwnode)
+{
+	struct iort_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
+
+	if (WARN_ON(!iommu))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&iommu->list);
+	iommu->ops = ops;
+	iommu->node = node;
+	iommu->fwnode = fwnode;
+	spin_lock(&iort_iommu_lock);
+	list_add_tail(&iommu->list, &iort_iommu_list);
+	spin_unlock(&iort_iommu_lock);
+
+	return 0;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
diff --git a/include/linux/iort.h b/include/linux/iort.h
index b15fe1a..148d9a1 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -28,5 +28,7 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_its_find_domain_token(int trans_id);
 u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id);
 struct fwnode_handle *iort_pci_get_domain(struct pci_dev *pdev, u32 req_id);
+int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
+			struct fwnode_handle *fwnode);
 
 #endif /* __IORT_H__ */
-- 
2.6.4

