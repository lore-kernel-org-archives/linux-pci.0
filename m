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
Subject: [PATCH 21/37] iommu/arm-smmu-v3: Seize private ASID
Date: Mon, 12 Feb 2018 18:33:36 +0000
Message-Id: <20180212183352.22730-22-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SMMU has a single ASID space, the union of shared and private ASID
sets. This means that the PASID lib competes with the arch allocator for
ASIDs. Shared ASIDs are those of Linux processes, allocated by the arch,
and contribute in broadcast TLB maintenance. Private ASIDs are allocated
by the SMMU driver and used for "classic" map/unmap DMA. They require
explicit TLB invalidations.

When we pin down an mm_context and get an ASID that is already in use by
the SMMU, it belongs to a private context. We used to simply abort the
bind, but this is unfair to users that would be unable to bind a few
seemingly random processes. We can try one step further, by allocating a
new private ASID for the context in use, and make the old ASID shared.

Introduce a new lock to prevent races when rewriting context descriptors.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3-context.c | 88 ++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index b7c90384ff56..5b8c5875e0d9 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -82,6 +82,7 @@
 	(((tcr) >> ARM64_TCR_##fld##_SHIFT & ARM64_TCR_##fld##_MASK)	\
 	 << CTXDESC_CD_0_TCR_##fld##_SHIFT)
 
+#define ARM_SMMU_NO_PASID		(-1)
 
 struct arm_smmu_cd {
 	struct iommu_pasid_entry	entry;
@@ -90,8 +91,14 @@ struct arm_smmu_cd {
 	u64				tcr;
 	u64				mair;
 
+	int				pasid;
+
+	/* 'refs' tracks alloc/free */
 	refcount_t			refs;
+	/* 'users' tracks attach/detach, and is only used for sanity checking */
+	unsigned int			users;
 	struct mm_struct		*mm;
+	struct arm_smmu_cd_tables	*tbl;
 };
 
 #define pasid_entry_to_cd(entry) \
@@ -123,6 +130,7 @@ struct arm_smmu_cd_tables {
 #define pasid_ops_to_tables(ops) \
 	pasid_to_cd_tables(iommu_pasid_table_ops_to_table(ops))
 
+static DEFINE_SPINLOCK(contexts_lock);
 static DEFINE_SPINLOCK(asid_lock);
 static DEFINE_IDR(asid_idr);
 
@@ -209,8 +217,8 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	return val;
 }
 
-static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
-				    struct arm_smmu_cd *cd)
+static int __arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
+				     struct arm_smmu_cd *cd)
 {
 	u64 val;
 	bool cd_live;
@@ -284,6 +292,18 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 	return 0;
 }
 
+static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
+				   struct arm_smmu_cd *cd)
+{
+	int ret;
+
+	spin_lock(&contexts_lock);
+	ret = __arm_smmu_write_ctx_desc(tbl, ssid, cd);
+	spin_unlock(&contexts_lock);
+
+	return ret;
+}
+
 static bool arm_smmu_free_asid(struct arm_smmu_cd *cd)
 {
 	bool free;
@@ -308,14 +328,25 @@ static struct arm_smmu_cd *arm_smmu_alloc_cd(struct arm_smmu_cd_tables *tbl)
 	if (!cd)
 		return NULL;
 
+	cd->pasid	= ARM_SMMU_NO_PASID;
+	cd->tbl		= tbl;
 	refcount_set(&cd->refs, 1);
 
 	return cd;
 }
 
+/*
+ * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
+ * the private entry. Careful here, we may be modifying the context tables of
+ * another SMMU!
+ */
 static struct arm_smmu_cd *arm_smmu_share_asid(u16 asid)
 {
+	int ret;
 	struct arm_smmu_cd *cd;
+	struct arm_smmu_cd_tables *tbl;
+	struct arm_smmu_context_cfg *cfg;
+	struct iommu_pasid_entry old_entry;
 
 	cd = idr_find(&asid_idr, asid);
 	if (!cd)
@@ -325,17 +356,47 @@ static struct arm_smmu_cd *arm_smmu_share_asid(u16 asid)
 		/*
 		 * It's pretty common to find a stale CD when doing unbind-bind,
 		 * given that the release happens after a RCU grace period.
-		 * Simply reuse it.
+		 * Simply reuse it, but check that it isn't active, because it's
+		 * going to be assigned a different PASID.
 		 */
+		if (WARN_ON(cd->users))
+			return ERR_PTR(-EINVAL);
+
 		refcount_inc(&cd->refs);
 		return cd;
 	}
 
+	tbl = cd->tbl;
+	cfg = &tbl->pasid.cfg.arm_smmu;
+
+	ret = idr_alloc_cyclic(&asid_idr, cd, 0, 1 << cfg->asid_bits,
+			       GFP_ATOMIC);
+	if (ret < 0)
+		return ERR_PTR(-ENOSPC);
+
+	/* Save the previous ASID */
+	old_entry = cd->entry;
+
+	/*
+	 * Race with unmap; TLB invalidations will start targeting the new ASID,
+	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
+	 * later, so it doesn't matter.
+	 */
+	cd->entry.tag = ret;
+
 	/*
-	 * Ouch, ASID is already in use for a private cd.
-	 * TODO: seize it, for the common good.
+	 * Update ASID and invalidate CD in all associated masters. There will
+	 * be some overlap between use of both ASIDs, until we invalidate the
+	 * TLB.
 	 */
-	return ERR_PTR(-EEXIST);
+	arm_smmu_write_ctx_desc(tbl, cd->pasid, cd);
+
+	/* Invalidate TLB entries previously associated with that context */
+	iommu_pasid_flush_tlbs(&tbl->pasid, cd->pasid, &old_entry);
+
+	idr_remove(&asid_idr, asid);
+
+	return NULL;
 }
 
 static struct iommu_pasid_entry *
@@ -500,6 +561,15 @@ static int arm_smmu_set_cd(struct iommu_pasid_table_ops *ops, int pasid,
 	if (WARN_ON(pasid > (1 << tbl->pasid.cfg.order)))
 		return -EINVAL;
 
+	if (WARN_ON(cd->pasid != ARM_SMMU_NO_PASID && cd->pasid != pasid))
+		return -EEXIST;
+
+	/*
+	 * There is a single cd structure for each address space, multiple
+	 * devices may use the same in different tables.
+	 */
+	cd->users++;
+	cd->pasid = pasid;
 	return arm_smmu_write_ctx_desc(tbl, pasid, cd);
 }
 
@@ -507,10 +577,16 @@ static void arm_smmu_clear_cd(struct iommu_pasid_table_ops *ops, int pasid,
 			      struct iommu_pasid_entry *entry)
 {
 	struct arm_smmu_cd_tables *tbl = pasid_ops_to_tables(ops);
+	struct arm_smmu_cd *cd = pasid_entry_to_cd(entry);
 
 	if (WARN_ON(pasid > (1 << tbl->pasid.cfg.order)))
 		return;
 
+	WARN_ON(cd->pasid != pasid);
+
+	if (!(--cd->users))
+		cd->pasid = ARM_SMMU_NO_PASID;
+
 	arm_smmu_write_ctx_desc(tbl, pasid, NULL);
 
 	/*
-- 
2.15.1

