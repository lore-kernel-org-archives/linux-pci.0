Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37806 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdHEGi1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 02:38:27 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 01/10] PCI: avoid arch_remove_reservations() for PCI_TEST
Date: Fri,  4 Aug 2017 23:37:52 -0700
Message-Id: <20170805063801.15880-2-yinghai@kernel.org>
In-Reply-To: <20170805063801.15880-1-yinghai@kernel.org>
References: <20170805063801.15880-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

arch_remove_reservations will clip out with e820 from host that kernel
running, that will cause failure from PCI_TEST from simulated data.

PCI_TEST has different iomem resource instead iomem_resource,
so check if iomem_resource is related to avoid calling
arch_remove_reservations()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/kernel/resource.c | 15 +++++++++++++--
 include/linux/ioport.h     |  3 ++-
 kernel/resource.c          |  5 +++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 5ab3895..f19b0f6 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -35,14 +35,25 @@ static void remove_e820_regions(struct resource *avail)
 	}
 }
 
-void arch_remove_reservations(struct resource *avail)
+static int is_from_iomem_resource(struct resource *root)
+{
+	while (root->parent)
+		root = root->parent;
+
+	if (root == &iomem_resource)
+		return 1;
+
+	return 0;
+}
+
+void arch_remove_reservations(struct resource *root, struct resource *avail)
 {
 	/*
 	 * Trim out BIOS area (high 2MB) and E820 regions. We do not remove
 	 * the low 1MB unconditionally, as this area is needed for some ISA
 	 * cards requiring a memory range, e.g. the i82365 PCMCIA controller.
 	 */
-	if (avail->flags & IORESOURCE_MEM) {
+	if ((avail->flags & IORESOURCE_MEM) && is_from_iomem_resource(root)) {
 		resource_clip(avail, BIOS_ROM_BASE, BIOS_ROM_END);
 
 		remove_e820_regions(avail);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6230064..4e9272d 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -177,7 +177,8 @@ extern struct resource *insert_resource_conflict(struct resource *parent, struct
 extern int insert_resource(struct resource *parent, struct resource *new);
 extern void insert_resource_expand_to_fit(struct resource *root, struct resource *new);
 extern int remove_resource(struct resource *old);
-extern void arch_remove_reservations(struct resource *avail);
+extern void arch_remove_reservations(struct resource *root,
+					struct resource *avail);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     resource_size_t size, resource_size_t min,
 			     resource_size_t max, resource_size_t align,
diff --git a/kernel/resource.c b/kernel/resource.c
index 9b5f044..4174020 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -570,7 +570,8 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
-void __weak arch_remove_reservations(struct resource *avail)
+void __weak arch_remove_reservations(struct resource *root,
+					 struct resource *avail)
 {
 }
 
@@ -622,7 +623,7 @@ static int __find_resource(struct resource *root, struct resource *old,
 			goto next;
 
 		resource_clip(&tmp, constraint->min, constraint->max);
-		arch_remove_reservations(&tmp);
+		arch_remove_reservations(root, &tmp);
 
 		/* Check for overflow after ALIGN() */
 		avail.start = ALIGN(tmp.start, constraint->align);
-- 
2.9.4
