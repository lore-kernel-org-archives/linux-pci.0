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
Subject: [RFCv2 PATCH 35/36] iommu/arm-smmu-v3: Add support for PRI
Date: Fri,  6 Oct 2017 14:32:02 +0100
Message-Id: <20171006133203.22803-36-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For PCI devices that support it, enable the PRI capability and handle
PRI Page Requests with the generic fault handler.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 176 ++++++++++++++++++++++++++++++--------------
 1 file changed, 122 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f008b4617cd4..852714f35010 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -272,6 +272,7 @@
 #define STRTAB_STE_1_S1COR_SHIFT	4
 #define STRTAB_STE_1_S1CSH_SHIFT	6
 
+#define STRTAB_STE_1_PPAR		(1UL << 18)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
 #define STRTAB_STE_1_EATS_ABT		0UL
@@ -426,9 +427,9 @@
 #define CMDQ_PRI_1_GRPID_SHIFT		0
 #define CMDQ_PRI_1_GRPID_MASK		0x1ffUL
 #define CMDQ_PRI_1_RESP_SHIFT		12
-#define CMDQ_PRI_1_RESP_DENY		(0UL << CMDQ_PRI_1_RESP_SHIFT)
-#define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
-#define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
+#define CMDQ_PRI_1_RESP_FAILURE		(0UL << CMDQ_PRI_1_RESP_SHIFT)
+#define CMDQ_PRI_1_RESP_INVALID		(1UL << CMDQ_PRI_1_RESP_SHIFT)
+#define CMDQ_PRI_1_RESP_SUCCESS		(2UL << CMDQ_PRI_1_RESP_SHIFT)
 
 #define CMDQ_RESUME_0_SID_SHIFT		32
 #define CMDQ_RESUME_0_SID_MASK		0xffffffffUL
@@ -504,6 +505,7 @@
 
 /* Flags for iommu_data in iommu_fault */
 #define ARM_SMMU_FAULT_STALL		(1 << 0)
+#define ARM_SMMU_FAULT_RESP_PASID	(1 << 1);
 
 /* Until ACPICA headers cover IORT rev. C */
 #ifndef ACPI_IORT_SMMU_HISILICON_HI161X
@@ -524,12 +526,6 @@ module_param_named(disable_ats_check, disable_ats_check, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_ats_check,
 	"By default, the SMMU checks whether each incoming transaction marked as translated is allowed by the stream configuration. This option disables the check.");
 
-enum pri_resp {
-	PRI_RESP_DENY,
-	PRI_RESP_FAIL,
-	PRI_RESP_SUCC,
-};
-
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -613,7 +609,7 @@ struct arm_smmu_cmdq_ent {
 			u32			sid;
 			u32			ssid;
 			u16			grpid;
-			enum pri_resp		resp;
+			enum iommu_fault_status	resp;
 		} pri;
 
 		#define CMDQ_OP_RESUME		0x44
@@ -720,6 +716,7 @@ struct arm_smmu_strtab_ent {
 	struct arm_smmu_s2_cfg		*s2_cfg;
 
 	bool				can_stall;
+	bool				prg_resp_needs_ssid;
 };
 
 struct arm_smmu_strtab_cfg {
@@ -1078,14 +1075,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= (u64)ent->pri.sid << CMDQ_PRI_0_SID_SHIFT;
 		cmd[1] |= ent->pri.grpid << CMDQ_PRI_1_GRPID_SHIFT;
 		switch (ent->pri.resp) {
-		case PRI_RESP_DENY:
-			cmd[1] |= CMDQ_PRI_1_RESP_DENY;
+		case IOMMU_FAULT_STATUS_FAILURE:
+			cmd[1] |= CMDQ_PRI_1_RESP_FAILURE;
 			break;
-		case PRI_RESP_FAIL:
-			cmd[1] |= CMDQ_PRI_1_RESP_FAIL;
+		case IOMMU_FAULT_STATUS_INVALID:
+			cmd[1] |= CMDQ_PRI_1_RESP_INVALID;
 			break;
-		case PRI_RESP_SUCC:
-			cmd[1] |= CMDQ_PRI_1_RESP_SUCC;
+		case IOMMU_FAULT_STATUS_HANDLED:
+			cmd[1] |= CMDQ_PRI_1_RESP_SUCCESS;
 			break;
 		default:
 			return -EINVAL;
@@ -1214,8 +1211,13 @@ static int arm_smmu_fault_response(struct iommu_domain *domain,
 		cmd.resume.stag		= fault->id;
 		cmd.resume.resp		= resp;
 	} else {
-		/* TODO: put PRI response here */
-		return -EINVAL;
+		cmd.opcode		= CMDQ_OP_PRI_RESP;
+		cmd.substream_valid	= fault->iommu_data &
+					  ARM_SMMU_FAULT_RESP_PASID;
+		cmd.pri.sid		= sid;
+		cmd.pri.ssid		= fault->pasid;
+		cmd.pri.grpid		= fault->id;
+		cmd.pri.resp		= resp;
 	}
 
 	arm_smmu_cmdq_issue_cmd(smmu_domain->smmu, &cmd);
@@ -1631,6 +1633,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			  STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1) <<
 			 STRTAB_STE_1_STRW_SHIFT);
 
+		if (ste->prg_resp_needs_ssid)
+			dst[1] |= STRTAB_STE_1_PPAR;
+
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE) &&
 		   !ste->can_stall)
@@ -1856,40 +1861,42 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
-	u32 sid, ssid;
-	u16 grpid;
-	bool ssv, last;
-
-	sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
-	ssv = evt[0] & PRIQ_0_SSID_V;
-	ssid = ssv ? evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK : 0;
-	last = evt[0] & PRIQ_0_PRG_LAST;
-	grpid = evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK;
-
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
-		 sid, ssid, grpid, last ? "L" : "",
-		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
-		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
-		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-		 evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT);
+	u32 sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
 
-	if (last) {
-		struct arm_smmu_cmdq_ent cmd = {
-			.opcode			= CMDQ_OP_PRI_RESP,
-			.substream_valid	= ssv,
-			.pri			= {
-				.sid	= sid,
-				.ssid	= ssid,
-				.grpid	= grpid,
-				.resp	= PRI_RESP_DENY,
-			},
-		};
+	struct arm_smmu_master_data *master;
+	struct iommu_domain *domain;
+	struct iommu_fault fault = {
+		.pasid		= evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK,
+		.id		= evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK,
+		.address	= evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT,
+		.flags		= IOMMU_FAULT_GROUP | IOMMU_FAULT_RECOVERABLE,
+	};
 
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	}
+	if (evt[0] & PRIQ_0_SSID_V)
+		fault.flags |= IOMMU_FAULT_PASID;
+	if (evt[0] & PRIQ_0_PRG_LAST)
+		fault.flags |= IOMMU_FAULT_LAST;
+	if (evt[0] & PRIQ_0_PERM_READ)
+		fault.flags |= IOMMU_FAULT_READ;
+	if (evt[0] & PRIQ_0_PERM_WRITE)
+		fault.flags |= IOMMU_FAULT_WRITE;
+	if (evt[0] & PRIQ_0_PERM_EXEC)
+		fault.flags |= IOMMU_FAULT_EXEC;
+	if (evt[0] & PRIQ_0_PERM_PRIV)
+		fault.flags |= IOMMU_FAULT_PRIV;
+
+	master = arm_smmu_find_master(smmu, sid);
+	if (WARN_ON(!master))
+		return;
+
+	if (fault.flags & IOMMU_FAULT_PASID && master->ste.prg_resp_needs_ssid)
+		fault.iommu_data |= ARM_SMMU_FAULT_RESP_PASID;
+
+	domain = iommu_get_domain_for_dev(master->dev);
+	if (WARN_ON(!domain))
+		return;
+
+	handle_iommu_fault(domain, master->dev, &fault);
 }
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
@@ -1967,7 +1974,8 @@ static int arm_smmu_flush_queues(struct notifier_block *nb,
 	if (master) {
 		if (master->ste.can_stall)
 			arm_smmu_flush_queue(smmu, &smmu->evtq.q, "evtq");
-		/* TODO: add support for PRI */
+		else if (master->can_fault)
+			arm_smmu_flush_queue(smmu, &smmu->priq.q, "priq");
 		return 0;
 	}
 
@@ -2933,6 +2941,46 @@ static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
 	return 0;
 }
 
+static int arm_smmu_enable_pri(struct arm_smmu_master_data *master)
+{
+	int ret, pos;
+	struct pci_dev *pdev;
+	/*
+	 * TODO: find a good inflight PPR number. We should divide the PRI queue
+	 * by the number of PRI-capable devices, but it's impossible to know
+	 * about current and future (hotplugged) devices. So we're at risk of
+	 * dropping PPRs (and leaking pending requests in the FQ).
+	 */
+	size_t max_inflight_pprs = 16;
+	struct arm_smmu_device *smmu = master->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return -ENOSYS;
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_pri(pdev, max_inflight_pprs);
+	if (ret) {
+		dev_err(master->dev, "cannot enable PRI: %d\n", ret);
+		return ret;
+	}
+
+	master->can_fault = true;
+	master->ste.prg_resp_needs_ssid = pci_prg_resp_requires_prefix(pdev);
+
+	dev_dbg(master->dev, "enabled PRI");
+
+	return 0;
+}
+
 static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
 {
 	struct pci_dev *pdev;
@@ -2948,6 +2996,22 @@ static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
 	pci_disable_ats(pdev);
 }
 
+static void arm_smmu_disable_pri(struct arm_smmu_master_data *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pri_enabled)
+		return;
+
+	pci_disable_pri(pdev);
+	master->can_fault = false;
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master_data *master)
 {
@@ -3070,12 +3134,13 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ste.can_stall = true;
 	}
 
-	arm_smmu_enable_ats(master);
+	if (!arm_smmu_enable_ats(master))
+		arm_smmu_enable_pri(master);
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
-		goto err_disable_ats;
+		goto err_disable_pri;
 	}
 
 	iommu_group_put(group);
@@ -3084,7 +3149,8 @@ static int arm_smmu_add_device(struct device *dev)
 
 	return 0;
 
-err_disable_ats:
+err_disable_pri:
+	arm_smmu_disable_pri(master);
 	arm_smmu_disable_ats(master);
 
 	return ret;
@@ -3104,6 +3170,8 @@ static void arm_smmu_remove_device(struct device *dev)
 	if (master && master->ste.assigned)
 		arm_smmu_detach_dev(dev);
 	arm_smmu_remove_master(smmu, master);
+
+	arm_smmu_disable_pri(master);
 	arm_smmu_disable_ats(master);
 
 	iommu_group_remove_device(dev);
-- 
2.13.3

