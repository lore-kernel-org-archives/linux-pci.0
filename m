Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 6/7] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Wed, 24 May 2017 19:01:42 +0100
Message-Id: <20170524180143.19855-7-jean-philippe.brucker@arm.com>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com,
 joro@8bytes.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 okaya@codeaurora.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com, lenb@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

PCIe devices can implement their own TLB, named Address Translation Cache
(ATC). Enable Address Translation Service (ATS) for devices that support
it and send them invalidation requests whenever we invalidate the IOTLBs.

  Range calculation
  -----------------

The invalidation packet itself is a bit awkward: range must be naturally
aligned, which means that the start address is a multiple of the range
size. In addition, the size must be a power of two number of 4k pages. We
have a few options to enforce this constraint:

(1) Find the smallest naturally aligned region that covers the requested
    range. This is simple to compute and only takes one ATC_INV, but it
    will spill on lots of neighbouring ATC entries.

(2) Align the start address to the region size (rounded up to a power of
    two), and send a second invalidation for the next range of the same
    size. Still not great, but reduces spilling.

(3) Cover the range exactly with the smallest number of naturally aligned
    regions. This would be interesting to implement but as for (2),
    requires multiple ATC_INV.

As I suspect ATC invalidation packets will be a very scarce resource, I'll
go with option (1) for now, and only send one big invalidation. We can
move to (2), which is both easier to read and more gentle with the ATC,
once we've observed on real systems that we can send multiple smaller
Invalidation Requests for roughly the same price as a single big one.

Note that with io-pgtable, the unmap function is called for each page, so
this doesn't matter. The problem shows up when sharing page tables with
the MMU.

  Timeout
  -------

ATC invalidation is allowed to take up to 90 seconds, according to the
PCIe spec, so it is possible to hit the SMMU command queue timeout during
normal operations.

Some SMMU implementations will raise a CERROR_ATC_INV_SYNC when a CMD_SYNC
fails because of an ATC invalidation. Some will just abort the CMD_SYNC.
Others might let CMD_SYNC complete and have an asynchronous IMPDEF
mechanism to record the error. When we receive a CERROR_ATC_INV_SYNC, we
could retry sending all ATC_INV since last successful CMD_SYNC. When a
CMD_SYNC fails without CERROR_ATC_INV_SYNC, we could retry sending *all*
commands since last successful CMD_SYNC.

We cannot afford to wait 90 seconds in iommu_unmap, let alone MMU
notifiers. So we'd have to introduce a more clever system if this timeout
becomes a problem, like keeping hold of mappings and invalidating in the
background. Implementing safe delayed invalidations is a very complex
problem and deserves a series of its own. We'll assess whether more work
is needed to properly handle ATC invalidation timeouts once this code runs
on real hardware.

  Misc
  ----

I didn't put ATC and TLB invalidations in the same functions for three
reasons:

* TLB invalidation by range is batched and committed with a single sync.
  Batching ATC invalidation is inconvenient, endpoints limit the number of
  inflight invalidations. We'd have to count the number of invalidations
  queued and send a sync periodically. In addition, I suspect we always
  need a sync between TLB and ATC invalidation for the same page.

* Doing ATC invalidation outside tlb_inv_range also allows to send less
  requests, since TLB invalidations are done per page or block, while ATC
  invalidations target IOVA ranges.

* TLB invalidation by context is performed when freeing the domain, at
  which point there isn't any device attached anymore.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 232 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 225 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 524e1b051962..87ed6239b9a6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -35,6 +35,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 
 #include <linux/amba/bus.h>
@@ -102,6 +103,7 @@
 #define IDR5_OAS_48_BIT			(5 << IDR5_OAS_SHIFT)
 
 #define ARM_SMMU_CR0			0x20
+#define CR0_ATSCHK			(1 << 4)
 #define CR0_CMDQEN			(1 << 3)
 #define CR0_EVTQEN			(1 << 2)
 #define CR0_PRIQEN			(1 << 1)
@@ -343,6 +345,7 @@
 #define CMDQ_ERR_CERROR_NONE_IDX	0
 #define CMDQ_ERR_CERROR_ILL_IDX		1
 #define CMDQ_ERR_CERROR_ABT_IDX		2
+#define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_0_OP_SHIFT			0
 #define CMDQ_0_OP_MASK			0xffUL
@@ -364,6 +367,15 @@
 #define CMDQ_TLBI_1_VA_MASK		~0xfffUL
 #define CMDQ_TLBI_1_IPA_MASK		0xfffffffff000UL
 
+#define CMDQ_ATC_0_SSID_SHIFT		12
+#define CMDQ_ATC_0_SSID_MASK		0xfffffUL
+#define CMDQ_ATC_0_SID_SHIFT		32
+#define CMDQ_ATC_0_SID_MASK		0xffffffffUL
+#define CMDQ_ATC_0_GLOBAL		(1UL << 9)
+#define CMDQ_ATC_1_SIZE_SHIFT		0
+#define CMDQ_ATC_1_SIZE_MASK		0x3fUL
+#define CMDQ_ATC_1_ADDR_MASK		~0xfffUL
+
 #define CMDQ_PRI_0_SSID_SHIFT		12
 #define CMDQ_PRI_0_SSID_MASK		0xfffffUL
 #define CMDQ_PRI_0_SID_SHIFT		32
@@ -417,6 +429,11 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
+static bool disable_ats_check;
+module_param_named(disable_ats_check, disable_ats_check, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_ats_check,
+	"By default, the SMMU checks whether each incoming transaction marked as translated is allowed by the stream configuration. This option disables the check.");
+
 enum pri_resp {
 	PRI_RESP_DENY,
 	PRI_RESP_FAIL,
@@ -485,6 +502,16 @@ struct arm_smmu_cmdq_ent {
 			u64			addr;
 		} tlbi;
 
+		#define CMDQ_OP_ATC_INV		0x40
+		#define ATC_INV_SIZE_ALL	52
+		struct {
+			u32			sid;
+			u32			ssid;
+			u64			addr;
+			u8			size;
+			bool			global;
+		} atc;
+
 		#define CMDQ_OP_PRI_RESP	0x41
 		struct {
 			u32			sid;
@@ -631,6 +658,7 @@ struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
 
+	struct device			*dev;
 	struct arm_smmu_domain		*domain;
 	struct list_head		list; /* domain->devices */
 };
@@ -835,6 +863,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_S12_VMALL:
 		cmd[0] |= (u64)ent->tlbi.vmid << CMDQ_TLBI_0_VMID_SHIFT;
 		break;
+	case CMDQ_OP_ATC_INV:
+		cmd[0] |= ent->substream_valid ? CMDQ_0_SSV : 0;
+		cmd[0] |= ent->atc.global ? CMDQ_ATC_0_GLOBAL : 0;
+		cmd[0] |= ent->atc.ssid << CMDQ_ATC_0_SSID_SHIFT;
+		cmd[0] |= (u64)ent->atc.sid << CMDQ_ATC_0_SID_SHIFT;
+		cmd[1] |= ent->atc.size << CMDQ_ATC_1_SIZE_SHIFT;
+		cmd[1] |= ent->atc.addr & CMDQ_ATC_1_ADDR_MASK;
+		break;
 	case CMDQ_OP_PRI_RESP:
 		cmd[0] |= ent->substream_valid ? CMDQ_0_SSV : 0;
 		cmd[0] |= ent->pri.ssid << CMDQ_PRI_0_SSID_SHIFT;
@@ -870,6 +906,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
 		[CMDQ_ERR_CERROR_ILL_IDX]	= "Illegal command",
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
+		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
 
 	int i;
@@ -889,6 +926,14 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		dev_err(smmu->dev, "retrying command fetch\n");
 	case CMDQ_ERR_CERROR_NONE_IDX:
 		return;
+	case CMDQ_ERR_CERROR_ATC_INV_IDX:
+		/*
+		 * ATC Invalidation Completion timeout. CONS is still pointing
+		 * at the CMD_SYNC. Attempt to complete other pending commands
+		 * by repeating the CMD_SYNC, though we might well end up back
+		 * here since the ATC invalidation may still be pending.
+		 */
+		return;
 	case CMDQ_ERR_CERROR_ILL_IDX:
 		/* Fallthrough */
 	default:
@@ -1084,9 +1129,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1COR_SHIFT |
 			 STRTAB_STE_1_S1C_SH_ISH << STRTAB_STE_1_S1CSH_SHIFT |
-#ifdef CONFIG_PCI_ATS
-			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
-#endif
 			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
@@ -1115,6 +1157,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		val |= STRTAB_STE_0_CFG_S2_TRANS;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_ATS))
+		dst[1] |= cpu_to_le64(STRTAB_STE_1_EATS_TRANS
+				      << STRTAB_STE_1_EATS_SHIFT);
+
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 	dst[0] = cpu_to_le64(val);
 	arm_smmu_sync_ste_for_sid(smmu, sid);
@@ -1374,6 +1420,106 @@ static const struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_sync	= arm_smmu_tlb_sync,
 };
 
+static bool arm_smmu_master_has_ats(struct arm_smmu_master_data *master)
+{
+	return dev_is_pci(master->dev) && to_pci_dev(master->dev)->ats_enabled;
+}
+
+static void
+arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+			struct arm_smmu_cmdq_ent *cmd)
+{
+	size_t log2_span;
+	size_t span_mask;
+	/* ATC invalidates are always on 4096 bytes pages */
+	size_t inval_grain_shift = 12;
+	unsigned long page_start, page_end;
+
+	*cmd = (struct arm_smmu_cmdq_ent) {
+		.opcode			= CMDQ_OP_ATC_INV,
+		.substream_valid	= !!ssid,
+		.atc.ssid		= ssid,
+	};
+
+	if (!size) {
+		cmd->atc.size = ATC_INV_SIZE_ALL;
+		return;
+	}
+
+	page_start	= iova >> inval_grain_shift;
+	page_end	= (iova + size - 1) >> inval_grain_shift;
+
+	/*
+	 * Find the smallest power of two that covers the range. Most
+	 * significant differing bit between start and end address indicates the
+	 * required span, ie. fls(start ^ end). For example:
+	 *
+	 * We want to invalidate pages [8; 11]. This is already the ideal range:
+	 *		x = 0b1000 ^ 0b1011 = 0b11
+	 *		span = 1 << fls(x) = 4
+	 *
+	 * To invalidate pages [7; 10], we need to invalidate [0; 15]:
+	 *		x = 0b0111 ^ 0b1010 = 0b1101
+	 *		span = 1 << fls(x) = 16
+	 */
+	log2_span	= fls_long(page_start ^ page_end);
+	span_mask	= (1ULL << log2_span) - 1;
+
+	page_start	&= ~span_mask;
+
+	cmd->atc.addr	= page_start << inval_grain_shift;
+	cmd->atc.size	= log2_span;
+}
+
+static int arm_smmu_atc_inv_master(struct arm_smmu_master_data *master,
+				   struct arm_smmu_cmdq_ent *cmd)
+{
+	int i;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+	struct arm_smmu_cmdq_ent sync_cmd = {
+		.opcode = CMDQ_OP_CMD_SYNC,
+	};
+
+	if (!arm_smmu_master_has_ats(master))
+		return 0;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		cmd->atc.sid = fwspec->ids[i];
+		arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
+	}
+
+	arm_smmu_cmdq_issue_cmd(master->smmu, &sync_cmd);
+
+	return 0;
+}
+
+static int arm_smmu_atc_inv_master_all(struct arm_smmu_master_data *master,
+				       int ssid)
+{
+	struct arm_smmu_cmdq_ent cmd;
+
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
+	return arm_smmu_atc_inv_master(master, &cmd);
+}
+
+static size_t
+arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
+			unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_master_data *master;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, list)
+		arm_smmu_atc_inv_master(master, &cmd);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	return size;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)
 {
@@ -1623,6 +1769,8 @@ static void arm_smmu_detach_dev(struct device *dev)
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (smmu_domain) {
+		arm_smmu_atc_inv_master_all(master, 0);
+
 		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 		list_del(&master->list);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
@@ -1727,7 +1875,11 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 
 	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
 	ret = ops->unmap(ops, iova, size);
+
+	if (ret && smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS)
+		ret = arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
 	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
+
 	return ret;
 }
 
@@ -1778,6 +1930,48 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
+{
+	int ret;
+	size_t stu;
+	struct pci_dev *pdev;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
+	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_SUPPORTS_ATS))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	/* Smallest Translation Unit: log2 of the smallest supported granule */
+	stu = __ffs(smmu->pgsize_bitmap);
+
+	ret = pci_enable_ats(pdev, stu);
+	if (ret)
+		return ret;
+
+	dev_dbg(&pdev->dev, "enabled ATS (STU=%zu, QDEP=%d)\n", stu,
+		pci_ats_queue_depth(pdev));
+
+	return 0;
+}
+
+static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->ats_enabled)
+		return;
+
+	pci_disable_ats(pdev);
+}
+
 static struct iommu_ops arm_smmu_ops;
 
 static int arm_smmu_add_device(struct device *dev)
@@ -1807,6 +2001,7 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->dev = dev;
 		fwspec->iommu_priv = master;
 	}
 
@@ -1825,13 +2020,23 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	arm_smmu_enable_ats(master);
+
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
-		iommu_group_put(group);
-		iommu_device_link(&smmu->iommu, dev);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_disable_ats;
 	}
 
-	return PTR_ERR_OR_ZERO(group);
+	iommu_group_put(group);
+	iommu_device_link(&smmu->iommu, dev);
+
+	return 0;
+
+err_disable_ats:
+	arm_smmu_disable_ats(master);
+
+	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
@@ -1847,6 +2052,9 @@ static void arm_smmu_remove_device(struct device *dev)
 	smmu = master->smmu;
 	if (master && master->ste.assigned)
 		arm_smmu_detach_dev(dev);
+
+	arm_smmu_disable_ats(master);
+
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
@@ -2417,6 +2625,16 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
+	if (smmu->features & ARM_SMMU_FEAT_ATS && !disable_ats_check) {
+		enables |= CR0_ATSCHK;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable ATS check\n");
+			return ret;
+		}
+	}
+
 	ret = arm_smmu_setup_irqs(smmu);
 	if (ret) {
 		dev_err(smmu->dev, "failed to setup irqs\n");
-- 
2.12.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
