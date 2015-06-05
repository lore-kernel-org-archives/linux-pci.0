Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH 14/17] iommu/vt-d: Move kdump pointer intialization to __iommu_load_old_irte
Date: Fri,  5 Jun 2015 16:11:00 +0200
Message-Id: <1433513463-19128-15-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

We initialize the base_old_phys and base_old_virt in this
function. This cleans up the caller and makes the code more
readable. Also add a check for the size of the irq
remapping table of the old kernel, break out if it does not
match our size. Rename the function to iommu_load_old_irte
while at it.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 50 +++++++++++++++++++++----------------
 include/linux/intel-iommu.h         |  1 +
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index c3d1e63..fd6c25b 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -21,7 +21,7 @@
 
 #include "irq_remapping.h"
 
-static int __iommu_load_old_irte(struct intel_iommu *iommu);
+static int iommu_load_old_irte(struct intel_iommu *iommu);
 static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu);
 
@@ -698,14 +698,7 @@ static int __init intel_enable_irq_remapping(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		if (iommu->pre_enabled_ir) {
-			unsigned long long q;
-
-			q = dmar_readq(iommu->reg + DMAR_IRTA_REG);
-			iommu->ir_table->base_old_phys = q & VTD_PAGE_MASK;
-			iommu->ir_table->base_old_virt = ioremap_cache(
-				iommu->ir_table->base_old_phys,
-				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
-			__iommu_load_old_irte(iommu);
+			iommu_load_old_irte(iommu);
 		} else {
 			iommu_set_irq_remapping(iommu, eim_mode);
 			iommu_enable_irq_remapping(iommu);
@@ -1303,21 +1296,34 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	return ret;
 }
 
-static int __iommu_load_old_irte(struct intel_iommu *iommu)
+static int iommu_load_old_irte(struct intel_iommu *iommu)
 {
-	if ((!iommu)
-		|| (!iommu->ir_table)
-		|| (!iommu->ir_table->base)
-		|| (!iommu->ir_table->base_old_phys)
-		|| (!iommu->ir_table->base_old_virt))
-		return -1;
+	struct irte *old_ir_table;
+	phys_addr_t irt_phys;
+	size_t size;
+	u64 irta;
+
+	/* Check whether the old ir-table has the same size as ours */
+	irta = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+	if ((irta & INTR_REMAP_TABLE_REG_SIZE_MASK)
+		 != INTR_REMAP_TABLE_REG_SIZE)
+		return -EINVAL;
+
+	irt_phys = irta & VTD_PAGE_MASK;
+	size     = INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte);
+
+	/* Map the old IR table */
+	old_ir_table = ioremap_cache(irt_phys, size);
+	if (!old_ir_table)
+		return -ENOMEM;
+
+	/* Copy data over */
+	memcpy(iommu->ir_table->base, old_ir_table, size);
 
-	memcpy(iommu->ir_table->base,
-		iommu->ir_table->base_old_virt,
-		INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
-	__iommu_flush_cache(iommu, iommu->ir_table->base,
-		INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+	iommu->ir_table->base_old_phys = irt_phys;
+	iommu->ir_table->base_old_virt = old_ir_table;
 
 	return 0;
 }
@@ -1327,7 +1333,7 @@ static int __iommu_update_old_irte(struct intel_iommu *iommu, int index)
 	int start;
 	unsigned long size;
 	void __iomem *to;
-	void *from;
+void *from;
 
 	if ((!iommu)
 		|| (!iommu->ir_table)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6c37de9..5aa8834 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -295,6 +295,7 @@ struct q_inval {
 /* 1MB - maximum possible interrupt remapping table size */
 #define INTR_REMAP_PAGE_ORDER	8
 #define INTR_REMAP_TABLE_REG_SIZE	0xf
+#define INTR_REMAP_TABLE_REG_SIZE_MASK  0xf
 
 #define INTR_REMAP_TABLE_ENTRIES	65536
 
-- 
1.9.1

