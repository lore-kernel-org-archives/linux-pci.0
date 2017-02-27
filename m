Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbdB0ULO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 15:11:14 -0500
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shanker Donthineni <shankerd@qti.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@qti.qualcomm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nate Watterson <nwatters@qti.qualcomm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [RFC PATCH 09/30] iommu/arm-smmu-v3: Support broadcast TLB maintenance
Date: Mon, 27 Feb 2017 19:54:20 +0000
Message-Id: <20170227195441.5170-10-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SMMUv3 can handle invalidation targeted at TLB entries with shared
ASIDs. If the implementation supports broadcast TLB maintenance, enable
it and keep track of it in a feature bit. The SMMU will then take into
account the following CPU instruction for ASIDs in the shared set:

* TLBI VAE1IS(ASID, VA)
* TLBI ASIDE1IS(ASID)

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0981159ada04..2724788157a5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -65,6 +65,7 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF_SHIFT			2
 #define IDR0_TTF_MASK			0x3
@@ -669,6 +670,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALLS		(1 << 11)
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
 #define ARM_SMMU_FEAT_E2H		(1 << 13)
+#define ARM_SMMU_FEAT_BTM		(1 << 14)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -3023,11 +3025,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
-	reg = CR2_PTM | CR2_RECINVSID;
+	reg = CR2_RECINVSID;
 
 	if (smmu->features & ARM_SMMU_FEAT_E2H)
 		reg |= CR2_E2H;
 
+	if (!(smmu->features & ARM_SMMU_FEAT_BTM))
+		reg |= CR2_PTM;
+
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);
 
 	/* Stream table */
@@ -3138,6 +3143,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+	bool vhe = cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN);
 
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
@@ -3187,11 +3193,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	if (reg & IDR0_HYP) {
 		smmu->features |= ARM_SMMU_FEAT_HYP;
-		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+		if (vhe)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
 	/*
+	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
+	 * will create TLB entries for NH-EL1 world and will miss the
+	 * broadcasted TLB invalidations that target EL2-E2H world. Don't enable
+	 * BTM in that case.
+	 */
+	if (reg & IDR0_BTM && (!vhe || reg & IDR0_HYP))
+		smmu->features |= ARM_SMMU_FEAT_BTM;
+
+	/*
 	 * The coherency feature as set by FW is used in preference to the ID
 	 * register, but warn on mismatch.
 	 */
-- 
2.11.0
