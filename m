Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031988AbcJRQE2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Oct 2016 12:04:28 -0400
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
Subject: [PATCH v6 14/16] drivers: acpi: iort: replace rid map type with type mask
Date: Tue, 18 Oct 2016 17:04:12 +0100
Message-Id: <20161018160414.1228-15-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
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
index 04cc5f7..f205d41 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -26,6 +26,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IORT_TYPE_MASK(type)	(1 << (type))
+#define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
+
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
@@ -317,7 +320,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 
 static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 						u32 rid_in, u32 *rid_out,
-						u8 type)
+						u8 type_mask)
 {
 	u32 rid = rid_in;
 
@@ -326,7 +329,7 @@ static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 		struct acpi_iort_id_mapping *map;
 		int i;
 
-		if (node->type == type) {
+		if (IORT_TYPE_MASK(node->type) & type_mask) {
 			if (rid_out)
 				*rid_out = rid;
 			return node;
@@ -399,7 +402,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 	if (!node)
 		return req_id;
 
-	iort_node_map_rid(node, req_id, &dev_id, ACPI_IORT_NODE_ITS_GROUP);
+	iort_node_map_rid(node, req_id, &dev_id, IORT_MSI_TYPE);
 	return dev_id;
 }
 
@@ -421,7 +424,7 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
 	if (!node)
 		return -ENXIO;
 
-	node = iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GROUP);
+	node = iort_node_map_rid(node, req_id, NULL, IORT_MSI_TYPE);
 	if (!node)
 		return -ENXIO;
 
-- 
2.10.0

