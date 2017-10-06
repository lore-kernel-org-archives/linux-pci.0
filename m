Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbdJFNaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:30:05 -0400
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
Subject: [RFCv2 PATCH 26/36] iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
Date: Fri,  6 Oct 2017 14:31:53 +0100
Message-Id: <20171006133203.22803-27-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the SMMU supports it and the kernel was built with HTTU support, enable
hardware update of access and dirty flags. This is essential for shared
page tables, to reduce the number of access faults on the fault queue.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b7355630526a..2b2e2be03de7 100644
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
@@ -342,7 +344,16 @@
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
@@ -670,6 +681,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 14)
 #define ARM_SMMU_FEAT_BTM		(1 << 15)
 #define ARM_SMMU_FEAT_SVM		(1 << 16)
+#define ARM_SMMU_FEAT_HA		(1 << 17)
+#define ARM_SMMU_FEAT_HD		(1 << 18)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1157,7 +1170,7 @@ static __u64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain, u32 ssid)
 	return l1_desc->cdptr + idx * CTXDESC_CD_DWORDS;
 }
 
-static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
+static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 {
 	u64 val = 0;
 
@@ -1172,6 +1185,12 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
 	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
+	if (smmu->features & ARM_SMMU_FEAT_HA)
+		val |= ARM_SMMU_TCR2CD(tcr, HA);
+
+	if (smmu->features & ARM_SMMU_FEAT_HD)
+		val |= ARM_SMMU_TCR2CD(tcr, HD);
+
 	return val;
 }
 
@@ -1235,7 +1254,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 			 */
 			arm_smmu_sync_cd(smmu_domain, ssid, true);
 
-		val = arm_smmu_cpu_tcr_to_cd(cd->tcr) |
+		val = arm_smmu_cpu_tcr_to_cd(smmu_domain->smmu, cd->tcr) |
 #ifdef __BIG_ENDIAN
 		      CTXDESC_CD_0_ENDI |
 #endif
@@ -2203,8 +2222,7 @@ static int arm_smmu_process_init_pgtable(struct arm_smmu_process *smmu_process,
 	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
 	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
-
-	tcr |= TCR_TBI0;
+	tcr |= TCR_TBI0 | TCR_HA | TCR_HD;
 
 	cfg->asid       = asid;
 	cfg->ttbr       = virt_to_phys(mm->pgd);
@@ -3275,6 +3293,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && (reg & (IDR0_HA | IDR0_HD))) {
+		smmu->features |= ARM_SMMU_FEAT_HA;
+		if (reg & IDR0_HD)
+			smmu->features |= ARM_SMMU_FEAT_HD;
+	}
+
 	/*
 	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
 	 * will create TLB entries for NH-EL1 world and will miss the
-- 
2.13.3
