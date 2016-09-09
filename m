Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751325AbcIIOXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Sep 2016 10:23:48 -0400
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
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 04/14] drivers: acpi: iort: add support for IOMMU fwnode registration
Date: Fri,  9 Sep 2016 15:23:33 +0100
Message-Id: <20160909142343.13314-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IORT table provide entries for IOMMU (aka SMMU in ARM world)
components that allow creating the kernel data structures required to
probe and initialize the IOMMU devices.

This patch provides support in the IORT kernel code to register IOMMU
components and their respective fwnode.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  9 +++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4cbeb707..b89b3d3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -20,7 +20,9 @@
 
 #include <linux/acpi_iort.h>
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
+ *          <0 on failure
+ */
+int iort_set_fwnode(struct acpi_iort_node *iort_node,
+		    struct fwnode_handle *fwnode)
+{
+	struct iort_fwnode *np;
+
+	np = kzalloc(sizeof(struct iort_fwnode), GFP_ATOMIC);
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
+ * Returns: fwnode_handle pointer on success, NULL on failure
+*/
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
+{
+	struct iort_fwnode *curr;
+	struct fwnode_handle *fwnode = NULL;
+
+	spin_lock(&iort_fwnode_lock);
+	list_for_each_entry(curr, &iort_fwnode_list, list) {
+		if (curr->iort_node == node) {
+			fwnode = curr->fwnode;
+			break;
+		}
+	}
+	spin_unlock(&iort_fwnode_lock);
+
+	return fwnode;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index d16fdda..c851646 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -30,6 +30,9 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
 void acpi_iort_init(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+int iort_set_fwnode(struct acpi_iort_node *iort_node,
+		    struct fwnode_handle *fwnode);
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
@@ -37,6 +40,12 @@ static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
+static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
+				  struct fwnode_handle *fwnode)
+{ return -ENODEV; }
+static inline
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
+{ return NULL; }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.10.0

