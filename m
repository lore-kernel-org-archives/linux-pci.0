Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0070.outbound.protection.outlook.com ([65.55.169.70]:51499
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755294AbbGPRAr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jul 2015 13:00:47 -0400
Message-ID: <55A7E334.3030101@caviumnetworks.com>
Date: Thu, 16 Jul 2015 10:00:36 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason Cooper" <jason@lakedaemon.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Robert Richter <rrichter@cavium.com>,
	"David Daney" <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] arm64, pci: Allow RC drivers to supply pcibios_add_device()
 implementation.
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com> <1436979285-8177-4-git-send-email-ddaney.cavm@gmail.com> <20150716090426.GA17097@red-moon>
In-Reply-To: <20150716090426.GA17097@red-moon>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/16/2015 02:04 AM, Lorenzo Pieralisi wrote:
> Hi David,
>
> On Wed, Jul 15, 2015 at 05:54:43PM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
[...]
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 4095379..3356023 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -38,11 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>>   	return res->start;
>>   }
>>
>> +static int (*pcibios_add_device_impl)(struct pci_dev *);
>> +
>> +void set_pcibios_add_device(int (*arg)(struct pci_dev *))
>> +{
>> +	pcibios_add_device_impl = arg;
>> +}
>> +
>>   /*
>>    * Try to assign the IRQ number from DT when adding a new device
>>    */
>>   int pcibios_add_device(struct pci_dev *dev)
>>   {
>> +	if (pcibios_add_device_impl)
>> +		return pcibios_add_device_impl(dev);
>
> I am totally against this (and to be honest by reading the other
> patches I failed to understand why you even need it), see above.
>

It is because ...


> Thanks,
> Lorenzo
>
>> +
>>   	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);


  ... this is total crap.  But I didn't want to break existing systems.

The PCI RC drivers need a way to configure the legacy virtual-wire 
interrupts, because the existing code doesn't do it.

David Daney



