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
Subject: [RFCv2 PATCH 24/36] iommu/arm-smmu-v3: Steal private ASID from a domain
Date: Fri,  6 Oct 2017 14:31:51 +0100
Message-Id: <20171006133203.22803-25-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SMMU only has one ASID space, so the process allocator competes with
the domain allocator for ASIDs. Process ASIDs are allocated by the arch
allocator and shared with CPUs, whereas domain ASIDs are private to the
SMMU, and not affected by broadcast TLB invalidations.

When the process allocator pins an mm_context and gets an ASID that is
already in use by the SMMU, it belongs to a domain. At the moment we
simply abort the bind, but we can try one step further. Attempt to assign
a new private ASID to the domain, and steal the old one for our process.

Use the smmu-wide ASID lock to prevent racing with attach_dev over the
foreign domain. We now need to also take this lock when modifying entry 0
of the context table. Concurrent modifications of a given context table
used to be prevented by group->mutex but in this patch we modify the CD of
another group.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 53 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 293f260782c2..e89e6d1263d9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1731,7 +1731,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= READ_ONCE(smmu_domain->s1_cfg.cd.asid);
 		cmd.tlbi.vmid	= 0;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
@@ -1757,7 +1757,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= READ_ONCE(smmu_domain->s1_cfg.cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
@@ -2119,7 +2119,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		ste->s1_cfg = &smmu_domain->s1_cfg;
 		ste->s2_cfg = NULL;
+		spin_lock(&smmu->asid_lock);
 		arm_smmu_write_ctx_desc(smmu_domain, 0, &ste->s1_cfg->cd);
+		spin_unlock(&smmu->asid_lock);
 	} else {
 		ste->s1_cfg = NULL;
 		ste->s2_cfg = &smmu_domain->s2_cfg;
@@ -2253,14 +2255,57 @@ static int arm_smmu_process_share(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_process *smmu_process)
 {
 	int asid, ret;
-	struct arm_smmu_asid_state *asid_state;
+	struct arm_smmu_asid_state *asid_state, *new_state;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	asid = smmu_process->ctx_desc.asid;
 
 	asid_state = idr_find(&smmu->asid_idr, asid);
 	if (asid_state && asid_state->domain) {
-		return -EEXIST;
+		struct arm_smmu_domain *smmu_domain = asid_state->domain;
+		struct arm_smmu_cmdq_ent cmd = {
+			.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
+				CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
+		};
+
+		new_state = kzalloc(sizeof(*new_state), GFP_ATOMIC);
+		if (!new_state)
+			return -ENOMEM;
+
+		new_state->domain = smmu_domain;
+
+		ret = idr_alloc_cyclic(&smmu->asid_idr, new_state, 0,
+				       1 << smmu->asid_bits, GFP_ATOMIC);
+		if (ret < 0) {
+			kfree(new_state);
+			return ret;
+		}
+
+		/*
+		 * Race with unmap; TLB invalidations will start targeting the
+		 * new ASID, which isn't assigned yet. We'll do an
+		 * invalidate-all on the old ASID later, so it doesn't matter.
+		 */
+		WRITE_ONCE(smmu_domain->s1_cfg.cd.asid, ret);
+
+		/*
+		 * Update ASID and invalidate CD in all associated masters.
+		 * There will be some overlapping between use of both ASIDs,
+		 * until we invalidate the TLB.
+		 */
+		arm_smmu_write_ctx_desc(smmu_domain, 0, &smmu_domain->s1_cfg.cd);
+
+		/* Invalidate TLB entries previously associated with that domain */
+		cmd.tlbi.asid = asid;
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		cmd.opcode = CMDQ_OP_CMD_SYNC;
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+
+		asid_state->domain = NULL;
+		asid_state->refs = 1;
+
+		return 0;
+
 	} else if (asid_state) {
 		asid_state->refs++;
 		return 0;
-- 
2.13.3

