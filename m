Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11130EF95
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679659; cv=none; b=DUP/O3MZ/7fsrm/K2u2cUee3rf4Hu3pAtiwCS2HiINsdPSyKKPAiaLAOL/fkdGQbnBnlBsypJ7EtAv/Q95xzlNrygFDryMCUHnhyLjp9LvnfSAI+pLFUIUtBf4+3gNNN1Sn8G+UMSdEFfbXYzIj8DXhGyTdR4w8gERfQ59Cvi1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679659; c=relaxed/simple;
	bh=8tDeo6TW+INo9YjRfWa3uUVdlSdJmtEHYXLa8et7eD0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jCAa4g+KYc1RsFAxaCux9NgKLsP2EGiyPz20PGIZaSbKiZspuKhbwatjO8gLkQbv5dOParNEVcjvxqhG5JGC21cBiWJkZLNOHy6YISSczkc0dhbeWuzrgw/5StfH+3tL09ox5JSHwwiAM6a0BjqGaWURpSySerQASHGJtNqMoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iqtLFLnP; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iqtLFLnP"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b641e2ae;
	Mon, 20 Apr 2026 17:52:09 +0800 (GMT+08:00)
Message-ID: <37904506-71ad-4284-67a6-32135a8265a6@rock-chips.com>
Date: Mon, 20 Apr 2026 17:52:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/3] PCI/MSI: Add Devres managed IRQ vectors allocation
To: phasta@kernel.org
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
 <1776392767-83668-2-git-send-email-shawn.lin@rock-chips.com>
 <a688f479ee522b101f02d17f9fe81c64cbe5f70d.camel@mailbox.org>
 <c2f0d971-2150-7771-f9c6-cd02f05a5441@rock-chips.com>
 <cffc558c0110ba06e26912ea10df30ea1fb288cb.camel@mailbox.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <cffc558c0110ba06e26912ea10df30ea1fb288cb.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9daa4df5c809cckunm46e6cb44722d77
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhDH1YaTxlDSEkaSx5PHk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iqtLFLnPURgd2Rljdl9TnEUnMNgr2GnRFA/fcinWMgegYEVQsMUkLK85+fd9D5EB/EGZKIT/x0qX3hg7cL8IoGx749XQu74VIdJUEqQO/6ZXQmbtxsxEUPlgybue3DY38cHZirEySetusvtLwwONj0pO2Rh6blt9r0fwRmJuJ4s=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=aeH2hX/T3o4AULp7NSrL9hApAeU3fPYzglKvcRpSDPs=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/20 星期一 17:28, Philipp Stanner 写道:
> On Fri, 2026-04-17 at 17:33 +0800, Shawn Lin wrote:
>> Hi Philipp
>>
>> 在 2026/04/17 星期五 16:44, Philipp Stanner 写道:
>>> Hello Shawn,
>>>
>>> On Fri, 2026-04-17 at 10:26 +0800, Shawn Lin wrote:
>>>> pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
>>>> pci device drivers which rely on the devres machinery to help cleanup the IRQ
>>>> vectors.
>>>
>>> The commit message doesn't really detail *why* you add this. The rule
>>> of thumb is to first describe the problem and then describe roughly
>>> what the patch does about the problem. That also makes it easier for
>>> reviewers to quickly match code to intent
>>>
>>
>> Sure, will do.
>>> `
> 
> […]
> 
>>>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>>> +				   unsigned int max_vecs, unsigned int flags,
>>>> +				   struct irq_affinity *affd)
>>>> +{
>>>> +	dev->is_msi_managed = true;
>>>
>>> Do you have to set this to 'false' again? If so, who does that? A small
>>> comment here could describe that.
>>>
>>>
>>> Note that for your cleanup, in the long run, once all users are ported,
>>> these helper bools should not be necessary anymore because devres
>>> already stores all the relevant state.
>>>
>>> Likewise, I would like to remove the "is_managed" and "is_pinned"
>>> flags, but that can only be done once all API users are ported.
>>>
>>> If this is the case with 'is_msi_managed', too, there should be a
>>> cleanup TODO comment in my opinion. "This can be removed once…"
>>>
>>
>> My initial plan was to make it into 3 steps:
>> (1) Set is_msi_managed true via pcim_alloc_irq_vectors*();
>> (2) All pcim_enable_device() + pci_alloc_irq_vectors*() users are ported
>> (3) remove is_msi_managed assignment‌ from pcim_enable_device()
>>
>> As you could see, on step 1 & 2, pcim_enable_device() +
>> pci_alloc_irq_vectors*() users uncondictionly set is_msi_managed true.
> 
> pcim_enable_device() does not set that flag (if you meant that; I'm not
> sure).
> 

My bad, I meant pcim_enable_device() sets is_managed, so
pcim_setup_msi_release() would skip the check of `if 
(!pci_is_managed(dev) || dev->is_msi_managed)`, thus is_msi_managed is 
set at the end.

> The flag is already set by pcim_setup_msi_release(). Why do you need a
> second place to set it?
> 
>> So they don't have to set it false again. At least it keeps the previous
>> behaviour. For potential new pci_enable_device() +
>> pcim_alloc_irq_vectors*() users before all the convertion is done, It's
>> indeed a problem here.
> 
> The thing is that I believe that this should be orthogonal.
> 
> 1. You'd keep the old functions exactly as they are now.
> 
> 2. Then, you add new pcim_irq_vector() et. al. functions. They won't
> need any flag, because the managed state is stored by the devres
> backend.
> 
> 3. You port a few users of the pcim_enable_device() + alloc_irq()
> function combination
> 
> 4. Once you have ported all of them, you can completely remove the
> is_managed flag and related devres functionality from the old
> interfaces.
> 
> 
> I don't see why new code should interact with that flag mechanism. That
> seems incorrect to me. Can you explain to me why you think it's
> necessary?
> 
> 

I was thinking if we need to unset the flag but thinking more about it,
the answer seems no, you're right, the devres backend manages it
properly.

Thanks, Philipp!

>>
>> Does something below make sense to you?
>>
>> int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int
>>                                       min_vecs, unsigned int max_vecs,
>>                                       unsigned int flags,
>>                                       struct irq_affinity *affd)
>> {
>> 	int nvecs;
>> 	bool already_set_msi_managed = dev->is_msi_managed;
>>
>> 	if (!already_set_msi_managed)
>> 		dev->is_msi_managed= true;
>>
>> 	nvecs = pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> 					      flags, affd);
>> 	if (nvecs < 0 && !already_set_msi_managed)
>> 		dev->is_msi_managed = false;
> 
> Hmm, not sure. See above.
> 
> 
> P.
> 
>>
>> 	return nvecs;
>> }
>>
>>
>> Thanks.
>>
>>> (But I'm not super deep in PCI devres since many months; but I think I
>>> remember that not properly dealing with that flag state even caused us
>>> a bug or two in the past)
>>>
>>>
>>> Regards,
>>> Philipp
>>>
>>>> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>>>> +					      flags, affd);
>>>> +}
>>>> +EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
>>>> +
>>>> +/**
>>>>     * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
>>>>     * @dev: the PCI device to operate on
>>>>     * @nr:  device-relative interrupt vector index (0-based); has different
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 2c44545..3716c67 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>>>    				   unsigned int max_vecs, unsigned int flags,
>>>>    				   struct irq_affinity *affd);
>>>>    
>>>> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>>> +			  unsigned int max_vecs, unsigned int flags);
>>>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>>> +				   unsigned int max_vecs, unsigned int flags,
>>>> +				   struct irq_affinity *affd);
>>>> +
>>>>    bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
>>>>    struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>>>>    				     const struct irq_affinity_desc *affdesc);
>>>> @@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>>>    					      flags, NULL);
>>>>    }
>>>>    
>>>> +static inline int
>>>> +pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>>> +			       unsigned int max_vecs, unsigned int flags,
>>>> +			       struct irq_affinity *aff_desc)
>>>> +{
>>>> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>>>> +					      flags, aff_desc);
>>>> +}
>>>> +static inline int
>>>> +pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>>> +		      unsigned int max_vecs, unsigned int flags)
>>>> +{
>>>> +	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>>>> +					      flags, NULL);
>>>> +}
>>>> +
>>>>    static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
>>>>    { return false; }
>>>>    static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>>>
>>>
> 
> 
