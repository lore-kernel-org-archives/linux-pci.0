Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([125.16.236.4]:33810 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391AbcECNeE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 09:34:04 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 3 May 2016 18:53:53 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
	alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 18/22] drivers/of: Rename unflatten_dt_node()
Date: Tue,  3 May 2016 23:22:49 +1000
Message-Id: <1462281773-26438-19-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This renames unflatten_dt_node() to unflatten_dt_nodes() as it
populates multiple device nodes from FDT blob. No logical changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1d5309..7850150 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -381,7 +381,7 @@ static void reverse_nodes(struct device_node *parent)
 }
 
 /**
- * unflatten_dt_node - Alloc and populate a device_node from the flat tree
+ * unflatten_dt_nodes - Alloc and populate a device_node from the flat tree
  * @blob: The parent device tree blob
  * @mem: Memory chunk to use for allocating device nodes and properties
  * @dad: Parent struct device_node
@@ -389,10 +389,10 @@ static void reverse_nodes(struct device_node *parent)
  *
  * It returns the size of unflattened device tree or error code
  */
-static int unflatten_dt_node(const void *blob,
-			     void *mem,
-			     struct device_node *dad,
-			     struct device_node **nodepp)
+static int unflatten_dt_nodes(const void *blob,
+			      void *mem,
+			      struct device_node *dad,
+			      struct device_node **nodepp)
 {
 	struct device_node *root;
 	int offset = 0, depth = 0;
@@ -479,7 +479,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	size = unflatten_dt_node(blob, NULL, NULL, NULL);
+	size = unflatten_dt_nodes(blob, NULL, NULL, NULL);
 	if (size < 0)
 		return;
 
@@ -495,7 +495,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_node(blob, mem, NULL, mynodes);
+	unflatten_dt_nodes(blob, mem, NULL, mynodes);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
-- 
2.1.0

