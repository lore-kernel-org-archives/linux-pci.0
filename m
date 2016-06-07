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
Subject: [RFC PATCH v2 14/15] drivers: acpi: iort: add function to retrieve IOMMU platform devices
Date: Tue,  7 Jun 2016 14:31:09 +0100
Message-Id: <1465306270-27076-15-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some kernel components (ie ARM SMMU drivers) require to look-up
the platform device corresponding to a specific IORT node to
carry out streamid translation.

Platform devices created for ARM SMMU components out of IORT tables
have no fwnode token initialized, in that they do not have any device
tree node or ACPI device backing them.

Therefore, to implement the IORT node<->platform device look-up, this
patch adds a function to the IORT kernel layer that allows to
retrieve the platform device corresponding to an IORT node through
platform device name and its platform_data (that for platform devices
created out of IORT nodes for SMMUs contains a pointer to the respective
IORT node).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/iort.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 56258ac..8e76acc 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -34,6 +34,42 @@ struct iort_its_msi_chip {
 	u32			translation_id;
 };
 
+static int iort_dev_match(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	const char *name = data;
+
+	return !strcmp(pdev->name, name);
+}
+
+/**
+ * iort_find_iommu_device- Retrieve IOMMU platform_device associated with
+ *			   IORT node
+ *
+ * @node: IORT table node associated with the device
+ *
+ * Returns: device on success
+ *          NULL on failure
+ */
+struct platform_device *iort_find_iommu_device(struct acpi_iort_node *node)
+{
+	struct acpi_iort_node *curr;
+	struct device *dev = NULL;
+	const struct iort_iommu_config *cfg = iort_get_iommu_config(node);
+
+	if (!cfg)
+		return NULL;
+
+	while ((dev = bus_find_device(&platform_bus_type, dev,
+				      (void *)cfg->name, iort_dev_match))) {
+		curr = *(struct acpi_iort_node **) dev_get_platdata(dev);
+		if (curr == node)
+			return to_platform_device(dev);
+	}
+
+	return NULL;
+}
+
 struct iort_ops_node {
 	struct list_head list;
 	struct acpi_iort_node *node;
diff --git a/include/linux/iort.h b/include/linux/iort.h
index bb29647..4c8dcf8 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -32,6 +32,7 @@ u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id);
 struct irq_domain *iort_pci_get_domain(struct pci_dev *pdev, u32 req_id);
 
 /* IOMMU interface */
+struct platform_device *iort_find_iommu_device(struct acpi_iort_node *node);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline bool iort_node_match(u8 type) { return false; }
@@ -41,6 +42,8 @@ static inline struct irq_domain *
 iort_pci_get_domain(struct pci_dev *pdev, u32 req_id) { return NULL; }
 
 /* IOMMU interface */
+static inline struct platform_device *
+iort_find_iommu_device(struct acpi_iort_node *node) { return NULL; }
 static inline const struct iommu_ops *
 iort_iommu_configure(struct device *dev) { return NULL; }
 #endif
-- 
2.6.4

