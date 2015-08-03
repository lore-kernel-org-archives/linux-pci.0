Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52904 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbbHCKxn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Aug 2015 06:53:43 -0400
Message-ID: <55BF4830.9050104@arm.com>
Date: Mon, 03 Aug 2015 11:53:36 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Ley Foon Tan <lftan@altera.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v2 3/5] pci: altera: Add Altera PCIe MSI driver
References: <1438337715-22594-1-git-send-email-lftan@altera.com>	<1438337715-22594-4-git-send-email-lftan@altera.com>	<55BB6621.9060505@arm.com> <CAFiDJ5-5eZEBFwbuzrPB+XKX_E2Fd0qEeP-_H3Wz2jT8pcbJfQ@mail.gmail.com>
In-Reply-To: <CAFiDJ5-5eZEBFwbuzrPB+XKX_E2Fd0qEeP-_H3Wz2jT8pcbJfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/15 11:37, Ley Foon Tan wrote:
> On Fri, Jul 31, 2015 at 8:12 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 31/07/15 11:15, Ley Foon Tan wrote:
>>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
>>> number of vectors, which is a dts parameter.
>>
>> I've reviewed the initial drop of this code; basic courtesy would be to
>> keep me CCed on the follow-up series.
> Will keep you in CC for the following revision. Sorry about this.
> 
>>>
>>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>>> ---
>>>  drivers/pci/host/Kconfig           |   7 +
>>>  drivers/pci/host/Makefile          |   1 +
>>>  drivers/pci/host/pcie-altera-msi.c | 324 +++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 332 insertions(+)
>>>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
>>>

[...]

>>> +
>>> +     msg->address_lo = lower_32_bits(addr);
>>> +     msg->address_hi = upper_32_bits(addr);
>>> +     msg->data = data->hwirq;
>>> +
>>> +     mask = msi_readl(msi, MSI_INTMASK);
>>> +     mask |= 1 << data->hwirq;
>>> +     msi_writel(msi, mask, MSI_INTMASK);
>>
>> It feels a bit weird to unmask the interrupt when you compose the
>> message. I'd expect this to be done in the mask/unmask methods.
> Do you refer to these 2 callbacks?
> .irq_mask = pci_msi_mask_irq,
> .irq_unmask = pci_msi_unmask_irq,
> 
> How about we move this INTMASK code above to altera_irq_domain_alloc()?
> We have unmask code in altera_irq_domain_free() now.

Either you move the mask/unmask code to local irq_mask/irq_unmask
methods (and call pci_msi_(un)mask_irq from there), or you move it
entierely to alloc/free.

Some level of symmetry helps following what is going on in the code.

[...]

>>> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>> +                               unsigned int nr_irqs, void *args)
>>> +{
>>> +     struct altera_msi *msi = domain->host_data;
>>> +     int bit;
>>> +
>>> +     mutex_lock(&msi->lock);
>>> +
>>> +     bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>>> +     if (bit < msi->num_of_vectors)
>>> +             set_bit(bit, msi->used);
>>> +
>>> +     mutex_unlock(&msi->lock);
>>> +
>>> +     if (bit < 0)
>>> +             return bit;
>>
>> How can "bit" be negative here? find_first_zero_bit returns an unsigned
>> long... You probably want to change the type of "bit" to reflect that.
> Okay, will change to "unsigned long" type.
>>
>>> +     else if (bit >= msi->num_of_vectors)
>>
>> Useless "else" anyway.
> 
> I think we still need to check for failing case, if we don't have
> available unused bit.
> This could be rewritten  as below:
> 
> bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
> if (bit < msi->num_of_vectors)
>       set_bit(bit, msi->used);
> else
>       return -ENOSPC;

The more logical to write this is:

	if (bit >= msi->num_of_vectors)
		return -ENOSPC;

	set_bit(bit, msi->used);

which gets rid of the error case early and streamlines the normal case.

> 
>>
>>> +             return -ENOSPC;
>>> +
>>> +     irq_domain_set_info(domain, virq, bit, &altera_msi_bottom_irq_chip,
>>> +                         domain->host_data, handle_simple_irq,
>>> +                         NULL, NULL);
>>> +     set_irq_flags(virq, IRQF_VALID);
>>> +
>>> +     return 0;
>>> +}

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
