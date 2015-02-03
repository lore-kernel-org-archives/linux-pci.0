Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40772 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbbBCKii (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 05:38:38 -0500
Message-ID: <54D0A521.7030405@arm.com>
Date: Tue, 03 Feb 2015 10:38:25 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Przywara <Andre.Przywara@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <4145359.V8A0ARGtXz@wuerfel>
In-Reply-To: <4145359.V8A0ARGtXz@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/02/15 17:02, Arnd Bergmann wrote:
> On Wednesday 28 January 2015 14:51:23 Marc Zyngier wrote:
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
> 
> I'm puzzled by this. Why is it even important what we write into
> the config space? Isn't this just an interface between BIOS and
> OS for systems that rely on the interrupt numbers to be statically
> assigned before boot?

That's exactly what I thought until Lorenzo reported kvmtool falling
over because of this write. Obviously, some platforms must actually
require this (possibly for bridges that are not known by the firmware).

Entirely removing that code solves my problem too, but that'd cannot be
the right solution...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
