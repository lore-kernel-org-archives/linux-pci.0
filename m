Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40720 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbBBSI0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 13:08:26 -0500
Message-ID: <54CFBD11.3010004@arm.com>
Date: Mon, 02 Feb 2015 18:08:17 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Przywara <Andre.Przywara@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com> <20150202163344.GF8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150202163344.GF8656@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Russell,

On 02/02/15 16:33, Russell King - ARM Linux wrote:
> On Wed, Jan 28, 2015 at 02:51:23PM +0000, Marc Zyngier wrote:
>>  void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>>  {
>> -	dev_dbg(&dev->dev, "assigning IRQ %02d\n", irq);
>> -	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>> +	struct irq_data *d;
>> +
>> +	d = irq_get_irq_data(irq);
>> +#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
>> +	while (d->parent_data)
>> +		d = d->parent_data;
>> +#endif
>> +	dev_dbg(&dev->dev, "assigning IRQ %02ld\n", d->hwirq);
>> +	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, d->hwirq);
> 
> I'm really not convinced about this being the correct thing to do.
> 
> Let's take an older ARM system, such as a Footbridge based system with a
> PCI southbridge.
> 
> Such a system has IRQs 0-15 as the PCI southbridge ISA interrupts.  Then
> there are four PCI interrupts provided by the on-board Footbridge.
> 
> Right now, PCI devices are programmed with the OS specific interrupt
> number - eg:
> 
> 00:06.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
>         Flags: medium devsel, IRQ 14
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00
> 
> 00:06.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
>         Flags: medium devsel, IRQ 15
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 02 00 00
> 
> 00:06.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
>         Flags: medium devsel, IRQ 12
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00
> 
> 00:07.0 Mass storage controller: Integrated Technology Express, Inc. IT/ITE8212
> Dual channel ATA RAID controller (rev 13)
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 24
> 30: 00 00 02 04 80 00 00 00 00 00 00 00 18 01 08 08
> 
> 00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
>         Flags: bus master, medium devsel, latency 32, IRQ 22
> 30: 00 00 06 04 dc 00 00 00 00 00 00 00 16 01 0a 0a
> 
> 00:09.0 VGA compatible controller: S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX] (rev 16) (prog-if 00 [VGA controller])
>         Flags: medium devsel, IRQ 21
> 30: 00 00 00 0c 00 00 00 00 00 00 00 00 15 01 00 00
> 
> What your change would mean is that the IRQs currently being programmed
>> = 16 would be programmed into with numbers with 16 removed from them.
> This means that legacy stuff (eg on the Southbridge which really do signal
> via the ISA IRQ controller) end up using the same number range as those
> which take PCI specific IRQs.
> 
> This surely is not sane.

I suppose this is ebsa285? I must confess I don't see how to distinguish
the two cases (the GIC case uses a purely virtual number, and the
footbridge case uses something that seems to be physical).

A very easy fix would be to entirely contain this change within #ifdef
CONFIG_IRQ_DOMAIN_HIERARCHY/#endif, but that doesn't fill me with
confidence.

What I don't get is how the hwirq field is set in this case. It probably
isn't very useful (as there is no domain lookup), so I would have hoped
to see irq == hwirq. Obviously, this is not the case. What am I missing?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
