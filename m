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
Subject: [RFC PATCH v3 07/13] drivers: acpi: iort: add node match function
Date: Wed, 20 Jul 2016 12:23:29 +0100
Message-Id: <1469013815-24380-8-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
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
index 86f6985..71516e8 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -205,6 +205,21 @@ iort_scan_node(enum acpi_iort_node_type type,
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
 iort_match_node_callback(struct acpi_iort_node *node, void *context)
 {
 	struct device *dev = context;
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 9bb30c5..ac2706a 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -27,10 +27,12 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_IORT_TABLE
+bool iort_node_match(u8 type);
 void iort_table_detect(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 #else
+static inline bool iort_node_match(u8 type) { return false; }
 static inline void iort_table_detect(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
-- 
2.6.4

