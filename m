Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:12531 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaIXDLn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 23:11:43 -0400
Message-ID: <54223666.8040500@huawei.com>
Date: Wed, 24 Sep 2014 11:11:34 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: Remove the redundant irq_set_msi_desc()
References: <1410320852-17725-1-git-send-email-wangyijing@huawei.com> <20140923182311.GC6776@google.com>
In-Reply-To: <20140923182311.GC6776@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/9/24 2:23, Bjorn Helgaas wrote:
> On Wed, Sep 10, 2014 at 11:47:32AM +0800, Yijing Wang wrote:
>> Irq and msi_desc will be associated in arch MSI
>> setup code. The irq_set_msi_desc() in msix_program_entries()
>> is redundant.
> 
> Can you help me review this by mentioning exactly *where* the IRQ and
> msi_desc are associated by the arch MSI setup code?

Hi Bjorn,
   We have two ARCH MSI interfaces, arch_setup_msi_irqs() and arch_setup_msi_irq().

Use arch_setup_msi_irqs():
x86:
native_setup_msi_irqs()
	setup_msi_irq()
		irq_set_msi_desc_off();	   ---associate irq and msi_desc

irq remapping also call setup_msi_irq() finally, so irq and msi_desc also will be associated.

xen:
All xen ARCH MSI funcs also call irq_set_msi_desc() in xen_bind_pirq_msi_to_irq().

mips: Msi-octeon,
arch_setup_msi_irqs()
	arch_setup_msi_irq()
		irq_set_msi_desc()	---associate irq and msi_desc

s390:
arch_setup_msi_irqs()
	irq_set_msi_desc()

powerpc:
axon_msi_setup_msi_irqs()
fsl_setup_msi_irqs()
pasemi_msi_setup_msi_irqs()
u3msi_setup_msi_irqs()
rtas_setup_msi_irqs()
pnv_setup_msi_irqs()
....

All above ARCH MSI func call irq_set_msi_desc().

There are a lot of ARCH MSI code in kernel, and I almost checked each one,
irq_set_msi_desc() and irq_set_msi_desc_off() always be called in ARCH MSI code.


I grep it and we can find almost every ARCH has been called irq_set_msi_desc()

[yijing@localhost linux]$ grep -Rn "irq_set_msi_desc" --include="*.c" .
./arch/ia64/sn/kernel/msi_sn.c:147:	irq_set_msi_desc(irq, entry);
./arch/ia64/kernel/msi_ia64.c:56:	irq_set_msi_desc(irq, desc);
./arch/mips/pci/msi-xlp.c:344:	ret = irq_set_msi_desc(xirq, desc);
./arch/mips/pci/msi-xlp.c:445:	ret = irq_set_msi_desc(xirq, desc);
./arch/mips/pci/msi-octeon.c:180:	irq_set_msi_desc(irq, desc);
./arch/mips/pci/pci-xlr.c:259:	ret = irq_set_msi_desc(irq, desc);
./arch/powerpc/sysdev/ppc4xx_hsta_msi.c:81:		if (irq_set_msi_desc(hwirq, entry)) {
./arch/powerpc/sysdev/ppc4xx_hsta_msi.c:119:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/sysdev/mpic_pasemi_msi.c:76:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/sysdev/mpic_pasemi_msi.c:128:		irq_set_msi_desc(virq, entry);
./arch/powerpc/sysdev/ppc4xx_msi.c:117:		irq_set_msi_desc(virq, entry);
./arch/powerpc/sysdev/ppc4xx_msi.c:134:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/sysdev/fsl_msi.c:121:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/sysdev/fsl_msi.c:225:		irq_set_msi_desc(virq, entry);
./arch/powerpc/sysdev/mpic_u3msi.c:116:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/sysdev/mpic_u3msi.c:164:		irq_set_msi_desc(virq, entry);
./arch/powerpc/platforms/cell/axon_msi.c:280:		irq_set_msi_desc(virq, entry);
./arch/powerpc/platforms/cell/axon_msi.c:298:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/platforms/pseries/msi.c:123:		irq_set_msi_desc(entry->irq, NULL);
./arch/powerpc/platforms/pseries/msi.c:476:		irq_set_msi_desc(virq, entry);
./arch/powerpc/platforms/powernv/pci.c:93:		irq_set_msi_desc(virq, entry);
./arch/powerpc/platforms/powernv/pci.c:111:		irq_set_msi_desc(entry->irq, NULL);
./arch/tile/kernel/pci_gx.c:1588:	irq_set_msi_desc(irq, desc);
./arch/s390/pci/pci.c:398:		rc = irq_set_msi_desc(irq, msi);
./arch/s390/pci/pci.c:422:		irq_set_msi_desc(msi->irq, NULL);
./arch/s390/pci/pci.c:454:		irq_set_msi_desc(msi->irq, NULL);
./arch/arm/mach-iop13xx/msi.c:148:	irq_set_msi_desc(irq, desc);
./arch/sparc/kernel/pci_msi.c:163:	irq_set_msi_desc(*irq_p, entry);
./arch/x86/kernel/apic/io_apic.c:3185:	irq_set_msi_desc_off(irq_base, irq_offset, msidesc);
./drivers/irqchip/irq-armada-370-xp.c:153:	irq_set_msi_desc(virq, desc);
./drivers/pci/host/pcie-rcar.c:637:	irq_set_msi_desc(irq, desc);
./drivers/pci/host/pci-tegra.c:1176:	irq_set_msi_desc(irq, desc);
./drivers/pci/host/pcie-designware.c:238:		irq_set_msi_desc_off(irq_base, i, NULL);
./drivers/pci/host/pcie-designware.c:299:		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
./drivers/pci/msi.c:692:		irq_set_msi_desc(entry->irq, entry);
./drivers/xen/events/events_base.c:742:	ret = irq_set_msi_desc(irq, msidesc);
./kernel/irq/chip.c:92: *	irq_set_msi_desc_off - set MSI descriptor data for an irq at offset
./kernel/irq/chip.c:99:int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset,
./kernel/irq/chip.c:115: *	irq_set_msi_desc - set MSI descriptor data for an irq
./kernel/irq/chip.c:121:int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
./kernel/irq/chip.c:123:	return irq_set_msi_desc_off(irq, 0, entry);

[yijing@localhost linux]$ grep -Rn "irq_set_msi_desc_off" --include="*.c" .
./arch/x86/kernel/apic/io_apic.c:3185:	irq_set_msi_desc_off(irq_base, irq_offset, msidesc);
./drivers/pci/host/pcie-designware.c:238:		irq_set_msi_desc_off(irq_base, i, NULL);
./drivers/pci/host/pcie-designware.c:299:		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
./kernel/irq/chip.c:92: *	irq_set_msi_desc_off - set MSI descriptor data for an irq at offset
./kernel/irq/chip.c:99:int irq_set_msi_desc_off(unsigned int irq_base, unsigned int irq_offset,
./kernel/irq/chip.c:123:	return irq_set_msi_desc_off(irq, 0, entry);


> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 5a40516..902b0cb 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -719,7 +719,6 @@ static void msix_program_entries(struct pci_dev *dev,
>>  						PCI_MSIX_ENTRY_VECTOR_CTRL;
>>  
>>  		entries[i].vector = entry->irq;
>> -		irq_set_msi_desc(entry->irq, entry);
>>  		entry->masked = readl(entry->mask_base + offset);
>>  		msix_mask_irq(entry, 1);
>>  		i++;
>> -- 
>> 1.7.1
>>
> 
> 


-- 
Thanks!
Yijing

