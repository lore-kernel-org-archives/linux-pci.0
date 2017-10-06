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
Subject: [RFCv2 PATCH 14/36] iommu/arm-smmu-v3: Add support for Substream IDs
Date: Fri,  6 Oct 2017 14:31:41 +0100
Message-Id: <20171006133203.22803-15-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
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

SSIDs are allocated by the core.

Note that we only implement one level of context descriptor table for now,
but as with stream and page tables, an SSID can be split to target
multiple levels of tables.

In all stream table entries, we set S1DSS=SSID0 mode, which forces all
traffic lacking an SSID to be routed to context descriptor 0.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 228 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 188 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ecc424b15749..37061e1cbae4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -244,6 +244,12 @@
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
@@ -349,10 +355,14 @@
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
@@ -469,14 +479,18 @@ struct arm_smmu_cmdq_ent {
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
@@ -546,16 +560,20 @@ struct arm_smmu_strtab_l1_desc {
 	dma_addr_t			l2ptr_dma;
 };
 
+struct arm_smmu_ctx_desc {
+	u16				asid;
+	u64				ttbr;
+	u64				tcr;
+	u64				mair;
+};
+
 struct arm_smmu_s1_cfg {
 	__le64				*cdptr;
 	dma_addr_t			cdptr_dma;
 
-	struct arm_smmu_ctx_desc {
-		u16	asid;
-		u64	ttbr;
-		u64	tcr;
-		u64	mair;
-	}				cd;
+	size_t				num_contexts;
+
+	struct arm_smmu_ctx_desc	cd; /* Default context (SSID0) */
 };
 
 struct arm_smmu_s2_cfg {
@@ -649,6 +667,8 @@ struct arm_smmu_master_data {
 	struct list_head		list; /* domain->devices */
 
 	struct device			*dev;
+
+	size_t				num_ssids;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -840,14 +860,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
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
@@ -972,6 +1000,35 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
+static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, u32 ssid)
+{
+	size_t i;
+	unsigned long flags;
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_CFGI_CD,
+		.cfgi   = {
+			.ssid   = ssid,
+			.leaf   = true,
+		},
+	};
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, list) {
+		struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+
+		for (i = 0; i < fwspec->num_ids; i++) {
+			cmd.cfgi.sid = fwspec->ids[i];
+			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		}
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	cmd.opcode = CMDQ_OP_CMD_SYNC;
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+}
+
 static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 {
 	u64 val = 0;
@@ -990,33 +1047,116 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	return val;
 }
 
-static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
-				    struct arm_smmu_s1_cfg *cfg)
+static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
+				    u32 ssid, struct arm_smmu_ctx_desc *cd)
 {
 	u64 val;
+	bool cd_live;
+	__u64 *cdptr = (__u64 *)smmu_domain->s1_cfg.cdptr + ssid * CTXDESC_CD_DWORDS;
 
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
 	 */
-	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
+
+	val = le64_to_cpu(cdptr[0]);
+	cd_live = !!(val & CTXDESC_CD_0_V);
+
+	if (!cd) {
+		/* (4) */
+		cdptr[0] = 0;
+		if (ssid)
+			arm_smmu_sync_cd(smmu_domain, ssid);
+		return;
+	}
+
+	if (cd_live) {
+		/* (3) */
+		val &= ~(CTXDESC_CD_0_ASID_MASK << CTXDESC_CD_0_ASID_SHIFT);
+		val |= (u64)cd->asid << CTXDESC_CD_0_ASID_SHIFT;
+
+		cdptr[0] = cpu_to_le64(val);
+		/*
+		 * Until CD+TLB invalidation, both ASIDs may be used for tagging
+		 * this substream's traffic
+		 */
+
+	} else {
+		/* (1) and (2) */
+		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK
+				       << CTXDESC_CD_1_TTB0_SHIFT);
+		cdptr[2] = 0;
+		cdptr[3] = cpu_to_le64(cd->mair << CTXDESC_CD_3_MAIR_SHIFT);
+
+		if (ssid)
+			/*
+			 * STE is live, and the SMMU might fetch this CD at any
+			 * time. Ensure it observes the rest of the CD before we
+			 * enable it.
+			 */
+			arm_smmu_sync_cd(smmu_domain, ssid);
+
+		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
 #ifdef __BIG_ENDIAN
-	      CTXDESC_CD_0_ENDI |
+		      CTXDESC_CD_0_ENDI |
 #endif
-	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
-	      CTXDESC_CD_0_AA64 | (u64)cfg->cd.asid << CTXDESC_CD_0_ASID_SHIFT |
-	      CTXDESC_CD_0_V;
+		      CTXDESC_CD_0_R | CTXDESC_CD_0_A |
+		      CTXDESC_CD_0_ASET_PRIVATE |
+		      CTXDESC_CD_0_AA64 |
+		      (u64)cd->asid << CTXDESC_CD_0_ASID_SHIFT |
+		      CTXDESC_CD_0_V;
+
+		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
+		if (smmu_domain->smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+			val |= CTXDESC_CD_0_S;
+
+		cdptr[0] = cpu_to_le64(val);
+	}
+
+	if (ssid || cd_live)
+		arm_smmu_sync_cd(smmu_domain, ssid);
+}
+
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	int num_ssids;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+
+	if (WARN_ON(smmu_domain->stage != ARM_SMMU_DOMAIN_S1))
+		return -EINVAL;
+
+	num_ssids = cfg->num_contexts;
+
+	cfg->cdptr = dmam_alloc_coherent(smmu->dev,
+					 num_ssids * (CTXDESC_CD_DWORDS << 3),
+					 &cfg->cdptr_dma,
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!cfg->cdptr)
+		return -ENOMEM;
 
-	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-		val |= CTXDESC_CD_0_S;
+	return 0;
+}
 
-	cfg->cdptr[0] = cpu_to_le64(val);
+static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
-	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK << CTXDESC_CD_1_TTB0_SHIFT;
-	cfg->cdptr[1] = cpu_to_le64(val);
+	if (WARN_ON(smmu_domain->stage != ARM_SMMU_DOMAIN_S1))
+		return;
 
-	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair << CTXDESC_CD_3_MAIR_SHIFT);
+	dmam_free_coherent(smmu->dev,
+			   cfg->num_contexts * (CTXDESC_CD_DWORDS << 3),
+			   cfg->cdptr, cfg->cdptr_dma);
 }
 
 /* Stream table manipulation functions */
@@ -1115,8 +1255,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	if (ste->s1_cfg) {
+		unsigned int s1cdmax = ilog2(ste->s1_cfg->num_contexts);
+
 		BUG_ON(ste_live);
+
 		dst[1] = cpu_to_le64(
+			 STRTAB_STE_1_S1DSS_SSID0 |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1CIR_SHIFT |
 			 STRTAB_STE_1_S1C_CACHE_WBRA
@@ -1133,6 +1277,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 
 		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
+			(u64)(s1cdmax & STRTAB_STE_0_S1CDMAX_MASK)
+			<< STRTAB_STE_0_S1CDMAX_SHIFT |
+			STRTAB_STE_0_S1FMT_LINEAR |
 			STRTAB_STE_0_CFG_S1_TRANS;
 	}
 
@@ -1501,16 +1648,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
-	/* Free the CD and ASID, if we allocated them */
+	/* Free the CD table and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-
-		if (cfg->cdptr) {
-			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
-					   cfg->cdptr,
-					   cfg->cdptr_dma);
-
+		if (cfg->num_contexts) {
+			arm_smmu_free_cd_tables(smmu_domain);
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
 	} else {
@@ -1534,14 +1676,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;
 
-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma,
-					 GFP_KERNEL | __GFP_ZERO);
-	if (!cfg->cdptr) {
-		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
-		ret = -ENOMEM;
+	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	if (ret)
 		goto out_free_asid;
-	}
 
 	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
@@ -1571,7 +1708,8 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_master_data *master)
 {
 	int ret;
 	unsigned long ias, oas;
@@ -1600,6 +1738,12 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
+
+		if (master->num_ssids) {
+			domain->min_pasid = 1;
+			domain->max_pasid = master->num_ssids - 1;
+			smmu_domain->s1_cfg.num_contexts = master->num_ssids;
+		}
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -1717,7 +1861,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, master);
 		if (ret) {
 			smmu_domain->smmu = NULL;
 			goto out_unlock;
@@ -1744,7 +1888,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		ste->s1_cfg = &smmu_domain->s1_cfg;
 		ste->s2_cfg = NULL;
-		arm_smmu_write_ctx_desc(smmu, ste->s1_cfg);
+		arm_smmu_write_ctx_desc(smmu_domain, 0, &ste->s1_cfg->cd);
 	} else {
 		ste->s1_cfg = NULL;
 		ste->s2_cfg = &smmu_domain->s2_cfg;
@@ -1866,6 +2010,10 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	if (smmu->ssid_bits)
+		master->num_ssids = 1 << min(smmu->ssid_bits,
+					     fwspec->num_pasid_bits);
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		iommu_group_put(group);
-- 
2.13.3

