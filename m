Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0114.outbound.protection.outlook.com ([157.56.111.114]:48560
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755293AbaIWREr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 13:04:47 -0400
Message-ID: <5421A825.70201@amd.com>
Date: Tue, 23 Sep 2014 10:04:37 -0700
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	<jason@lakedaemon.net>, <pawel.moll@arm.com>,
	<Catalin.Marinas@arm.com>, <Will.Deacon@arm.com>,
	<liviu.dudau@arm.com>, <Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [V8 1/2] irqchip: gic: Add support for multiple MSI for ARM64
References: <1411230698-8081-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411230698-8081-2-git-send-email-suravee.suthikulpanit@amd.com>
 <alpine.DEB.2.10.1409222349560.4604@nanos>
In-Reply-To: <alpine.DEB.2.10.1409222349560.4604@nanos>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

Sorry again for the mistake on my part. Let me try to address some other 
concerns you have below.


On 09/22/2014 04:08 PM, Thomas Gleixner wrote:
> On Sat, 20 Sep 2014, suravee.suthikulpanit@amd.com wrote:
>
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> This patch implelments the ARM64 version of arch_setup_msi_irqs(),
>> which does not return 1 for when PCI_CAP_ID_MSI and nvec > 1.
>
> I can see that myself. What your changelog is missing is the reason
> WHY you think that copying that code from drivers/pci/msi.c and
> removing the "PCI_CAP_ID_MSI and nvec > 1" has any value.

[Suravee] This is mainly be cause the weak version of 
arch_setup_msi_irqs() in the drivers/pci/msi.c doesn't support 
multi-MSI. Sorry for not being clear in the commit message.

>
> And that new function "arm64_setup_msi_irqs" is declared in which
> header file exactly?

[Suravee] This was supposed to be arch_setup_msi_irqs(). My bad. I'm 
fixing this in the next version.

......

>> + *
>> + * Note:
>> + * Current implementation assumes that all interrupt controller used in
>> + * ARM64 architecture _MUST_ supports multi-MSI.
>
> Great assumption....
>

[Suravee] So, Marc and I have discussed in the past that at this point, 
we are not seeing the case that there will be interrupt or 
MSI-controller that will not support multi-MSI.  If you think this 
should not be the case, would you please share your thought.

......

>
> At least you are consistent on the useless side of affairs:
>
>> +{
>> +	struct msi_desc *entry;
>> +	int ret;
>> +
>> +	list_for_each_entry(entry, &dev->msi_list, list) {
>> +		ret = arch_setup_msi_irq(dev, entry);
>
> Anyone who has the slightest idea how multi-MSI works will know that
> this CANNOT work at all, but that's none of my business.

[Suravee] I noticed that in the x86 version, there is a callback that 
each MSI controller need to register for handling the multi-MSI stuff.

In gicv2m_setup_msi_irq(), there is logic which handles the setup for 
multi-MSI and MSIx separately. In case of multi-MSI, the vectors are 
allocated on the first call to arch_setup_msi_irq(). Here, Marc and I 
are trying to simplify the arch-specific code so that each GIC 
controller (V2m and V3) would not need to implement and register the 
callbacks separately for handling multi-MSI.

The thing that is broken here is the error handling where the 
arch_setup_msi_irqs() is supposed to return the number of available MSI 
vectors. It would fail to do so because the arch_setup_msi_irq() would 
not return positive value. We should be able to fix this by 
re-implementing the arch_setup_msi_irq() and arch_setup_msi_irqs() to 
allow returning of positive values.

Please let me know what you think. I am open for suggestions :)

Thanks,

Suravee
