Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59221 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423044AbbFEOLU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:20 -0400
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
Subject: [PATCH 12/17] iommu/vt-d: Move EIM detection to intel_prepare_irq_remapping
Date: Fri,  5 Jun 2015 16:10:58 +0200
Message-Id: <1433513463-19128-13-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This needs to be set up before the ir-table can be
programmed to the iommu hardware register. This programming
will be moved to intel_setup_irq_remapping, so EIM needs to
be set up earlier too.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 44 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 70e4955..35d73f6 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -637,10 +637,26 @@ static int __init intel_prepare_irq_remapping(void)
 		goto error;
 	}
 
+	if (x2apic_supported()) {
+		eim_mode = !dmar_x2apic_optout();
+		if (!eim_mode)
+			pr_info("BIOS set x2apic opt out bit. Use "
+				"'intremap=no_x2apic_optout' to enable x2apic\n");
+	}
+
 	/* First make sure all IOMMUs support IRQ remapping */
-	for_each_iommu(iommu, drhd)
+	for_each_iommu(iommu, drhd) {
 		if (!ecap_ir_support(iommu->ecap))
 			goto error;
+		if (eim_mode && !ecap_eim_support(iommu->ecap)) {
+			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
+			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
+			eim_mode = 0;
+		}
+	}
+
+	if (eim_mode)
+		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
 	/* Do the allocations early */
 	for_each_iommu(iommu, drhd)
@@ -659,13 +675,6 @@ static int __init intel_enable_irq_remapping(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	bool setup = false;
-	int eim = 0;
-
-	if (x2apic_supported()) {
-		eim = !dmar_x2apic_optout();
-		if (!eim)
-			pr_info("x2apic is disabled because BIOS sets x2apic opt out bit. You can use 'intremap=no_x2apic_optout' to override the BIOS setting.\n");
-	}
 
 	for_each_iommu(iommu, drhd) {
 		iommu_check_pre_ir_status(iommu);
@@ -679,19 +688,6 @@ static int __init intel_enable_irq_remapping(void)
 	}
 
 	/*
-	 * check for the Interrupt-remapping support
-	 */
-	for_each_iommu(iommu, drhd)
-		if (eim && !ecap_eim_support(iommu->ecap)) {
-			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
-			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
-			eim = 0;
-		}
-	eim_mode = eim;
-	if (eim)
-		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
-
-	/*
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
@@ -705,7 +701,7 @@ static int __init intel_enable_irq_remapping(void)
 				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
 			__iommu_load_old_irte(iommu);
 		} else
-			iommu_set_irq_remapping(iommu, eim);
+			iommu_set_irq_remapping(iommu, eim_mode);
 
 		setup = true;
 	}
@@ -722,9 +718,9 @@ static int __init intel_enable_irq_remapping(void)
 	 */
 	x86_io_apic_ops.print_entries = intel_ir_io_apic_print_entries;
 
-	pr_info("Enabled IRQ remapping in %s mode\n", eim ? "x2apic" : "xapic");
+	pr_info("Enabled IRQ remapping in %s mode\n", eim_mode ? "x2apic" : "xapic");
 
-	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
+	return eim_mode ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
 
 error:
 	intel_cleanup_irq_remapping();
-- 
1.9.1

