Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944FFC282DD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7A02064B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 18:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfDQS2d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:28:33 -0400
Received: from foss.arm.com ([217.140.101.70]:49894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDQS2d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 14:28:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC08169E;
        Wed, 17 Apr 2019 11:28:32 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2AC323F59C;
        Wed, 17 Apr 2019 11:28:30 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 8/9] iommu/arm-smmu-v3: Add support for PCI ATS
Date:   Wed, 17 Apr 2019 19:24:47 +0100
Message-Id: <20190417182448.12382-9-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe devices can implement their own TLB, named Address Translation Cache
(ATC). Enable Address Translation Service (ATS) for devices that support
it and send them invalidation requests whenever we invalidate the IOTLBs.

ATC invalidation is allowed to take up to 90 seconds, according to the
PCIe spec, so it is possible to get a SMMU command queue timeout during
normal operations. However we expect implementations to complete
invalidation in reasonable time.

We only enable ATS for "trusted" devices, and currently rely on the
pci_dev->untrusted bit. For ATS we have to trust that:

(a) The device doesn't issue "translated" memory requests for addresses
    that weren't returned by the SMMU in a Translation Completion. In
    particular, if we give control of a device or device partition to a VM
    or userspace, software cannot program the device to access arbitrary
    "translated" addresses.

(b) The device follows permissions granted by the SMMU in a Translation
    Completion. If the device requested read+write permission and only
    got read, then it doesn't write.

(c) The device doesn't send Translated transactions for an address that
    was invalidated by an ATC invalidation.

Note that the PCIe specification explicitly requires all of these, so we
can assume that implementations will cleanly shield ATCs from software.

All ATS translated requests still go through the SMMU, to walk the stream
table and check that the device is actually allowed to send translated
requests.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 201 ++++++++++++++++++++++++++++++++++--
 1 file changed, 195 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3e7198ee9530..3bde137a3755 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -29,6 +29,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 
 #include <linux/amba/bus.h>
@@ -86,6 +87,7 @@
 #define IDR5_VAX_52_BIT			1
 
 #define ARM_SMMU_CR0			0x20
+#define CR0_ATSCHK			(1 << 4)
 #define CR0_CMDQEN			(1 << 3)
 #define CR0_EVTQEN			(1 << 2)
 #define CR0_PRIQEN			(1 << 1)
@@ -294,6 +296,7 @@
 #define CMDQ_ERR_CERROR_NONE_IDX	0
 #define CMDQ_ERR_CERROR_ILL_IDX		1
 #define CMDQ_ERR_CERROR_ABT_IDX		2
+#define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_0_OP			GENMASK_ULL(7, 0)
 #define CMDQ_0_SSV			(1UL << 11)
@@ -312,6 +315,12 @@
 #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
 #define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
 
+#define CMDQ_ATC_0_SSID			GENMASK_ULL(31, 12)
+#define CMDQ_ATC_0_SID			GENMASK_ULL(63, 32)
+#define CMDQ_ATC_0_GLOBAL		(1UL << 9)
+#define CMDQ_ATC_1_SIZE			GENMASK_ULL(5, 0)
+#define CMDQ_ATC_1_ADDR_MASK		GENMASK_ULL(63, 12)
+
 #define CMDQ_PRI_0_SSID			GENMASK_ULL(31, 12)
 #define CMDQ_PRI_0_SID			GENMASK_ULL(63, 32)
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
@@ -433,6 +442,16 @@ struct arm_smmu_cmdq_ent {
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
@@ -580,10 +599,12 @@ struct arm_smmu_device {
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
+	struct device			*dev;
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	u32				*sids;
 	unsigned int			num_sids;
+	bool				ats_enabled		:1;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -813,6 +834,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_S12_VMALL:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		break;
+	case CMDQ_OP_ATC_INV:
+		cmd[0] |= FIELD_PREP(CMDQ_0_SSV, ent->substream_valid);
+		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_GLOBAL, ent->atc.global);
+		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_SSID, ent->atc.ssid);
+		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_SID, ent->atc.sid);
+		cmd[1] |= FIELD_PREP(CMDQ_ATC_1_SIZE, ent->atc.size);
+		cmd[1] |= ent->atc.addr & CMDQ_ATC_1_ADDR_MASK;
+		break;
 	case CMDQ_OP_PRI_RESP:
 		cmd[0] |= FIELD_PREP(CMDQ_0_SSV, ent->substream_valid);
 		cmd[0] |= FIELD_PREP(CMDQ_PRI_0_SSID, ent->pri.ssid);
@@ -857,6 +886,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
 		[CMDQ_ERR_CERROR_ILL_IDX]	= "Illegal command",
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
+		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
 
 	int i;
@@ -876,6 +906,14 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
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
@@ -992,7 +1030,7 @@ static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
 	int ret;
 	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
@@ -1002,6 +1040,7 @@ static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 		  : __arm_smmu_cmdq_issue_sync(smmu);
 	if (ret)
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
+	return ret;
 }
 
 /* Context descriptor manipulation functions */
@@ -1174,9 +1213,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
-#ifdef CONFIG_PCI_ATS
-			 FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS) |
-#endif
 			 FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_NSEL1));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
@@ -1203,6 +1239,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
 	}
 
+	if (master->ats_enabled)
+		dst[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
+						 STRTAB_STE_1_EATS_TRANS));
+
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 	dst[0] = cpu_to_le64(val);
 	arm_smmu_sync_ste_for_sid(smmu, sid);
@@ -1405,6 +1445,96 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 	return IRQ_WAKE_THREAD;
 }
 
+static void
+arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+			struct arm_smmu_cmdq_ent *cmd)
+{
+	size_t log2_span;
+	size_t span_mask;
+	/* ATC invalidates are always on 4096-bytes pages */
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
+	 * In an ATS Invalidate Request, the address must be aligned on the
+	 * range size, which must be a power of two number of page sizes. We
+	 * thus have to choose between grossly over-invalidating the region, or
+	 * splitting the invalidation into multiple commands. For simplicity
+	 * we'll go with the first solution, but should refine it in the future
+	 * if multiple commands are shown to be more efficient.
+	 *
+	 * Find the smallest power of two that covers the range. The most
+	 * significant differing bit between the start and end addresses,
+	 * fls(start ^ end), indicates the required span. For example:
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
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
+				   struct arm_smmu_cmdq_ent *cmd)
+{
+	int i;
+
+	if (!master->ats_enabled)
+		return 0;
+
+	for (i = 0; i < master->num_sids; i++) {
+		cmd->atc.sid = master->sids[i];
+		arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
+	}
+
+	return arm_smmu_cmdq_issue_sync(master->smmu);
+}
+
+static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+				   int ssid, unsigned long iova, size_t size)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_master *master;
+
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
+		return 0;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		ret |= arm_smmu_atc_inv_master(master, &cmd);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+	return ret ? -ETIMEDOUT : 0;
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_sync(void *cookie)
 {
@@ -1726,6 +1856,42 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	}
 }
 
+static int arm_smmu_enable_ats(struct arm_smmu_master *master)
+{
+	int ret;
+	size_t stu;
+	struct pci_dev *pdev;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
+	    !(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS) || pci_ats_disabled())
+		return -ENXIO;
+
+	pdev = to_pci_dev(master->dev);
+	if (pdev->untrusted)
+		return -EPERM;
+
+	/* Smallest Translation Unit: log2 of the smallest supported granule */
+	stu = __ffs(smmu->pgsize_bitmap);
+
+	ret = pci_enable_ats(pdev, stu);
+	if (ret)
+		return ret;
+
+	master->ats_enabled = true;
+	return 0;
+}
+
+static void arm_smmu_disable_ats(struct arm_smmu_master *master)
+{
+	if (!master->ats_enabled || !dev_is_pci(master->dev))
+		return;
+
+	pci_disable_ats(to_pci_dev(master->dev));
+	master->ats_enabled = false;
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -1740,6 +1906,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
+
+	/* Disabling ATS invalidates all ATC entries */
+	arm_smmu_disable_ats(master);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1783,6 +1952,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
+		arm_smmu_enable_ats(master);
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		arm_smmu_write_ctx_desc(smmu, &smmu_domain->s1_cfg);
 
@@ -1806,12 +1978,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t
 arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
-	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	int ret;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova, size);
+	ret = ops->unmap(ops, iova, size);
+	if (ret && arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size))
+		return 0;
+
+	return ret;
 }
 
 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
@@ -1898,6 +2076,7 @@ static int arm_smmu_add_device(struct device *dev)
 		if (!master)
 			return -ENOMEM;
 
+		master->dev = dev;
 		master->smmu = smmu;
 		master->sids = fwspec->ids;
 		master->num_sids = fwspec->num_ids;
@@ -2564,6 +2743,16 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
+	if (smmu->features & ARM_SMMU_FEAT_ATS) {
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
2.21.0

