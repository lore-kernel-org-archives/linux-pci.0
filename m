Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B693388E40
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846978; cv=none; b=E+ltX26FlKxAz7J7c8gXTOul/R3wAB+JdzzseE7gzlchGLHtfiuUyYoipYTao+pMlhaz8vl6rEcBCPccKjBYpcuvnJalZnHdwNm+48rBmxZsC0u3Uhe4+ILgTGzmQuxYSaoF68mMQg1ZeJP5u89lh+VxEwJKl+9USnwCkcsUKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846978; c=relaxed/simple;
	bh=895r9R8pvH/grRaj2UAM9jvIap20aYhDb3LTZk450HE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q6L5cNeyTkMG+ThNPaq8Qecy3/7hZztbIz1y5OdTSqX02MXHCekeyRT5nBsS5aYjK20DHvr2twMrtNfxi+cczyGzHNZdbwKomTMejsgLADwPvdlPB3zBwolz2zArB/2SJj86h+PEmlUsXWXgHlVWrBGvLSs/Xr6aLyua+VJyr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=L9a7Yz7v; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="L9a7Yz7v"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3bb2452e8;
	Wed, 22 Apr 2026 16:36:02 +0800 (GMT+08:00)
Message-ID: <f912358d-925b-1e25-2852-1f265d09032a@rock-chips.com>
Date: Wed, 22 Apr 2026 16:36:01 +0800
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
 Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v3 1/3] PCI/MSI: Add Devres managed IRQ vectors
 allocation
To: phasta@kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
 <1776825522-6390-2-git-send-email-shawn.lin@rock-chips.com>
 <2c227e17a573c8c674c027c9b3014c2ec9ebfec7.camel@mailbox.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <2c227e17a573c8c674c027c9b3014c2ec9ebfec7.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9db455000709cckunm35c3acf31c7f24
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpNTlYeQ0pKT05PHUMdSE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=L9a7Yz7vIzyTmPWNR/uyn4V/9h1s8d1Dlgru8WRSPraVbm2JjipSFs1mV8kH8LvmAGfY9jSGmDWewXTGqnBo98JZyl6f2M1GXkJZUHCA+gLpO5/fKUki7R8hCNxH1/y5dTcbCW1//h8/WXFs72N4GRcLFi+XDw5FJyJD1ZtiBKg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HvzoTKGV5baRQBqmA+S6gxaOOoxHxlZHK5GStkF/uzw=;
	h=date:mime-version:subject:message-id:from;

Hi Philipp

在 2026/04/22 星期三 15:32, Philipp Stanner 写道:
> On Wed, 2026-04-22 at 10:38 +0800, Shawn Lin wrote:
>> The PCI/MSI subsystem suffers from a long-standing design issue where
>> the implicit, automatic management of IRQ vectors by the devres
> 
> nit:
> The *automatic* handling is not actually the issue. All devres
> interfaces (pcim_) are automatic by definition.
> 
> The issue is the "sometimes managed, sometimes not" nature of some pci_
> interfaces. I came to call those "hybrid functions".
> 
>> framework conflicts with explicit driver cleanup, leading to ambiguous
>> ownership and potential resource management bugs.
>>
>> Historically, pcim_enable_device() not only manages standard PCI
>> resources (BARs) via devres
>>
> 
> See cover-letter. As I said, that's not the case anymore. It was the
> case once.
> 
> I think you could just briefly state "Historically, some functions
> exhibited this hybrid behavior, the last of which by now are …"
> 
> If you want you could maybe also Link: one  of my patch series's for
> the wider history.
> 
>> but also implicitly sets the is_msi_managed
>> flag if calling pci_alloc_irq_vectors*(). This registers pcim_msi_release()
>> as a cleanup action, creating a hybrid ownership model.
> 
> nit:
> s/ownership/responsibility
> 
>>
>> This ambiguity causes problems when drivers follow a common but
>> hazardous pattern:
>> 1. Using pcim_enable_device() (which implicitly marks IRQs as managed)
>> 2. Explicitly calling pci_alloc_irq_vectors() for IRQ allocation
>> 3. Also calling pci_free_irq_vectors() in error paths or remove routines
>>
>> In this scenario, the devres framework may attempt to free the IRQ
>> vectors a second time upon device release, leading to double-free
>> issues. Analysis of the tree shows this hazardous pattern exists
>> in multiple drivers, while 35 other drivers correctly rely solely
>> on the implicit cleanup.
> 
> See cover-letter.
> 
> I would leave that to Bjorn's preference, but I think that info is
> useful for the cover letter so that reviewers get what's going on, but
> it's not useful in the commit message. Your description of the
> problematic API is justification enough IMO.
> 
>>
>> To resolve this ambiguity, introduce explicit managed APIs for IRQ
>> vector allocation:
>> - pcim_alloc_irq_vectors()
>> - pcim_alloc_irq_vectors_affinity()
>>
>> These functions are the devres-managed counterparts to
>> pci_alloc_irq_vectors[_affinity](). Drivers that wish to have
>> devres-managed IRQ vectors should use these new APIs instead.
>>
>> The long-term goal is to convert all drivers which use pcim_enable_device()
>> as well as pci_alloc_irq_vectors[_affinity]() to use these managed
> 
> nit:
> s/as well as/in combination with
> 
>> functions, and eventually remove the problematic hybrid management
>> pattern from pcim_enable_device() and pcim_setup_msi_release() entirely.
>> This patch lays the foundation by introducing the APIs.
> 
> But in general reads very nice and is mostly spot-on :)
> 
>>
>> Suggested-by: Philipp Stanner <phasta@kernel.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v3:
>> - Rework the commit message and function doc (Philipp)
>> - Remove setting is_msi_managed flag from new APIs (Philipp)
>>
>> Changes in v2:
>> - Rebase
>> - Introduce patches only for PCI subsystem to convert the API
>>
>>   drivers/pci/msi/api.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h   | 22 ++++++++++++++++++++++
>>   2 files changed, 69 insertions(+)
>>
>> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
>> index c18559b..90b67f5 100644
>> --- a/drivers/pci/msi/api.c
>> +++ b/drivers/pci/msi/api.c
>> @@ -297,6 +297,53 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>   EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>>   
>>   /**
>> + * pcim_alloc_irq_vectors - devres managed pci_alloc_irq_vectors()
>> + * @dev: the PCI device to operate on
>> + * @min_vecs: minimum number of vectors required (must be >= 1)
>> + * @max_vecs: maximum (desired) number of vectors
>> + * @flags: flags for this allocation, see pci_alloc_irq_vectors()
>> + *
>> + * This is a device resource managed version of pci_alloc_irq_vectors().
>> + * Interrupt vectors are automatically freed on driver detach by the
>> + * devres. Drivers do not need to explicitly call pci_free_irq_vectors().
> 
> s/the devres/devres
> 
> s/do not need/must not  <- You stated doing so would be a bug, right?
> 
>> + *
>> + * Returns number of vectors allocated (which might be smaller than
>> + * @max_vecs) on success, or a negative error code on failure.
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
>> + * pcim_alloc_irq_vectors_affinity - devres managed pci_alloc_irq_vectors_affinity()
>> + * @dev: the PCI device to operate on
>> + * @min_vecs: minimum number of vectors required (must be >= 1)
>> + * @max_vecs: maximum (desired) number of vectors
>> + * @flags: flags for this allocation, see pci_alloc_irq_vectors()
>> + * @affd: optional description of the affinity requirements
>> + *
>> + * This is a device resource managed version of pci_alloc_irq_vectors_affinity().
>> + * Interrupt vectors are automatically freed on driver detach by the devres
>> + * machinery. Drivers which use pcim_enable_device() as well as this function,
>> + * do not need to explicitly call pci_free_irq_vectors() currently.
>> + *
>> + * Returns number of vectors allocated (which might be smaller than
>> + * @max_vecs) on success, or a negative error code on failure.
>> + */
>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>> +				   unsigned int max_vecs, unsigned int flags,
>> +				   struct irq_affinity *affd)
>> +{
>> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>> +					      flags, affd);
> 
> Hmmm, OK – I am not thaaaat deep in the topic anymore, so correct me if
> I am wrong. But to me it seems that we might have a problem.
> 
> Your intention seems to be to rely on hybrid devres here, isn't it?
> 

Yes, it's.

> Because pci_alloc_irq_vectors_affinity() runs into
> __pci_enable_msi(x)_range(), which runs into pci_setup_msi_context(),
> which sets up the devres callbacks.
> 
> And this would now mean that your new function here *also* is hybrid,
> because it relies on pcim_enable_device() setting the flag, right?
> 
> IOW, when someone called pci_enable_device(), your pcim_ function here
> would NOT be a managed devres function. Right?
> 
> That would obviously not fly. The current (and IMO) desirable design
> goal for devres PCI is that pcim_ functions are ALWAYS managed (hence
> the 'm' = managed, and pci_ functions are NEVER managed).
> 
> I am sorry if / that I overlooked that while first glimpsing at your
> previous versions.
> 

Don't worry.

> 
> IIRC for this reason I had to provide a completely unmanaged backend,
> and to do so I actually had to *copy* existing functions from pci.c, so
> for many months PCI contained two versions of the same functions.
> 

I was trying to avoid copying the existing functions.

There are some combinations here:
1. pcim_enable_device() + pci_alloc   -> correct
2. pcim_enable_device() + pci_alloc + pci_free  -> bug
3. pci_enable_device() + pci_alloc + pci_free -> correct

To solve the 2nd case, I need to remove the hybird mode from
pcim_enable_device(). So what I had in mind is to is :

1. keep pcim_alloc_irq_vectors() rely on pcim_enable_device(), still
the hybrid mode as you pointed out.
2. convert pcim_enable_device() + pci_alloc_irq_vectors() users to
pcim_enable_device() + pcim_alloc_irq_vectors(), which is the first
above case. Meanwhile add documentation or code check to prevent new
pci_enable_device() + pcim_alloc_irq_vectors() user from using it.

3. after conversions, we still have three combinations:
- pcim_enable_device() + pcim_alloc()  -> correct
- pcim_enable_device() + pci_alloc + pci_free  -> bug
- pci_enable_device() + pci_alloc + pci_free   -> correct

4. Then remove pcim_setup_msi_release() from pci_setup_msi_context().
And add pcim_setup_msi_release() to my new APIs. This way,
- pcim_enable_device() + pcim_alloc()  -> correct
- pcim_enable_device() + pci_alloc + pci_free  -> correct
- pci_enable_device() + pci_alloc + pci_free   -> correct

5. remove the limitation of using pci_enable_device() + pcim_alloc, as
mentioned in the 2nd above step. so we could allow this 4th pattern.
Finally all things work fine.

Please let me know if this approach works for you?


> The reason was that the hybrid behavior was burried so deep in the
> subsystem.
> 
> See here:
> 
> Here I had to reimplement some functions to be used by my new pcim_
> functions:
> https://lore.kernel.org/linux-pci/20240610093149.20640-4-pstanner@redhat.com/
> 
> 
> And here I could finally remove them later:
> https://lore.kernel.org/linux-pci/20250519112959.25487-7-phasta@kernel.org/
> 
> 
> I hope this helps. And again sorry for potentially causing you
> unnecessary work :(
> 
> 
> Regards
> Philipp
> 
> 
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
