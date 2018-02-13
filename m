Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 29/37] iommu/arm-smmu-v3: Add stall support for platform
 devices
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-30-jean-philippe.brucker@arm.com>
From: Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <5A824359.1080005@huawei.com>
Date: Tue, 13 Feb 2018 09:46:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-30-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 catalin.marinas@arm.com, jonathan.cameron@huawei.com, will.deacon@arm.com,
 okaya@codeaurora.org, liguozhu <liguozhu@hisilicon.com>, yi.l.liu@intel.com,
 lorenzo.pieralisi@arm.com, ashok.raj@intel.com, tn@semihalf.com,
 joro@8bytes.org, bharatku@xilinx.com, rfranz@cavium.com, lenb@kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 rjw@rjwysocki.net, jcrouse@codeaurora.org, robdclark@gmail.com,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 2018/2/13 2:33, Jean-Philippe Brucker wrote:
> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCI PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked and
> the OS is given a chance to fix the page tables and retry the transaction.
>
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler. If
> the fault is recoverable, it will call us back to terminate or continue
> the stall.
>
> Note that this patch tweaks the iommu_fault_event and page_response_msg to
> extend the fault id field. Stall uses 16 bits of IDs whereas PCI PRI only
> uses 9.
For PCIe devices without ATC,  can they use this Stall model?

Thanks.

Xu Zaibo
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 175 +++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/iommu.h       |   4 +-
>   2 files changed, 173 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2430b2140f8d..8b9f5dd06be0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -338,6 +338,15 @@
>   #define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
>   #define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
>   
> +#define CMDQ_RESUME_0_SID_SHIFT		32
> +#define CMDQ_RESUME_0_SID_MASK		0xffffffffUL
> +#define CMDQ_RESUME_0_ACTION_SHIFT	12
> +#define CMDQ_RESUME_0_ACTION_TERM	(0UL << CMDQ_RESUME_0_ACTION_SHIFT)
> +#define CMDQ_RESUME_0_ACTION_RETRY	(1UL << CMDQ_RESUME_0_ACTION_SHIFT)
> +#define CMDQ_RESUME_0_ACTION_ABORT	(2UL << CMDQ_RESUME_0_ACTION_SHIFT)
> +#define CMDQ_RESUME_1_STAG_SHIFT	0
> +#define CMDQ_RESUME_1_STAG_MASK		0xffffUL
> +
>   #define CMDQ_SYNC_0_CS_SHIFT		12
>   #define CMDQ_SYNC_0_CS_NONE		(0UL << CMDQ_SYNC_0_CS_SHIFT)
>   #define CMDQ_SYNC_0_CS_IRQ		(1UL << CMDQ_SYNC_0_CS_SHIFT)
> @@ -358,6 +367,31 @@
>   #define EVTQ_0_ID_SHIFT			0
>   #define EVTQ_0_ID_MASK			0xffUL
>   
> +#define EVT_ID_TRANSLATION_FAULT	0x10
> +#define EVT_ID_ADDR_SIZE_FAULT		0x11
> +#define EVT_ID_ACCESS_FAULT		0x12
> +#define EVT_ID_PERMISSION_FAULT		0x13
> +
> +#define EVTQ_0_SSV			(1UL << 11)
> +#define EVTQ_0_SSID_SHIFT		12
> +#define EVTQ_0_SSID_MASK		0xfffffUL
> +#define EVTQ_0_SID_SHIFT		32
> +#define EVTQ_0_SID_MASK			0xffffffffUL
> +#define EVTQ_1_STAG_SHIFT		0
> +#define EVTQ_1_STAG_MASK		0xffffUL
> +#define EVTQ_1_STALL			(1UL << 31)
> +#define EVTQ_1_PRIV			(1UL << 33)
> +#define EVTQ_1_EXEC			(1UL << 34)
> +#define EVTQ_1_READ			(1UL << 35)
> +#define EVTQ_1_S2			(1UL << 39)
> +#define EVTQ_1_CLASS_SHIFT		40
> +#define EVTQ_1_CLASS_MASK		0x3UL
> +#define EVTQ_1_TT_READ			(1UL << 44)
> +#define EVTQ_2_ADDR_SHIFT		0
> +#define EVTQ_2_ADDR_MASK		0xffffffffffffffffUL
> +#define EVTQ_3_IPA_SHIFT		12
> +#define EVTQ_3_IPA_MASK			0xffffffffffUL
> +
>   /* PRI queue */
>   #define PRIQ_ENT_DWORDS			2
>   #define PRIQ_MAX_SZ_SHIFT		8
> @@ -472,6 +506,13 @@ struct arm_smmu_cmdq_ent {
>   			enum pri_resp		resp;
>   		} pri;
>   
> +		#define CMDQ_OP_RESUME		0x44
> +		struct {
> +			u32			sid;
> +			u16			stag;
> +			enum page_response_code	resp;
> +		} resume;
> +
>   		#define CMDQ_OP_CMD_SYNC	0x46
>   		struct {
>   			u32			msidata;
> @@ -545,6 +586,8 @@ struct arm_smmu_strtab_ent {
>   	bool				assigned;
>   	struct arm_smmu_s1_cfg		*s1_cfg;
>   	struct arm_smmu_s2_cfg		*s2_cfg;
> +
> +	bool				can_stall;
>   };
>   
>   struct arm_smmu_strtab_cfg {
> @@ -904,6 +947,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   			return -EINVAL;
>   		}
>   		break;
> +	case CMDQ_OP_RESUME:
> +		cmd[0] |= (u64)ent->resume.sid << CMDQ_RESUME_0_SID_SHIFT;
> +		cmd[1] |= ent->resume.stag << CMDQ_RESUME_1_STAG_SHIFT;
> +		switch (ent->resume.resp) {
> +		case IOMMU_PAGE_RESP_INVALID:
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			cmd[0] |= CMDQ_RESUME_0_ACTION_ABORT;
> +			break;
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			cmd[0] |= CMDQ_RESUME_0_ACTION_RETRY;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
>   	case CMDQ_OP_CMD_SYNC:
>   		if (ent->sync.msiaddr)
>   			cmd[0] |= CMDQ_SYNC_0_CS_IRQ;
> @@ -1065,6 +1123,35 @@ static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>   		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
>   }
>   
> +static int arm_smmu_page_response(struct iommu_domain *domain,
> +				  struct device *dev,
> +				  struct page_response_msg *resp)
> +{
> +	int sid = dev->iommu_fwspec->ids[0];
> +	struct arm_smmu_cmdq_ent cmd = {0};
> +	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
> +
> +	if (master->ste.can_stall) {
> +		cmd.opcode		= CMDQ_OP_RESUME;
> +		cmd.resume.sid		= sid;
> +		cmd.resume.stag		= resp->page_req_group_id;
> +		cmd.resume.resp		= resp->resp_code;
> +	} else {
> +		/* TODO: put PRI response here */
> +		return -EINVAL;
> +	}
> +
> +	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> +	/*
> +	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
> +	 * RESUME consumption guarantees that the stalled transaction will be
> +	 * terminated... at some point in the future. PRI_RESP is fire and
> +	 * forget.
> +	 */
> +
> +	return 0;
> +}
> +
>   /* Stream table manipulation functions */
>   static void
>   arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
> @@ -1182,7 +1269,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>   			 STRTAB_STE_1_STRW_SHIFT);
>   
>   		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
> -		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
> +		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE) &&
> +		   !ste->can_stall)
>   			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>   
>   		val |= (cfg->base & STRTAB_STE_0_S1CTXPTR_MASK
> @@ -1285,10 +1373,73 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>   	return master;
>   }
>   
> +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> +{
> +	struct arm_smmu_master_data *master;
> +	u8 type = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
> +	u32 sid = evt[0] >> EVTQ_0_SID_SHIFT & EVTQ_0_SID_MASK;
> +
> +	struct iommu_fault_event fault = {
> +		.page_req_group_id = evt[1] >> EVTQ_1_STAG_SHIFT & EVTQ_1_STAG_MASK,
> +		.addr		= evt[2] >> EVTQ_2_ADDR_SHIFT & EVTQ_2_ADDR_MASK,
> +		.last_req	= true,
> +	};
> +
> +	switch (type) {
> +	case EVT_ID_TRANSLATION_FAULT:
> +	case EVT_ID_ADDR_SIZE_FAULT:
> +	case EVT_ID_ACCESS_FAULT:
> +		fault.reason = IOMMU_FAULT_REASON_PTE_FETCH;
> +		break;
> +	case EVT_ID_PERMISSION_FAULT:
> +		fault.reason = IOMMU_FAULT_REASON_PERMISSION;
> +		break;
> +	default:
> +		/* TODO: report other unrecoverable faults. */
> +		return -EFAULT;
> +	}
> +
> +	/* Stage-2 is always pinned at the moment */
> +	if (evt[1] & EVTQ_1_S2)
> +		return -EFAULT;
> +
> +	master = arm_smmu_find_master(smmu, sid);
> +	if (!master)
> +		return -EINVAL;
> +
> +	/*
> +	 * The domain is valid until the fault returns, because detach() flushes
> +	 * the fault queue.
> +	 */
> +	if (evt[1] & EVTQ_1_STALL)
> +		fault.type = IOMMU_FAULT_PAGE_REQ;
> +	else
> +		fault.type = IOMMU_FAULT_DMA_UNRECOV;
> +
> +	if (evt[1] & EVTQ_1_READ)
> +		fault.prot |= IOMMU_FAULT_READ;
> +	else
> +		fault.prot |= IOMMU_FAULT_WRITE;
> +
> +	if (evt[1] & EVTQ_1_EXEC)
> +		fault.prot |= IOMMU_FAULT_EXEC;
> +
> +	if (evt[1] & EVTQ_1_PRIV)
> +		fault.prot |= IOMMU_FAULT_PRIV;
> +
> +	if (evt[0] & EVTQ_0_SSV) {
> +		fault.pasid_valid = true;
> +		fault.pasid = evt[0] >> EVTQ_0_SSID_SHIFT & EVTQ_0_SSID_MASK;
> +	}
> +
> +	/* Report to device driver or populate the page tables */
> +	return iommu_report_device_fault(master->dev, &fault);
> +}
> +
>   /* IRQ and event handlers */
>   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>   {
> -	int i;
> +	int i, ret;
>   	int num_handled = 0;
>   	struct arm_smmu_device *smmu = dev;
>   	struct arm_smmu_queue *q = &smmu->evtq.q;
> @@ -1300,12 +1451,19 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>   		while (!queue_remove_raw(q, evt)) {
>   			u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
>   
> +			spin_unlock(&q->wq.lock);
> +			ret = arm_smmu_handle_evt(smmu, evt);
> +			spin_lock(&q->wq.lock);
> +
>   			if (++num_handled == queue_size) {
>   				q->batch++;
>   				wake_up_locked(&q->wq);
>   				num_handled = 0;
>   			}
>   
> +			if (!ret)
> +				continue;
> +
>   			dev_info(smmu->dev, "event 0x%02x received:\n", id);
>   			for (i = 0; i < ARRAY_SIZE(evt); ++i)
>   				dev_info(smmu->dev, "\t0x%016llx\n",
> @@ -1442,7 +1600,9 @@ static int arm_smmu_flush_queues(struct notifier_block *nb,
>   		master = dev->iommu_fwspec->iommu_priv;
>   
>   	if (master) {
> -		/* TODO: add support for PRI and Stall */
> +		if (master->ste.can_stall)
> +			arm_smmu_flush_queue(smmu, &smmu->evtq.q, "evtq");
> +		/* TODO: add support for PRI */
>   		return 0;
>   	}
>   
> @@ -1756,7 +1916,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>   		.order			= master->ssid_bits,
>   		.sync			= &arm_smmu_ctx_sync,
>   		.arm_smmu = {
> -			.stall		= !!(smmu->features & ARM_SMMU_FEAT_STALL_FORCE),
> +			.stall		= !!(smmu->features & ARM_SMMU_FEAT_STALL_FORCE) ||
> +					  master->ste.can_stall,
>   			.asid_bits	= smmu->asid_bits,
>   			.hw_access	= !!(smmu->features & ARM_SMMU_FEAT_HA),
>   			.hw_dirty	= !!(smmu->features & ARM_SMMU_FEAT_HD),
> @@ -2296,6 +2457,11 @@ static int arm_smmu_add_device(struct device *dev)
>   
>   	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
>   
> +	if (fwspec->can_stall && smmu->features & ARM_SMMU_FEAT_STALLS) {
> +		master->can_fault = true;
> +		master->ste.can_stall = true;
> +	}
> +
>   	group = iommu_group_get_for_dev(dev);
>   	if (!IS_ERR(group)) {
>   		arm_smmu_insert_master(smmu, master);
> @@ -2435,6 +2601,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.mm_attach		= arm_smmu_mm_attach,
>   	.mm_detach		= arm_smmu_mm_detach,
>   	.mm_invalidate		= arm_smmu_mm_invalidate,
> +	.page_response		= arm_smmu_page_response,
>   	.map			= arm_smmu_map,
>   	.unmap			= arm_smmu_unmap,
>   	.map_sg			= default_iommu_map_sg,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 37c3b9d087ce..f5c2f4be2b42 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,7 +227,7 @@ struct page_response_msg {
>   	u32 pasid;
>   	enum page_response_code resp_code;
>   	u32 pasid_present:1;
> -	u32 page_req_group_id : 9;
> +	u32 page_req_group_id;
>   	enum page_response_type type;
>   	u32 private_data;
>   };
> @@ -421,7 +421,7 @@ struct iommu_fault_event {
>   	enum iommu_fault_reason reason;
>   	u64 addr;
>   	u32 pasid;
> -	u32 page_req_group_id : 9;
> +	u32 page_req_group_id;
>   	u32 last_req : 1;
>   	u32 pasid_valid : 1;
>   	u32 prot;



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
