Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE713126B9;
	Thu, 19 Mar 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906105; cv=none; b=pB86fcotoKd65Ow5gZN2rTqbO9HchrosRiCGPZ5nWrMGdvjhoDWFcPsp/+/ASKqudrSaESndEstl3AILGEhMNPQYdyRXBqTlbriCJEqbgCLXZpWuFAyCxYkBmb6rMFyJhEbT+ScCvPWr8NQq19DIhCw832zLxrzQPaJhTmKD53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906105; c=relaxed/simple;
	bh=yY0ONwJT7hMWrrDF3sJ/0j/CTKM6T5BWZqrt0m+7QYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjCeHHJ8loWy7xr/UP7VsTOVrt8p2zhWl1JF4RObbl2fQtR+xq9nxEi5zI8oFPg3EO0kgnxwPW0Xg/PM4A6kMfIcnLa32MnGuJxdeSFoMQCp9OSg/UrbYMu80e4AB2J+C8oaVs7T1HUKJnow+uFTg//8ASbcmgMYQbXaW9PmSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fUA2nZtJ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fUA2nZtJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773906101; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aGDLL6Ar9BwuYWHlCus806lUe1cL7vSPADZrnW2oChs=;
	b=fUA2nZtJXHUgfHxlvMo+BR9GXOv55h346/yY6jccegTECnSnYSQP3MvxTPnKrrqKepNVAtg8cVXUs1xoEjnp7aCBVXYKoQhjkLSZ+RNJPgl9AtBUfDkrL/qwNRGplzHDPxpG/6qGA5f/EQl+KItE786AcINu297s25bn+/q04Lo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.Hj-we_1773906099;
Received: from 30.246.163.250(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.Hj-we_1773906099 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 15:41:40 +0800
Message-ID: <0e2d1eb5-a58d-4fe6-9a63-e10e527abd6f@linux.alibaba.com>
Date: Thu, 19 Mar 2026 15:41:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] iommu/arm-smmu-v3: Block ATS upon an ATC
 invalidation timeout
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org, lenb@kernel.org,
 praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <7e21e14faddeb0e3af692356f4fefbae2dfbebda.1773774441.git.nicolinc@nvidia.com>
 <eeee122f-54e2-4fe9-82a6-724c3f80a499@linux.alibaba.com>
 <abts8l0UPvGuzrzF@Asurada-Nvidia>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <abts8l0UPvGuzrzF@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/19/26 11:26 AM, Nicolin Chen wrote:
> On Thu, Mar 19, 2026 at 10:56:43AM +0800, Shuai Xue wrote:
>> On 3/18/26 3:15 AM, Nicolin Chen wrote:
>>> For batched ATC_INV commands, SMMU hardware only reports a timeout at the
>>> CMD_SYNC, which could follow the batch issued for multiple devices. So, it
>>> isn't straightforward to identify which command in a batch resulted in the
>>> timeout. Fortunately, the invs array has a sorted list of ATC entries. So,
>>> the issued batch must be sorted as well. This makes it possible to bisect
>>> the batch to retry the command per Stream ID and identify the master.
>>
>> Nit: The implementation is a linear per-SID retry, not a binary
>> search / bisection. Suggest rewording to:
>>
>>    "retry the ATC_INV command for each unique Stream ID in the batch
>>     to identify the unresponsive master"
> 
> You are right. And that sounds OK.
> 
>>> +	step = arm_smmu_get_step_for_sid(smmu, sid);
>>> +	WRITE_ONCE(step->data[1],
>>> +		   READ_ONCE(step->data[1]) & cpu_to_le64(~STRTAB_STE_1_EATS));
>>
>>
>> This non-atomic read-modify-write on step->data[1] can race with the
>> normal STE installation path (arm_smmu_write_entry → entry_set →
>> WRITE_ONCE).
>>
>> The error path runs from:
>>
>>    __arm_smmu_domain_inv_range()  (data path, no group->mutex)
>>      → arm_smmu_cmdq_batch_retry()
>>        → arm_smmu_master_disable_ats()
>>          → arm_smmu_disable_eats_for_sid()   ← NO locks on STE
>>
>> The normal STE path runs from:
>>
>>    iommu_attach_device()
>>      → mutex_lock(&group->mutex)
>>        → arm_smmu_attach_dev()
>>          → mutex_lock(&arm_smmu_asid_lock)
>>            → arm_smmu_install_ste_for_dev()
>>              → arm_smmu_write_entry()        ← holds both mutexes
>>
>> Since the error path holds neither group->mutex nor arm_smmu_asid_lock,
>> the following race is possible:
> 
> Because invalidations can be in atomic context so we can't hold
> those mutex locks.
> 
>>    CPU A (error path):             CPU B (attach path):
>>    READ data[1] = X
>>                                    WRITE data[1] = Y (new STE config)
>>    WRITE data[1] = X & ~EATS
>>                                    // Y is lost
>>
>> This could clobber a concurrent STE update from the attach path.
> 
> Oh, that's true. Maybe this:
> 	__le64 new, old = READ_ONCE(step->data[1]);
> 	[...]
> 	do {
> 		new = old & cpu_to_le64(~STRTAB_STE_1_EATS);
> 	} while (!try_cmpxchg64(&step->data[1], &old, new));
> ?

Yes, the cmpxchg loop looks correct to me.

Thanks.
Shuai

