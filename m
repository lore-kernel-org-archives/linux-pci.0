Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Mon, 27 Feb 2017 19:54:15 +0000
Message-Id: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
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

PCIe devices can implement their own TLB, named Address Translation Cache
(ATC). Steps involved in the use and maintenance of such caches are:

* Device sends an Address Translation Request for a given IOVA to the
  IOMMU. If the translation succeeds, the IOMMU returns the corresponding
  physical address, which is stored in the device's ATC.

* Device can then use the physical address directly in a transaction.
  A PCIe device does so by setting the TLP AT field to 0b10 - translated.
  The SMMU might check that the device is allowed to send translated
  transactions, and let it pass through.

* When an address is unmapped, CPU sends a CMD_ATC_INV command to the
  SMMU, that is relayed to the device.

In theory, this doesn't require a lot of software intervention. The IOMMU
driver needs to enable ATS when adding a PCI device, and send an
invalidation request when unmapping. Note that this invalidation is
allowed to take up to a minute, according to the PCIe spec. In
addition, the invalidation queue on the ATC side is fairly small, 32 by
default, so we cannot keep many invalidations in flight (see ATS spec
section 3.5, Invalidate Flow Control).

Handling these constraints properly would require to postpone
invalidations, and keep the stale mappings until we're certain that all
devices forgot about them. This requires major work in the page table
managers, and is therefore not done by this patch.

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

As I suspect ATC invalidation packets will be a very scarce resource,
we'll go with option (1) for now, and only send one big invalidation.

Note that with io-pgtable, the unmap function is called for each page, so
this doesn't matter. The problem shows up when sharing page tables with
the MMU.

  Locking
  -------

The atc_invalidate function is called from arm_smmu_unmap, with pgtbl_lock
held (hardirq-safe). When sharing page tables with the MMU, we will have a
few more call sites:

* When unbinding an address space from a device, to invalidate the whole
  address space.
* When a task bound to a device does an mlock, munmap, etc. This comes
  from an MMU notifier, with mmap_sem and pte_lock held.

Given this, all locks take on the ATC invalidation path must be hardirq-
safe.

  Timeout
  -------

Some SMMU implementations will raise a CERROR_ATC_INV_SYNC when a CMD_SYNC
fails because of an ATC invalidation. Some will just fail the CMD_SYNC.
Others might let CMD_SYNC complete and have an asynchronous IMPDEF
mechanism to record the error. When we receive a CERROR_ATC_INV_SYNC, we
could retry sending all ATC_INV since last successful CMD_SYNC. When a
CMD_SYNC fails without CERROR_ATC_INV_SYNC, we could retry sending *all*
commands since last successful CMD_SYNC. This patch doesn't properly
handle timeout, and ignores devices that don't behave. It might lead to
memory corruption.

  Optional support
  ----------------

For the moment, enable ATS whenever a device advertises it. Later, we
might want to allow users to opt-in for the whole system or individual
devices via sysfs or cmdline. Some firmware interfaces also provide a
description of ATS capabilities in the root complex, and we might want to
add a similar capability in DT. For instance, the following could be added
to bindings/pci/pci-iommu.txt, as an optional property to PCI RC:

- ats-map: describe Address Translation Service support by the root
  complex. This property is an arbitrary number of tuples of
  (rid-base,length). Any RID in this interval is allowed to issue address
  translation requests.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 262 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 250 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 69d00416990d..e7b940146ae3 100644
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
@@ -485,6 +502,15 @@ struct arm_smmu_cmdq_ent {
 			u64			addr;
 		} tlbi;
 
+		#define CMDQ_OP_ATC_INV		0x40
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
@@ -662,6 +688,8 @@ struct arm_smmu_group {
 
 	struct list_head		devices;
 	spinlock_t			devices_lock;
+
+	bool				ats_enabled;
 };
 
 struct arm_smmu_option_prop {
@@ -839,6 +867,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
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
@@ -874,6 +910,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
 		[CMDQ_ERR_CERROR_ILL_IDX]	= "Illegal command",
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
+		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
 
 	int i;
@@ -893,6 +930,13 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		dev_err(smmu->dev, "retrying command fetch\n");
 	case CMDQ_ERR_CERROR_NONE_IDX:
 		return;
+	case CMDQ_ERR_CERROR_ATC_INV_IDX:
+		/*
+		 * CMD_SYNC failed because of ATC Invalidation completion
+		 * timeout. CONS is still pointing at the CMD_SYNC. Ensure other
+		 * operations complete by re-submitting the CMD_SYNC, cowardly
+		 * ignoring the ATC error.
+		 */
 	case CMDQ_ERR_CERROR_ILL_IDX:
 		/* Fallthrough */
 	default:
@@ -1084,9 +1128,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1COR_SHIFT |
 			 STRTAB_STE_1_S1C_SH_ISH << STRTAB_STE_1_S1CSH_SHIFT |
-#ifdef CONFIG_PCI_ATS
-			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
-#endif
 			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
@@ -1115,6 +1156,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		val |= STRTAB_STE_0_CFG_S2_TRANS;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_ATS) && !ste_live)
+		dst[1] |= cpu_to_le64(STRTAB_STE_1_EATS_TRANS
+				      << STRTAB_STE_1_EATS_SHIFT);
+
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 	dst[0] = cpu_to_le64(val);
 	arm_smmu_sync_ste_for_sid(smmu, sid);
@@ -1377,6 +1422,120 @@ static const struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_sync	= arm_smmu_tlb_sync,
 };
 
+static void arm_smmu_atc_invalidate_to_cmd(struct arm_smmu_device *smmu,
+					   unsigned long iova, size_t size,
+					   struct arm_smmu_cmdq_ent *cmd)
+{
+	size_t log2_span;
+	size_t span_mask;
+	size_t smmu_grain;
+	/* ATC invalidates are always on 4096 bytes pages */
+	size_t inval_grain_shift = 12;
+	unsigned long iova_start, iova_end;
+	unsigned long page_start, page_end;
+
+	smmu_grain	= 1ULL << __ffs(smmu->pgsize_bitmap);
+
+	/* In case parameters are not aligned on PAGE_SIZE */
+	iova_start	= round_down(iova, smmu_grain);
+	iova_end	= round_up(iova + size, smmu_grain) - 1;
+
+	page_start	= iova_start >> inval_grain_shift;
+	page_end	= iova_end >> inval_grain_shift;
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
+	*cmd = (struct arm_smmu_cmdq_ent) {
+		.opcode	= CMDQ_OP_ATC_INV,
+		.atc	= {
+			.addr = page_start << inval_grain_shift,
+			.size = log2_span,
+		}
+	};
+}
+
+static int arm_smmu_atc_invalidate_master(struct arm_smmu_master_data *master,
+					  struct arm_smmu_cmdq_ent *cmd)
+{
+	int i;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+	struct pci_dev *pdev = to_pci_dev(master->dev);
+
+	if (!pdev->ats_enabled)
+		return 0;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		cmd->atc.sid = fwspec->ids[i];
+
+		dev_dbg(master->smmu->dev,
+			"ATC invalidate %#x:%#x:%#llx-%#llx, esz=%d\n",
+			cmd->atc.sid, cmd->atc.ssid, cmd->atc.addr,
+			cmd->atc.addr + (1 << (cmd->atc.size + 12)) - 1,
+			cmd->atc.size);
+
+		arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
+	}
+
+	return 0;
+}
+
+static size_t arm_smmu_atc_invalidate_domain(struct arm_smmu_domain *smmu_domain,
+					     unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	struct arm_smmu_cmdq_ent cmd = {0};
+	struct arm_smmu_group *smmu_group;
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent sync_cmd = {
+		.opcode = CMDQ_OP_CMD_SYNC,
+	};
+
+	spin_lock_irqsave(&smmu_domain->groups_lock, flags);
+
+	list_for_each_entry(smmu_group, &smmu_domain->groups, domain_head) {
+		if (!smmu_group->ats_enabled)
+			continue;
+
+		/* Initialise command lazily */
+		if (!cmd.opcode)
+			arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
+
+		spin_lock(&smmu_group->devices_lock);
+
+		list_for_each_entry(master, &smmu_group->devices, group_head)
+			arm_smmu_atc_invalidate_master(master, &cmd);
+
+		/*
+		 * TODO: ensure we do a sync whenever we have sent ats_queue_depth
+		 * invalidations to the same device.
+		 */
+		arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
+
+		spin_unlock(&smmu_group->devices_lock);
+	}
+
+	spin_unlock_irqrestore(&smmu_domain->groups_lock, flags);
+
+	return size;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)
 {
@@ -1782,7 +1941,10 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 
 	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
 	ret = ops->unmap(ops, iova, size);
+	if (ret)
+		ret = arm_smmu_atc_invalidate_domain(smmu_domain, iova, size);
 	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
+
 	return ret;
 }
 
@@ -1830,11 +1992,63 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+/*
+ * Returns -ENOSYS if ATS is not supported either by the device or by the SMMU
+ */
+static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
+{
+	int ret;
+	size_t stu;
+	struct pci_dev *pdev;
+	struct arm_smmu_device *smmu = master->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+#ifdef CONFIG_PCI_ATS
+	if (!pdev->ats_cap)
+		return -ENOSYS;
+#else
+	return -ENOSYS;
+#endif
+
+	/* Smallest Translation Unit: log2 of the smallest supported granule */
+	stu = __ffs(smmu->pgsize_bitmap);
+
+	ret = pci_enable_ats(pdev, stu);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable ATS: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "enabled ATS with STU = %zu\n", stu);
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
 {
 	int i, ret;
+	bool ats_enabled;
 	unsigned long flags;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_group *smmu_group;
@@ -1880,19 +2094,31 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	ats_enabled = !arm_smmu_enable_ats(master);
+
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
-		smmu_group = to_smmu_group(group);
+	if (IS_ERR(group)) {
+		ret = PTR_ERR(group);
+		goto err_disable_ats;
+	}
 
-		spin_lock_irqsave(&smmu_group->devices_lock, flags);
-		list_add(&master->group_head, &smmu_group->devices);
-		spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
+	smmu_group = to_smmu_group(group);
 
-		iommu_group_put(group);
-		iommu_device_link(&smmu->iommu, dev);
-	}
+	smmu_group->ats_enabled |= ats_enabled;
 
-	return PTR_ERR_OR_ZERO(group);
+	spin_lock_irqsave(&smmu_group->devices_lock, flags);
+	list_add(&master->group_head, &smmu_group->devices);
+	spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
+
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
@@ -1921,6 +2147,8 @@ static void arm_smmu_remove_device(struct device *dev)
 		spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
 
 		iommu_group_put(group);
+
+		arm_smmu_disable_ats(master);
 	}
 
 	iommu_group_remove_device(dev);
@@ -2485,6 +2713,16 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
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
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
