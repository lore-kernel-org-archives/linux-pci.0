Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdB0ULP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 15:11:15 -0500
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
Subject: [RFC PATCH 15/30] iommu/arm-smmu-v3: Steal private ASID from a domain
Date: Mon, 27 Feb 2017 19:54:26 +0000
Message-Id: <20170227195441.5170-16-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SMMU only has one ASID space, so the task allocator competes with the
domain allocator for ASIDs. Task ASIDs are shared with CPUs, whereas
domain ASIDs are private to the SMMU, and not affected by broadcast TLB
invalidations. When the task allocator pins a mm_context and gets an ASID
already used by the SMMU, it belongs to a domain. Attempt to assign a new
ASID to the domain, and steal the old one for our shared context.

Replacing an ASID requires some pretty invasive introspection. We could
try to do fine-grained locking on asid_map, domains list, context
descriptors and domains themselves, but it gets terribly complicated and
my brain melted twice before I could find solutions to all lock
dependencies.

Instead, introduce a big fat mutex around domains and (default) contexts
modifications. It ensures that arm_smmu_context_share finds the domain
that owns the ASID we want, and then changes all associated stream table
entries without racing with attach/detach_dev. Note that domain_free is
called after devices have been removed from the group, so
arm_smmu_context_share might do the whole ASID replacement dance for
nothing, but it is harmless.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 98 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c3fa4616bd58..3af47b1427a6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -708,6 +708,9 @@ struct arm_smmu_device {
 	spinlock_t			contexts_lock;
 	struct rb_root			streams;
 	struct list_head		tasks;
+
+	struct list_head		domains;
+	struct mutex			domains_mutex;
 };
 
 struct arm_smmu_stream {
@@ -752,6 +755,8 @@ struct arm_smmu_domain {
 
 	struct list_head		groups;
 	spinlock_t			groups_lock;
+
+	struct list_head		list; /* For domain search by ASID */
 };
 
 struct arm_smmu_task {
@@ -2179,11 +2184,79 @@ static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 static int arm_smmu_context_share(struct arm_smmu_task *smmu_task, int asid)
 {
 	int ret = 0;
+	int new_asid;
+	unsigned long flags;
+	struct arm_smmu_group *smmu_group;
+	struct arm_smmu_master_data *master;
 	struct arm_smmu_device *smmu = smmu_task->smmu;
+	struct arm_smmu_domain *tmp_domain, *smmu_domain = NULL;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
+			  CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
+	};
+
+	mutex_lock(&smmu->domains_mutex);
+
+	if (!test_and_set_bit(asid, smmu->asid_map))
+		goto out_unlock;
+
+	/* ASID is used by a domain. Try to replace it with a new one. */
+	new_asid = arm_smmu_bitmap_alloc(smmu->asid_map, smmu->asid_bits);
+	if (new_asid < 0) {
+		ret = new_asid;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(tmp_domain, &smmu->domains, list) {
+		if (tmp_domain->stage != ARM_SMMU_DOMAIN_S1 ||
+		    tmp_domain->s1_cfg.asid != asid)
+			continue;
+
+		smmu_domain = tmp_domain;
+		break;
+	}
+
+	/*
+	 * We didn't find the domain that owns this ASID. It is a bug, since we
+	 * hold domains_mutex
+	 */
+	if (WARN_ON(!smmu_domain)) {
+		ret = -ENOSPC;
+		goto out_unlock;
+	}
+
+	/*
+	 * Race with smmu_unmap; TLB invalidations will start targeting the
+	 * new ASID, which isn't assigned yet. We'll do an invalidate-all on
+	 * the old ASID later, so it doesn't matter.
+	 */
+	smmu_domain->s1_cfg.asid = new_asid;
 
-	if (test_and_set_bit(asid, smmu->asid_map))
-		/* ASID is already used for a domain */
-		return -EEXIST;
+	/*
+	 * Update ASID and invalidate CD in all associated masters. There will
+	 * be some overlapping between use of both ASIDs, until we invalidate
+	 * the TLB.
+	 */
+	spin_lock_irqsave(&smmu_domain->groups_lock, flags);
+
+	list_for_each_entry(smmu_group, &smmu_domain->groups, domain_head) {
+		spin_lock(&smmu_group->devices_lock);
+		list_for_each_entry(master, &smmu_group->devices, group_head) {
+			arm_smmu_write_ctx_desc(master, 0, &smmu_domain->s1_cfg);
+		}
+		spin_unlock(&smmu_group->devices_lock);
+	}
+
+	spin_unlock_irqrestore(&smmu_domain->groups_lock, flags);
+
+	/* Invalidate TLB entries previously associated with that domain */
+	cmd.tlbi.asid = asid;
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	cmd.opcode = CMDQ_OP_CMD_SYNC;
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+
+out_unlock:
+	mutex_unlock(&smmu->domains_mutex);
 
 	return ret;
 }
@@ -2426,16 +2499,23 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
+	mutex_lock(&smmu->domains_mutex);
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-		if (cfg->asid)
+		if (cfg->asid) {
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->asid);
+
+			list_del(&smmu_domain->list);
+		}
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
 			arm_smmu_bitmap_free(smmu->vmid_map, cfg->vmid);
 	}
 
+	mutex_unlock(&smmu->domains_mutex);
+
 	kfree(smmu_domain);
 }
 
@@ -2455,6 +2535,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	cfg->tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
 
+	list_add(&smmu_domain->list, &smmu->domains);
+
 	return 0;
 }
 
@@ -2604,12 +2686,16 @@ static void arm_smmu_detach_dev(struct device *dev)
 	struct arm_smmu_context *smmu_context;
 	struct rb_node *node, *next;
 
+	mutex_lock(&smmu->domains_mutex);
+
 	master->ste.bypass = true;
 	if (arm_smmu_install_ste_for_dev(dev->iommu_fwspec) < 0)
 		dev_warn(dev, "failed to install bypass STE\n");
 
 	arm_smmu_write_ctx_desc(master, 0, NULL);
 
+	mutex_unlock(&smmu->domains_mutex);
+
 	if (!master->ste.valid)
 		return;
 
@@ -2682,6 +2768,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		arm_smmu_detach_dev(dev);
 	}
 
+	mutex_lock(&smmu->domains_mutex);
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -2726,6 +2813,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
+	mutex_unlock(&smmu->domains_mutex);
 
 	iommu_group_put(group);
 
@@ -3330,9 +3418,11 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	mutex_init(&smmu->domains_mutex);
 	spin_lock_init(&smmu->contexts_lock);
 	smmu->streams = RB_ROOT;
 	INIT_LIST_HEAD(&smmu->tasks);
+	INIT_LIST_HEAD(&smmu->domains);
 
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
-- 
2.11.0
