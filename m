Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:22631 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbbKSC46 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2015 21:56:58 -0500
Subject: Re: [PATCH 4/5] PCI: iproc: Add iProc PCIe MSI support
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
 <1447806715-30043-5-git-send-email-rjui@broadcom.com>
 <20151118084845.49ba6304@arm.com> <564D27CC.3030505@broadcom.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <564D3A78.4020804@broadcom.com>
Date: Wed, 18 Nov 2015 18:56:56 -0800
MIME-Version: 1.0
In-Reply-To: <564D27CC.3030505@broadcom.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On 11/18/2015 5:37 PM, Ray Jui wrote:
> Hi Marc,
>
> On 11/18/2015 12:48 AM, Marc Zyngier wrote:
>> On Tue, 17 Nov 2015 16:31:54 -0800
>> Ray Jui <rjui@broadcom.com> wrote:

>>> +static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
>>> +                      unsigned int virq, unsigned int nr_irqs,
>>> +                      void *args)
>>> +{
>>> +    struct iproc_msi *msi = domain->host_data;
>>> +    int i, msi_irq;
>>> +
>>> +    mutex_lock(&msi->bitmap_lock);
>>> +
>>> +    for (i = 0; i < nr_irqs; i++) {
>>> +        msi_irq = find_first_zero_bit(msi->used, msi->nirqs);
>>
>> This is slightly puzzling. Do you really have at most 6 MSIs? Usually,
>> we end up with a larger number of MSIs (32 or 64) multiplexed on top of
>> a small number of wired interrupts. Here, you seem to have a 1-1
>> mapping. Is that really the case?
>
> Yes, based on the poorly written iProc PCIe arch doc, :), we seem to
> have 1-1 mapping between each wired interrupt and MSI, with each MSI
> handled by an event queue, that consists of 64x word entries allocated
> from host memory (DDR). The MSI data is stored in the low 16-bit of each
> entry, whereas the upper 16-bit of each entry is reserved for the iProc
> PCIe controller for its own use.
>

In fact, let me confirm with our ASIC team on the above statement. The 
iProc PCIe arch doc is in fact not very clear on this....

>>
>> If so (and assuming the wired interrupts are always contiguous), you
>> shouldn't represent this as a chained interrupt (a multiplexer), but as
>> a stacked irqchip, similar to what GICv2m does.
>>
>
> Okay, I think I might be missing something here, but I thought I
> currently have a stacked irqdomain (chip), i.e., GIC -> inner_domain ->
> MSI domain?
>
> And does this imply I should expect 'nr_irqs' in this routine to be
> always zero and therefore I can get rid of the for loop here (same in
> the domain free routine)?
>

Thanks,

Ray
