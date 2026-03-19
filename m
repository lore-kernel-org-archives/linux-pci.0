Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D412236F0;
	Thu, 19 Mar 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889008; cv=none; b=a9WmUCcqM5n6QQ3b7NTzhin6Q5EA7RCsxrM38bAArOcT95jRfQ/lUTnq0pFCBTTfhw43sxv2Y1Q6lcJz/6qqFvA03OdE41+U4DRFidEah1PGB9NzTVeuNXgl8u8bWIiqgVAVroj1OUTH/jaU23eEKlmvi+DXHBAaWUDakrUi7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889008; c=relaxed/simple;
	bh=ekgg94jge4t3T6LNQQw0IlTcM8gZqdOJGmNhqs4bero=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yzf4E8FgT49La/kRcBy57gQCWIWm9fwQo3bIgxiEYAatDB1r7enj4MznhOr0krkv7iy3WRRpiDEtZLT5M1GGTCUEHm80AmJTYEoMicQFAOYuewoM9Y44oBis18kKAtyT1yJrVC2Qc8D7uLZ5j0noulUglwvTj3qnx70Jemx7aMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k5p8a+AI; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k5p8a+AI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773888996; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OSY4j6v6Vry0f0VpWhFzrjV5u9/NqNAQFRbrmOpCuHY=;
	b=k5p8a+AIJg2jLKxMnUu5xyftUmg9Ph5JxKKJxM7MjqA/sIp15Djp/w7grPjP7nSuY4mqmGzDibX8wOZT2mJSzKyE0Y2sba3iPuc9egu7M8EmNdnPbLIYbDxsVo4X3EiOzhDGG4p6/pn8VbAP7yf8yZFJmXZxvE60GtW9JCM0Y/o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.Gp621_1773888993;
Received: from 30.246.163.250(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.Gp621_1773888993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 10:56:34 +0800
Message-ID: <eeee122f-54e2-4fe9-82a6-724c3f80a499@linux.alibaba.com>
Date: Thu, 19 Mar 2026 10:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] iommu/arm-smmu-v3: Block ATS upon an ATC
 invalidation timeout
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: rafael@kernel.org, lenb@kernel.org, praan@google.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <7e21e14faddeb0e3af692356f4fefbae2dfbebda.1773774441.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <7e21e14faddeb0e3af692356f4fefbae2dfbebda.1773774441.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/26 3:15 AM, Nicolin Chen wrote:
> Currently, when GERROR_CMDQ_ERR occurs, the arm_smmu_cmdq_skip_err() won't
> do anything for the CMDQ_ERR_CERROR_ATC_INV_IDX.
> 
> When a device wasn't responsive to an ATC invalidation request, this often
> results in constant CMDQ errors:
>    unexpected global error reported (0x00000001), this could be serious
>    CMDQ error (cons 0x0302bb84): ATC invalidate timeout
>    unexpected global error reported (0x00000001), this could be serious
>    CMDQ error (cons 0x0302bb88): ATC invalidate timeout
>    unexpected global error reported (0x00000001), this could be serious
>    CMDQ error (cons 0x0302bb8c): ATC invalidate timeout
>    ...
> 
> An ATC invalidation timeout indicates that the device failed to respond to
> a protocol-critical coherency request, which means that device's internal
> ATS state is desynchronized from the SMMU.
> 
> Furthermore, ignoring the timeout leaves the system in an unsafe state, as
> the device cache may retain stale ATC entries for memory pages that the OS
> has already reclaimed and reassigned. This might lead to data corruption.
> 
> Isolate the device that is confirmed to be unresponsive by a surgical STE
> update to unset its EATS bit so as to reject any further ATS transaction,
> which could corrupt the memory.
> 
> Also, set the master->ats_broken flag that is revertible after the device
> completes a reset. This flag avoids further ATS requests and invalidations
> from happening.
> 
> Finally, report this broken device to the IOMMU core to isolate the device
> in the core level too.
> 
> For batched ATC_INV commands, SMMU hardware only reports a timeout at the
> CMD_SYNC, which could follow the batch issued for multiple devices. So, it
> isn't straightforward to identify which command in a batch resulted in the
> timeout. Fortunately, the invs array has a sorted list of ATC entries. So,
> the issued batch must be sorted as well. This makes it possible to bisect
> the batch to retry the command per Stream ID and identify the master.

Nit: The implementation is a linear per-SID retry, not a binary
search / bisection. Suggest rewording to:

   "retry the ATC_INV command for each unique Stream ID in the batch
    to identify the unresponsive master"


> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 92 ++++++++++++++++++++-
>   1 file changed, 89 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 366d812668011..418ee2f40d96d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -107,6 +107,8 @@ static const char * const event_class_str[] = {
>   	[3] = "Reserved",
>   };
>   
> +static struct arm_smmu_ste *
> +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
>   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
> @@ -2495,10 +2497,43 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
>   	cmd->atc.size	= log2_span;
>   }
>   
> +static void arm_smmu_disable_eats_for_sid(struct arm_smmu_device *smmu,
> +					  struct arm_smmu_cmdq *cmdq, u32 sid)
> +{
> +	struct arm_smmu_cmdq_ent ent = {
> +		.opcode = CMDQ_OP_CFGI_STE,
> +		.cfgi	= {
> +			.sid = sid,
> +			.leaf = true,
> +		},
> +	};
> +	struct arm_smmu_ste *step;
> +	u64 cmd[CMDQ_ENT_DWORDS];
> +
> +	step = arm_smmu_get_step_for_sid(smmu, sid);
> +	WRITE_ONCE(step->data[1],
> +		   READ_ONCE(step->data[1]) & cpu_to_le64(~STRTAB_STE_1_EATS));


This non-atomic read-modify-write on step->data[1] can race with the
normal STE installation path (arm_smmu_write_entry → entry_set →
WRITE_ONCE).

The error path runs from:

   __arm_smmu_domain_inv_range()  (data path, no group->mutex)
     → arm_smmu_cmdq_batch_retry()
       → arm_smmu_master_disable_ats()
         → arm_smmu_disable_eats_for_sid()   ← NO locks on STE

The normal STE path runs from:

   iommu_attach_device()
     → mutex_lock(&group->mutex)
       → arm_smmu_attach_dev()
         → mutex_lock(&arm_smmu_asid_lock)
           → arm_smmu_install_ste_for_dev()
             → arm_smmu_write_entry()        ← holds both mutexes

Since the error path holds neither group->mutex nor arm_smmu_asid_lock,
the following race is possible:

   CPU A (error path):             CPU B (attach path):
   READ data[1] = X
                                   WRITE data[1] = Y (new STE config)
   WRITE data[1] = X & ~EATS
                                   // Y is lost

This could clobber a concurrent STE update from the attach path.


> +
> +	arm_smmu_cmdq_build_cmd(cmd, &ent);
> +	arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmd, 1, true);
> +}
> +
> +static void arm_smmu_master_disable_ats(struct arm_smmu_master *master,
> +					struct arm_smmu_cmdq *cmdq)
> +{
> +	int i;
> +
> +	for (i = 0; i < master->num_streams; i++)
> +		arm_smmu_disable_eats_for_sid(master->smmu, cmdq,
> +					      master->streams[i].id);
> +	WRITE_ONCE(master->ats_broken, true);
> +	iommu_report_device_broken(master->dev);
> +}
> +
>   static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>   				   ioasid_t ssid)
>   {
> -	int i;
> +	int i, ret;
>   	struct arm_smmu_cmdq_ent cmd;
>   	struct arm_smmu_cmdq_batch cmds;
>   
> @@ -2514,7 +2549,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>   		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
>   	}
>   
> -	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
> +	ret = arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
> +	if (ret)
> +		arm_smmu_master_disable_ats(master, cmds.cmdq);
> +	return ret;
>   }
>   
>   /* IO_PGTABLE API */
> @@ -2661,6 +2699,53 @@ static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
>   	return false;
>   }
>   
> +static void arm_smmu_invs_disable_ats(struct arm_smmu_invs *invs,
> +				      struct arm_smmu_cmdq *cmdq,
> +				      struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct arm_smmu_inv *cur;
> +	size_t i;
> +
> +	arm_smmu_invs_for_each_entry(invs, i, cur) {
> +		if (cur->master->smmu == smmu && arm_smmu_inv_is_ats(cur) &&
> +		    cur->id == sid) {
> +			arm_smmu_master_disable_ats(cur->master, cmdq);
> +			break;
> +		}
> +	}
> +}
> +
> +static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_invs *invs,
> +				      struct arm_smmu_cmdq_batch *cmds)
> +{
> +	u64 atc[CMDQ_ENT_DWORDS] = {0};
> +	int i;
> +
> +	/* Only a timed out ATC_INV command needs a retry */
> +	if (!invs->has_ats)
> +		return;
> +
> +	for (i = 0; i < cmds->num * CMDQ_ENT_DWORDS; i += CMDQ_ENT_DWORDS) {
> +		struct arm_smmu_cmdq *cmdq = cmds->cmdq;
> +		u32 sid;
> +
> +		/* Only need to retry ATC invalidations */
> +		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i]) != CMDQ_OP_ATC_INV)
> +			continue;
> +
> +		/* Only need to retry with one ATC_INV per Stream ID (device) */
> +		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i]);
> +		if (atc[0] && sid == FIELD_GET(CMDQ_ATC_0_SID, atc[0]))
> +			continue;
> +
> +		atc[0] = cmds->cmds[i];
> +		atc[1] = cmds->cmds[i + 1];
> +		if (arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, atc, 1, true))
> +			arm_smmu_invs_disable_ats(invs, cmdq, smmu, sid);
> +	}
> +}
> +
>   static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
>   					unsigned long iova, size_t size,
>   					unsigned int granule, bool leaf)
> @@ -2739,7 +2824,8 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
>   
>   		if (cmds.num &&
>   		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
> -			arm_smmu_cmdq_batch_submit(smmu, &cmds);
> +			if (arm_smmu_cmdq_batch_submit(smmu, &cmds))
> +				arm_smmu_cmdq_batch_retry(smmu, invs, &cmds);
>   			cmds.num = 0;
>   		}
>   		cur = next;

