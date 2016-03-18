Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52832 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbcCRTvH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Mar 2016 15:51:07 -0400
Subject: Re: PCI IO resource question.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160316164531.GA28797@localhost> <56E9A12F.50008@ti.com>
 <20160316192904.GA2703@localhost> <56E9BE6A.6090107@ti.com>
 <20160316214733.GA11542@localhost> <56EB217F.8070603@ti.com>
 <20160318112802.GA1810@red-moon> <56EC1A27.7000206@ti.com>
 <20160318152824.GA18864@localhost> <56EC4523.9010304@ti.com>
 <20160318193447.GA28507@localhost>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56EC5C29.1010406@ti.com>
Date: Fri, 18 Mar 2016 15:51:05 -0400
MIME-Version: 1.0
In-Reply-To: <20160318193447.GA28507@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/18/2016 03:34 PM, Bjorn Helgaas wrote:
> On Fri, Mar 18, 2016 at 02:12:51PM -0400, Murali Karicheri wrote:
>> On 03/18/2016 11:28 AM, Bjorn Helgaas wrote:
>>> On Fri, Mar 18, 2016 at 11:09:27AM -0400, Murali Karicheri wrote:
>>>> On 03/18/2016 07:28 AM, Lorenzo Pieralisi wrote:
>>>>> On Thu, Mar 17, 2016 at 05:28:31PM -0400, Murali Karicheri wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
>>>>>>> "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
>>>>>>>
>>>>>>> I expect you're in this path:
>>>>>>>
>>>>>>>   ahci_init_one
>>>>>>>     pcim_enable_device
>>>>>>>       pci_enable_device
>>>>>>>         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
>>>>>>>           # build "bars" mask
>>>>>>>           do_pci_enable_device(dev, bars)
>>>>>>>             pcibios_enable_device
>>>>>>>               if (pci_has_flag(PCI_PROBE_ONLY))
>>>>>>>                 return 0;
>>>>>>>               pci_enable_resources
>>>>>>>
>>>>>>> Can you add a little debug code like this to verify that we're in this
>>>>>>> path?
>>>>>>
>>>>>> Yes we are in the path.
>>>>>>
>>>>>>
>>>>>> [    1.557561] ahci_init_one
>>>>>> [    1.560214] ahci 0000:01:00.0: version 3.0
>>>>>> [    1.564302] pcim_enable_device
>>>>>> [    1.567349] pci_enable_device
>>>>>> [    1.570340] pci_enable_device_flags
>>>>>> [    1.573824] do_pci_enable_device
>>>>>> [    1.577042] pcibios_enable_device
>>>>>> [    1.580380] pci_enable_resources
>>>>>
>>>>> So resources are actually enabled (ie PCI_PROBE_ONLY is not set)
>>>>> and that makes sense otherwise you would not be able to use the
>>>>> MEM resources anyway (ie they would not be enabled).
>>>>>
>>>>> I suspect the PCI dev IO resources were reset in reset_resource() in
>>>>> assign_requested_resource_sorted(), hence the bar mask that is built
>>>>> in pci_enable_device_flags() does not contain the IO resources,
>>>>> it would be helpful if you can print the bar mask passed to
>>>>> pcibios_enable_device() (ie the mask parameter).
>>>>
>>>> Here it is
>>>>
>>>> [    1.556507] ahci_init_one
>>>> [    1.559124] ahci 0000:01:00.0: version 3.0
>>>> [    1.563246] pcim_enable_device
>>>> [    1.566294] pci_enable_device
>>>> [    1.569252] pci_enable_device_flags
>>>> [    1.572766] do_pci_enable_device
>>>> [    1.575985] pcibios_enable_device 60
>>>> [    1.579551] pci_enable_resources
>>>>
>>>> I know that some of our customers use PCIe SATA from u-boot and would
>>>> like to honor the assignment in Linux space.. I believe they use PCI_PROBE_ONLY
>>>> by setting the bootarg. So Keystone PCI should work in both cases.
>>>
>>> We're only getting little pieces of the story here.  Can you apply the
>>> following patch and collect the entire dmesg log?  I want to see:
>>>
>>>   - the root bus resources (which presumably include no I/O space)
>>>   - all the SATA resources during enumeration (which should include an
>>>     I/O BAR)
>>>   - the reset_resource() call that clears the I/O BAR flags
>>>   - all the SATA resources in pci_enable_resources() (the I/O BAR
>>>     should be cleared out)
>>>   - the PCI_COMMAND register values before and after
>>>     pci_enable_resources()
>>>
>>> Bjorn
>>>
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index 55641a3..83e8d42 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -211,6 +211,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
>>>  
>>>  static inline void reset_resource(struct resource *res)
>>>  {
>>> +	printk("%s: %pR\n", __func__, res);
>>>  	res->start = 0;
>>>  	res->end = 0;
>>>  	res->flags = 0;
>>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>>> index 66c4d8f..c2c45f9 100644
>>> --- a/drivers/pci/setup-res.c
>>> +++ b/drivers/pci/setup-res.c
>>> @@ -364,11 +364,14 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>>>  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>>  	old_cmd = cmd;
>>>  
>>> +	dev_info(&dev->dev, "%s: mask %#x old_cmd %#x\n", __func__, mask, old_cmd);
>>> +
>>>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>>>  		if (!(mask & (1 << i)))
>>>  			continue;
>>>  
>>>  		r = &dev->resource[i];
>>> +		dev_info(&dev->dev, "  BAR %d %pR parent %p\n", i, r, r->parent);
>>>  
>>>  		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>>>  			continue;
>>> @@ -394,6 +397,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>>>  			cmd |= PCI_COMMAND_MEMORY;
>>>  	}
>>>  
>>> +	dev_info(&dev->dev, "%s: cmd %#x\n", __func__, cmd);
>>>  	if (cmd != old_cmd) {
>>>  		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
>>>  			 old_cmd, cmd);
>>>
>> You can see complete bootlog with above at
>> http://pastebin.ubuntu.com/15416575/
> 
> Here are the interesting parts:
> 
>   keystone-pcie 21021000.pcie: PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [bus 00-ff]
>   pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
> 
> No I/O space, as we expected.
> 
>   pci 0000:01:00.0: [1b4b:9182] type 00 class 0x010601
>   pci 0000:01:00.0: reg 0x10: [io  0x8000-0x8007]
>   pci 0000:01:00.0: reg 0x14: [io  0x8040-0x8043]
>   pci 0000:01:00.0: reg 0x18: [io  0x8100-0x8107]
>   pci 0000:01:00.0: reg 0x1c: [io  0x8140-0x8143]
>   pci 0000:01:00.0: reg 0x20: [io  0x800000-0x80000f]
>   pci 0000:01:00.0: reg 0x24: [mem 0x00900000-0x009001ff]
>   pci 0000:01:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]
> 
> Several I/O BARs shown above.
> 
>   pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
>   pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
>   pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
>   reset_resource: [io  size 0x0010]
>   pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
>   reset_resource: [io  size 0x0008]
>   pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
>   reset_resource: [io  size 0x0008]
>   pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
>   reset_resource: [io  size 0x0004]
>   pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]
>   reset_resource: [io  size 0x0004]
> 
> reset_resource() shows "size 0x...." instead of the address because we
> set the IORESOURCE_UNSET bit when we failed to assign space.  That
> part is fine, but then reset_resource() goes on to clear res->flags,
> which is not fine.
> 
>   ahci 0000:01:00.0: ahci_init_one:
>   ahci 0000:01:00.0: version 3.0
>   ahci 0000:01:00.0: pcim_enable_device:
>   ahci 0000:01:00.0: pci_enable_device:
>   ahci 0000:01:00.0: pci_enable_device_flags:
>   ahci 0000:01:00.0: do_pci_enable_device:
>   ahci 0000:01:00.0: pcibios_enable_device: 60
>   ahci 0000:01:00.0: pci_enable_resources: mask 0x60 old_cmd 0x143
>   ahci 0000:01:00.0:   BAR 5 [mem 0x60000000-0x600001ff] parent eb149b10
>   ahci 0000:01:00.0:   BAR 6 [mem 0x60100000-0x6010ffff pref] parent eb149b38
>   ahci 0000:01:00.0: pci_enable_resources: cmd 0x143
> 
> pci_enable_device() requests all resources of type
> IORESOURCE_MEM | IORESOURCE_IO.  pci_enable_device_flags() builds
> "mask" (0x60 here) based on which resources match that type.  For the
> I/O resources, res->flags has been cleared out by reset_resource(), so
> only the MMIO resources (BARs 5 & 6) match, hence we have bits 5 and 6
> set in "mask".
> 
> So pci_enable_resources() only looks at the MMIO resources, which are
> both fine.  It thinks no IORESOURCE_IO resources are needed, so it
> doesn't turn on PCI_COMMAND_IO.  Somebody (maybe firmware) had
> previously enabled PCI_COMMAND_IO, and we leave it enabled.  This is a
> potential problem because those I/O BARs are still enabled and the
> device will respond if it receives an I/O access to those regions.
> This isn't a problem on your particular system because there's no way
> to generate I/O accesses, but it *is* a problem in general.
> 
> There are lots of things I think we should fix here.  They're all in
> the PCI core and in drivers, not in anything Keystone-related:
> 
>   - reset_resource() shouldn't clear the IORESOURCE_TYPE_BITS.  This
>     probably has implications in the rest of resource assignment.
>   - pci_enable_resources() probably should clear PCI_COMMAND_IO if any
>     I/O resources are unset.
>   - There should be a pcim_enable_device_mem().
>   - ahci_init_one() and similar drivers that don't need I/O space
>     should use pcim_enable_device_mem().
> 

Ok.

Murali


> Bjorn
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
