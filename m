Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 07/30] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Date: Mon, 27 Feb 2017 19:54:18 +0000
Message-Id: <20170227195441.5170-8-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The SMMU can support up to 20 bits of SSID. Add a second level of page
tables to accommodate this. Devices without support for SSID still have a
single context descriptor, but the others now have a first table of 1024
entries (8kB), pointing to tables of 1024 context descriptors (64kB),
allocated on demand.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 251 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 223 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f88d62025efa..cebbc8a22ec6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -241,6 +241,8 @@
 
 #define STRTAB_STE_0_S1FMT_SHIFT	4
 #define STRTAB_STE_0_S1FMT_LINEAR	(0UL << STRTAB_STE_0_S1FMT_SHIFT)
+#define STRTAB_STE_0_S1FMT_4K_L2	(1UL << STRTAB_STE_0_S1FMT_SHIFT)
+#define STRTAB_STE_0_S1FMT_64K_L2	(2UL << STRTAB_STE_0_S1FMT_SHIFT)
 #define STRTAB_STE_0_S1CTXPTR_SHIFT	6
 #define STRTAB_STE_0_S1CTXPTR_MASK	0x3ffffffffffUL
 #define STRTAB_STE_0_S1CDMAX_SHIFT	59
@@ -289,7 +291,21 @@
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
@@ -588,11 +604,27 @@ struct arm_smmu_s2_cfg {
 	u64				vtcr;
 };
 
-struct arm_smmu_cd_cfg {
+struct arm_smmu_cd_table {
 	__le64				*cdptr;
 	dma_addr_t			cdptr_dma;
 
 	unsigned long			*context_map;
+};
+
+struct arm_smmu_cd_cfg {
+	bool				linear;
+
+	union {
+		struct arm_smmu_cd_table table;
+		struct {
+			__le64		*ptr;
+			dma_addr_t	ptr_dma;
+
+			struct arm_smmu_cd_table *tables;
+			unsigned long	cur_table;
+		} l1;
+	};
+
 	size_t				num_entries;
 };
 
@@ -1054,6 +1086,27 @@ static void arm_smmu_sync_cd(struct arm_smmu_master_data *master, u32 ssid,
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 }
 
+static __u64 *arm_smmu_get_cd_ptr(struct arm_smmu_cd_cfg *cfg, u32 ssid)
+{
+	unsigned long idx;
+	struct arm_smmu_cd_table *l1_desc;
+
+	if (cfg->linear)
+		return cfg->table.cdptr + ssid * CTXDESC_CD_DWORDS;
+
+	idx = ssid >> CTXDESC_SPLIT;
+	if (idx >= cfg->num_entries)
+		return NULL;
+
+	l1_desc = &cfg->l1.tables[idx];
+	if (!l1_desc->cdptr)
+		return NULL;
+
+	idx = ssid & ((1 << CTXDESC_SPLIT) - 1);
+
+	return l1_desc->cdptr + idx * CTXDESC_CD_DWORDS;
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 {
 	u64 val = 0;
@@ -1073,6 +1126,15 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 	return val;
 }
 
+static void arm_smmu_write_cd_l1_desc(__le64 *dst,
+				      struct arm_smmu_cd_table *table)
+{
+	u64 val = (table->cdptr_dma & CTXDESC_L1_DESC_L2PTR_MASK
+		  << CTXDESC_L1_DESC_L2PTR_SHIFT) | CTXDESC_L1_DESC_VALID;
+
+	*dst = cpu_to_le64(val);
+}
+
 static void arm_smmu_write_ctx_desc(struct arm_smmu_master_data *master,
 				    u32 ssid, struct arm_smmu_s1_cfg *cfg)
 {
@@ -1080,7 +1142,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_master_data *master,
 	bool cd_live;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cd_cfg *descs_cfg = &master->ste.cd_cfg;
-	__u64 *cdptr = (__u64 *)descs_cfg->cdptr + ssid * CTXDESC_CD_DWORDS;
+	__u64 *cdptr = arm_smmu_get_cd_ptr(descs_cfg, ssid);
 
 	/*
 	 * This function handles the following cases:
@@ -1097,6 +1159,9 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_master_data *master,
 	 *     so this CD is already unreachable and invalidated.
 	 */
 
+	if (WARN_ON(!cdptr))
+		return;
+
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
@@ -1152,9 +1217,43 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_master_data *master,
 		arm_smmu_sync_cd(master, ssid, true);
 }
 
+static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
+					struct arm_smmu_cd_table *desc,
+					size_t num_entries)
+{
+	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
+
+	desc->context_map = devm_kzalloc(smmu->dev, BITS_TO_LONGS(num_entries) *
+					 sizeof(long), GFP_ATOMIC);
+	if (!desc->context_map)
+		return -ENOMEM;
+
+	desc->cdptr = dmam_alloc_coherent(smmu->dev, size, &desc->cdptr_dma,
+					  GFP_ATOMIC | __GFP_ZERO);
+	if (!desc->cdptr) {
+		devm_kfree(smmu->dev, desc->context_map);
+		return -ENOMEM;
+	}
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
+	devm_kfree(smmu->dev, desc->context_map);
+}
+
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master_data *master,
-				    size_t nr_ssids)
+				    int nr_ssids)
 {
+	int ret;
+	size_t num_leaf_entries, size = 0;
+	struct arm_smmu_cd_table *leaf_table;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
 
@@ -1170,42 +1269,86 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master_data *master,
 	if (WARN_ON_ONCE(!is_power_of_2(nr_ssids)))
 		nr_ssids = 1;
 
-	cfg->num_entries = nr_ssids;
+	if (nr_ssids <= (1 << CTXDESC_SPLIT)) {
+		/* Fits in a single table */
+		cfg->linear = true;
+		cfg->num_entries = num_leaf_entries = nr_ssids;
+		leaf_table = &cfg->table;
+	} else {
+		/*
+		 * SSID[S1CDmax-1:10] indexes 1st-level table, SSID[9:0] indexes
+		 * 2nd-level
+		 */
+		cfg->linear = false;
+		cfg->num_entries = nr_ssids / CTXDESC_NUM_L2_ENTRIES;
 
-	cfg->context_map = devm_kzalloc(smmu->dev,
-					BITS_TO_LONGS(nr_ssids) * sizeof(long),
-					GFP_KERNEL);
-	if (!cfg->context_map)
-		return -ENOMEM;
+		cfg->l1.tables = devm_kzalloc(smmu->dev,
+					      sizeof(struct arm_smmu_cd_table) *
+					      cfg->num_entries, GFP_KERNEL);
+		if (!cfg->l1.tables)
+			return -ENOMEM;
 
-	/* SSID 0 corresponds to default context */
-	set_bit(0, cfg->context_map);
-
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev,
-					 nr_ssids * (CTXDESC_CD_DWORDS << 3),
-					 &cfg->cdptr_dma,
-					 GFP_KERNEL | __GFP_ZERO);
-	if (!cfg->cdptr) {
-		devm_kfree(smmu->dev, cfg->context_map);
-		return -ENOMEM;
+		size = cfg->num_entries * (CTXDESC_L1_DESC_DWORD << 3);
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
 	}
 
+	ret = arm_smmu_alloc_cd_leaf_table(smmu, leaf_table, num_leaf_entries);
+	if (ret) {
+		if (!cfg->linear) {
+			dmam_free_coherent(smmu->dev, size, cfg->l1.ptr,
+					   cfg->l1.ptr_dma);
+			devm_kfree(smmu->dev, cfg->l1.tables);
+		}
+
+		cfg->num_entries = 0;
+		return ret;
+	}
+
+	if (!cfg->linear)
+		arm_smmu_write_cd_l1_desc(cfg->l1.ptr, leaf_table);
+
+	/* SSID 0 corresponds to default context */
+	set_bit(0, leaf_table->context_map);
+
 	return nr_ssids;
 }
 
 static void arm_smmu_free_cd_tables(struct arm_smmu_master_data *master)
 {
+	size_t i, size;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
 
 	if (!cfg->num_entries)
 		return;
 
-	dmam_free_coherent(smmu->dev,
-			   cfg->num_entries * (CTXDESC_CD_DWORDS << 3),
-			   cfg->cdptr, cfg->cdptr_dma);
+	if (cfg->linear) {
+		arm_smmu_free_cd_leaf_table(smmu, &cfg->table, cfg->num_entries);
+	} else {
+		for (i = 0; i < cfg->num_entries; i++) {
+			struct arm_smmu_cd_table *desc = &cfg->l1.tables[i];
+
+			if (!desc->cdptr)
+				continue;
+
+			arm_smmu_free_cd_leaf_table(smmu, desc,
+						    CTXDESC_NUM_L2_ENTRIES);
+		}
+
+		size = cfg->num_entries * (CTXDESC_L1_DESC_DWORD << 3);
+		dmam_free_coherent(smmu->dev, size, cfg->l1.ptr, cfg->l1.ptr_dma);
 
-	devm_kfree(smmu->dev, cfg->context_map);
+		devm_kfree(smmu->dev, cfg->l1.tables);
+	}
 
 	cfg->num_entries = 0;
 }
@@ -1213,17 +1356,59 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master_data *master)
 __maybe_unused
 static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
 {
+	int ssid;
+	int i, ret;
 	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
 
-	return arm_smmu_bitmap_alloc(cfg->context_map, ilog2(cfg->num_entries));
+	if (cfg->linear)
+		return arm_smmu_bitmap_alloc(cfg->table.context_map,
+					     ilog2(cfg->num_entries));
+
+	/* Find first leaf table with an empty slot, or allocate a new leaf */
+	for (i = cfg->l1.cur_table; i < cfg->num_entries; i++) {
+		struct arm_smmu_cd_table *table = &cfg->l1.tables[i];
+
+		if (!table->cdptr) {
+			__le64 *l1ptr = cfg->l1.ptr + i * CTXDESC_L1_DESC_DWORD;
+
+			ret = arm_smmu_alloc_cd_leaf_table(master->smmu, table,
+							   CTXDESC_NUM_L2_ENTRIES);
+			if (ret)
+				return ret;
+
+			arm_smmu_write_cd_l1_desc(l1ptr, table);
+			arm_smmu_sync_cd(master, i << CTXDESC_SPLIT, false);
+		}
+
+		ssid = arm_smmu_bitmap_alloc(table->context_map, CTXDESC_SPLIT);
+		if (ssid < 0)
+			continue;
+
+		cfg->l1.cur_table = i;
+		return i << CTXDESC_SPLIT | ssid;
+	}
+
+	return -ENOSPC;
 }
 
 __maybe_unused
 static void arm_smmu_free_cd(struct arm_smmu_master_data *master, u32 ssid)
 {
+	unsigned long l1_idx, idx;
 	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
 
-	arm_smmu_bitmap_free(cfg->context_map, ssid);
+	if (cfg->linear) {
+		arm_smmu_bitmap_free(cfg->table.context_map, ssid);
+		return;
+	}
+
+	l1_idx = ssid >> CTXDESC_SPLIT;
+	idx = ssid & ((1 << CTXDESC_SPLIT) - 1);
+	arm_smmu_bitmap_free(cfg->l1.tables[l1_idx].context_map, idx);
+
+	/* Prepare next allocation */
+	if (cfg->l1.cur_table > idx)
+		cfg->l1.cur_table = idx;
 }
 
 /* Stream table manipulation functions */
@@ -1318,7 +1503,16 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s1_cfg) {
+		dma_addr_t s1ctxptr;
 		unsigned int s1cdmax = ilog2(ste->cd_cfg.num_entries);
+
+		if (ste->cd_cfg.linear) {
+			s1ctxptr = ste->cd_cfg.table.cdptr_dma;
+		} else {
+			s1cdmax += CTXDESC_SPLIT;
+			s1ctxptr = ste->cd_cfg.l1.ptr_dma;
+		}
+
 		BUG_ON(ste_live);
 
 		dst[1] = cpu_to_le64(
@@ -1333,11 +1527,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->cd_cfg.cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
+		val |= (s1ctxptr & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
 			(u64)(s1cdmax & STRTAB_STE_0_S1CDMAX_MASK)
 			<< STRTAB_STE_0_S1CDMAX_SHIFT |
-			STRTAB_STE_0_S1FMT_LINEAR |
+			(ste->cd_cfg.linear ? STRTAB_STE_0_S1FMT_LINEAR :
+			   STRTAB_STE_0_S1FMT_64K_L2) |
 			STRTAB_STE_0_CFG_S1_TRANS;
 	}
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
