Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:46222 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965382AbbKDNNc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:13:32 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 18:43:31 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 46/50] drivers/of: Rename unflatten_dt_node()
Date: Thu,  5 Nov 2015 00:12:46 +1100
Message-Id: <1446642770-4681-47-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This renames unflatten_dt_node() to unflatten_dt_nodes() as it
populates multiple device nodes from FDT blob. No logical changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index f4793d0..559ce49 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -380,7 +380,7 @@ static void reverse_nodes(struct device_node *parent)
 }
 
 /**
- * unflatten_dt_node - Alloc and populate a device_node from the flat tree
+ * unflatten_dt_nodes - Alloc and populate device nodes from the flat tree
  * @blob: The parent device tree blob
  * @mem: Memory chunk to use for allocating device nodes and properties
  * @dad: Parent struct device_node
@@ -388,11 +388,11 @@ static void reverse_nodes(struct device_node *parent)
  * @dryrun: If true, do not allocate device nodes but still calculate needed
  * memory size
  */
-static void *unflatten_dt_node(const void *blob,
-			       void *mem,
-			       struct device_node *dad,
-			       struct device_node **nodepp,
-			       bool dryrun)
+static void *unflatten_dt_nodes(const void *blob,
+				void *mem,
+				struct device_node *dad,
+				struct device_node **nodepp,
+				bool dryrun)
 {
 	struct device_node *root;
 	int offset = 0, depth = 0;
@@ -472,7 +472,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	size = (unsigned long)unflatten_dt_node(blob, NULL, NULL, NULL, true);
+	size = (unsigned long)unflatten_dt_nodes(blob, NULL, NULL, NULL, true);
 	size = ALIGN(size, 4);
 
 	pr_debug("  size is %lx, allocating...\n", size);
@@ -486,7 +486,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	unflatten_dt_node(blob, mem, NULL, mynodes, false);
+	unflatten_dt_nodes(blob, mem, NULL, mynodes, false);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
-- 
2.1.0

