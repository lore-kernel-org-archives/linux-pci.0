Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211241E6DC;
	Tue, 13 Oct 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891347; cv=none; b=hR2UUN6JuLLv9Iv6zSx/EqlNGPKKlAg6Fw/8onRWnuPdKwu9vKOOQ6/p8UYbvNeHABQMVgRuzijYorZezhw2AFVzUrP96ZUgkiZzu1XJ+ljgXs9sRDBS8kB1wq2OqhR6iR/7MugCnTA8cbzjD7qV+onOHDfXgJmLvTt+dak0eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891347; c=relaxed/simple;
	bh=iFHnFsr3NjAcsRUa/CVUBKDHfKdX/CfcLbNrrMoPACE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff/LehhZq6XfTwzj9qfyozU/e04tV7yzB7J4SU2XxvdRKQu8sZbXpmoZMtk/k8CDi43rLAGYGhPN7mqcfmhqNRDfWl48aL7n0yjwYTcDDb5MZLu8nHCgs8eOgxXnlKdIc8686P/uKDBlr4YxqhOwJTNTtzHZilQw4B0J9MAXgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Gl4+NGju; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gl4+NGju"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977A01570;
	Tue, 13 Oct 2026 04:35:41 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A23143F66F;
	Tue, 13 Oct 2026 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791891344; bh=iFHnFsr3NjAcsRUa/CVUBKDHfKdX/CfcLbNrrMoPACE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gl4+NGjuoXJn53qe90hDjficciUU0vZiX+yyPYW+ZDx13uFc4Q5PLHcJhbPEDlp/W
	 pzQnrSxhy37kEHopU8W//0TMy1atxB3VauY7j+UROpxd0jwNa1Cmp9OEaDoa+9UVbS
	 qL35dEEYtZsulURYhEruyJQNPy9gWwgtw5g72G7A=
Message-ID: <370a947c-601b-434c-befd-4896ed523ced@arm.com>
Date: Tue, 13 Oct 2026 12:35:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Will Deacon <will@kernel.org>, Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>,
 Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, rafael@kernel.org,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <asZSQRSYBjbUaaH0@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2026 3:08 pm, Will Deacon wrote:
> On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
>> Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
>> queue's producer index to safely gate command submissions during device
>> suspension.
>>
>> The flag embeds the suspend state directly into the existing global state
>> The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
>> which acts as a Point of Commitment, ensuring that no indices are
>> reserved or committed once the SMMU begins suspending.
> 
> I'm not familiar with the term "Point of Commitment". Is that something
> you came up with? Without a general definition, I think I'd prefer to
> avoid using it, especially as it sounds like something to do with the
> Arm memory system (where we already have architectural terms such as
> "Point of Coherency".
>   
>> This prevents a situation of "abandoned batches" where indices are
>> incremented but commands are never written, which would otherwise
>> lead to timeout during the drain poll.
>>
>> Update queue_inc_prod_n() to preserve this flag during index
>> calculations, ensuring that any in-flight commands that successfully
>> passed the point of commitment can proceed to completion while the
>> flag remains set.
>>
>> Suggested-by: Daniel Mentz <danielmentz@google.com>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
>>   2 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index a123810fac57..7f89e2306942 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
>>   static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
>>   {
>>   	u32 prod = Q_POS(q, q->prod) + n;
>> -	return Q_OVF(q->prod) | Q_POS(q, prod);
>> +
>> +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
>>   }
>>   
>>   static void queue_poll_init(struct arm_smmu_device *smmu,
>> @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>>   	do {
>>   		u64 old;
>>   
>> +		/*
>> +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
>> +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
>> +		 * our new indices yet, we can safely bail. Once the indices are
>> +		 * committed, we MUST write valid commands to those slots to
>> +		 * avoid indefinite polling in the drain function.
>> +		 */
>> +		if (Q_STOP(llq.prod)) {
>> +			local_irq_restore(flags);
>> +			return 0;
>> +		}
>> +
>>   		while (!queue_has_space(&llq, n + sync)) {
>>   			local_irq_restore(flags);
>> +
>> +			/* Avoid waiting for space if the SMMU is suspending */
>> +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
>> +				return 0;
>> +
>>   			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
>>   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> 
> It's a bit grotty to have the extra READ_ONCE() here. Why not make
> arm_smmu_cmdq_poll_until_not_full() return if the stop bit is set?
> 
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index deefb17e31eb..794b258550dd 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>>   #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
>>   
>>   #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
>> +#define CMDQ_PROD_STOP_FLAG		(1U << 30)
> 
> I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it's
> plausible that the architecture allocates that bit for something in future.
> For example, if the index field was extended, then I think that would
> cause problems for the driver.
> 
> Do we have to put the stop flag in the producer value, or can it just be
> a flag elsewhere in memory?

Logically, it feels like this should happen earlier in the process 
anyway - if we're entering a state where we don't want to accept _any_ 
new command submissions, then surely arm_smmu_get_cmdq() should just 
start saying "No, there is no valid queue to submit this command." to 
everything?

Thanks,
Robin.
