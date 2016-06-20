Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Subject: [PATCH V7 2/8] ACPI: Add new IORT functions to support MSI domain
 handling
Date: Mon, 20 Jun 2016 13:02:15 +0200
Message-Id: <1466420541-20101-3-git-send-email-tn@semihalf.com>
In-Reply-To: <1466420541-20101-1-git-send-email-tn@semihalf.com>
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org,
 Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, andrea.gallo@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

For ITS, MSI functionality consists on building domain stack and
during that process we need to reference to domain stack components
e.g. before we create new DOMAIN_BUS_PCI_MSI domain we need to specify
its DOMAIN_BUS_NEXUS parent domain. In order to manage that process
properly, maintain list which elements contain domain token
(unique for MSI domain stack) and ITS ID: iort_register_domain_token()
and iort_deregister_domain_token(). Then retrieve domain token
any time later with ITS ID being key off: iort_find_domain_token().
With domain token and domain type we are able to find corresponding
IRQ domain.

Since IORT is prepared to describe MSI domain on a per-device basis,
use existing IORT helpers and implement two calls:
1. iort_msi_map_rid() to map MSI RID for a device
2. iort_get_device_domain() to find domain token for a device

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/iort.c  | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iort.h |  11 ++++
 2 files changed, 180 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index e342bac..496dcf6 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -22,12 +22,91 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
+struct iort_its_msi_chip {
+	struct list_head	list;
+	struct fwnode_handle	*fw_node;
+	u32			translation_id;
+};
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
 /* Root pointer to the mapped IORT table */
 static struct acpi_table_header *iort_table;
 
+static LIST_HEAD(iort_msi_chip_list);
+static DEFINE_SPINLOCK(iort_msi_chip_lock);
+
+/**
+ * iort_register_domain_token() - register domain token and related ITS ID
+ * to the list from where we can get it back later on.
+ * @trans_id: ITS ID.
+ * @fw_node: Domain token.
+ *
+ * Returns: 0 on success, -ENOMEM if no memory when allocating list element
+ */
+int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
+{
+	struct iort_its_msi_chip *its_msi_chip;
+
+	its_msi_chip = kzalloc(sizeof(*its_msi_chip), GFP_KERNEL);
+	if (!its_msi_chip)
+		return -ENOMEM;
+
+	its_msi_chip->fw_node = fw_node;
+	its_msi_chip->translation_id = trans_id;
+
+	spin_lock(&iort_msi_chip_lock);
+	list_add(&its_msi_chip->list, &iort_msi_chip_list);
+	spin_unlock(&iort_msi_chip_lock);
+
+	return 0;
+}
+
+/**
+ * iort_deregister_domain_token() - Deregister domain token based on ITS ID
+ * @trans_id: ITS ID.
+ *
+ * Returns: none.
+ */
+void iort_deregister_domain_token(int trans_id)
+{
+	struct iort_its_msi_chip *its_msi_chip, *t;
+
+	spin_lock(&iort_msi_chip_lock);
+	list_for_each_entry_safe(its_msi_chip, t, &iort_msi_chip_list, list) {
+		if (its_msi_chip->translation_id == trans_id) {
+			list_del(&its_msi_chip->list);
+			kfree(its_msi_chip);
+			break;
+		}
+	}
+	spin_unlock(&iort_msi_chip_lock);
+}
+
+/**
+ * iort_find_domain_token() - Find domain token based on given ITS ID
+ * @trans_id: ITS ID.
+ *
+ * Returns: domain token when find on the list, NULL otherwise
+ */
+struct fwnode_handle *iort_find_domain_token(int trans_id)
+{
+	struct fwnode_handle *fw_node = NULL;
+	struct iort_its_msi_chip *its_msi_chip;
+
+	spin_lock(&iort_msi_chip_lock);
+	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
+		if (its_msi_chip->translation_id == trans_id) {
+			fw_node = its_msi_chip->fw_node;
+			break;
+		}
+	}
+	spin_unlock(&iort_msi_chip_lock);
+
+	return fw_node;
+}
+
 static struct acpi_iort_node *
 iort_scan_node(enum acpi_iort_node_type type,
 	       iort_find_node_callback callback, void *context)
@@ -205,6 +284,96 @@ iort_find_dev_node(struct device *dev)
 			      iort_match_node_callback, &pbus->dev);
 }
 
+/**
+ * iort_msi_map_rid() - Map a MSI requester ID for a device
+ * @dev: The device for which the mapping is to be done.
+ * @req_id: The device requester ID.
+ *
+ * Returns: mapped MSI RID on success, input requester ID otherwise
+ */
+u32 iort_msi_map_rid(struct device *dev, u32 req_id)
+{
+	struct acpi_iort_node *node;
+	u32 dev_id;
+
+	if (!iort_table)
+		return req_id;
+
+	node = iort_find_dev_node(dev);
+	if (!node) {
+		dev_err(dev, "can't find related IORT node\n");
+		return req_id;
+	}
+
+	iort_node_map_rid(node, req_id, &dev_id, ACPI_IORT_NODE_ITS_GROUP);
+	return dev_id;
+}
+
+/**
+ * iort_dev_find_its_id() - Find the ITS identifier for a device
+ * @dev: The device.
+ * @idx: Index of the ITS identifier list.
+ * @its_id: ITS identifier.
+ *
+ * Returns: 0 on success, appropriate error value otherwise
+ */
+static int
+iort_dev_find_its_id(struct device *dev, u32 req_id, unsigned int idx,
+		     int *its_id)
+{
+	struct acpi_iort_its_group *its;
+	struct acpi_iort_node *node;
+
+	node = iort_find_dev_node(dev);
+	if (!node) {
+		dev_err(dev, "can't find related IORT node\n");
+		return -ENXIO;
+	}
+
+	node = iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GROUP);
+	if (!node) {
+		dev_err(dev, "can't find related ITS node\n");
+		return -ENXIO;
+	}
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)node->node_data;
+	if (idx > its->its_count) {
+		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
+			idx, its->its_count);
+		return -ENXIO;
+	}
+
+	*its_id = its->identifiers[idx];
+	return 0;
+}
+
+/**
+ * iort_get_device_domain() - Find MSI domain related to a device
+ * @dev: The device.
+ * @req_id: Requester ID for the device.
+ *
+ * Returns: the MSI domain for this device, NULL otherwise
+ */
+struct irq_domain *
+iort_get_device_domain(struct device *dev, u32 req_id)
+{
+	static struct fwnode_handle *handle;
+	int its_id;
+
+	if (!iort_table)
+		return NULL;
+
+	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
+		return NULL;
+
+	handle = iort_find_domain_token(its_id);
+	if (!handle)
+		return NULL;
+
+	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
+}
+
 void __init iort_table_detect(void)
 {
 	acpi_status status;
diff --git a/include/linux/iort.h b/include/linux/iort.h
index cde6809..d7daba1 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -20,11 +20,22 @@
 #define __IORT_H__
 
 #include <linux/acpi.h>
+#include <linux/fwnode.h>
+#include <linux/irqdomain.h>
 
+int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
+void iort_deregister_domain_token(int trans_id);
+struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_IORT_TABLE
 void iort_table_detect(void);
+u32 iort_msi_map_rid(struct device *dev, u32 req_id);
+struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 #else
 static inline void iort_table_detect(void) { }
+static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
+{ return req_id; }
+static inline struct irq_domain *
+iort_get_device_domain(struct device *dev, u32 req_id) { return NULL; }
 #endif
 
 #endif /* __IORT_H__ */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
