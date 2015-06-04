Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:42223 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbFDGo4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:44:56 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:44:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 41/42] drivers/of: Return allocated memory chunk from of_fdt_unflatten_tree()
Date: Thu,  4 Jun 2015 16:42:10 +1000
Message-Id: <1433400131-18429-42-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes of_fdt_unflatten_tree() so that it returns the
allocated memory chunk for unflattened device-tree, which can be
released once it's obsoleted.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Newly introduced
---
 drivers/of/fdt.c       | 21 +++++++++++----------
 include/linux/of_fdt.h |  6 +++---
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index b6a6c59..a954279 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -405,10 +405,10 @@ static void *unflatten_dt_node(void *blob,
  * @dt_alloc: An allocator that provides a virtual address to memory
  * for the resulting tree
  */
-static void __unflatten_device_tree(void *blob,
-				    struct device_node *dad,
-				    struct device_node **mynodes,
-				    void * (*dt_alloc)(u64 size, u64 align))
+static void *__unflatten_device_tree(void *blob,
+				     struct device_node *dad,
+				     struct device_node **mynodes,
+				     void * (*dt_alloc)(u64 size, u64 align))
 {
 	unsigned long size;
 	int start;
@@ -418,7 +418,7 @@ static void __unflatten_device_tree(void *blob,
 
 	if (!blob) {
 		pr_debug("No device tree pointer\n");
-		return;
+		return NULL;
 	}
 
 	pr_debug("Unflattening device tree:\n");
@@ -428,7 +428,7 @@ static void __unflatten_device_tree(void *blob,
 
 	if (fdt_check_header(blob)) {
 		pr_err("Invalid device tree blob header\n");
-		return;
+		return NULL;
 	}
 
 	/* First pass, scan for size */
@@ -455,6 +455,7 @@ static void __unflatten_device_tree(void *blob,
 			   be32_to_cpup(mem + size));
 
 	pr_debug(" <- unflatten_device_tree()\n");
+	return mem;
 }
 
 static void *kernel_tree_alloc(u64 size, u64 align)
@@ -470,11 +471,11 @@ static void *kernel_tree_alloc(u64 size, u64 align)
  * pointers of the nodes so the normal device-tree walking functions
  * can be used.
  */
-void of_fdt_unflatten_tree(unsigned long *blob,
-			   struct device_node *dad,
-			   struct device_node **mynodes)
+void *of_fdt_unflatten_tree(unsigned long *blob,
+			    struct device_node *dad,
+			    struct device_node **mynodes)
 {
-	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
+	return __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 8882640..8a38c6a 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -37,9 +37,9 @@ extern bool of_fdt_is_big_endian(const void *blob,
 				 unsigned long node);
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
-extern void of_fdt_unflatten_tree(unsigned long *blob,
-				  struct device_node *dad,
-				  struct device_node **mynodes);
+extern void *of_fdt_unflatten_tree(unsigned long *blob,
+				   struct device_node *dad,
+				   struct device_node **mynodes);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
 extern int __initdata dt_root_addr_cells;
-- 
2.1.0

