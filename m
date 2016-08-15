Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v4 04/15] drivers: acpi: iort: add support for IOMMU fwnode
 registration
Date: Mon, 15 Aug 2016 16:23:29 +0100
Message-Id: <1471274620-20754-5-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Jon Masters <jcm@redhat.com>, Dennis Chen <dennis.chen@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
 drivers/acpi/arm64/iort.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iort.h      |  8 ++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index cad7d1d..01a5258 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
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
 
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 9bb30c5..666a3de 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -30,12 +30,20 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
 void iort_table_detect(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+int iort_set_fwnode(struct acpi_iort_node *iort_node,
+		    struct fwnode_handle *fwnode);
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
 #else
 static inline void iort_table_detect(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
 static inline struct irq_domain *
 iort_get_device_domain(struct device *dev, u32 req_id) { return NULL; }
+static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
+				  struct fwnode_handle *fwnode)
+{ return -ENODEV; }
+static inline struct fwnode_handle *
+iort_get_fwnode(struct acpi_iort_node *node) { return NULL; }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
