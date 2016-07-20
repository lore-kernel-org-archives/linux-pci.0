Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 03/13] drivers: acpi: iort: add support for IOMMU fwnode registration
Date: Wed, 20 Jul 2016 12:23:25 +0100
Message-Id: <1469013815-24380-4-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IORT table provide entries for IOMMU (aka SMMU in ARM world)
components that allow creating the kernel data structures required to
probe and initialize the IOMMU devices.

This patch provides support in the IORT kernel code to register IOMMU
components and their respective fwnode.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 1f440d2..86f6985 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -20,7 +20,9 @@
 
 #include <linux/iort.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -28,6 +30,69 @@ struct iort_its_msi_chip {
 	u32			translation_id;
 };
 
+struct iort_fwnode {
+	struct list_head list;
+	struct acpi_iort_node *iort_node;
+	struct fwnode_handle *fwnode;
+};
+static LIST_HEAD(iort_fwnode_list);
+static DEFINE_SPINLOCK(iort_fwnode_lock);
+
+/**
+ * iort_set_fwnode() - Create iort_fwnode and use it to register
+ *		       iommu data in the iort_fwnode_list
+ *
+ * @node: IORT table node associated with the IOMMU
+ * @fwnode: fwnode associated with the IORT node
+ *
+ * Returns: 0 on success
+ *          -ENOMEM on failure
+ */
+static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
+				  struct fwnode_handle *fwnode)
+{
+	struct iort_fwnode *np;
+
+	np = kzalloc(sizeof(struct iort_fwnode), GFP_KERNEL);
+
+	if (WARN_ON(!np))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&np->list);
+	np->iort_node = iort_node;
+	np->fwnode = fwnode;
+
+	spin_lock(&iort_fwnode_lock);
+	list_add_tail(&np->list, &iort_fwnode_list);
+	spin_unlock(&iort_fwnode_lock);
+
+	return 0;
+}
+
+/**
+ * iort_get_fwnode() - Retrieve fwnode associated with an IORT node
+ *
+ * @node: IORT table node to be looked-up
+ *
+ * Returns: fwnode_handle pointer on success NULL on failure
+*/
+static inline struct fwnode_handle *
+iort_get_fwnode(struct acpi_iort_node *node)
+{
+	struct iort_fwnode *curr, *iommu_fwnode = NULL;
+
+	spin_lock(&iort_fwnode_lock);
+	list_for_each_entry(curr, &iort_fwnode_list, list) {
+		if (curr->iort_node == node) {
+			iommu_fwnode = curr;
+			break;
+		}
+	}
+	spin_unlock(&iort_fwnode_lock);
+
+	return iommu_fwnode ? iommu_fwnode->fwnode : NULL;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
-- 
2.6.4

