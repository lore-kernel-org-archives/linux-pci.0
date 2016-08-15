Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v4 08/15] drivers: acpi: iort: add node match function
Date: Mon, 15 Aug 2016 16:23:33 +0100
Message-Id: <1471274620-20754-9-git-send-email-lorenzo.pieralisi@arm.com>
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
 drivers/acpi/arm64/iort.c | 15 +++++++++++++++
 include/linux/iort.h      |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 01a5258..f6db3d8 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
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
index 666a3de..bf37aaf 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -27,6 +27,7 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_IORT_TABLE
+bool iort_node_match(u8 type);
 void iort_table_detect(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
@@ -34,6 +35,7 @@ int iort_set_fwnode(struct acpi_iort_node *iort_node,
 		    struct fwnode_handle *fwnode);
 struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
 #else
+static inline bool iort_node_match(u8 type) { return false; }
 static inline void iort_table_detect(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
