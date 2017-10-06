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
Subject: [RFCv2 PATCH 16/36] iommu/arm-smmu-v3: Add support for VHE
Date: Fri,  6 Oct 2017 14:31:43 +0100
Message-Id: <20171006133203.22803-17-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ARMv8.1 extensions added Virtualization Host Extensions (VHE), which allow
to run a host kernel at EL2. When using normal DMA, Device and CPU address
spaces are orthogonal, and do not need to implement the same capabilities,
so VHE hasn't been in use on the SMMU side until now.

With shared address spaces however, ASIDs are shared between MMU and SMMU,
and broadcast TLB invalidations issued by a CPU are taken into account by
the SMMU. TLB entries on both sides need to have identical exception level
in order to be shot with a single invalidation.

When the CPU is using VHE, enable VHE in the SMMU and for all streams.
Normal DMA mappings will need to use TLBI_EL2 commands instead of TLBI_NH,
but shouldn't be otherwise affected by this change.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c444f9e83b91..27376e1193c1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -22,6 +22,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/cpufeature.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
@@ -516,6 +517,8 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
+		#define CMDQ_OP_TLBI_EL2_ASID	0x21
+		#define CMDQ_OP_TLBI_EL2_VA	0x22
 		#define CMDQ_OP_TLBI_S12_VMALL	0x28
 		#define CMDQ_OP_TLBI_S2_IPA	0x2a
 		#define CMDQ_OP_TLBI_NSNH_ALL	0x30
@@ -655,6 +658,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALLS		(1 << 11)
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
+#define ARM_SMMU_FEAT_E2H		(1 << 14)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -912,6 +916,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= CMDQ_CFGI_1_RANGE_MASK << CMDQ_CFGI_1_RANGE_SHIFT;
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_EL2_VA:
 		cmd[0] |= (u64)ent->tlbi.asid << CMDQ_TLBI_0_ASID_SHIFT;
 		cmd[1] |= ent->tlbi.leaf ? CMDQ_TLBI_1_LEAF : 0;
 		cmd[1] |= ent->tlbi.addr & CMDQ_TLBI_1_VA_MASK;
@@ -927,6 +932,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_S12_VMALL:
 		cmd[0] |= (u64)ent->tlbi.vmid << CMDQ_TLBI_0_VMID_SHIFT;
 		break;
+	case CMDQ_OP_TLBI_EL2_ASID:
+		cmd[0] |= (u64)ent->tlbi.asid << CMDQ_TLBI_0_ASID_SHIFT;
+		break;
 	case CMDQ_OP_PRI_RESP:
 		cmd[0] |= ent->substream_valid ? CMDQ_0_SSV : 0;
 		cmd[0] |= ent->pri.ssid << CMDQ_PRI_0_SSID_SHIFT;
@@ -1428,7 +1436,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 #ifdef CONFIG_PCI_ATS
 			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
 #endif
-			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
+			 (smmu->features & ARM_SMMU_FEAT_E2H ?
+			  STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1) <<
+			 STRTAB_STE_1_STRW_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
@@ -1694,7 +1704,8 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	struct arm_smmu_cmdq_ent cmd;
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
+		cmd.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
+				  CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
 		cmd.tlbi.vmid	= 0;
 	} else {
@@ -1719,7 +1730,8 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	};
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+		cmd.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
+				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
@@ -2718,7 +2730,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
-	reg = CR2_PTM | CR2_RECINVSID | CR2_E2H;
+	reg = CR2_PTM | CR2_RECINVSID;
+
+	if (smmu->features & ARM_SMMU_FEAT_E2H)
+		reg |= CR2_E2H;
+
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);
 
 	/* Stream table */
@@ -2868,8 +2884,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR0_MSI)
 		smmu->features |= ARM_SMMU_FEAT_MSI;
 
-	if (reg & IDR0_HYP)
+	if (reg & IDR0_HYP) {
 		smmu->features |= ARM_SMMU_FEAT_HYP;
+		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+			smmu->features |= ARM_SMMU_FEAT_E2H;
+	}
 
 	/*
 	 * The coherency feature as set by FW is used in preference to the ID
-- 
2.13.3

