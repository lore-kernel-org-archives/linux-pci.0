Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 20/37] iommu/arm-smmu-v3: Share process page tables
Date: Mon, 12 Feb 2018 18:33:35 +0000
Message-Id: <20180212183352.22730-21-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
into two sets, shared and private. Shared ASIDs correspond to those
obtained from the arch ASID allocator, and private ASIDs are used for
"classic" map/unmap DMA.

Replace the ASID IDA with an IDR, allowing to keep information about each
context. Initialize shared contexts with info obtained from the mm.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3-context.c | 181 ++++++++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index aaffc2071966..b7c90384ff56 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -10,9 +10,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
+#include <linux/mmu_context.h>
 #include <linux/slab.h>
 
 #include "iommu-pasid.h"
+#include "io-pgtable-arm.h"
 
 /*
  * Linear: when less than 1024 SSIDs are supported
@@ -87,6 +89,9 @@ struct arm_smmu_cd {
 	u64				ttbr;
 	u64				tcr;
 	u64				mair;
+
+	refcount_t			refs;
+	struct mm_struct		*mm;
 };
 
 #define pasid_entry_to_cd(entry) \
@@ -118,7 +123,8 @@ struct arm_smmu_cd_tables {
 #define pasid_ops_to_tables(ops) \
 	pasid_to_cd_tables(iommu_pasid_table_ops_to_table(ops))
 
-static DEFINE_IDA(asid_ida);
+static DEFINE_SPINLOCK(asid_lock);
+static DEFINE_IDR(asid_idr);
 
 static int arm_smmu_alloc_cd_leaf_table(struct device *dev,
 					struct arm_smmu_cd_table *desc,
@@ -260,7 +266,8 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 		      CTXDESC_CD_0_ENDI |
 #endif
 		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
-		      CTXDESC_CD_0_ASET_PRIVATE |
+		      (cd->mm ? CTXDESC_CD_0_ASET_SHARED :
+		       CTXDESC_CD_0_ASET_PRIVATE) |
 		      CTXDESC_CD_0_AA64 |
 		      (cd->entry.tag & CTXDESC_CD_0_ASID_MASK)
 		      << CTXDESC_CD_0_ASID_SHIFT |
@@ -277,10 +284,145 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 	return 0;
 }
 
+static bool arm_smmu_free_asid(struct arm_smmu_cd *cd)
+{
+	bool free;
+	struct arm_smmu_cd *old_cd;
+
+	spin_lock(&asid_lock);
+	free = refcount_dec_and_test(&cd->refs);
+	if (free) {
+		old_cd = idr_remove(&asid_idr, (u16)cd->entry.tag);
+		WARN_ON(old_cd != cd);
+	}
+	spin_unlock(&asid_lock);
+
+	return free;
+}
+
+static struct arm_smmu_cd *arm_smmu_alloc_cd(struct arm_smmu_cd_tables *tbl)
+{
+	struct arm_smmu_cd *cd;
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return NULL;
+
+	refcount_set(&cd->refs, 1);
+
+	return cd;
+}
+
+static struct arm_smmu_cd *arm_smmu_share_asid(u16 asid)
+{
+	struct arm_smmu_cd *cd;
+
+	cd = idr_find(&asid_idr, asid);
+	if (!cd)
+		return NULL;
+
+	if (cd->mm) {
+		/*
+		 * It's pretty common to find a stale CD when doing unbind-bind,
+		 * given that the release happens after a RCU grace period.
+		 * Simply reuse it.
+		 */
+		refcount_inc(&cd->refs);
+		return cd;
+	}
+
+	/*
+	 * Ouch, ASID is already in use for a private cd.
+	 * TODO: seize it, for the common good.
+	 */
+	return ERR_PTR(-EEXIST);
+}
+
 static struct iommu_pasid_entry *
 arm_smmu_alloc_shared_cd(struct iommu_pasid_table_ops *ops, struct mm_struct *mm)
 {
-	return ERR_PTR(-ENODEV);
+	u16 asid;
+	u64 tcr, par, reg;
+	int ret = -ENOMEM;
+	struct arm_smmu_cd *cd;
+	struct arm_smmu_cd *old_cd = NULL;
+	struct arm_smmu_cd_tables *tbl = pasid_ops_to_tables(ops);
+
+	asid = mm_context_get(mm);
+	if (!asid)
+		return ERR_PTR(-ESRCH);
+
+	cd = arm_smmu_alloc_cd(tbl);
+	if (!cd)
+		goto err_put_context;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&asid_lock);
+	old_cd = arm_smmu_share_asid(asid);
+	if (!old_cd)
+		ret = idr_alloc(&asid_idr, cd, asid, asid + 1, GFP_ATOMIC);
+	spin_unlock(&asid_lock);
+	idr_preload_end();
+
+	if (!IS_ERR_OR_NULL(old_cd)) {
+		if (WARN_ON(old_cd->mm != mm)) {
+			ret = -EINVAL;
+			goto err_free_cd;
+		}
+		kfree(cd);
+		mm_context_put(mm);
+		return &old_cd->entry;
+	} else if (old_cd) {
+		ret = PTR_ERR(old_cd);
+		goto err_free_cd;
+	}
+
+	tcr = TCR_T0SZ(VA_BITS) | TCR_IRGN0_WBWA | TCR_ORGN0_WBWA |
+		TCR_SH0_INNER | ARM_LPAE_TCR_EPD1;
+
+	switch (PAGE_SIZE) {
+	case SZ_4K:
+		tcr |= TCR_TG0_4K;
+		break;
+	case SZ_16K:
+		tcr |= TCR_TG0_16K;
+		break;
+	case SZ_64K:
+		tcr |= TCR_TG0_64K;
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto err_free_asid;
+	}
+
+	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+
+	cd->ttbr	= virt_to_phys(mm->pgd);
+	cd->tcr		= tcr;
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cd->mair	= read_sysreg(mair_el1);
+
+	cd->mm		= mm;
+	cd->entry.tag	= asid;
+
+	return &cd->entry;
+
+err_free_asid:
+	arm_smmu_free_asid(cd);
+
+err_free_cd:
+	kfree(cd);
+
+err_put_context:
+	mm_context_put(mm);
+
+	return ERR_PTR(ret);
 }
 
 static struct iommu_pasid_entry *
@@ -294,19 +436,23 @@ arm_smmu_alloc_priv_cd(struct iommu_pasid_table_ops *ops,
 	struct arm_smmu_cd_tables *tbl = pasid_ops_to_tables(ops);
 	struct arm_smmu_context_cfg *ctx_cfg = &tbl->pasid.cfg.arm_smmu;
 
-	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	cd = arm_smmu_alloc_cd(tbl);
 	if (!cd)
 		return ERR_PTR(-ENOMEM);
 
-	asid = ida_simple_get(&asid_ida, 0, 1 << ctx_cfg->asid_bits,
-			      GFP_KERNEL);
+	idr_preload(GFP_KERNEL);
+	spin_lock(&asid_lock);
+	asid = idr_alloc_cyclic(&asid_idr, cd, 0, 1 << ctx_cfg->asid_bits,
+				GFP_ATOMIC);
+	cd->entry.tag = asid;
+	spin_unlock(&asid_lock);
+	idr_preload_end();
+
 	if (asid < 0) {
 		kfree(cd);
 		return ERR_PTR(asid);
 	}
 
-	cd->entry.tag = asid;
-
 	switch (fmt) {
 	case ARM_64_LPAE_S1:
 		cd->ttbr	= cfg->arm_lpae_s1_cfg.ttbr[0];
@@ -322,7 +468,7 @@ arm_smmu_alloc_priv_cd(struct iommu_pasid_table_ops *ops,
 	return &cd->entry;
 
 err_free_asid:
-	ida_simple_remove(&asid_ida, asid);
+	arm_smmu_free_asid(cd);
 
 	kfree(cd);
 
@@ -334,7 +480,14 @@ static void arm_smmu_free_cd(struct iommu_pasid_table_ops *ops,
 {
 	struct arm_smmu_cd *cd = pasid_entry_to_cd(entry);
 
-	ida_simple_remove(&asid_ida, (u16)entry->tag);
+	if (!arm_smmu_free_asid(cd))
+		return;
+
+	if (cd->mm) {
+		/* Unpin ASID */
+		mm_context_put(cd->mm);
+	}
+
 	kfree(cd);
 }
 
@@ -359,6 +512,14 @@ static void arm_smmu_clear_cd(struct iommu_pasid_table_ops *ops, int pasid,
 		return;
 
 	arm_smmu_write_ctx_desc(tbl, pasid, NULL);
+
+	/*
+	 * The ASID allocator won't broadcast the final TLB invalidations for
+	 * this ASID, so we need to do it manually. For private contexts,
+	 * freeing io-pgtable ops performs the invalidation.
+	 */
+	if (cd->mm)
+		iommu_pasid_flush_tlbs(&tbl->pasid, cd->pasid, entry);
 }
 
 static struct iommu_pasid_table *
-- 
2.15.1

