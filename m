Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbbG0XNP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 19:13:15 -0400
Message-ID: <55B6BB0A.80904@redhat.com>
Date: Mon, 27 Jul 2015 19:13:14 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 10/11] PCI: Stop caching ATS Invalidate Queue Depth
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150721001511.28145.29144.stgit@bhelgaas-glaptop2.roam.corp.google.com> <55B63995.8000808@redhat.com> <20150727222726.GA24401@google.com>
In-Reply-To: <20150727222726.GA24401@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/27/2015 06:27 PM, Bjorn Helgaas wrote:
> Hi Don,
>
> On Mon, Jul 27, 2015 at 10:00:53AM -0400, Don Dutile wrote:
>> On 07/20/2015 08:15 PM, Bjorn Helgaas wrote:
>>> Stop caching the Invalidate Queue Depth in struct pci_dev.
>>> pci_ats_queue_depth() is typically called only once per device, and it
>>> returns a fixed value per-device, so callers who need the value frequently
>>> can cache it themselves.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>   drivers/pci/ats.c   |    9 ++++-----
>>>   include/linux/pci.h |    1 -
>>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>> index 67524a7..bdb1383 100644
>>> --- a/drivers/pci/ats.c
>>> +++ b/drivers/pci/ats.c
>>> @@ -20,16 +20,12 @@
>>>   void pci_ats_init(struct pci_dev *dev)
>>>   {
>>>   	int pos;
>>> -	u16 cap;
>>>
>>>   	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
>>>   	if (!pos)
>>>   		return;
>>>
>>>   	dev->ats_cap = pos;
>>> -	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CAP, &cap);
>>> -	dev->ats_qdep = PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) :
>>> -					    PCI_ATS_MAX_QDEP;
>>>   }
>>>
>>>   /**
>>> @@ -131,13 +127,16 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
>>>    */
>>>   int pci_ats_queue_depth(struct pci_dev *dev)
>>>   {
>>> +	u16 cap;
>>> +
>>>   	if (!dev->ats_cap)
>>>   		return -EINVAL;
>>>
>>>   	if (dev->is_virtfn)
>>>   		return 0;
>>>
>> hmmm, isn't one of the fixes in this patch set to
>> change the caching of ats queue depth ?  won't above
>> make it 0 for all VF's ?  is that correct, or desired (virtual) value?
>
> Per spec (SR-IOV r1.1., sec 3.7.4), the ATS queue depth register on a VF
> always contains zero.
>
> Here's the v4.1 code:
>
>      int pci_ats_queue_depth(struct pci_dev *dev)
>      {
>          if (dev->is_virtfn)
>                  return 0;
>
>          if (dev->ats)
>                  return dev->ats->qdep;
>
> 	...
>
>
> In v4.1, pci_ats_queue_depth() always returned 0 for a VF.  For VFs, we
> didn't look at the dev->ats->qdep cache.  So I don't think this changes
> anything for the caller.
>
> A previous patch changed this path so we return -EINVAL instead of 0 for
> VFs that don't support ATS.  I think the previous behavior there was wrong,
> but I doubt anybody noticed.
>
> Bjorn
>
ok. thanks for the sanity check.

>>> -	return dev->ats_qdep;
>>> +	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CAP, &cap);
>>> +	return PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) : PCI_ATS_MAX_QDEP;
>>>   }
>>>   EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
>>>
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 307f96a..4b484fd 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -378,7 +378,6 @@ struct pci_dev {
>>>   	};
>>>   	u16		ats_cap;	/* ATS Capability offset */
>>>   	u8		ats_stu;	/* ATS Smallest Translation Unit */
>>> -	u8		ats_qdep;	/* ATS Invalidate Queue Depth */
>>>   	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
>>>   #endif
>>>   	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>

