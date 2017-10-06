Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 15/36] iommu/arm-smmu-v3: Add second level of context descriptor table
Date: Fri,  6 Oct 2017 14:31:42 +0100
Message-Id: <20171006133203.22803-16-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SMMU can support up to 20 bits of SSID. Add a second level of page
tables to accommodate this. Devices that support more than 1024 SSIDs now
have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
descriptors (64kB), allocated on demand.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 198 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 179 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 37061e1cbae4..c444f9e83b91 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -239,6 +239,8 @@
 
 #define STRTAB_STE_0_S1FMT_SHIFT	4
 #define STRTAB_STE_0_S1FMT_LINEAR	(0UL << STRTAB_STE_0_S1FMT_SHIFT)
+#define STRTAB_STE_0_S1FMT_4K_L2	(1UL << STRTAB_STE_0_S1FMT_SHIFT)
+#define STRTAB_STE_0_S1FMT_64K_L2	(2UL << STRTAB_STE_0_S1FMT_SHIFT)
 #define STRTAB_STE_0_S1CTXPTR_SHIFT	6
 #define STRTAB_STE_0_S1CTXPTR_MASK	0x3ffffffffffUL
 #define STRTAB_STE_0_S1CDMAX_SHIFT	59
@@ -287,7 +289,21 @@
 #define STRTAB_STE_3_S2TTB_SHIFT	4
 #define STRTAB_STE_3_S2TTB_MASK		0xfffffffffffUL
 
-/* Context descriptor (stage-1 only) */
+/*
+ * Context descriptor
+ *
+ * Linear: when less than 1024 SSIDs are supported
+ * 2lvl: at most 1024 L1 entrie,
+ *	 1024 lazy entries per table.
+ */
+#define CTXDESC_SPLIT			10
+#define CTXDESC_NUM_L2_ENTRIES		(1 << CTXDESC_SPLIT)
+
+#define CTXDESC_L1_DESC_DWORD		1
+#define CTXDESC_L1_DESC_VALID		1
+#define CTXDESC_L1_DESC_L2PTR_SHIFT	12
+#define CTXDESC_L1_DESC_L2PTR_MASK	0xfffffffffUL
+
 #define CTXDESC_CD_DWORDS		8
 #define CTXDESC_CD_0_TCR_T0SZ_SHIFT	0
 #define ARM64_TCR_T0SZ_SHIFT		0
@@ -567,9 +583,24 @@ struct arm_smmu_ctx_desc {
 	u64				mair;
 };
 
-struct arm_smmu_s1_cfg {
+struct arm_smmu_cd_table {
 	__le64				*cdptr;
 	dma_addr_t			cdptr_dma;
+};
+
+struct arm_smmu_s1_cfg {
+	bool				linear;
+
+	union {
+		struct arm_smmu_cd_table table;
+		struct {
+			__le64		*ptr;
+			dma_addr_t	ptr_dma;
+			size_t		num_entries;
+
+			struct arm_smmu_cd_table *tables;
+		} l1;
+	};
 
 	size_t				num_contexts;
 
@@ -1000,7 +1031,8 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
-static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, u32 ssid)
+static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, u32 ssid,
+			     bool leaf)
 {
 	size_t i;
 	unsigned long flags;
@@ -1010,7 +1042,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, u32 ssid)
 		.opcode = CMDQ_OP_CFGI_CD,
 		.cfgi   = {
 			.ssid   = ssid,
-			.leaf   = true,
+			.leaf   = leaf,
 		},
 	};
 
@@ -1029,6 +1061,69 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, u32 ssid)
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 }
 
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *desc,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	desc->cdptr = dmam_alloc_coherent(smmu->dev, size, &desc->cdptr_dma,
+					  GFP_ATOMIC | __GFP_ZERO);
+	if (!desc->cdptr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *desc,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	dmam_free_coherent(smmu->dev, size, desc->cdptr, desc->cdptr_dma);
+}
+
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_cd_table *table)
+{
+	u64 val = (table->cdptr_dma & CTXDESC_L1_DESC_L2PTR_MASK
+		  << CTXDESC_L1_DESC_L2PTR_SHIFT) | CTXDESC_L1_DESC_VALID;
+
+	*dst = cpu_to_le64(val);
+}
+
+static __u64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain, u32 ssid)
+{
+	unsigned long idx;
+	struct arm_smmu_cd_table *l1_desc;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	if (cfg->linear)
+		return cfg->table.cdptr + ssid * CTXDESC_CD_DWORDS;
+
+	idx = ssid >> CTXDESC_SPLIT;
+	if (idx >= cfg->l1.num_entries)
+		return NULL;
+
+	l1_desc = &cfg->l1.tables[idx];
+	if (!l1_desc->cdptr) {
+		__le64 *l1ptr = cfg->l1.ptr + idx * CTXDESC_L1_DESC_DWORD;
+
+		if (arm_smmu_alloc_cd_leaf_table(smmu_domain->smmu, l1_desc,
+						 CTXDESC_NUM_L2_ENTRIES))
+			return NULL;
+
+		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
+		/* An invalid L1 entry is allowed to be cached */
+		arm_smmu_sync_cd(smmu_domain, idx << CTXDESC_SPLIT, false);
+	}
+
+	idx = ssid & (CTXDESC_NUM_L2_ENTRIES - 1);
+
+	return l1_desc->cdptr + idx * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -1052,7 +1147,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 {
 	u64 val;
 	bool cd_live;
-	__u64 *cdptr = (__u64 *)smmu_domain->s1_cfg.cdptr + ssid * CTXDESC_CD_DWORDS;
+	__u64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
 
 	/*
 	 * This function handles the following cases:
@@ -1067,6 +1162,9 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	 * (4) Remove a secondary CD and invalidate it.
 	 */
 
+	if (WARN_ON(!cdptr))
+		return;
+
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
@@ -1074,7 +1172,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		/* (4) */
 		cdptr[0] = 0;
 		if (ssid)
-			arm_smmu_sync_cd(smmu_domain, ssid);
+			arm_smmu_sync_cd(smmu_domain, ssid, true);
 		return;
 	}
 
@@ -1102,7 +1200,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 			 * time. Ensure it observes the rest of the CD before we
 			 * enable it.
 			 */
-			arm_smmu_sync_cd(smmu_domain, ssid);
+			arm_smmu_sync_cd(smmu_domain, ssid, true);
 
 		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
 #ifdef __BIG_ENDIAN
@@ -1122,12 +1220,15 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 	}
 
 	if (ssid || cd_live)
-		arm_smmu_sync_cd(smmu_domain, ssid);
+		arm_smmu_sync_cd(smmu_domain, ssid, true);
 }
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	int ret;
 	int num_ssids;
+	size_t num_leaf_entries, size = 0;
+	struct arm_smmu_cd_table *leaf_table;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
@@ -1135,28 +1236,80 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 		return -EINVAL;
 
 	num_ssids = cfg->num_contexts;
+	if (num_ssids <= CTXDESC_NUM_L2_ENTRIES) {
+		/* Fits in a single table */
+		cfg->linear = true;
+		num_leaf_entries = num_ssids;
+		leaf_table = &cfg->table;
+	} else {
+		/*
+		 * SSID[S1CDmax-1:10] indexes 1st-level table, SSID[9:0] indexes
+		 * 2nd-level
+		 */
+		cfg->linear = false;
+		cfg->l1.num_entries = num_ssids / CTXDESC_NUM_L2_ENTRIES;
 
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev,
-					 num_ssids * (CTXDESC_CD_DWORDS << 3),
-					 &cfg->cdptr_dma,
-					 GFP_KERNEL | __GFP_ZERO);
-	if (!cfg->cdptr)
-		return -ENOMEM;
+		cfg->l1.tables = devm_kzalloc(smmu->dev,
+					      sizeof(struct arm_smmu_cd_table) *
+					      cfg->l1.num_entries, GFP_KERNEL);
+		if (!cfg->l1.tables)
+			return -ENOMEM;
+
+		size = cfg->l1.num_entries * (CTXDESC_L1_DESC_DWORD << 3);
+		cfg->l1.ptr = dmam_alloc_coherent(smmu->dev, size,
+						  &cfg->l1.ptr_dma,
+						  GFP_KERNEL | __GFP_ZERO);
+		if (!cfg->l1.ptr) {
+			devm_kfree(smmu->dev, cfg->l1.tables);
+			return -ENOMEM;
+		}
+
+		num_leaf_entries = CTXDESC_NUM_L2_ENTRIES;
+		leaf_table = cfg->l1.tables;
+	}
+
+	ret = arm_smmu_alloc_cd_leaf_table(smmu, leaf_table, num_leaf_entries);
+	if (ret) {
+		if (!cfg->linear) {
+			dmam_free_coherent(smmu->dev, size, cfg->l1.ptr,
+					   cfg->l1.ptr_dma);
+			devm_kfree(smmu->dev, cfg->l1.tables);
+		}
+
+		return ret;
+	}
+
+	if (!cfg->linear)
+		arm_smmu_write_cd_l1_desc(cfg->l1.ptr, leaf_table);
 
 	return 0;
 }
 
 static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 {
+	size_t i, size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 	if (WARN_ON(smmu_domain->stage != ARM_SMMU_DOMAIN_S1))
 		return;
 
-	dmam_free_coherent(smmu->dev,
-			   cfg->num_contexts * (CTXDESC_CD_DWORDS << 3),
-			   cfg->cdptr, cfg->cdptr_dma);
+	if (cfg->linear) {
+		arm_smmu_free_cd_leaf_table(smmu, &cfg->table, cfg->num_contexts);
+	} else {
+		for (i = 0; i < cfg->l1.num_entries; i++) {
+			struct arm_smmu_cd_table *desc = &cfg->l1.tables[i];
+
+			if (!desc->cdptr)
+				continue;
+
+			arm_smmu_free_cd_leaf_table(smmu, desc,
+						    CTXDESC_NUM_L2_ENTRIES);
+		}
+
+		size = cfg->l1.num_entries * (CTXDESC_L1_DESC_DWORD << 3);
+		dmam_free_coherent(smmu->dev, size, cfg->l1.ptr, cfg->l1.ptr_dma);
+	}
 }
 
 /* Stream table manipulation functions */
@@ -1255,10 +1408,16 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s1_cfg) {
+		dma_addr_t s1ctxptr;
 		unsigned int s1cdmax = ilog2(ste->s1_cfg->num_contexts);
 
 		BUG_ON(ste_live);
 
+		if (ste->s1_cfg->linear)
+			s1ctxptr = ste->s1_cfg->table.cdptr_dma;
+		else
+			s1ctxptr = ste->s1_cfg->l1.ptr_dma;
+
 		dst[1] = cpu_to_le64(
 			 STRTAB_STE_1_S1DSS_SSID0 |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
@@ -1275,11 +1434,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
+		val |= (s1ctxptr & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
 			(u64)(s1cdmax & STRTAB_STE_0_S1CDMAX_MASK)
 			<< STRTAB_STE_0_S1CDMAX_SHIFT |
-			STRTAB_STE_0_S1FMT_LINEAR |
+			(ste->s1_cfg->linear ? STRTAB_STE_0_S1FMT_LINEAR :
+			   STRTAB_STE_0_S1FMT_64K_L2) |
 			STRTAB_STE_0_CFG_S1_TRANS;
 	}
 
-- 
2.13.3

