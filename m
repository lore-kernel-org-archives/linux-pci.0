Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63961 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096AbbBBQGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Feb 2015 11:06:49 -0500
Message-ID: <54CFA093.9040508@linux.intel.com>
Date: Tue, 03 Feb 2015 00:06:43 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <CAErSpo5=NhPZ5RNbBeGqKuLbKdOyTD1m+ijWM2SzQFWuKLTJfg@mail.gmail.com>
In-Reply-To: <CAErSpo5=NhPZ5RNbBeGqKuLbKdOyTD1m+ijWM2SzQFWuKLTJfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/2/2 23:57, Bjorn Helgaas wrote:
> On Wed, Jan 28, 2015 at 8:51 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> pcibios_update_irq writes an irq number into the config space
>> of a given PCI device, but ignores the fact that this number
>> is a virtual interrupt number, which might be a very different
>> value from what the underlying hardware is using.
>>
>> The obvious fix is to fetch the HW interrupt number from the
>> corresponding irq_data structure. This is slightly complicated
>> by the fact that this interrupt might be services by a stacked
>> domain.
>>
>> This has been tested on KVM with kvmtool.
>>
>> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Jiang, are you OK with this patch as-is now, since it isn't used on x86?
Sure, I'm OK. I missed the point that it's not used on x86 at all
in previous review.

> 
> Marc, Lorenzo, I assume this actually fixes a bug.  Can we get any
> more details about what happens when you hit the bug, and how you
> reproduced it (what platform, driver, etc.)?
> 
> Bjorn
> 
>> ---
>>  drivers/pci/setup-irq.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
>> index 4e2d595..828cbc9 100644
>> --- a/drivers/pci/setup-irq.c
>> +++ b/drivers/pci/setup-irq.c
>> @@ -15,11 +15,19 @@
>>  #include <linux/errno.h>
>>  #include <linux/ioport.h>
>>  #include <linux/cache.h>
>> +#include <linux/irq.h>
>>
>>  void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>>  {
>> -       dev_dbg(&dev->dev, "assigning IRQ %02d\n", irq);
>> -       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>> +       struct irq_data *d;
>> +
>> +       d = irq_get_irq_data(irq);
>> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
>> +       while (d->parent_data)
>> +               d = d->parent_data;
>> +#endif
>> +       dev_dbg(&dev->dev, "assigning IRQ %02ld\n", d->hwirq);
>> +       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, d->hwirq);
>>  }
>>
>>  static void pdev_fixup_irq(struct pci_dev *dev,
>> --
>> 2.1.4
>>
