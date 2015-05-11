Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:51379 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbEKJyM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 05:54:12 -0400
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
To: <dwmw2@infradead.org>, <indou.takao@jp.fujitsu.com>,
	<bhe@redhat.com>, <joro@8bytes.org>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>
Cc: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
	<alex.williamson@redhat.com>, <ddutile@redhat.com>,
	<ishii.hironobu@jp.fujitsu.com>, <bhelgaas@google.com>,
	<doug.hatch@hp.com>, <jerry.hoemann@hp.com>, <tom.vaden@hp.com>,
	<li.zhang6@hp.com>, <lisa.mitchell@hp.com>,
	<billsumnerlinux@gmail.com>, <zhen-hual@hp.com>, <rwright@hp.com>
Subject: [PATCH v11 02/10] iommu/vt-d: Items required for kdump
Date: Mon, 11 May 2015 17:52:46 +0800
Message-Id: <1431337974-545-3-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add context entry functions needed for kdump.

Bill Sumner:
    Original version;

Li, Zhenhua:
    Changed the name of new functions, make them consistent with current
    context get/set functions.
    Remove the structure dve which is not used in new version.

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cb9d6cc..1e7ceb5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -190,6 +190,31 @@ struct root_entry {
 };
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
+static inline bool root_present(struct root_entry *root)
+{
+	return (root->lo & 1);
+}
+
+static inline void set_root_value(struct root_entry *root, unsigned long value)
+{
+	root->lo &= ~VTD_PAGE_MASK;
+	root->lo |= value & VTD_PAGE_MASK;
+}
+
+static inline struct context_entry *
+get_context_addr_from_root(struct root_entry *root)
+{
+	return (struct context_entry *)
+		(root_present(root)?phys_to_virt(
+		root->lo & VTD_PAGE_MASK) :
+		NULL);
+}
+
+static inline unsigned long
+get_context_phys_from_root(struct root_entry *root)
+{
+	return  root_present(root) ? (root->lo & VTD_PAGE_MASK) : 0;
+}
 
 /*
  * low 64 bits:
@@ -211,6 +236,32 @@ static inline bool context_present(struct context_entry *context)
 {
 	return (context->lo & 1);
 }
+
+static inline int context_fault_enable(struct context_entry *c)
+{
+	return((c->lo >> 1) & 0x1);
+}
+
+static inline int context_translation_type(struct context_entry *c)
+{
+	return((c->lo >> 2) & 0x3);
+}
+
+static inline u64 context_address_root(struct context_entry *c)
+{
+	return((c->lo >> VTD_PAGE_SHIFT));
+}
+
+static inline int context_address_width(struct context_entry *c)
+{
+	return((c->hi >> 0) & 0x7);
+}
+
+static inline int context_domain_id(struct context_entry *c)
+{
+	return((c->hi >> 8) & 0xffff);
+}
+
 static inline void context_set_present(struct context_entry *context)
 {
 	context->lo |= 1;
@@ -296,6 +347,27 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
+
+/*
+ * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
+ *
+ * Fixes the crashdump kernel to deal with an active iommu and legacy
+ * DMA from the (old) panicked kernel in a manner similar to how legacy
+ * DMA is handled when no hardware iommu was in use by the old kernel --
+ * allow the legacy DMA to continue into its current buffers.
+ *
+ * In the crashdump kernel, this code:
+ * 1. skips disabling the IOMMU's translating.
+ * 2. Do not re-enable IOMMU's translating.
+ * 3. In kdump kernel, use the old root entry table.
+ * 4. Allocate pages for new context entry, copy data from old context entries
+ *    in the old kernel to the new ones.
+ *
+ * In other kinds of kernel, for example, a kernel started by kexec,
+ * do the same thing as crashdump kernel.
+ */
+
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
-- 
2.0.0-rc0

