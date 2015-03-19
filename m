Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:50752 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbbCSFhV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 01:37:21 -0400
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
Subject: [PATCH v9 03/10] iommu/vt-d: Function to get old context entry
Date: Thu, 19 Mar 2015 13:36:21 +0800
Message-Id: <1426743388-26908-4-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Interface for when a new domain in the crashdump kernel needs some
values from the panicked kernel's context entries.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 577d5de..f7dbe70 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -369,6 +369,10 @@ static inline int first_pte_in_page(struct dma_pte *pte)
  *
  */
 
+static struct context_entry *device_to_existing_context_entry(
+				struct intel_iommu *iommu,
+				u8 bus, u8 devfn);
+
 
 #endif /* CONFIG_CRASH_DUMP */
 
@@ -4796,3 +4800,26 @@ static void __init check_tylersburg_isoch(void)
 	printk(KERN_WARNING "DMAR: Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
+
+#ifdef CONFIG_CRASH_DUMP
+
+static struct context_entry *device_to_existing_context_entry(
+				struct intel_iommu *iommu,
+				u8 bus, u8 devfn)
+{
+	struct root_entry *root;
+	struct context_entry *context;
+	struct context_entry *ret;
+	unsigned long flags;
+
+	ret = NULL;
+	spin_lock_irqsave(&iommu->lock, flags);
+	root = &iommu->root_entry[bus];
+	context = get_context_addr_from_root(root);
+	if (context && context_present(context+devfn))
+		ret = &context[devfn];
+	spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+#endif /* CONFIG_CRASH_DUMP */
-- 
2.0.0-rc0

