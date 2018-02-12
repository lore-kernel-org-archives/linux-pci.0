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
Subject: [PATCH 26/37] iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
Date: Mon, 12 Feb 2018 18:33:41 +0000
Message-Id: <20180212183352.22730-27-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the SMMU supports it and the kernel was built with HTTU support, enable
hardware update of access and dirty flags. This is essential for shared
page tables, to reduce the number of access faults on the fault queue.

We can still enable HTTU if CPUs don't support it, because the kernel
always checks for HW dirty bit and updates the PTE flags atomically.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3-context.c | 20 ++++++++++++++++++--
 drivers/iommu/arm-smmu-v3.c         | 12 ++++++++++++
 drivers/iommu/iommu-pasid.h         |  4 ++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index 5b8c5875e0d9..eaeba1bec2e9 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -62,7 +62,16 @@
 #define ARM64_TCR_TBI0_SHIFT		37
 #define ARM64_TCR_TBI0_MASK		0x1UL
 
+#define ARM64_TCR_HA_SHIFT		39
+#define ARM64_TCR_HA_MASK		0x1UL
+#define ARM64_TCR_HD_SHIFT		40
+#define ARM64_TCR_HD_MASK		0x1UL
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
+#define CTXDESC_CD_0_TCR_HD_SHIFT	42
+#define CTXDESC_CD_0_TCR_HA_SHIFT	43
+#define CTXDESC_CD_0_HD			(1UL << CTXDESC_CD_0_TCR_HD_SHIFT)
+#define CTXDESC_CD_0_HA			(1UL << CTXDESC_CD_0_TCR_HA_SHIFT)
 #define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
 #define CTXDESC_CD_0_A			(1UL << 46)
@@ -199,7 +208,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_cd_tables *tbl, u32 ssid)
 	return l1_desc->ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
+static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_context_cfg *cfg, u64 tcr)
 {
 	u64 val = 0;
 
@@ -214,6 +223,12 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
 	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
+	if (cfg->hw_access)
+		val |= ARM_SMMU_TCR2CD(tcr, HA);
+
+	if (cfg->hw_dirty)
+		val |= ARM_SMMU_TCR2CD(tcr, HD);
+
 	return val;
 }
 
@@ -269,7 +284,7 @@ static int __arm_smmu_write_ctx_desc(struct arm_smmu_cd_tables *tbl, int ssid,
 		iommu_pasid_flush(&tbl->pasid, ssid, true);
 
 
-		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
+		val = arm_smmu_cpu_tcr_to_cd(cfg, cd->tcr) |
 #ifdef __BIG_ENDIAN
 		      CTXDESC_CD_0_ENDI |
 #endif
@@ -460,6 +475,7 @@ arm_smmu_alloc_shared_cd(struct iommu_pasid_table_ops *ops, struct mm_struct *mm
 	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
 	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+	tcr |= TCR_HA | TCR_HD;
 
 	cd->ttbr	= virt_to_phys(mm->pgd);
 	cd->tcr		= tcr;
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1cdeea7e22cb..8528704627b5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -67,6 +67,8 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HD				(1 << 7)
+#define IDR0_HA				(1 << 6)
 #define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF_SHIFT			2
@@ -573,6 +575,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 14)
 #define ARM_SMMU_FEAT_BTM		(1 << 15)
 #define ARM_SMMU_FEAT_SVA		(1 << 16)
+#define ARM_SMMU_FEAT_HA		(1 << 17)
+#define ARM_SMMU_FEAT_HD		(1 << 18)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1631,6 +1635,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 		.arm_smmu = {
 			.stall		= !!(smmu->features & ARM_SMMU_FEAT_STALL_FORCE),
 			.asid_bits	= smmu->asid_bits,
+			.hw_access	= !!(smmu->features & ARM_SMMU_FEAT_HA),
+			.hw_dirty	= !!(smmu->features & ARM_SMMU_FEAT_HD),
 		},
 	};
 
@@ -2865,6 +2871,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	if (reg & (IDR0_HA | IDR0_HD)) {
+		smmu->features |= ARM_SMMU_FEAT_HA;
+		if (reg & IDR0_HD)
+			smmu->features |= ARM_SMMU_FEAT_HD;
+	}
+
 	/*
 	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
 	 * will create TLB entries for NH-EL1 world and will miss the
diff --git a/drivers/iommu/iommu-pasid.h b/drivers/iommu/iommu-pasid.h
index 77e449a1655b..46fd44e7f4f1 100644
--- a/drivers/iommu/iommu-pasid.h
+++ b/drivers/iommu/iommu-pasid.h
@@ -79,6 +79,8 @@ struct iommu_pasid_sync_ops {
  *
  * SMMU properties:
  * @stall:	devices attached to the domain are allowed to stall.
+ * @hw_dirty:	hardware may update dirty flag
+ * @hw_access:	hardware may update access flag
  * @asid_bits:	number of ASID bits supported by the SMMU
  *
  * @s1fmt:	PASID table format, chosen by the allocator.
@@ -86,6 +88,8 @@ struct iommu_pasid_sync_ops {
 struct arm_smmu_context_cfg {
 	u8				stall:1;
 	u8				asid_bits;
+	u8				hw_dirty:1;
+	u8				hw_access:1;
 
 #define ARM_SMMU_S1FMT_LINEAR		0x0
 #define ARM_SMMU_S1FMT_4K_L2		0x1
-- 
2.15.1

