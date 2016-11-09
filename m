Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933586AbcKIOTo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 09:19:44 -0500
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
Subject: [PATCH v7 15/16] drivers: acpi: iort: add single mapping function
Date: Wed,  9 Nov 2016 14:19:47 +0000
Message-Id: <20161109141948.19244-16-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current IORT id mapping API requires components to provide
an input requester ID (a Bus-Device-Function (BDF) identifier for
PCI devices) to translate an input identifier to an output
identifier through an IORT range mapping.

Named components do not have an identifiable source ID therefore
their respective input/output mapping can only be defined in
IORT tables through single mappings, that provide a translation
that does not require any input identifier.

Current IORT interface for requester id mappings (iort_node_map_rid())
is not suitable for components that do not provide a requester id,
so it cannot be used for IORT named components.

Add an interface to the IORT API to enable retrieval of id
by allowing an indexed walk of the single mappings array for
a given component, therefore completing the IORT mapping API.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Tomasz Nowicki <tn@semihalf.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 62057c6..7d30605 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -318,6 +318,45 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 	return 0;
 }
 
+static
+struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
+					u32 *id_out, u8 type_mask,
+					int index)
+{
+	struct acpi_iort_node *parent;
+	struct acpi_iort_id_mapping *map;
+
+	if (!node->mapping_offset || !node->mapping_count ||
+				     index >= node->mapping_count)
+		return NULL;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset);
+
+	/* Firmware bug! */
+	if (!map->output_reference) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+			       map->output_reference);
+
+	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
+		return NULL;
+
+	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
+		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
+		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
+			*id_out = map[index].output_base;
+			return parent;
+		}
+	}
+
+	return NULL;
+}
+
 static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
 						u32 rid_in, u32 *rid_out,
 						u8 type_mask)
-- 
2.10.0

