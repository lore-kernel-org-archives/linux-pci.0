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
Subject: [RFCv2 PATCH 29/36] iommu/arm-smmu-v3: Add stall support for platform devices
Date: Fri,  6 Oct 2017 14:31:56 +0100
Message-Id: <20171006133203.22803-30-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The SMMU provides a Stall model for handling page faults in platform
devices. It is similar to PCI PRI, but doesn't require devices to have
their own translation cache. Instead, faulting transactions are parked and
the OS is given a chance to fix the page tables and retry the transaction.

Enable stall for devices that support it (opt-in by firmware). When an
event corresponds to a translation error, call the IOMMU fault handler. If
the fault is recoverable, it will call us back to terminate or continue
the stall.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 176 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e915e649643..48a1da0934b4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -418,6 +418,15 @@
 #define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
 #define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
 
+#define CMDQ_RESUME_0_SID_SHIFT		32
+#define CMDQ_RESUME_0_SID_MASK		0xffffffffUL
+#define CMDQ_RESUME_0_ACTION_SHIFT	12
+#define CMDQ_RESUME_0_ACTION_TERM	(0UL << CMDQ_RESUME_0_ACTION_SHIFT)
+#define CMDQ_RESUME_0_ACTION_RETRY	(1UL << CMDQ_RESUME_0_ACTION_SHIFT)
+#define CMDQ_RESUME_0_ACTION_ABORT	(2UL << CMDQ_RESUME_0_ACTION_SHIFT)
+#define CMDQ_RESUME_1_STAG_SHIFT	0
+#define CMDQ_RESUME_1_STAG_MASK		0xffffUL
+
 #define CMDQ_SYNC_0_CS_SHIFT		12
 #define CMDQ_SYNC_0_CS_NONE		(0UL << CMDQ_SYNC_0_CS_SHIFT)
 #define CMDQ_SYNC_0_CS_SEV		(2UL << CMDQ_SYNC_0_CS_SHIFT)
@@ -429,6 +438,31 @@
 #define EVTQ_0_ID_SHIFT			0
 #define EVTQ_0_ID_MASK			0xffUL
 
+#define EVT_ID_TRANSLATION_FAULT	0x10
+#define EVT_ID_ADDR_SIZE_FAULT		0x11
+#define EVT_ID_ACCESS_FAULT		0x12
+#define EVT_ID_PERMISSION_FAULT		0x13
+
+#define EVTQ_0_SSV			(1UL << 11)
+#define EVTQ_0_SSID_SHIFT		12
+#define EVTQ_0_SSID_MASK		0xfffffUL
+#define EVTQ_0_SID_SHIFT		32
+#define EVTQ_0_SID_MASK			0xffffffffUL
+#define EVTQ_1_STAG_SHIFT		0
+#define EVTQ_1_STAG_MASK		0xffffUL
+#define EVTQ_1_STALL			(1UL << 31)
+#define EVTQ_1_PRIV			(1UL << 33)
+#define EVTQ_1_EXEC			(1UL << 34)
+#define EVTQ_1_READ			(1UL << 35)
+#define EVTQ_1_S2			(1UL << 39)
+#define EVTQ_1_CLASS_SHIFT		40
+#define EVTQ_1_CLASS_MASK		0x3UL
+#define EVTQ_1_TT_READ			(1UL << 44)
+#define EVTQ_2_ADDR_SHIFT		0
+#define EVTQ_2_ADDR_MASK		0xffffffffffffffffUL
+#define EVTQ_3_IPA_SHIFT		12
+#define EVTQ_3_IPA_MASK			0xffffffffffUL
+
 /* PRI queue */
 #define PRIQ_ENT_DWORDS			2
 #define PRIQ_MAX_SZ_SHIFT		8
@@ -456,6 +490,9 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+/* Flags for iommu_data in iommu_fault */
+#define ARM_SMMU_FAULT_STALL		(1 << 0)
+
 /* Until ACPICA headers cover IORT rev. C */
 #ifndef ACPI_IORT_SMMU_HISILICON_HI161X
 #define ACPI_IORT_SMMU_HISILICON_HI161X		0x1
@@ -552,6 +589,13 @@ struct arm_smmu_cmdq_ent {
 			enum pri_resp		resp;
 		} pri;
 
+		#define CMDQ_OP_RESUME		0x44
+		struct {
+			u32			sid;
+			u16			stag;
+			enum iommu_fault_status	resp;
+		} resume;
+
 		#define CMDQ_OP_CMD_SYNC	0x46
 	};
 };
@@ -625,6 +669,7 @@ struct arm_smmu_s1_cfg {
 	};
 
 	size_t				num_contexts;
+	bool				can_stall;
 
 	struct arm_smmu_ctx_desc	cd; /* Default context (SSID0) */
 };
@@ -646,6 +691,8 @@ struct arm_smmu_strtab_ent {
 	bool				assigned;
 	struct arm_smmu_s1_cfg		*s1_cfg;
 	struct arm_smmu_s2_cfg		*s2_cfg;
+
+	bool				can_stall;
 };
 
 struct arm_smmu_strtab_cfg {
@@ -1009,6 +1056,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 			return -EINVAL;
 		}
 		break;
+	case CMDQ_OP_RESUME:
+		switch (ent->resume.resp) {
+		case IOMMU_FAULT_STATUS_FAILURE:
+		case IOMMU_FAULT_STATUS_INVALID:
+			cmd[0] |= CMDQ_RESUME_0_ACTION_ABORT;
+			break;
+		case IOMMU_FAULT_STATUS_HANDLED:
+			cmd[0] |= CMDQ_RESUME_0_ACTION_RETRY;
+			break;
+		default:
+			return -EINVAL;
+		}
+		cmd[0] |= (u64)ent->resume.sid << CMDQ_RESUME_0_SID_SHIFT;
+		cmd[1] |= ent->resume.stag << CMDQ_RESUME_1_STAG_SHIFT;
+		break;
 	case CMDQ_OP_CMD_SYNC:
 		cmd[0] |= CMDQ_SYNC_0_CS_SEV;
 		break;
@@ -1093,6 +1155,32 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 }
 
+static int arm_smmu_fault_response(struct iommu_domain *domain,
+				   struct device *dev,
+				   struct iommu_fault *fault,
+				   enum iommu_fault_status resp)
+{
+	int sid = dev->iommu_fwspec->ids[0];
+	struct arm_smmu_cmdq_ent cmd = {0};
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (fault->iommu_data & ARM_SMMU_FAULT_STALL) {
+		cmd.opcode		= CMDQ_OP_RESUME;
+		cmd.resume.sid		= sid;
+		cmd.resume.stag		= fault->id;
+		cmd.resume.resp		= resp;
+	} else {
+		/* TODO: put PRI response here */
+		return -EINVAL;
+	}
+
+	arm_smmu_cmdq_issue_cmd(smmu_domain->smmu, &cmd);
+	cmd.opcode = CMDQ_OP_CMD_SYNC;
+	arm_smmu_cmdq_issue_cmd(smmu_domain->smmu, &cmd);
+
+	return 0;
+}
+
 /* Context descriptor manipulation functions */
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain, u32 ssid,
 			     bool leaf)
@@ -1283,7 +1371,8 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		      CTXDESC_CD_0_V;
 
 		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-		if (smmu_domain->smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		if ((smmu_domain->smmu->features & ARM_SMMU_FEAT_STALL_FORCE) ||
+		    (ssid && smmu_domain->s1_cfg.can_stall))
 			val |= CTXDESC_CD_0_S;
 
 		cdptr[0] = cpu_to_le64(val);
@@ -1503,7 +1592,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			 STRTAB_STE_1_STRW_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
-		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
+		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE) &&
+		   !ste->can_stall)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1ctxptr & STRTAB_STE_0_S1CTXPTR_MASK
@@ -1606,10 +1696,72 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	return master;
 }
 
+static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+{
+	struct iommu_domain *domain;
+	struct arm_smmu_master_data *master;
+	u8 type = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
+	u32 sid = evt[0] >> EVTQ_0_SID_SHIFT & EVTQ_0_SID_MASK;
+
+	struct iommu_fault fault = {
+		.id		= evt[1] >> EVTQ_1_STAG_SHIFT & EVTQ_1_STAG_MASK,
+		.address	= evt[2] >> EVTQ_2_ADDR_SHIFT & EVTQ_2_ADDR_MASK,
+		.iommu_data	= ARM_SMMU_FAULT_STALL,
+	};
+
+	switch (type) {
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	/* Stage-2 is always pinned at the moment */
+	if (evt[1] & EVTQ_1_S2)
+		return -EFAULT;
+
+	master = arm_smmu_find_master(smmu, sid);
+	if (!master)
+		return -EINVAL;
+
+	/*
+	 * The domain is valid until the fault returns, because detach() flushes
+	 * the fault queue.
+	 */
+	domain = iommu_get_domain_for_dev(master->dev);
+	if (!domain)
+		return -EINVAL;
+
+	if (evt[1] & EVTQ_1_STALL)
+		fault.flags |= IOMMU_FAULT_RECOVERABLE;
+
+	if (evt[1] & EVTQ_1_READ)
+		fault.flags |= IOMMU_FAULT_READ;
+	else
+		fault.flags |= IOMMU_FAULT_WRITE;
+
+	if (evt[1] & EVTQ_1_EXEC)
+		fault.flags |= IOMMU_FAULT_EXEC;
+
+	if (evt[1] & EVTQ_1_PRIV)
+		fault.flags |= IOMMU_FAULT_PRIV;
+
+	if (evt[0] & EVTQ_0_SSV) {
+		fault.flags |= IOMMU_FAULT_PASID;
+		fault.pasid = evt[0] >> EVTQ_0_SSID_SHIFT & EVTQ_0_SSID_MASK;
+	}
+
+	/* Report to device driver or populate the page tables */
+	return handle_iommu_fault(domain, master->dev, &fault);
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i;
+	int i, ret;
 	int num_handled = 0;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
@@ -1621,12 +1773,19 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
 
+			spin_unlock(&q->wq.lock);
+			ret = arm_smmu_handle_evt(smmu, evt);
+			spin_lock(&q->wq.lock);
+
 			if (++num_handled == queue_size) {
 				q->batch++;
 				wake_up_locked(&q->wq);
 				num_handled = 0;
 			}
 
+			if (!ret)
+				continue;
+
 			dev_info(smmu->dev, "event 0x%02x received:\n", id);
 			for (i = 0; i < ARRAY_SIZE(evt); ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
@@ -1762,7 +1921,9 @@ static int arm_smmu_flush_queues(struct notifier_block *nb,
 		master = dev->iommu_fwspec->iommu_priv;
 
 	if (master) {
-		/* TODO: add support for PRI and Stall */
+		if (master->ste.can_stall)
+			arm_smmu_flush_queue(smmu, &smmu->evtq.q, "evtq");
+		/* TODO: add support for PRI */
 		return 0;
 	}
 
@@ -2110,6 +2271,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 			domain->max_pasid = master->num_ssids - 1;
 			smmu_domain->s1_cfg.num_contexts = master->num_ssids;
 		}
+		smmu_domain->s1_cfg.can_stall = master->ste.can_stall;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -2707,6 +2869,11 @@ static int arm_smmu_add_device(struct device *dev)
 		master->num_ssids = 1 << min(smmu->ssid_bits,
 					     fwspec->num_pasid_bits);
 
+	if (fwspec->can_stall && smmu->features & ARM_SMMU_FEAT_STALLS) {
+		master->can_fault = true;
+		master->ste.can_stall = true;
+	}
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		arm_smmu_insert_master(smmu, master);
@@ -2845,6 +3012,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.process_detach		= arm_smmu_process_detach,
 	.process_invalidate	= arm_smmu_process_invalidate,
 	.process_exit		= arm_smmu_process_exit,
+	.fault_response		= arm_smmu_fault_response,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
-- 
2.13.3

