Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 28/30] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update at stage 1
Date: Mon, 27 Feb 2017 19:54:39 +0000
Message-Id: <20170227195441.5170-29-jean-philippe.brucker@arm.com>
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

If the SMMU supports it and the kernel was built with HTTU support, enable
hardware update of access and dirty flags.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1a5e72752e6d..5d202f164b95 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -68,6 +68,8 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HD				(1 << 7)
+#define IDR0_HA				(1 << 6)
 #define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF_SHIFT			2
@@ -346,7 +348,16 @@
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
 #define CTXDESC_CD_0_R			(1UL << 45)
 #define CTXDESC_CD_0_A			(1UL << 46)
 #define CTXDESC_CD_0_ASET_SHIFT		47
@@ -687,6 +698,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 13)
 #define ARM_SMMU_FEAT_BTM		(1 << 14)
 #define ARM_SMMU_FEAT_SVM		(1 << 15)
+#define ARM_SMMU_FEAT_HA		(1 << 16)
+#define ARM_SMMU_FEAT_HD		(1 << 17)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1275,6 +1288,12 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
+	if (smmu->features & ARM_SMMU_FEAT_HA)
+		val |= ARM_SMMU_TCR2CD(tcr, HA);
+
+	if (smmu->features & ARM_SMMU_FEAT_HD)
+		val |= ARM_SMMU_TCR2CD(tcr, HD);
+
 	return val;
 }
 
@@ -2497,7 +2516,7 @@ static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
 	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
 
 	/* Enable this by default, it will be filtered when writing the CD */
-	tcr |= TCR_TBI0;
+	tcr |= TCR_TBI0 | TCR_HA | TCR_HD;
 
 	cfg->asid	= asid;
 	cfg->ttbr	= virt_to_phys(smmu_task->mm->pgd);
@@ -4734,6 +4753,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
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
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
