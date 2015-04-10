Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:36361 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbbDJInc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 04:43:32 -0400
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
Subject: [PATCH v10 03/10] iommu/vt-d: Function to get old context entry
Date: Fri, 10 Apr 2015 16:42:06 +0800
Message-Id: <1428655333-19504-4-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Interface for when a new domain in the crashdump kernel needs some
values from the panicked kernel's context entries.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 735e28f..ff5ac04 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -369,6 +369,10 @@ static inline int first_pte_in_page(struct dma_pte *pte)
  */
 
 
+static struct context_entry *device_to_existing_context_entry(
+				struct intel_iommu *iommu,
+				u8 bus, u8 devfn);
+
 
 /*
  * This domain is a statically identity mapping domain.
@@ -4793,3 +4797,23 @@ static void __init check_tylersburg_isoch(void)
 	printk(KERN_WARNING "DMAR: Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
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
-- 
2.0.0-rc0

