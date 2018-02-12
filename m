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
Subject: [PATCH 18/37] iommu/arm-smmu-v3: Add support for Substream IDs
Date: Mon, 12 Feb 2018 18:33:33 +0000
Message-Id: <20180212183352.22730-19-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

At the moment, the SMMUv3 driver offers only one stage-1 or stage-2
address space to each device. SMMUv3 allows to associate multiple address
spaces per device. In addition to the Stream ID (SID), that identifies a
device, we can now have Substream IDs (SSID) identifying an address space.
In PCIe lingo, SID is called Requester ID (RID) and SSID is called Process
Address-Space ID (PASID).

Prepare the driver for SSID support, by adding context descriptor tables
in STEs (previously a single static context descriptor). A complete
stage-1 walk is now performed like this by the SMMU:

      Stream tables          Ctx. tables          Page tables
        +--------+   ,------->+-------+   ,------->+-------+
        :        :   |        :       :   |        :       :
        +--------+   |        +-------+   |        +-------+
   SID->|  STE   |---'  SSID->|  CD   |---'  IOVA->|  PTE  |--> IPA
        +--------+            +-------+            +-------+
        :        :            :       :            :       :
        +--------+            +-------+            +-------+

We only implement one level of context descriptor table for now, but as
with stream and page tables, an SSID can be split to target multiple
levels of tables.

In all stream table entries, we set S1DSS=SSID0 mode, making translations
without an ssid use context descriptor 0.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3-context.c | 132 ++++++++++++++++++++++++++----------
 drivers/iommu/arm-smmu-v3.c         |  33 +++++++--
 2 files changed, 126 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index e910cb356f45..3b0bb9475dea 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -79,11 +79,14 @@ struct arm_smmu_cd {
 #define pasid_entry_to_cd(entry) \
 	container_of((entry), struct arm_smmu_cd, entry)
 
+struct arm_smmu_cd_table {
+	__le64				*ptr;
+	dma_addr_t			ptr_dma;
+};
+
 struct arm_smmu_cd_tables {
 	struct iommu_pasid_table	pasid;
-
-	void				*ptr;
-	dma_addr_t			ptr_dma;
+	struct arm_smmu_cd_table	table;
 };
 
 #define pasid_to_cd_tables(pasid_table) \
@@ -94,6 +97,36 @@ struct arm_smmu_cd_tables {
 
 static DEFINE_IDA(asid_ida);
 
+static int arm_smmu_alloc_cd_leaf_table(struct device *dev,
+					struct arm_smmu_cd_table *desc,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	desc->ptr = dmam_alloc_coherent(dev, size, &desc->ptr_dma,
+					GFP_ATOMIC | __GFP_ZERO);
+	if (!desc->ptr) {
+		dev_warn(dev, "failed to allocate context descriptor table\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void arm_smmu_free_cd_leaf_table(struct device *dev,
+					struct arm_smmu_cd_table *desc,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(dev, size, desc->ptr, desc->ptr_dma);
+}
+
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_cd_tables *tbl, u32 ssid)
+{
+	return tbl->table.ptr + ssid * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -116,33 +149,72 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 				    struct arm_smmu_cd *cd)
 {
 	u64 val;
-	__u64 *cdptr = tbl->ptr;
+	bool cd_live;
 	struct arm_smmu_context_cfg *cfg = &tbl->pasid.cfg.arm_smmu;
-
-	if (!cd || WARN_ON(ssid))
-		return -EINVAL;
+	__le64 *cdptr = arm_smmu_get_cd_ptr(tbl, ssid);
 
 	/*
-	 * We don't need to issue any invalidation here, as we'll invalidate
-	 * the STE when installing the new entry anyway.
+	 * This function handles the following cases:
+	 *
+	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
+	 * (2) Install a secondary CD, for SID+SSID traffic, followed by an
+	 *     invalidation.
+	 * (3) Update ASID of primary CD. This is allowed by atomically writing
+	 *     the first 64 bits of the CD, followed by invalidation of the old
+	 *     entry and mappings.
+	 * (4) Remove a secondary CD and invalidate it.
 	 */
-	val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
+
+	if (!cdptr)
+		return -ENOMEM;
+
+	val = le64_to_cpu(cdptr[0]);
+	cd_live = !!(val & CTXDESC_CD_0_V);
+
+	if (!cd) { /* (4) */
+		cdptr[0] = 0;
+	} else if (cd_live) { /* (3) */
+		val &= ~(CTXDESC_CD_0_ASID_MASK << CTXDESC_CD_0_ASID_SHIFT);
+		val |= (cd->entry.tag & CTXDESC_CD_0_ASID_MASK)
+			<< CTXDESC_CD_0_ASID_SHIFT;
+
+		cdptr[0] = cpu_to_le64(val);
+		/*
+		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
+		 * this substream's traffic
+		 */
+	} else { /* (1) and (2) */
+		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK
+				       << CTXDESC_CD_1_TTB0_SHIFT);
+		cdptr[2] = 0;
+		cdptr[3] = cpu_to_le64(cd->mair << CTXDESC_CD_3_MAIR_SHIFT);
+
+		/*
+		 * STE is live, and the SMMU might fetch this CD at any
+		 * time. Ensure it observes the rest of the CD before we
+		 * enable it.
+		 */
+		iommu_pasid_flush(&tbl->pasid, ssid, true);
+
+
+		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
 #ifdef __BIG_ENDIAN
-	      CTXDESC_CD_0_ENDI |
+		      CTXDESC_CD_0_ENDI |
 #endif
-	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
-	      CTXDESC_CD_0_AA64 | cd->entry.tag << CTXDESC_CD_0_ASID_SHIFT |
-	      CTXDESC_CD_0_V;
+		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+		      CTXDESC_CD_0_ASET_PRIVATE |
+		      CTXDESC_CD_0_AA64 |
+		      (cd->entry.tag & CTXDESC_CD_0_ASID_MASK)
+		      << CTXDESC_CD_0_ASID_SHIFT |
+		      CTXDESC_CD_0_V;
 
-	if (cfg->stall)
-		val |= CTXDESC_CD_0_S;
+		if (cfg->stall)
+			val |= CTXDESC_CD_0_S;
 
-	cdptr[0] = cpu_to_le64(val);
-
-	val = cd->ttbr & CTXDESC_CD_1_TTB0_MASK << CTXDESC_CD_1_TTB0_SHIFT;
-	cdptr[1] = cpu_to_le64(val);
+		cdptr[0] = cpu_to_le64(val);
+	}
 
-	cdptr[3] = cpu_to_le64(cd->mair << CTXDESC_CD_3_MAIR_SHIFT);
+	iommu_pasid_flush(&tbl->pasid, ssid, true);
 
 	return 0;
 }
@@ -234,24 +306,17 @@ static void arm_smmu_clear_cd(struct iommu_pasid_table_ops *ops, int pasid,
 static struct iommu_pasid_table *
 arm_smmu_alloc_cd_tables(struct iommu_pasid_table_cfg *cfg, void *cookie)
 {
+	int ret;
 	struct arm_smmu_cd_tables *tbl;
 	struct device *dev = cfg->iommu_dev;
 
-	if (cfg->order) {
-		/* TODO: support SSID */
-		return NULL;
-	}
-
 	tbl = devm_kzalloc(dev, sizeof(*tbl), GFP_KERNEL);
 	if (!tbl)
 		return NULL;
 
-	tbl->ptr = dmam_alloc_coherent(dev, CTXDESC_CD_DWORDS << 3,
-				       &tbl->ptr_dma, GFP_KERNEL | __GFP_ZERO);
-	if (!tbl->ptr) {
-		dev_warn(dev, "failed to allocate context descriptor\n");
+	ret = arm_smmu_alloc_cd_leaf_table(dev, &tbl->table, 1 << cfg->order);
+	if (ret)
 		goto err_free_tbl;
-	}
 
 	tbl->pasid.ops = (struct iommu_pasid_table_ops) {
 		.alloc_priv_entry	= arm_smmu_alloc_priv_cd,
@@ -261,7 +326,7 @@ arm_smmu_alloc_cd_tables(struct iommu_pasid_table_cfg *cfg, void *cookie)
 		.clear_entry		= arm_smmu_clear_cd,
 	};
 
-	cfg->base		= tbl->ptr_dma;
+	cfg->base		= tbl->table.ptr_dma;
 	cfg->arm_smmu.s1fmt	= ARM_SMMU_S1FMT_LINEAR;
 
 	return &tbl->pasid;
@@ -278,8 +343,7 @@ static void arm_smmu_free_cd_tables(struct iommu_pasid_table *pasid_table)
 	struct device *dev = cfg->iommu_dev;
 	struct arm_smmu_cd_tables *tbl = pasid_to_cd_tables(pasid_table);
 
-	dmam_free_coherent(dev, CTXDESC_CD_DWORDS << 3,
-			   tbl->ptr, tbl->ptr_dma);
+	arm_smmu_free_cd_leaf_table(dev, &tbl->table, 1 << cfg->order);
 	devm_kfree(dev, tbl);
 }
 
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b6d8c90fafb3..a307c6885dc0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -239,12 +239,19 @@
 #define STRTAB_STE_0_CFG_S2_TRANS	(6UL << STRTAB_STE_0_CFG_SHIFT)
 
 #define STRTAB_STE_0_S1FMT_SHIFT	4
-#define STRTAB_STE_0_S1FMT_LINEAR	(0UL << STRTAB_STE_0_S1FMT_SHIFT)
+#define STRTAB_STE_0_S1FMT_MASK		0x3UL
 #define STRTAB_STE_0_S1CTXPTR_SHIFT	6
 #define STRTAB_STE_0_S1CTXPTR_MASK	0x3ffffffffffUL
 #define STRTAB_STE_0_S1CDMAX_SHIFT	59
 #define STRTAB_STE_0_S1CDMAX_MASK	0x1fUL
 
+#define STRTAB_STE_1_S1DSS_SHIFT	0
+#define STRTAB_STE_1_S1DSS_MASK		0x3UL
+#define STRTAB_STE_1_S1DSS_TERMINATE	(0x0 << STRTAB_STE_1_S1DSS_SHIFT)
+#define STRTAB_STE_1_S1DSS_BYPASS	(0x1 << STRTAB_STE_1_S1DSS_SHIFT)
+#define STRTAB_STE_1_S1DSS_SSID0	(0x2 << STRTAB_STE_1_S1DSS_SHIFT)
+
+
 #define STRTAB_STE_1_S1C_CACHE_NC	0UL
 #define STRTAB_STE_1_S1C_CACHE_WBRA	1UL
 #define STRTAB_STE_1_S1C_CACHE_WT	2UL
@@ -601,6 +608,8 @@ struct arm_smmu_master_data {
 	struct list_head		list; /* domain->devices */
 
 	struct device			*dev;
+
+	size_t				ssid_bits;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -1108,8 +1117,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s1_cfg) {
+		struct iommu_pasid_table_cfg *cfg = &ste->s1_cfg->tables;
+
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
+			 STRTAB_STE_1_S1DSS_SSID0 |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1CIR_SHIFT |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
@@ -1124,8 +1136,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->s1_cfg->tables.base & STRTAB_STE_0_S1CTXPTR_MASK
+		val |= (cfg->base & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
+			(u64)(cfg->order & STRTAB_STE_0_S1CDMAX_MASK)
+			<< STRTAB_STE_0_S1CDMAX_SHIFT |
+			(cfg->arm_smmu.s1fmt & STRTAB_STE_0_S1FMT_MASK)
+			<< STRTAB_STE_0_S1FMT_SHIFT |
 			STRTAB_STE_0_CFG_S1_TRANS;
 	}
 
@@ -1569,6 +1585,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master_data *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
@@ -1578,6 +1595,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct iommu_pasid_table_cfg pasid_cfg = {
 		.iommu_dev		= smmu->dev,
+		.order			= master->ssid_bits,
 		.sync			= &arm_smmu_ctx_sync,
 		.arm_smmu = {
 			.stall		= !!(smmu->features & ARM_SMMU_FEAT_STALL_FORCE),
@@ -1612,6 +1630,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_master_data *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
@@ -1628,7 +1647,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_master_data *master)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -1636,6 +1656,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_master_data *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
@@ -1688,7 +1709,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, master, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -1783,7 +1804,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, master);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -1939,6 +1960,8 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		iommu_group_put(group);
-- 
2.15.1

