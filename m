Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9853612D8;
	Fri, 26 Jun 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490521; cv=none; b=A/ETWk9DR91gzbdGytdw5qUdDxP60MdD1yYSTi78hUfwt4zn+C8U7J65vysw9o7wKzqcdHhrg65cJmMtxZOo4hJqXYJvfe89WFA+oa/s1aLVs6STnkXvkb3MPkIZAvJPDxaHd8QkxpY28KlptkD+KwwyZ5MkFgAIGHMUj0dPWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490521; c=relaxed/simple;
	bh=x1pZG/Gj42lOLXnmttonXXa2JSMsqRCTY2KmksX0HQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GU8Iw6L4yJf7Rp802f0mgG0VMBWp052jFTsKGGOUoFOv0280zYUMDWcJZ2TQtmcVZtFDK7y2XxVYYc46pJypHsQl4X5Y9EpIIrWMayB2pVpV6du5cOUoMH6OtlHNnpYzJHejJyt9AxauPyQlQNdEhJDD6zcSragFIvsgU/vEoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eRK/J+KY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eRK/J+KY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4936A1F37;
	Fri, 26 Jun 2026 09:15:14 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC793F905;
	Fri, 26 Jun 2026 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782490518; bh=x1pZG/Gj42lOLXnmttonXXa2JSMsqRCTY2KmksX0HQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eRK/J+KYf7DjADjIUXwQEubt1nCizCaOY2eJ8PmY/58KATn8ZkhCYGfu0BFdW1ryr
	 Lvi5GVIbuA65ERwq3LxT7PC01/3KTVY6fG4iysSn/KN9zjm/PgdP4jcMGNlqVvl02f
	 WsdIF967MSv63AMJVtIV7bYvAGlax9tCXlPPstF0=
Message-ID: <b5085e09-6533-4f88-938d-8d46751cf7da@arm.com>
Date: Fri, 26 Jun 2026 17:15:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: joro@8bytes.org, bhelgaas@google.com, praan@google.com,
 kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
 baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, skaestle@nvidia.com, mmarrid@nvidia.com,
 skolothumtho@nvidia.com, bbiber@nvidia.com
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <6c713c724fa09bf5a1b5e2247c633e516036f079.1779944354.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <6c713c724fa09bf5a1b5e2247c633e516036f079.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2026 8:59 am, Nicolin Chen wrote:
> From: Malak Marrid <mmarrid@nvidia.com>
> 
> To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
> must issue a CMDQ_OP_PRI_RESP back to the SMMU.
> 
> However, either a stall event in the EVTQ or a PRI request in the PRIQ can
> surface to the IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ,
> and a single master can in principle be both stall-capable and PRI-capable

No, the SMMU architecture does all it can to specifically forbid this, 
see 3.12.1 and 16.4, it just can't be made architecturally ILLEGAL to 
enable stalls for PCIe devices because there's no strict architectural 
definition for what "a PCIe device" actually is. Similarly with the note 
in the definition of STE.EATS about the relationship with CD.S - the 
unwritten implication is that defining specific behaviours would only 
create an unreasonable burden for hardware validation, for the sake of 
something that nobody in their right mind should ever do anyway.

The expectation is that RCiEPs which do speak stallable non-PCIe bus 
protocols will not go to the effort of implementing ATS/PRI capabilities 
(not least because there's every chance that such protocols simply 
doesn't have that kind of transaction flow anyway). And conversely that 
it can be considered an egregious firmware (or system design) error to 
even claim (let alone force) stall capability for a real PCIe root port 
which may be deadlocked by blocking its requirement for free-flowing 
writes. Thus I think we could go so far as to refuse to handle any 
endpoint which did somehow claim both.

Thanks,
Robin.

> (e.g. FEAT_STALL_FORCE on a PCIe device with PRI), so master state is not a
> reliable discriminator.
> 
> Add IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS to the generic flags so the fault
> reporter can mark a page request that is holding the device's transaction:
>      arm_smmu_handle_event() sets it on STALL events
>      arm_smmu_handle_ppr() leaves it clear for PRI events
> 
> Note: streams[0].id remains the RID because arm_smmu_enable_iopf() rejects
> num_streams != 1.
> 
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>   include/linux/iommu.h                       |  1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 +++++++++++++++------
>   3 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 2bb810e4d5fce..1083621705f16 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1007,6 +1007,7 @@ struct arm_smmu_master {
>   	/* Locked by the iommu core using the group mutex */
>   	struct arm_smmu_ctx_desc_cfg	cd_table;
>   	unsigned int			num_streams;
> +	bool				pri_enabled : 1;
>   	bool				ats_enabled : 1;
>   	bool				ste_ats_enabled : 1;
>   	bool				stall_enabled;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e587d4ac4d331..83c4dfcf20637 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -76,6 +76,7 @@ struct iommu_fault_page_request {
>   #define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
>   #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
>   #define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 2)
> +#define IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS	(1 << 3)
>   	u32	flags;
>   	u32	pasid;
>   	u32	grpid;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ffc9621cd2288..061f1d46fda0d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -921,32 +921,68 @@ static int arm_smmu_drain_queue_for_iopf(struct arm_smmu_device *smmu,
>   	return ret;
>   }
>   
> -static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
> +static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
>   				   struct iommu_page_response *resp)
>   {
>   	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	u8 resume_resp;
> +	struct arm_smmu_cmd cmd;
> +	int sid;
>   
> -	if (WARN_ON(!master->stall_enabled))
> +	if (WARN_ON_ONCE(evt->fault.type != IOMMU_FAULT_PAGE_REQ))
>   		return;
>   
> -	switch (resp->code) {
> -	case IOMMU_PAGE_RESP_INVALID:
> -	case IOMMU_PAGE_RESP_FAILURE:
> -		resume_resp = CMDQ_RESUME_0_RESP_ABORT;
> -		break;
> -	case IOMMU_PAGE_RESP_SUCCESS:
> -		resume_resp = CMDQ_RESUME_0_RESP_RETRY;
> -		break;
> -	default:
> -		resume_resp = CMDQ_RESUME_0_RESP_TERM;
> -		break;
> +	/* IOPF is gated to num_streams == 1 in arm_smmu_enable_iopf() */
> +	sid = master->streams[0].id;
> +
> +	if (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS) {
> +		u8 resume_resp;
> +
> +		if (WARN_ON_ONCE(!master->stall_enabled))
> +			return;
> +		switch (resp->code) {
> +		case IOMMU_PAGE_RESP_INVALID:
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			resume_resp = CMDQ_RESUME_0_RESP_ABORT;
> +			break;
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			resume_resp = CMDQ_RESUME_0_RESP_RETRY;
> +			break;
> +		default:
> +			resume_resp = CMDQ_RESUME_0_RESP_TERM;
> +			break;
> +		}
> +		cmd = arm_smmu_make_cmd_resume(sid, resp->grpid, resume_resp);
> +	} else {
> +		enum pri_resp pri_resp;
> +		bool ssv;
> +
> +		if (WARN_ON_ONCE(!master->pri_enabled))
> +			return;
> +		/* PCIe allows only one PRG Response per group */
> +		if (!(evt->fault.prm.flags &
> +		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> +			return;
> +		switch (resp->code) {
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			pri_resp = PRI_RESP_SUCC;
> +			break;
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			pri_resp = PRI_RESP_FAIL;
> +			break;
> +		case IOMMU_PAGE_RESP_INVALID:
> +			pri_resp = PRI_RESP_DENY;
> +			break;
> +		default:
> +			WARN_ON(true);
> +			return;
> +		}
> +		ssv = !!(evt->fault.prm.flags &
> +			 IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);
> +		cmd = arm_smmu_make_cmd_pri_resp(sid, resp->pasid, ssv,
> +						 resp->grpid, pri_resp);
>   	}
>   
> -	arm_smmu_cmdq_issue_cmd(master->smmu,
> -				arm_smmu_make_cmd_resume(master->streams[0].id,
> -							 resp->grpid,
> -							 resume_resp));
> +	arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
>   	/*
>   	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
>   	 * RESUME consumption guarantees that the stalled transaction will be
> @@ -2081,7 +2117,8 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
>   
>   		flt->type = IOMMU_FAULT_PAGE_REQ;
>   		flt->prm = (struct iommu_fault_page_request){
> -			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE |
> +				 IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS,
>   			.grpid = event->stag,
>   			.perm = perm,
>   			.addr = event->iova,

