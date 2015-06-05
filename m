Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59220 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423045AbbFEOLU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [PATCH 13/17] iommu/vt-d: Split up iommu_set_irq_remapping
Date: Fri,  5 Jun 2015 16:10:59 +0200
Message-Id: <1433513463-19128-14-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Split out the part that enables irq remapping into the new
function iommu_enable_irq_remapping. This allows to program
the irq remapping table to the hardware without enabling irq
remapping.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 35d73f6..c3d1e63 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -440,9 +440,9 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 
 static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 {
+	unsigned long flags;
 	u64 addr;
 	u32 sts;
-	unsigned long flags;
 
 	addr = virt_to_phys((void *)iommu->ir_table->base);
 
@@ -463,6 +463,12 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 	 * interrupt-remapping.
 	 */
 	qi_global_iec(iommu);
+}
+
+static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+	u32 sts;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
@@ -700,8 +706,10 @@ static int __init intel_enable_irq_remapping(void)
 				iommu->ir_table->base_old_phys,
 				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
 			__iommu_load_old_irte(iommu);
-		} else
+		} else {
 			iommu_set_irq_remapping(iommu, eim_mode);
+			iommu_enable_irq_remapping(iommu);
+		}
 
 		setup = true;
 	}
@@ -939,6 +947,7 @@ static int reenable_irq_remapping(int eim)
 
 		/* Set up interrupt remapping for iommu.*/
 		iommu_set_irq_remapping(iommu, eim);
+		iommu_enable_irq_remapping(iommu);
 		setup = true;
 	}
 
@@ -1257,6 +1266,7 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 		ir_remove_ioapic_hpet_scope(iommu);
 	} else {
 		iommu_set_irq_remapping(iommu, eim);
+		iommu_enable_irq_remapping(iommu);
 	}
 
 	return ret;
-- 
1.9.1

