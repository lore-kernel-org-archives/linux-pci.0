Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41285 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbcHOPYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 11:24:23 -0400
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
	Sinan Kaya <okaya@codeaurora.org>,
	Nate Watterson <nwatters@codeaurora.org>,
	Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 13/15] drivers: acpi: iort: replace rid map type with type mask
Date: Mon, 15 Aug 2016 16:23:38 +0100
Message-Id: <1471274620-20754-14-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

IORT tables provide data that allow the kernel to carry out
device ID mappings between endpoints and system components
(eg interrupt controllers, IOMMUs). When the mapping for a
given device ID is carried out, the translation mechanism
is done on a per-subsystem basis rather than a component
subtype (ie the IOMMU kernel layer will look for mappings
from a device to all IORT node types corresponding to IOMMU
components), therefore the corresponding mapping API should
work on a range (ie mask) of IORT node types corresponding
to a common set of components (eg IOMMUs) rather than a
specific node type.

Upgrade the IORT iort_node_map_rid() API to work with a
type mask instead of a single node type so that it can
be used for mappings that span multiple components types
(ie IOMMUs).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index f42cff8..a04a1d2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -25,6 +25,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IORT_TYPE_MASK(type)	(1 << (type))
+#define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
+
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
@@ -299,7 +302,7 @@ iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
 
 static struct acpi_iort_node *
 iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
-		  u32 *rid_out, u8 type)
+		  u32 *rid_out, u8 type_mask)
 {
 	u32 rid = rid_in;
 
@@ -308,7 +311,7 @@ iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
 		struct acpi_iort_id_mapping *map;
 		int i;
 
-		if (node->type == type) {
+		if (IORT_TYPE_MASK(node->type) & type_mask) {
 			if (rid_out)
 				*rid_out = rid;
 			return node;
@@ -386,7 +389,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 		return req_id;
 	}
 
-	iort_node_map_rid(node, req_id, &dev_id, ACPI_IORT_NODE_ITS_GROUP);
+	iort_node_map_rid(node, req_id, &dev_id, IORT_MSI_TYPE);
 	return dev_id;
 }
 
@@ -411,7 +414,7 @@ iort_dev_find_its_id(struct device *dev, u32 req_id, unsigned int idx,
 		return -ENXIO;
 	}
 
-	node = iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GROUP);
+	node = iort_node_map_rid(node, req_id, NULL, IORT_MSI_TYPE);
 	if (!node) {
 		dev_err(dev, "can't find related ITS node\n");
 		return -ENXIO;
-- 
2.6.4

