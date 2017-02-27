Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 14/30] iommu/arm-smmu-v3: Share process page tables
Date: Mon, 27 Feb 2017 19:54:25 +0000
Message-Id: <20170227195441.5170-15-jean-philippe.brucker@arm.com>
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

Copy the content of TCR, MAIR and TTBR of a given task into a context
descriptor.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ab49164bf09b..c3fa4616bd58 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -44,6 +44,7 @@
 #include <linux/amba/bus.h>
 
 #include "io-pgtable.h"
+#include "io-pgtable-arm.h"
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -2191,6 +2192,9 @@ static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
 {
 	int ret;
 	int asid;
+	unsigned long tcr;
+	unsigned long reg, par;
+	struct arm_smmu_s1_cfg *cfg = &smmu_task->s1_cfg;
 
 	/* Pin ASID on the CPU side */
 	asid = mm_context_get(smmu_task->mm);
@@ -2203,8 +2207,39 @@ static int arm_smmu_init_task_pgtable(struct arm_smmu_task *smmu_task)
 		return ret;
 	}
 
-	/* TODO: Initialize the rest of s1_cfg */
-	smmu_task->s1_cfg.asid = asid;
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
+		return -EFAULT;
+	}
+
+	reg = read_system_reg(SYS_ID_AA64MMFR0_EL1);
+	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
+	tcr |= par << ARM_LPAE_TCR_IPS_SHIFT;
+
+	/* Enable this by default, it will be filtered when writing the CD */
+	tcr |= TCR_TBI0;
+
+	cfg->asid	= asid;
+	cfg->ttbr	= virt_to_phys(smmu_task->mm->pgd);
+	/*
+	 * MAIR value is pretty much constant and global, so we can just get it
+	 * from the current CPU register
+	 */
+	cfg->mair	= read_sysreg(mair_el1);
+	cfg->tcr	= tcr;
 
 	return 0;
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
