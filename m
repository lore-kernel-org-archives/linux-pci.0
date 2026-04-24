Received: from mail-m32118.qiye.163.com (mail-m32118.qiye.163.com [220.197.32.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B3352F86
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015435; cv=none; b=IXFbJZuaqt6rgZiP0L7sLfXuG4LOquuf2iBegsZaGNW4X6hL7rhB7QQF1tay8FaY73BFEncT2cPtjPs7h61fLjfdI8NCQ3SidWRYIoIZM+Q5Ly6JuxfxdxGjcELf0bz8MBlx2kMsoJk9j4/+SwWQShs1p+gy68CUJtziKT2rig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015435; c=relaxed/simple;
	bh=KhJldYftAFxmrFsae9M0sdKrm1XntOQJxwid/8HHXC4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZANMAZTDykT5KMuFI4d0824qP3RAzTIGU9iPL1j3gBOYHvswJsbbUZ8HmtfcRDlR/uKGTBadxLSLOzfBU8EnrlAAUjVt3NHnsWfoYiCVX3veDids/689A1lrvv0IsuvYnmwsPiMzGimRoJeY4pjIwGa4rfFAn5iVxL5FQ8RMuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Fi7V9pY8; arc=none smtp.client-ip=220.197.32.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Fi7V9pY8"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c0098058;
	Fri, 24 Apr 2026 15:23:33 +0800 (GMT+08:00)
Message-ID: <84d19067-feb8-de53-7214-54301399edfb@rock-chips.com>
Date: Fri, 24 Apr 2026 15:23:32 +0800
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
 <f912358d-925b-1e25-2852-1f265d09032a@rock-chips.com>
 <42e31ebc86a34001e98aecc7197e5e5a8fd5bb03.camel@mailbox.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <42e31ebc86a34001e98aecc7197e5e5a8fd5bb03.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dbe5f5bcf09cckunm285be13e5a72b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGR1LGlZMSEgZQh1DT0
	pMSB1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Fi7V9pY8ZOw0tD8M5p16PA3kxf597olaguS7wPofMdvCSf4uK4Afq9/+Pss7n/fHBOCKobXbtrfoUAp3+5g3EO4sWkf0eyTRKsXkjkwOuUcbm90TiJMpKlcXGoyMN6BrZIkIakzxHM7X++hhT6+r1edckswzvkLLt2dIIOKAN98=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=K7D/Cq8d0n845qmidR5g1Yrvl3Hy5XjvRQdVr6Z3HoM=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/22 星期三 21:07, Philipp Stanner 写道:
> On Wed, 2026-04-22 at 16:36 +0800, Shawn Lin wrote:
>> Hi Philipp
>>
>> 在 2026/04/22 星期三 15:32, Philipp Stanner 写道:
>>> On Wed, 2026-04-22 at 10:38 +0800, Shawn Lin wrote:
>>>> The PCI/MSI subsystem suffers from a long-standing design issue where

...

> 
> The biggest issue I see is that you add another hybrid function, even
> if it's temporary. pcim_alloc_irq_vectors() will sometimes be managed
> and sometimes not – until you have removed all users of the
> aforementioned functions, and finally performed step №4 from above.
> 
> Note that even in the past, with the oldest, most broken version of the
> PCI devres API, pcim_ functions were *always* managed, completely
> independently from pci(m)_enable_device().
> 
> What pcim_enable_device() did was implicitly switch some pci_
> functions, such as pci_request_regions(), into managed mode.
> 
> The solution presented / intended by you would rely on:
>     1. New users of pcim_ being aware (through documentation for
>        example) that this one pcim_ function is special and not always
>        managed (for now).

Agreed. That could be limited by code check instead of document, though.

>     2. New users being nice and really using pcim_enable_device().
>     3. You being able to fully see it all through to the end, i.e., you
>        not being switched to a different project, switching jobs and
>        opening a bar in Hawaii etc. etc.
> 

I've been contributing for over 10 years purely out of personal
interest, for non-employees' work like this series， no one's ever paid 
me for it. So it shouldn't be an issue at all for me. :))


> My experience has, unfortunately, been that people often don't read
> documentation, especially if they are already used to interfaces like
> that working a certain way.

+1

> How many drivers are there to be ported, do you have a list and maybe a
> time horizon? I took almost a year to remove my helper functions again.
> 

I will add it to my v4.

> That's not a hard "NACK" from my side, it's just I wouldn't do it like
> that. I suppose it is for the maintainers to pick one of the two
> solution pathways:
> 
> a) have another hybrid function temporarily or
> b) have duplicated code temporarily
> 
> (where "temporarily" means until the contributor finishes the job :)
> 

I fully understand your concern. The more straight way is to adopt
option b for sure. I will sent out my v4 soon.

Thanks for your suggestions, really appreciate!

> 
> BTW, please keep in mind that in my opinion, once PCI/MSI is solved, I
> believe that pcim_enable_device() should do nothing anymore but disable
> the device on driver detach, without any other side effects.
> 
> 
> Regards
> P.
> 
>>
>>
>>> The reason was that the hybrid behavior was burried so deep in the
>>> subsystem.
>>>
>>> See here:
>>>
>>> Here I had to reimplement some functions to be used by my new pcim_
>>> functions:
>>> https://lore.kernel.org/linux-pci/20240610093149.20640-4-pstanner@redhat.com/
>>>
>>>
>>> And here I could finally remove them later:
>>> https://lore.kernel.org/linux-pci/20250519112959.25487-7-phasta@kernel.org/
>>>
>>>
>>> I hope this helps. And again sorry for potentially causing you
>>> unnecessary work :(
>>>
>>>
>>> Regards
>>> Philipp
>>>
>>>
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
>>>>        unsigned int max_vecs, unsigned int flags,
>>>>        struct irq_affinity *affd);
>>>>    
>>>> +int pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>>> +   unsigned int max_vecs, unsigned int flags);
>>>> +int pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>>> +    unsigned int max_vecs, unsigned int flags,
>>>> +    struct irq_affinity *affd);
>>>> +
>>>>    bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
>>>>    struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>>>>          const struct irq_affinity_desc *affdesc);
>>>> @@ -1812,6 +1818,22 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>>>           flags, NULL);
>>>>    }
>>>>    
>>>> +static inline int
>>>> +pcim_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>>>> +        unsigned int max_vecs, unsigned int flags,
>>>> +        struct irq_affinity *aff_desc)
>>>> +{
>>>> + return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>>>> +       flags, aff_desc);
>>>> +}
>>>> +static inline int
>>>> +pcim_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>>> +       unsigned int max_vecs, unsigned int flags)
>>>> +{
>>>> + return pcim_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
>>>> +       flags, NULL);
>>>> +}
>>>> +
>>>>    static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
>>>>    { return false; }
>>>>    static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>>>
>>>
> 
> 
