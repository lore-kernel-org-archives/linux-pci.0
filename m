Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55BF4830.9050104@arm.com>
References: <1438337715-22594-1-git-send-email-lftan@altera.com>
	<1438337715-22594-4-git-send-email-lftan@altera.com>
	<55BB6621.9060505@arm.com>
	<CAFiDJ5-5eZEBFwbuzrPB+XKX_E2Fd0qEeP-_H3Wz2jT8pcbJfQ@mail.gmail.com>
	<55BF4830.9050104@arm.com>
Date: Mon, 3 Aug 2015 19:00:13 +0800
Message-ID: <CAFiDJ5_WaNwXMppkhbxVakW2UddN29ypxE9dxhnyfEw5iwvmcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pci: altera: Add Altera PCIe MSI driver
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 3, 2015 at 6:53 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 03/08/15 11:37, Ley Foon Tan wrote:

>>>> +     msg->address_lo = lower_32_bits(addr);
>>>> +     msg->address_hi = upper_32_bits(addr);
>>>> +     msg->data = data->hwirq;
>>>> +
>>>> +     mask = msi_readl(msi, MSI_INTMASK);
>>>> +     mask |= 1 << data->hwirq;
>>>> +     msi_writel(msi, mask, MSI_INTMASK);
>>>
>>> It feels a bit weird to unmask the interrupt when you compose the
>>> message. I'd expect this to be done in the mask/unmask methods.
>> Do you refer to these 2 callbacks?
>> .irq_mask = pci_msi_mask_irq,
>> .irq_unmask = pci_msi_unmask_irq,
>>
>> How about we move this INTMASK code above to altera_irq_domain_alloc()?
>> We have unmask code in altera_irq_domain_free() now.
>
> Either you move the mask/unmask code to local irq_mask/irq_unmask
> methods (and call pci_msi_(un)mask_irq from there), or you move it
> entierely to alloc/free.
>
> Some level of symmetry helps following what is going on in the code.
Okay, will move it to alloc/free.
>
> [...]
>
>>>> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>> +                               unsigned int nr_irqs, void *args)
>>>> +{
>>>> +     struct altera_msi *msi = domain->host_data;
>>>> +     int bit;
>>>> +
>>>> +     mutex_lock(&msi->lock);
>>>> +
>>>> +     bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>>>> +     if (bit < msi->num_of_vectors)
>>>> +             set_bit(bit, msi->used);
>>>> +
>>>> +     mutex_unlock(&msi->lock);
>>>> +
>>>> +     if (bit < 0)
>>>> +             return bit;
>>>
>>> How can "bit" be negative here? find_first_zero_bit returns an unsigned
>>> long... You probably want to change the type of "bit" to reflect that.
>> Okay, will change to "unsigned long" type.
>>>
>>>> +     else if (bit >= msi->num_of_vectors)
>>>
>>> Useless "else" anyway.
>>
>> I think we still need to check for failing case, if we don't have
>> available unused bit.
>> This could be rewritten  as below:
>>
>> bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>> if (bit < msi->num_of_vectors)
>>       set_bit(bit, msi->used);
>> else
>>       return -ENOSPC;
>
> The more logical to write this is:
>
>         if (bit >= msi->num_of_vectors)
>                 return -ENOSPC;
>
>         set_bit(bit, msi->used);
>
> which gets rid of the error case early and streamlines the normal case.
Yes, will change to this way.

Thanks.

Regards
Ley Foon
