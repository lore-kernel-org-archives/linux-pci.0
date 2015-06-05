Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59193 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423048AbbFEOLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:22 -0400
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
Subject: [PATCH 16/17] iommu/vt-d: Copy old irte in intel_setup_irq_remapping
Date: Fri,  5 Jun 2015 16:11:02 +0200
Message-Id: <1433513463-19128-17-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Copy over the old irq remapping table in the
intel_setup_irq_remapping function. The reason is that
intel_enable_irq_remapping runs with irqs disabled and thus
we can not safely call ioremap. Therefore we need to copy in
the prepare stage when irqs are still enabled.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 40 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f7b02ca..07a8e82 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -24,6 +24,7 @@
 static int iommu_load_old_irte(struct intel_iommu *iommu);
 static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu);
+static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 
 struct ioapic_scope {
 	struct intel_iommu *iommu;
@@ -538,6 +539,26 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		}
 	}
 
+	iommu_check_pre_ir_status(iommu);
+
+	if (!is_kdump_kernel() && iommu->pre_enabled_ir) {
+		iommu_disable_irq_remapping(iommu);
+		iommu->pre_enabled_ir = 0;
+		pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
+				iommu->name);
+	}
+
+	if (iommu->pre_enabled_ir) {
+		if (iommu_load_old_irte(iommu))
+			pr_err("Failed to copy IR table for %s from previous kernel\n",
+			       iommu->name);
+		else
+			pr_info("Copied IR table for %s from previous kernel\n",
+				iommu->name);
+	}
+
+	iommu_set_irq_remapping(iommu, eim_mode);
+
 	return 0;
 
 out_free_pages:
@@ -682,28 +703,11 @@ static int __init intel_enable_irq_remapping(void)
 	struct intel_iommu *iommu;
 	bool setup = false;
 
-	for_each_iommu(iommu, drhd) {
-		iommu_check_pre_ir_status(iommu);
-
-		if (!is_kdump_kernel() && iommu->pre_enabled_ir) {
-			iommu_disable_irq_remapping(iommu);
-			iommu->pre_enabled_ir = 0;
-			pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
-				iommu->name);
-		}
-	}
-
 	/*
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
-		if (iommu->pre_enabled_ir) {
-			iommu_load_old_irte(iommu);
-		} else {
-			iommu_set_irq_remapping(iommu, eim_mode);
-			iommu_enable_irq_remapping(iommu);
-		}
-
+		iommu_enable_irq_remapping(iommu);
 		setup = true;
 	}
 
-- 
1.9.1

