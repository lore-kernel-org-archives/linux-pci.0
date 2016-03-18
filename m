Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43288 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639AbcCRPJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Mar 2016 11:09:31 -0400
Subject: Re: PCI IO resource question.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <56E987B8.1090904@ti.com> <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com> <20160316192904.GA2703@localhost>
 <56E9BE6A.6090107@ti.com> <20160316214733.GA11542@localhost>
 <56EB217F.8070603@ti.com> <20160318112802.GA1810@red-moon>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56EC1A27.7000206@ti.com>
Date: Fri, 18 Mar 2016 11:09:27 -0400
MIME-Version: 1.0
In-Reply-To: <20160318112802.GA1810@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/18/2016 07:28 AM, Lorenzo Pieralisi wrote:
> On Thu, Mar 17, 2016 at 05:28:31PM -0400, Murali Karicheri wrote:
> 
> [...]
> 
>>> The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
>>> "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
>>>
>>> I expect you're in this path:
>>>
>>>   ahci_init_one
>>>     pcim_enable_device
>>>       pci_enable_device
>>>         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
>>>           # build "bars" mask
>>>           do_pci_enable_device(dev, bars)
>>>             pcibios_enable_device
>>>               if (pci_has_flag(PCI_PROBE_ONLY))
>>>                 return 0;
>>>               pci_enable_resources
>>>
>>> Can you add a little debug code like this to verify that we're in this
>>> path?
>>
>> Yes we are in the path.
>>
>>
>> [    1.557561] ahci_init_one
>> [    1.560214] ahci 0000:01:00.0: version 3.0
>> [    1.564302] pcim_enable_device
>> [    1.567349] pci_enable_device
>> [    1.570340] pci_enable_device_flags
>> [    1.573824] do_pci_enable_device
>> [    1.577042] pcibios_enable_device
>> [    1.580380] pci_enable_resources
> 
> So resources are actually enabled (ie PCI_PROBE_ONLY is not set)
> and that makes sense otherwise you would not be able to use the
> MEM resources anyway (ie they would not be enabled).
> 
> I suspect the PCI dev IO resources were reset in reset_resource() in
> assign_requested_resource_sorted(), hence the bar mask that is built
> in pci_enable_device_flags() does not contain the IO resources,
> it would be helpful if you can print the bar mask passed to
> pcibios_enable_device() (ie the mask parameter).

Here it is

[    1.556507] ahci_init_one
[    1.559124] ahci 0000:01:00.0: version 3.0
[    1.563246] pcim_enable_device
[    1.566294] pci_enable_device
[    1.569252] pci_enable_device_flags
[    1.572766] do_pci_enable_device
[    1.575985] pcibios_enable_device 60
[    1.579551] pci_enable_resources

I know that some of our customers use PCIe SATA from u-boot and would
like to honor the assignment in Linux space.. I believe they use PCI_PROBE_ONLY
by setting the bootarg. So Keystone PCI should work in both cases.

Murali
> 
> Not saying that's what should happen, I think that's what's happening,
> that's the only reason I see why you do not have pci_enable_resources()
> failures when you remove the IO range from the host bridge.
> 
> Lorenzo
> 
>> [    1.583608] ahci 0000:01:00.0: limiting MRRS to 256
>> [    1.588595] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
>> [    1.596716] ahci 0000:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
>> [    1.606183] scsi host0: ahci
>> [    1.609448] scsi host1: ahci
>> [    1.612636] ata1: SATA max UDMA/133 abar m512@0x60000000 port 0x60000100 irq 82
>> [    1.619974] ata2: SATA max UDMA/133 abar m512@0x60000000 port 0x60000180 irq 82
>>
>>>
>>>> I looked at pci_enable_resources()
>>>>
>>>> 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>>>> 		if (!(mask & (1 << i)))
>>>> 			continue;
>>>>
>>>> 		r = &dev->resource[i];
>>>
>>>                 dev_info(&dev->dev, "BAR %d %pR mask %#04x parent %p\n", i, r, mask, r->parent);
>>>
>>>>
>>>> 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>>>> 			continue;
>>>> 		if ((i == PCI_ROM_RESOURCE) &&
>>>> 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
>>>> 			continue;
>>>>
>>>> 		if (r->flags & IORESOURCE_UNSET) {
>>>> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
>>>> 				i, r);
>>>> 			return -EINVAL;
>>>> 		}
>>>>
>>>> 		if (!r->parent) {
>>>> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not claimed\n",
>>>> 				i, r);
>>>> 			return -EINVAL;
>>>> 		}
>>>>
>>>> I don't see the error "can't enable device: BAR %d %pR not assigned" , so it doesn't
>>>> depend on IO bar as you mention below or is it in a different function?
>>>
>>
>>
>> -- 
>> Murali Karicheri
>> Linux Kernel, Keystone
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


-- 
Murali Karicheri
Linux Kernel, Keystone
