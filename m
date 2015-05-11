Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v11 03/10] iommu/vt-d: Function to get existing context entry
Date: Mon, 11 May 2015 17:52:47 +0800
Message-Id: <1431337974-545-4-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Interface for when a new domain in the old kernel needs some
values from the panicked kernel's context entries.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1e7ceb5..07e6118 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -367,6 +367,10 @@ static inline int first_pte_in_page(struct dma_pte *pte)
  * do the same thing as crashdump kernel.
  */
 
+static struct context_entry *device_to_existing_context_entry(
+				struct intel_iommu *iommu,
+				u8 bus, u8 devfn);
+
 
 /*
  * This domain is a statically identity mapping domain.
@@ -4810,3 +4814,22 @@ static void __init check_tylersburg_isoch(void)
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
+	struct context_entry *ret = NULL;
+	unsigned long flags;
+
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

