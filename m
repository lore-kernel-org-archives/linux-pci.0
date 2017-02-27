Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 06/30] iommu/arm-smmu-v3: Add support for Substream IDs
Date: Mon, 27 Feb 2017 19:54:17 +0000
Message-Id: <20170227195441.5170-7-jean-philippe.brucker@arm.com>
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

Note that we only implement one level of context descriptor table for now,
but as with stream and page tables, an SSID can be split to target
multiple levels of tables.

In all stream table entries, we set S1DSS=SSID0 mode, which forces all
traffic lacking an SSID to be routed to context descriptor 0. Since we
allocate a single context descriptor per group for the moment, this patch
doesn't introduce any change in behavior.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 314 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 243 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 06b29d4fcf65..f88d62025efa 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -246,6 +246,12 @@
 #define STRTAB_STE_0_S1CDMAX_SHIFT	59
 #define STRTAB_STE_0_S1CDMAX_MASK	0x1fUL
 
+#define STRTAB_STE_1_S1DSS_SHIFT	0
+#define STRTAB_STE_1_S1DSS_MASK		0x3UL
+#define STRTAB_STE_1_S1DSS_TERMINATE	(0x0 << STRTAB_STE_1_S1DSS_SHIFT)
+#define STRTAB_STE_1_S1DSS_BYPASS	(0x1 << STRTAB_STE_1_S1DSS_SHIFT)
+#define STRTAB_STE_1_S1DSS_SSID0	(0x2 << STRTAB_STE_1_S1DSS_SHIFT)
+
 #define STRTAB_STE_1_S1C_CACHE_NC	0UL
 #define STRTAB_STE_1_S1C_CACHE_WBRA	1UL
 #define STRTAB_STE_1_S1C_CACHE_WT	2UL
@@ -351,10 +357,14 @@
 #define CMDQ_0_OP_MASK			0xffUL
 #define CMDQ_0_SSV			(1UL << 11)
 
+#define CMDQ_PREFETCH_0_SSID_SHIFT	12
+#define CMDQ_PREFETCH_0_SSID_MASK	0xfffffUL
 #define CMDQ_PREFETCH_0_SID_SHIFT	32
 #define CMDQ_PREFETCH_1_SIZE_SHIFT	0
 #define CMDQ_PREFETCH_1_ADDR_MASK	~0xfffUL
 
+#define CMDQ_CFGI_0_SSID_SHIFT		12
+#define CMDQ_CFGI_0_SSID_MASK		0xfffffUL
 #define CMDQ_CFGI_0_SID_SHIFT		32
 #define CMDQ_CFGI_0_SID_MASK		0xffffffffUL
 #define CMDQ_CFGI_1_LEAF		(1UL << 0)
@@ -475,14 +485,18 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_PREFETCH_CFG	0x1
 		struct {
 			u32			sid;
+			u32			ssid;
 			u8			size;
 			u64			addr;
 		} prefetch;
 
 		#define CMDQ_OP_CFGI_STE	0x3
 		#define CMDQ_OP_CFGI_ALL	0x4
+		#define CMDQ_OP_CFGI_CD		0x5
+		#define CMDQ_OP_CFGI_CD_ALL	0x6
 		struct {
 			u32			sid;
+			u32			ssid;
 			union {
 				bool		leaf;
 				u8		span;
@@ -562,15 +576,10 @@ struct arm_smmu_strtab_l1_desc {
 };
 
 struct arm_smmu_s1_cfg {
-	__le64				*cdptr;
-	dma_addr_t			cdptr_dma;
-
-	struct arm_smmu_ctx_desc {
-		u16	asid;
-		u64	ttbr;
-		u64	tcr;
-		u64	mair;
-	}				cd;
+	u16				asid;
+	u64				ttbr;
+	u64				tcr;
+	u64				mair;
 };
 
 struct arm_smmu_s2_cfg {
@@ -579,10 +588,19 @@ struct arm_smmu_s2_cfg {
 	u64				vtcr;
 };
 
+struct arm_smmu_cd_cfg {
+	__le64				*cdptr;
+	dma_addr_t			cdptr_dma;
+
+	unsigned long			*context_map;
+	size_t				num_entries;
+};
+
 struct arm_smmu_strtab_ent {
 	bool				valid;
 
 	bool				bypass;	/* Overrides s1/s2 config */
+	struct arm_smmu_cd_cfg		cd_cfg;
 	struct arm_smmu_s1_cfg		*s1_cfg;
 	struct arm_smmu_s2_cfg		*s2_cfg;
 };
@@ -723,6 +741,24 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
+static int arm_smmu_bitmap_alloc(unsigned long *map, int span)
+{
+	int idx, size = 1 << span;
+
+	do {
+		idx = find_first_zero_bit(map, size);
+		if (idx == size)
+			return -ENOSPC;
+	} while (test_and_set_bit(idx, map));
+
+	return idx;
+}
+
+static void arm_smmu_bitmap_free(unsigned long *map, int idx)
+{
+	clear_bit(idx, map);
+}
+
 /* Low-level queue manipulation functions */
 static bool queue_full(struct arm_smmu_queue *q)
 {
@@ -839,14 +875,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_NSNH_ALL:
 		break;
 	case CMDQ_OP_PREFETCH_CFG:
+		cmd[0] |= ent->substream_valid ? CMDQ_0_SSV : 0;
 		cmd[0] |= (u64)ent->prefetch.sid << CMDQ_PREFETCH_0_SID_SHIFT;
+		cmd[0] |= ent->prefetch.ssid << CMDQ_PREFETCH_0_SSID_SHIFT;
 		cmd[1] |= ent->prefetch.size << CMDQ_PREFETCH_1_SIZE_SHIFT;
 		cmd[1] |= ent->prefetch.addr & CMDQ_PREFETCH_1_ADDR_MASK;
 		break;
+	case CMDQ_OP_CFGI_CD:
+		cmd[0] |= ent->cfgi.ssid << CMDQ_CFGI_0_SSID_SHIFT;
+		/* pass through */
 	case CMDQ_OP_CFGI_STE:
 		cmd[0] |= (u64)ent->cfgi.sid << CMDQ_CFGI_0_SID_SHIFT;
 		cmd[1] |= ent->cfgi.leaf ? CMDQ_CFGI_1_LEAF : 0;
 		break;
+	case CMDQ_OP_CFGI_CD_ALL:
+		cmd[0] |= (u64)ent->cfgi.sid << CMDQ_CFGI_0_SID_SHIFT;
+		break;
 	case CMDQ_OP_CFGI_ALL:
 		/* Cover the entire SID range */
 		cmd[1] |= CMDQ_CFGI_1_RANGE_MASK << CMDQ_CFGI_1_RANGE_SHIFT;
@@ -987,6 +1031,29 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
+static void arm_smmu_sync_cd(struct arm_smmu_master_data *master, u32 ssid,
+			     bool leaf)
+{
+	size_t i;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_CFGI_CD,
+		.cfgi   = {
+			.ssid   = ssid,
+			.leaf   = leaf,
+		},
+	};
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		cmd.cfgi.sid = fwspec->ids[i];
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	}
+
+	cmd.opcode = CMDQ_OP_CMD_SYNC;
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 {
 	u64 val = 0;
@@ -1006,28 +1073,157 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 	return val;
 }
 
-static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
-				    struct arm_smmu_s1_cfg *cfg)
+static void arm_smmu_write_ctx_desc(struct arm_smmu_master_data *master,
+				    u32 ssid, struct arm_smmu_s1_cfg *cfg)
 {
 	u64 val;
+	bool cd_live;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_cd_cfg *descs_cfg = &master->ste.cd_cfg;
+	__u64 *cdptr = (__u64 *)descs_cfg->cdptr + ssid * CTXDESC_CD_DWORDS;
 
 	/*
-	 * We don't need to issue any invalidation here, as we'll invalidate
-	 * the STE when installing the new entry anyway.
+	 * This function handles the following cases:
+	 *
+	 * (1) Install primary CD, for normal DMA traffic (SSID = 0). In this
+	 *     case, invalidation is performed when installing the STE.
+	 * (2) Install a secondary CD, for SID+SSID traffic, followed by an
+	 *     invalidation.
+	 * (3) Update ASID of primary CD. This is allowed by atomically writing
+	 *     the first 64 bits of the CD, followed by invalidation of the old
+	 *     entry and mappings.
+	 * (4) Remove a secondary CD and invalidate it.
+	 * (5) Remove primary CD. The STE is cleared and invalidated beforehand,
+	 *     so this CD is already unreachable and invalidated.
 	 */
-	val = arm_smmu_cpu_tcr_to_cd(smmu, cfg->cd.tcr) |
+
+	val = le64_to_cpu(cdptr[0]);
+	cd_live = !!(val & CTXDESC_CD_0_V);
+
+	if (!cfg) {
+		/* (4) and (5) */
+		cdptr[0] = 0;
+		if (ssid && cd_live)
+			arm_smmu_sync_cd(master, ssid, true);
+		return;
+	}
+
+	if (cd_live) {
+		/* (3) */
+		val &= ~(CTXDESC_CD_0_ASID_MASK << CTXDESC_CD_0_ASID_SHIFT);
+		val |= (u64)cfg->asid << CTXDESC_CD_0_ASID_SHIFT;
+
+		cdptr[0] = cpu_to_le64(val);
+		/*
+		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
+		 * this substream's traffic
+		 */
+
+	} else {
+		/* (1) and (2) */
+		cdptr[1] = cpu_to_le64(cfg->ttbr & CTXDESC_CD_1_TTB0_MASK
+				       << CTXDESC_CD_1_TTB0_SHIFT);
+		cdptr[2] = 0;
+		cdptr[3] = cpu_to_le64(cfg->mair << CTXDESC_CD_3_MAIR_SHIFT);
+
+		if (ssid)
+			/*
+			 * STE is live, and the SMMU might fetch this CD at any
+			 * time. Ensure it observes the rest of the CD before we
+			 * enable it.
+			 */
+			arm_smmu_sync_cd(master, ssid, true);
+
+		val = arm_smmu_cpu_tcr_to_cd(smmu, cfg->tcr) |
 #ifdef __BIG_ENDIAN
-	      CTXDESC_CD_0_ENDI |
+		      CTXDESC_CD_0_ENDI |
 #endif
-	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
-	      CTXDESC_CD_0_AA64 | (u64)cfg->cd.asid << CTXDESC_CD_0_ASID_SHIFT |
-	      CTXDESC_CD_0_V;
-	cfg->cdptr[0] = cpu_to_le64(val);
+		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+		      CTXDESC_CD_0_ASET_PRIVATE |
+		      CTXDESC_CD_0_AA64 |
+		      (u64)cfg->asid << CTXDESC_CD_0_ASID_SHIFT |
+		      CTXDESC_CD_0_V;
+
+		cdptr[0] = cpu_to_le64(val);
+
+	}
+
+	if (ssid || cd_live)
+		arm_smmu_sync_cd(master, ssid, true);
+}
+
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master_data *master,
+				    size_t nr_ssids)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
+
+	if (cfg->num_entries) {
+		/*
+		 * Messy master initialization. arm_smmu_add_device already
+		 * moaned about it, let's ignore it.
+		 */
+		return nr_ssids;
+	}
+
+	nr_ssids = clamp_val(nr_ssids, 1, 1 << smmu->ssid_bits);
+	if (WARN_ON_ONCE(!is_power_of_2(nr_ssids)))
+		nr_ssids = 1;
+
+	cfg->num_entries = nr_ssids;
+
+	cfg->context_map = devm_kzalloc(smmu->dev,
+					BITS_TO_LONGS(nr_ssids) * sizeof(long),
+					GFP_KERNEL);
+	if (!cfg->context_map)
+		return -ENOMEM;
 
-	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK << CTXDESC_CD_1_TTB0_SHIFT;
-	cfg->cdptr[1] = cpu_to_le64(val);
+	/* SSID 0 corresponds to default context */
+	set_bit(0, cfg->context_map);
 
-	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair << CTXDESC_CD_3_MAIR_SHIFT);
+	cfg->cdptr = dmam_alloc_coherent(smmu->dev,
+					 nr_ssids * (CTXDESC_CD_DWORDS << 3),
+					 &cfg->cdptr_dma,
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!cfg->cdptr) {
+		devm_kfree(smmu->dev, cfg->context_map);
+		return -ENOMEM;
+	}
+
+	return nr_ssids;
+}
+
+static void arm_smmu_free_cd_tables(struct arm_smmu_master_data *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
+
+	if (!cfg->num_entries)
+		return;
+
+	dmam_free_coherent(smmu->dev,
+			   cfg->num_entries * (CTXDESC_CD_DWORDS << 3),
+			   cfg->cdptr, cfg->cdptr_dma);
+
+	devm_kfree(smmu->dev, cfg->context_map);
+
+	cfg->num_entries = 0;
+}
+
+__maybe_unused
+static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
+{
+	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
+
+	return arm_smmu_bitmap_alloc(cfg->context_map, ilog2(cfg->num_entries));
+}
+
+__maybe_unused
+static void arm_smmu_free_cd(struct arm_smmu_master_data *master, u32 ssid)
+{
+	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
+
+	arm_smmu_bitmap_free(cfg->context_map, ssid);
 }
 
 /* Stream table manipulation functions */
@@ -1122,8 +1318,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s1_cfg) {
+		unsigned int s1cdmax = ilog2(ste->cd_cfg.num_entries);
 		BUG_ON(ste_live);
+
 		dst[1] = cpu_to_le64(
+			 STRTAB_STE_1_S1DSS_SSID0 |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1CIR_SHIFT |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
@@ -1134,8 +1333,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
+		val |= (ste->cd_cfg.cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
+			(u64)(s1cdmax & STRTAB_STE_0_S1CDMAX_MASK)
+			<< STRTAB_STE_0_S1CDMAX_SHIFT |
+			STRTAB_STE_0_S1FMT_LINEAR |
 			STRTAB_STE_0_CFG_S1_TRANS;
 	}
 
@@ -1380,7 +1582,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= smmu_domain->s1_cfg.asid;
 		cmd.tlbi.vmid	= 0;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
@@ -1405,7 +1607,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= smmu_domain->s1_cfg.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -1580,24 +1782,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	return &smmu_domain->domain;
 }
 
-static int arm_smmu_bitmap_alloc(unsigned long *map, int span)
-{
-	int idx, size = 1 << span;
-
-	do {
-		idx = find_first_zero_bit(map, size);
-		if (idx == size)
-			return -ENOSPC;
-	} while (test_and_set_bit(idx, map));
-
-	return idx;
-}
-
-static void arm_smmu_bitmap_free(unsigned long *map, int idx)
-{
-	clear_bit(idx, map);
-}
-
 static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -1606,18 +1790,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
-	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-
-		if (cfg->cdptr) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdptr,
-					   cfg->cdptr_dma);
-
-			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
-		}
+		if (cfg->asid)
+			arm_smmu_bitmap_free(smmu->asid_map, cfg->asid);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -1630,7 +1806,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
-	int ret;
 	int asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
@@ -1639,24 +1814,12 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma,
-					 GFP_KERNEL | __GFP_ZERO);
-	if (!cfg->cdptr) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
-		goto out_free_asid;
-	}
+	cfg->asid	= (u16)asid;
+	cfg->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
+	cfg->tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
+	cfg->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
 
-	cfg->cd.asid	= (u16)asid;
-	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
-	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
-	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
 	return 0;
-
-out_free_asid:
-	arm_smmu_bitmap_free(smmu->asid_map, asid);
-	return ret;
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
@@ -1805,6 +1968,8 @@ static void arm_smmu_detach_dev(struct device *dev)
 	master->ste.bypass = true;
 	if (arm_smmu_install_ste_for_dev(dev->iommu_fwspec) < 0)
 		dev_warn(dev, "failed to install bypass STE\n");
+
+	arm_smmu_write_ctx_desc(master, 0, NULL);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1894,7 +2059,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		ste->s1_cfg = &smmu_domain->s1_cfg;
 		ste->s2_cfg = NULL;
-		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
+		arm_smmu_write_ctx_desc(master, 0, ste->s1_cfg);
 	} else {
 		ste->s1_cfg = NULL;
 		ste->s2_cfg = &smmu_domain->s2_cfg;
@@ -2095,6 +2260,10 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	ret = arm_smmu_alloc_cd_tables(master, 1);
+	if (ret < 0)
+		return ret;
+
 	ats_enabled = !arm_smmu_enable_ats(master);
 
 	group = iommu_group_get_for_dev(dev);
@@ -2119,6 +2288,8 @@ static int arm_smmu_add_device(struct device *dev)
 err_disable_ats:
 	arm_smmu_disable_ats(master);
 
+	arm_smmu_free_cd_tables(master);
+
 	return ret;
 }
 
@@ -2150,6 +2321,7 @@ static void arm_smmu_remove_device(struct device *dev)
 		iommu_group_put(group);
 
 		arm_smmu_disable_ats(master);
+		arm_smmu_free_cd_tables(master);
 	}
 
 	iommu_group_remove_device(dev);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
