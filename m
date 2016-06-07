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
Subject: [RFC PATCH v2 07/15] drivers: acpi: iort: add node match function
Date: Tue,  7 Jun 2016 14:31:02 +0100
Message-Id: <1465306270-27076-8-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Device drivers (eg ARM SMMU) need to know if a specific component
is part of the IORT table, so that kernel data structures are not
initialized at initcalls time if the respective component is not
part of the IORT table.

To this end, this patch adds a trivial function that allows detecting
if a given IORT node type is present or not in the ACPI table, providing
an ACPI IORT equivalent for of_find_matching_node().

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/iort.c  | 15 +++++++++++++++
 include/linux/iort.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 0ba6c8a..875edde 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -213,6 +213,21 @@ iort_scan_node(enum acpi_iort_node_type type,
 }
 
 static acpi_status
+iort_match_callback(struct acpi_iort_node *node, void *context)
+{
+	return AE_OK;
+}
+
+bool iort_node_match(u8 type)
+{
+	struct acpi_iort_node *node;
+
+	node = iort_scan_node(type, iort_match_callback, NULL);
+
+	return node != NULL;
+}
+
+static acpi_status
 iort_find_dev_callback(struct acpi_iort_node *node, void *context)
 {
 	struct device *dev = context;
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 5053cc3..5ebe7e5 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -27,9 +27,11 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_its_find_domain_token(int trans_id);
 #ifdef CONFIG_IORT_TABLE
+bool iort_node_match(u8 type);
 u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id);
 struct irq_domain *iort_pci_get_domain(struct pci_dev *pdev, u32 req_id);
 #else
+static inline bool iort_node_match(u8 type) { return false; }
 static inline u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id)
 { return req_id; }
 static inline struct irq_domain *
-- 
2.6.4

