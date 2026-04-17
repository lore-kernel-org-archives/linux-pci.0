Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31A38F22E
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419342; cv=none; b=rv55E1NsCNGtaZJwXVjjMwqUm8uzQs1JhT8vQi7T4OF7d/GTEPT1otktdV2Qjzq5CUembJfWLDnGFXBNe9OqGRHj136ROACoc6dUvlBpcPcIN9GBXw+Rxs5ezr4KdiVkfcF9nODoQjgOK3PtYJtqXAdJvZg3ura9yXjovTorE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419342; c=relaxed/simple;
	bh=+AAe+Rq0Y2fN8Yqy3EtLORPir6cAxY6MZ1QNfd4z5tw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t+tSWUEBsbCfWrNdlWjGQhKOXvhcsjpZfXAMj46M8uuCHztxIHABwm49CIsa0B88CdVvT26YlYW6doUYo4PosZ6N6ts86iauMrVClyolrHYgfF1OXGY/+XsNDIQcCD1/w5ckBs5grZ0mMOqFVRFHZIHHqmjiW5VjJKaTQJN+fIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IEm5OMzq; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IEm5OMzq"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b21a2228;
	Fri, 17 Apr 2026 17:33:28 +0800 (GMT+08:00)
Message-ID: <c2f0d971-2150-7771-f9c6-cd02f05a5441@rock-chips.com>
Date: Fri, 17 Apr 2026 17:33:27 +0800
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
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <a688f479ee522b101f02d17f9fe81c64cbe5f70d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d9ac9c74409cckunmb9bc2d66383580
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4dGlZOHhhPHR1CH0hCHkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IEm5OMzqjTDGxlDp0rd5RD0KIhWeKCE88eP1D3Sl5LoP2HoJZw5AflBD3FHf38tS1J5zbaNxY74buW/aCKaHyHGX9Ri6TOJ0jWVujc/Y4+D//foFfTaOF8nCCz3g3gy6wgeAg2XPbuCizf2MpRhht02QrYLxurKEsFeUR29eT9g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9d4bNswcIBZn5HudovMCBgtCixEer0pSL5vdahuMXSY=;
	h=date:mime-version:subject:message-id:from;

Hi Philipp

在 2026/04/17 星期五 16:44, Philipp Stanner 写道:
> Hello Shawn,
> 
> On Fri, 2026-04-17 at 10:26 +0800, Shawn Lin wrote:
>> pcim_alloc_irq_vectors() and pcim_alloc_irq_vectors_affinity() are created for
>> pci device drivers which rely on the devres machinery to help cleanup the IRQ
>> vectors.
> 
> The commit message doesn't really detail *why* you add this. The rule
> of thumb is to first describe the problem and then describe roughly
> what the patch does about the problem. That also makes it easier for
> reviewers to quickly match code to intent
> 

Sure, will do.

>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Could contain a Suggested-by: Philipp Stanner <phasta@kernel.org> ? :)
> 

Sure!

>>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/pci/msi/api.c | 26 ++++++++++++++++++++++++++
>>   include/linux/pci.h   | 22 ++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
>> index c18559b..2362fca 100644
>> --- a/drivers/pci/msi/api.c
>> +++ b/drivers/pci/msi/api.c
>> @@ -297,6 +297,32 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>   EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>>   
>>   /**
>> + * pcim_alloc_irq_vectors() - devres managed pci_alloc_irq_vectors()
>> + * Interrupt vectors are automatically freed by the devres machinery
> 
> nit: "devres machinery" is not a very common expression. I would just
> say "through devres".
> 
> For correct docstrings, though, you need to describe all the parameters
> below, like 'dev', 'min_vecs' etc.
> 
> Also the return value needs to be described.
> 
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> 
> Do you do "make htmldocs"? I think that should provide warnings for
> that?
> 


Ahh, I didn't. I will describe all the parameters.

> 
>> + */
>> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>> +			   unsigned int max_vecs, unsigned int flags)
>> +{
>> +	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> +					       flags, NULL);
>> +}
>> +EXPORT_SYMBOL(pcim_alloc_irq_vectors);
>> +
>> +/**
>> + * pcim_alloc_irq_vectors_affinity() - devres managed pci_alloc_irq_vectors_affinity()
>> + * Interrupt vectors are automatically freed by the devres machinery
>> + */
> 
> Same here with docstrings
> 
>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>> +				   unsigned int max_vecs, unsigned int flags,
>> +				   struct irq_affinity *affd)
>> +{
>> +	dev->is_msi_managed = true;
> 
> Do you have to set this to 'false' again? If so, who does that? A small
> comment here could describe that.
> 
> 
> Note that for your cleanup, in the long run, once all users are ported,
> these helper bools should not be necessary anymore because devres
> already stores all the relevant state.
> 
> Likewise, I would like to remove the "is_managed" and "is_pinned"
> flags, but that can only be done once all API users are ported.
> 
> If this is the case with 'is_msi_managed', too, there should be a
> cleanup TODO comment in my opinion. "This can be removed once…"
> 

My initial plan was to make it into 3 steps:
(1) Set is_msi_managed true via pcim_alloc_irq_vectors*();
(2) All pcim_enable_device() + pci_alloc_irq_vectors*() users are ported
(3) remove is_msi_managed assignment‌ from pcim_enable_device()

As you could see, on step 1 & 2, pcim_enable_device() +
pci_alloc_irq_vectors*() users uncondictionly set is_msi_managed true.
So they don't have to set it false again. At least it keeps the previous
behaviour. For potential new pci_enable_device() +
pcim_alloc_irq_vectors*() users before all the convertion is done, It's
indeed a problem here.

Does something below make sense to you?

int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int
                                     min_vecs, unsigned int max_vecs,
                                     unsigned int flags,
                                     struct irq_affinity *affd)
{
	int nvecs;
	bool already_set_msi_managed = dev->is_msi_managed;

	if (!already_set_msi_managed)
		dev->is_msi_managed= true;

	nvecs = pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
					      flags, affd);
	if (nvecs < 0 && !already_set_msi_managed)
		dev->is_msi_managed = false;

	return nvecs;
}


Thanks.

> (But I'm not super deep in PCI devres since many months; but I think I
> remember that not properly dealing with that flag state even caused us
> a bug or two in the past)
> 
> 
> Regards,
> Philipp
> 
>> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> +					      flags, affd);
>> +}
>> +EXPORT_SYMBOL(pcim_alloc_irq_vectors_affinity);
>> +
>> +/**
>>    * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
>>    * @dev: the PCI device to operate on
>>    * @nr:  device-relative interrupt vector index (0-based); has different
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 2c44545..3716c67 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1770,6 +1770,12 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>   				   unsigned int max_vecs, unsigned int flags,
>>   				   struct irq_affinity *affd);
>>   
>> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>> +			  unsigned int max_vecs, unsigned int flags);
>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>> +				   unsigned int max_vecs, unsigned int flags,
>> +				   struct irq_affinity *affd);
>> +
>>   bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
>>   struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>>   				     const struct irq_affinity_desc *affdesc);
>> @@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>   					      flags, NULL);
>>   }
>>   
>> +static inline int
>> +pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>> +			       unsigned int max_vecs, unsigned int flags,
>> +			       struct irq_affinity *aff_desc)
>> +{
>> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> +					      flags, aff_desc);
>> +}
>> +static inline int
>> +pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>> +		      unsigned int max_vecs, unsigned int flags)
>> +{
>> +	return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> +					      flags, NULL);
>> +}
>> +
>>   static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
>>   { return false; }
>>   static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
> 
> 
