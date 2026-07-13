Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D33EAC8B;
	Mon, 13 Jul 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945239; cv=none; b=sUG5dc5fnYGcnmPMgqsw9ZCqufbOlN3NiEwEYYKa4yjMgPHpEtJBAYE8jfdnSvV7cDWnns+EEz8Nz3PhiBEb2EJCX3HS/B7XWi3plwJuSt+2jZaWImGHUTI7//wf4jNDHF85ml864XTXlV9+B7d9O6qlmiVvHHMTQmKCqgSt/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945239; c=relaxed/simple;
	bh=Wa3p4pJ1O3+kXOjLpmt1FfceI8MC9N80+kPasW7crM0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NG7h4me7BRQcnNnWfKNdlJfBz8/9XOWU+nuqpFlIlO8y+FkZBaSx6JIb/Vsai87mDALPJ/bX61Xpc0YC+5aGo8xdf/xAG5NAdc7Y1BxAtgmPkbOlQeKMfoHKDNVl3oB8i6u+yU78JXl6Ee4WeEmhfvbD/bVJzwrdcwvgQy8fuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSUPRyc1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSUPRyc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783945238; x=1815481238;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wa3p4pJ1O3+kXOjLpmt1FfceI8MC9N80+kPasW7crM0=;
  b=RSUPRyc11StF5mA/vH3o2P/u18WG2ORhlOcabs5DMHEWSLTs09zaBtaD
   Dlg4CPS6osx3zUhrmWtQAkc3NBXTFwbAGw4xiQA/kklR57XtZu7F0p+5R
   ey8eeK5skxmL+mlv07cGAyuKXxyr4myeBboJunNmh7VIFM59qwf2UzzOf
   YXTBH6nmHtn5XRI/tqQF8LUwFiPq8Xah0nveKn0oazLy3psTn6OyiCD3Y
   UgG6vYi9nOX0FLZ0LY3Kc5VGomI5sXC7OV2E2eHtjY+9wQL6B00DtlXpI
   tDAUXmtM3jiHztVv261l3hN+P0Q4TeHtM5I6aBgP9pbcSe+WrTgvBDbRk
   w==;
X-CSE-ConnectionGUID: 4YkmbFYiR86s37WfRQ/IeQ==
X-CSE-MsgGUID: bIQvI4i4RAqsfCQZJbk98g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="102101388"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="102101388"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 05:20:37 -0700
X-CSE-ConnectionGUID: i+FYRzvwR9Sut71d63+hiw==
X-CSE-MsgGUID: PLNBBH1XTLqng9296cDVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251114037"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 05:20:32 -0700
Message-ID: <9a85cccd-29ed-4c51-b9cb-140631966d20@linux.intel.com>
Date: Mon, 13 Jul 2026 20:20:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Mostafa Saleh <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 18/18] iommu/arm-smmu-v3: Block ATS for a master upon
 an ATC invalidation timeout
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/2026 12:06 PM, Nicolin Chen wrote:
> When a CMD_ATC_INV times out, the SMMU stalls at the trailing CMD_SYNC and
> arm_smmu_cmdq_issue_cmdlist() returns -EIO. The CMDQ HW reports the timeout
> on the CMD_SYNC, not the failing CMD_ATC_INV, so the master that caused it
> cannot be identified from the error alone.
> 
> cmds->cmds is sorted by SID, so arm_smmu_cmdq_batch_retry() walks the batch
> and re-issues one CMD_ATC_INV per unique ATS SID; a second -EIO can confirm
> which master is broken. arm_smmu_quarantine_ats() then quarantines it:
>   - clear STE.EATS on every SID it owns
>   - walk master->master_domains marking its INV_TYPE_ATS/_ATS_FULL entries
>     in every domain's invs as INV_TYPE_ATS_BROKEN so later walks skip them
> 
> When a batch carries only one unique Stream ID, the timed-out CMD_SYNC by
> itself identifies the target, in which case quarantine it directly and skip
> the re-issue probes. This is the common case, since it is uncommon for an
> ATS-capable PCI device to have multiple Stream IDs.
> 
> The marking spans every domain because a master may be attached at the RID
> and at multiple PASIDs; marking only the invs that hit the timeout would
> leave its other invs issuing CMD_ATC_INV that keep timing out. Clearing
> STE.EATS makes the SMMU reject the device's ATS but does not by itself
> stop the driver from issuing CMD_ATC_INV, so the marking is what suppresses
> the recurring timeouts.
> 
> The marking is gated on the STE.EATS clear: it runs only after the CFGI_STE
> batch completes successfully. If that batch fails the entries are left as
> ATS/ATS_FULL, so invalidations keep issuing CMD_ATC_INV and re-quarantine
> until the clear is confirmed, rather than suppressing ATC_INV while ATS may
> still be enabled.
> 
> The flip to INV_TYPE_ATS_BROKEN is a WRITE_ONCE on inv->type, paired with
> the READ_ONCE in arm_smmu_inv_type(). The invs->rwlock is not taken here:
> the caller holds the read side for the timed-out batch, so taking a write
> side would ABBA-deadlock against a concurrent timeout. It is safe unlocked
> because STE.EATS is cleared first, so a racing CMD_ATC_INV forms no ATC
> entry and at worst times out again.
> 
> The STE.EATS clear uses try_cmpxchg64() to avoid losing a concurrent
> arm_smmu_write_ste() update to data[1]. try_cmpxchg64() would be UB on the
> Non-Cacheable stream table of a non-coherent SMMU, and a non-atomic
> fallback could revert such a concurrent update (e.g. an S1DSS change). So
> leave a non-coherent SMMU unquarantined, keeping the pre-existing behavior
> of reporting every ATC_INV timeout.
> 
> Also force a CMD_SYNC on every sub-batch flush carrying an ATC_INV so the
> timeout is observed at the call site that issued the commands.
> 
> Identification is synchronous: each master that keeps timing out adds one
> more CMD_SYNC poll, capped at the ARM_SMMU_POLL_TIMEOUT_US software limit.
> That cap is rarely reached: a non-responding ATC_INV is completed in error
> when the device's PCIe Completion Timeout expires, which defaults to a
> short interval.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 201 +++++++++++++++++++-
>   1 file changed, 198 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index fd9a095154c72..528d816479d7f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -109,6 +109,10 @@ static const char * const event_class_str[] = {
>   
>   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>   static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
> +static struct arm_smmu_ste *
> +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
> +static struct arm_smmu_domain *
> +to_smmu_domain_devices(struct iommu_domain *domain);
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
>   {
> @@ -920,12 +924,25 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
>   	cmds->has_ats = false;
>   }
>   
> +static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_cmdq_batch *cmds);
> +
>   static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
>   				     struct arm_smmu_cmdq_batch *cmds,
>   				     bool sync)
>   {
> -	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
> -					   cmds->num, sync);
> +	int ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
> +					      cmds->num, sync);
> +
> +	/*
> +	 * The CMDQ HW reports an ATC invalidation timeout at the trailing
> +	 * CMD_SYNC, not at the failing CMD_ATC_INV. Re-issue each unique ATS
> +	 * SID in the batch to identify the unresponsive master and block its
> +	 * ATS so subsequent invalidations make forward progress.
> +	 */
> +	if (ret == -EIO && cmds->has_ats)
> +		arm_smmu_cmdq_batch_retry(smmu, cmds);
> +	return ret;
>   }
>   
>   static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
> @@ -941,6 +958,10 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>   	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>   		return true;
>   
> +	/* ATC_INV timeout is reported to CMD_SYNC; catch at the call site */
> +	if (cmds->num == CMDQ_BATCH_ENTRIES && cmds->has_ats)
> +		return true;
> +
>   	return false;
>   }
>   
> @@ -1014,7 +1035,11 @@ static inline struct arm_smmu_inv *
>   arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
>   {
>   	while (true) {
> -		if (next >= invs->num_invs) {
> +		/*
> +		 * Lockless readers (arm_smmu_invs_set_ats_broken) pair with the
> +		 * WRITE_ONCE() in arm_smmu_invs_unref(); num_invs only shrinks.
> +		 */
> +		if (next >= READ_ONCE(invs->num_invs)) {
>   			*idx = next;
>   			return NULL;
>   		}
> @@ -2505,6 +2530,176 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>   	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
>   }
>   
> +static void arm_smmu_invs_set_ats_broken(struct arm_smmu_invs *invs,
> +					 struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct arm_smmu_inv *inv;
> +	size_t i;
> +
> +	/* arm_smmu_atc_inv_master() submits batches with invs=NULL */
> +	if (!invs)
> +		return;
> +
> +	/*
> +	 * invs->rwlock is deliberately not taken: the caller holds one domain's
> +	 * read side for the timed-out batch, then taking another domain's write
> +	 * side while a concurrent timeout does the reverse would ABBA-deadlock.
> +	 *
> +	 * This indicates some potential races, but they are harmless since EATS
> +	 * was already cleared:
> +	 *  - WRITE_ONCE() may hit a stale invs copy if an attach just installed
> +	 *    a new invs, which might result in another ATC_INV timeout.
> +	 *  - a concurrent invalidation may still issue an ATC_INV that may time
> +	 *    out again.
> +	 */
> +	arm_smmu_invs_for_each_entry(invs, i, inv) {
> +		u8 type = arm_smmu_inv_type(inv);
> +
> +		if (inv->smmu == smmu && inv->id == sid &&
> +		    (type == INV_TYPE_ATS || type == INV_TYPE_ATS_FULL))
> +			WRITE_ONCE(inv->type, INV_TYPE_ATS_BROKEN);
> +	}
> +}
> +
> +/* Find the master by SID and block its ATS at the SMMU */
> +static void arm_smmu_quarantine_ats(struct arm_smmu_device *smmu, u32 stream_id)
> +{
> +	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(CMDQ_OP_CFGI_STE);
> +	struct arm_smmu_master_domain *md;
> +	struct arm_smmu_cmdq_batch cmds;
> +	struct arm_smmu_master *master;
> +	struct arm_smmu_invs *invs;
> +	unsigned long flags;
> +	int i;
> +
> +	/*
> +	 * The in-place STE.EATS clear relies on try_cmpxchg64(), which is UB
> +	 * on Non-Cacheable memory. Leave a non-coherent SMMU unquarantined:
> +	 * its invalidations keep issuing ATC_INV and reporting the timeouts.
> +	 */
> +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
> +		return;
> +
> +	guard(spinlock_irqsave)(&smmu->streams_lock);
> +	master = arm_smmu_find_master(smmu, stream_id);
> +	/*
> +	 * A concurrent hot-unplug can release the master while a stale ATS
> +	 * entry for it still lingers in the invs snapshot being walked here.
> +	 */
> +	if (!master)
> +		return;
> +
> +	/* Clear STE.EATS for every SID and sync to the SMMU */
> +	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
> +
> +	for (i = 0; i < master->num_streams; i++) {
> +		u32 sid = master->streams[i].id;
> +		struct arm_smmu_ste *ste = arm_smmu_get_step_for_sid(smmu, sid);
> +		__le64 old, new;
> +
> +		/*
> +		 * A concurrent arm_smmu_write_ste() of a domain attachment may
> +		 * overwrite the data[1] and set EATS, which is recoverable by
> +		 * another ATC_INV issued by its arm_smmu_attach_commit().
> +		 */
> +		old = READ_ONCE(ste->data[1]);
> +		do {
> +			new = old & ~cpu_to_le64(STRTAB_STE_1_EATS);
> +		} while (!try_cmpxchg64(&ste->data[1], &old, new));
> +
> +		arm_smmu_cmdq_batch_add_cmd(
> +			smmu, &cmds, arm_smmu_make_cmd_cfgi_ste(sid, true));
> +	}
> +
> +	/*
> +	 * Only proceed to mark the entries broken if the STE.EATS clear above
> +	 * is confirmed; otherwise return so invalidations keep issuing ATC_INV
> +	 * (and re-quarantine) until ATS is actually disabled.
> +	 */
> +	if (arm_smmu_cmdq_batch_submit(smmu, &cmds)) {
> +		dev_err_ratelimited(smmu->dev,
> +				    "failed to disable ATS for master\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Mark this master's ATS entries broken in every domain it is attached,
> +	 * so later invalidations skip the ATC_INV that would time out again.
> +	 */
> +	rcu_read_lock();
> +	spin_lock_irqsave(&master->master_domains_lock, flags);
> +	list_for_each_entry(md, &master->master_domains, master_elm) {
> +		struct arm_smmu_domain *smmu_domain =
> +			to_smmu_domain_devices(md->domain);
> +
> +		if (!smmu_domain)
> +			continue;
> +		invs = rcu_dereference(smmu_domain->invs);
> +		for (i = 0; i < master->num_streams; i++)
> +			arm_smmu_invs_set_ats_broken(invs, smmu,
> +						     master->streams[i].id);
> +	}
> +	spin_unlock_irqrestore(&master->master_domains_lock, flags);
> +	rcu_read_unlock();
> +}
> +
> +/* Re-issue every unique ATS SID in @cmds to identify and quarantine masters. */
> +static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_cmdq_batch *cmds)
> +{
> +	struct arm_smmu_cmd atc = {};
> +	u32 last_sid = 0;
> +	int nr_sids = 0;
> +	int i;
> +
> +	/*
> +	 * Count unique Stream IDs, taking advantage of the sorted commands. An
> +	 * ATS-capable PCI device rarely has multiple SIDs, so a batch commonly
> +	 * carries a single SID, where a re-issue probe would be pointless.
> +	 */
> +	for (i = 0; i < cmds->num; i++) {
> +		u32 sid;
> +
> +		/* Only ATC_INV commands can time out */
> +		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i].data[0]) !=
> +		    CMDQ_OP_ATC_INV)
> +			continue;
> +		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i].data[0]);
> +		if (!nr_sids || sid != last_sid) {
> +			nr_sids++;
> +			last_sid = sid;
> +		}
> +	}
> +
> +	/* The timed-out CMD_SYNC already identifies the lone Stream ID */
> +	if (nr_sids == 1) {
> +		arm_smmu_quarantine_ats(smmu, last_sid);
> +		return;
> +	}
> +
> +	for (i = 0; i < cmds->num; i++) {
> +		u32 sid;
> +
> +		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i].data[0]) !=
> +		    CMDQ_OP_ATC_INV)
> +			continue;
> +
> +		/*
> +		 * One retry per Stream ID. So, only try the first command since
> +		 * commands are sorted. And each dead master costs one CMD_SYNC,
> +		 * bounded by its PCIe Completion Timeout (usually <= 250ms).
> +		 */
> +		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i].data[0]);
> +		if (atc.data[0] &&
> +		    sid == FIELD_GET(CMDQ_ATC_0_SID, atc.data[0]))
> +			continue;
> +
> +		atc = cmds->cmds[i];
> +		if (arm_smmu_cmdq_issue_cmd_p(smmu, &atc, true) == -EIO)
> +			arm_smmu_quarantine_ats(smmu, sid);
> +	}
> +}
> +
>   /* IO_PGTABLE API */
>   static void arm_smmu_tlb_inv_context(void *cookie)
>   {

My understanding of the sequence to quarantine a faulty ATS device is
to:

1. Identify the devices that encountered an ATC invalidation timeout
    failure.
2. Have hardware block incoming DMA transfers and translation requests
    by clearing the corresponding bits in the device's context/
    translation table entries.
3. Have software prevent the driver from submitting new invalidation
    requests or re-attaching a new domain to the device.

If this understanding is correct, then while steps 1 and 2 are hardware-
and driver-specific, step 3 seems completely generic. Could it be
consolidated in the core or any helper library so that other drivers can
reuse it?

Thanks,
baolu
