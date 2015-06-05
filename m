Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59213 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423040AbbFEOLS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:18 -0400
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Cc: zhen-hual@hp.com, bhe@redhat.com, dwmw2@infradead.org,
	vgoyal@redhat.com, dyoung@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com,
	indou.takao@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com,
	jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com,
	lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH 11/17] iommu/vt-d: Move QI initialization to intel_setup_irq_remapping
Date: Fri,  5 Jun 2015 16:10:57 +0200
Message-Id: <1433513463-19128-12-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This function needs a working QI later when kdump recovery
is moved to this function.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 63 ++++++++++---------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index d22518d..70e4955 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -519,6 +519,19 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
 	iommu->ir_table = ir_table;
+
+	if (!iommu->qi) {
+		/*
+		 * Clear previous faults.
+		 */
+		dmar_fault(-1, iommu);
+		dmar_disable_qi(iommu);
+		if (dmar_enable_qi(iommu)) {
+			pr_err("Failed to enable queued invalidation\n");
+			goto out_free_pages;
+		}
+	}
+
 	return 0;
 
 out_free_pages:
@@ -655,18 +668,6 @@ static int __init intel_enable_irq_remapping(void)
 	}
 
 	for_each_iommu(iommu, drhd) {
-		/*
-		 * If the queued invalidation is already initialized,
-		 * shouldn't disable it.
-		 */
-		if (iommu->qi)
-			continue;
-
-		/*
-		 * Clear previous faults.
-		 */
-		dmar_fault(-1, iommu);
-
 		iommu_check_pre_ir_status(iommu);
 
 		if (!is_kdump_kernel() && iommu->pre_enabled_ir) {
@@ -675,8 +676,6 @@ static int __init intel_enable_irq_remapping(void)
 			pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
 				iommu->name);
 		}
-
-		dmar_disable_qi(iommu);
 	}
 
 	/*
@@ -693,20 +692,6 @@ static int __init intel_enable_irq_remapping(void)
 		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
 	/*
-	 * Enable queued invalidation for all the DRHD's.
-	 */
-	for_each_iommu(iommu, drhd) {
-		int ret = dmar_enable_qi(iommu);
-
-		if (ret) {
-			printk(KERN_ERR "DRHD %Lx: failed to enable queued, "
-			       " invalidation, ecap %Lx, ret %d\n",
-			       drhd->reg_base_addr, iommu->ecap, ret);
-			goto error;
-		}
-	}
-
-	/*
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
@@ -1270,28 +1255,12 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	/* Setup Interrupt-remapping now. */
 	ret = intel_setup_irq_remapping(iommu);
 	if (ret) {
-		pr_err("DRHD %Lx: failed to allocate resource\n",
+		pr_err("DRHD %Lx: failed to setup IRQ remapping\n",
 		       iommu->reg_phys);
-		ir_remove_ioapic_hpet_scope(iommu);
-		return ret;
-	}
-
-	if (!iommu->qi) {
-		/* Clear previous faults. */
-		dmar_fault(-1, iommu);
-		iommu_disable_irq_remapping(iommu);
-		dmar_disable_qi(iommu);
-	}
-
-	/* Enable queued invalidation */
-	ret = dmar_enable_qi(iommu);
-	if (!ret) {
-		iommu_set_irq_remapping(iommu, eim);
-	} else {
-		pr_err("DRHD %Lx: failed to enable queued invalidation, ecap %Lx, ret %d\n",
-		       iommu->reg_phys, iommu->ecap, ret);
 		intel_teardown_irq_remapping(iommu);
 		ir_remove_ioapic_hpet_scope(iommu);
+	} else {
+		iommu_set_irq_remapping(iommu, eim);
 	}
 
 	return ret;
-- 
1.9.1

