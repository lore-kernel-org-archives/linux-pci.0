Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:52164
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751076AbaHOOxq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Aug 2014 10:53:46 -0400
Message-ID: <53EE1EE5.3060103@amd.com>
Date: Fri, 15 Aug 2014 09:53:25 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: Mark Rutland <Mark.Rutland@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Harish.Kasiviswanathan@amd.com" <Harish.Kasiviswanathan@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2 V4] irqchip: gicv2m: Add support for multiple MSI
 for ARM64 GICv2m
References: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1407942041-3291-3-git-send-email-suravee.suthikulpanit@amd.com>
 <87k369ri9k.fsf@approximate.cambridge.arm.com>
In-Reply-To: <87k369ri9k.fsf@approximate.cambridge.arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/15/2014 8:31 AM, Marc Zyngier wrote:
> Hi Suravee,
>
>> +/*
>> + * ARM64 function for seting up MSI irqs.
>> + * Copied from driver/pci/msi.c: arch_setup_msi_irqs().
>> + */
>> +int arm64_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>> +{
>> +	struct msi_desc *entry;
>> +	int ret;
>> +
>> +	if (type == PCI_CAP_ID_MSI && nvec > 1)
>> +		return 1;
>> +
>> +	list_for_each_entry(entry, &dev->msi_list, list) {
>> +		ret = arch_setup_msi_irq(dev, entry);
>> +		if (ret < 0)
>> +			return ret;
>> +		if (ret > 0)
>> +			return -ENOSPC;
>> +	}
>> +
>> +	return 0;
>> +}
>
> I'm going to reiterate what I said last time: Why do we need this?

[Suravee] Marc, I understand what you described last time but I think 
there is one point that missing here. See below.

> So far, we have two MSI-capable controllers on their way upstream:
> GICv2m and GICv3. Both are perfectly capable of handling more than a
> single MSI per device.

[Suravee] I am aware of this.

> So why should we cater for this? My gut feeling is that we should just
> have:
>
> int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> {
>          struct msi_desc *entry;
>          int ret;
>
>          /*
>           * So far, all our MSI controllers are capable of handling more
>           * than a single MSI per device. Should we encounter less
>           * capable devices, we'll consider doing something special for
>           * them.
>           */
>          list_for_each_entry(entry, &dev->msi_list, list) {
>                  ret = arch_setup_msi_irq(dev, entry);
>                  if (ret < 0)
>                          return ret;
>                  if (ret > 0)
>                          return -ENOSPC;
>          }
>
>          return 0;
> }
>
> and nothing else. Your driver should be able to retrieve the number of
> MSI needed by the device, and allocate them. GICv3 manages it, and so
> should GICv2m.
>

[Suravee] Multi-MSI and MSI-x are not the same. For MSI-X, you can treat 
each of the MSI separately since it MSI-X capability structure has a 
table specific for each one of them.  For Multi-MSI, there is only one 
MSI capability structure which control all of them, and you need to 
program the "multiple-message enable" field with the encoding for 
"power-of-two", and therefore must be in contiguous range.

Your logic above is what the standard MSI-x setup code is using. It is 
not handling of how many it can allocate all at once.

As for sharing the logic b/w GICv2m and GICv3, unless they are sharing 
the same common data structure (e.g. the struct v2m which contans 
msi_chip), and the allocation function (e.g. generic 
gic_alloc_msi_irqs()), you pretty much need to do this separately since 
we need to walk the msi_chip back to its container structure.

I am not saying this cannot be done, but we need to work out the detail 
together b/w GICv2m and GICv3.

Thanks,

Suravee


