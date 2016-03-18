Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49433 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030AbcCRSMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Mar 2016 14:12:54 -0400
Subject: Re: PCI IO resource question.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56E987B8.1090904@ti.com> <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com> <20160316192904.GA2703@localhost>
 <56E9BE6A.6090107@ti.com> <20160316214733.GA11542@localhost>
 <56EB217F.8070603@ti.com> <20160318112802.GA1810@red-moon>
 <56EC1A27.7000206@ti.com> <20160318152824.GA18864@localhost>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56EC4523.9010304@ti.com>
Date: Fri, 18 Mar 2016 14:12:51 -0400
MIME-Version: 1.0
In-Reply-To: <20160318152824.GA18864@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/18/2016 11:28 AM, Bjorn Helgaas wrote:
> On Fri, Mar 18, 2016 at 11:09:27AM -0400, Murali Karicheri wrote:
>> On 03/18/2016 07:28 AM, Lorenzo Pieralisi wrote:
>>> On Thu, Mar 17, 2016 at 05:28:31PM -0400, Murali Karicheri wrote:
>>>
>>> [...]
>>>
>>>>> The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
>>>>> "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
>>>>>
>>>>> I expect you're in this path:
>>>>>
>>>>>   ahci_init_one
>>>>>     pcim_enable_device
>>>>>       pci_enable_device
>>>>>         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
>>>>>           # build "bars" mask
>>>>>           do_pci_enable_device(dev, bars)
>>>>>             pcibios_enable_device
>>>>>               if (pci_has_flag(PCI_PROBE_ONLY))
>>>>>                 return 0;
>>>>>               pci_enable_resources
>>>>>
>>>>> Can you add a little debug code like this to verify that we're in this
>>>>> path?
>>>>
>>>> Yes we are in the path.
>>>>
>>>>
>>>> [    1.557561] ahci_init_one
>>>> [    1.560214] ahci 0000:01:00.0: version 3.0
>>>> [    1.564302] pcim_enable_device
>>>> [    1.567349] pci_enable_device
>>>> [    1.570340] pci_enable_device_flags
>>>> [    1.573824] do_pci_enable_device
>>>> [    1.577042] pcibios_enable_device
>>>> [    1.580380] pci_enable_resources
>>>
>>> So resources are actually enabled (ie PCI_PROBE_ONLY is not set)
>>> and that makes sense otherwise you would not be able to use the
>>> MEM resources anyway (ie they would not be enabled).
>>>
>>> I suspect the PCI dev IO resources were reset in reset_resource() in
>>> assign_requested_resource_sorted(), hence the bar mask that is built
>>> in pci_enable_device_flags() does not contain the IO resources,
>>> it would be helpful if you can print the bar mask passed to
>>> pcibios_enable_device() (ie the mask parameter).
>>
>> Here it is
>>
>> [    1.556507] ahci_init_one
>> [    1.559124] ahci 0000:01:00.0: version 3.0
>> [    1.563246] pcim_enable_device
>> [    1.566294] pci_enable_device
>> [    1.569252] pci_enable_device_flags
>> [    1.572766] do_pci_enable_device
>> [    1.575985] pcibios_enable_device 60
>> [    1.579551] pci_enable_resources
>>
>> I know that some of our customers use PCIe SATA from u-boot and would
>> like to honor the assignment in Linux space.. I believe they use PCI_PROBE_ONLY
>> by setting the bootarg. So Keystone PCI should work in both cases.
> 
> We're only getting little pieces of the story here.  Can you apply the
> following patch and collect the entire dmesg log?  I want to see:
> 
>   - the root bus resources (which presumably include no I/O space)
>   - all the SATA resources during enumeration (which should include an
>     I/O BAR)
>   - the reset_resource() call that clears the I/O BAR flags
>   - all the SATA resources in pci_enable_resources() (the I/O BAR
>     should be cleared out)
>   - the PCI_COMMAND register values before and after
>     pci_enable_resources()
> 
> Bjorn
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 55641a3..83e8d42 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -211,6 +211,7 @@ static void __dev_sort_resources(struct pci_dev *dev,
>  
>  static inline void reset_resource(struct resource *res)
>  {
> +	printk("%s: %pR\n", __func__, res);
>  	res->start = 0;
>  	res->end = 0;
>  	res->flags = 0;
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 66c4d8f..c2c45f9 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -364,11 +364,14 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>  	pci_read_config_word(dev, PCI_COMMAND, &cmd);
>  	old_cmd = cmd;
>  
> +	dev_info(&dev->dev, "%s: mask %#x old_cmd %#x\n", __func__, mask, old_cmd);
> +
>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  		if (!(mask & (1 << i)))
>  			continue;
>  
>  		r = &dev->resource[i];
> +		dev_info(&dev->dev, "  BAR %d %pR parent %p\n", i, r, r->parent);
>  
>  		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>  			continue;
> @@ -394,6 +397,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>  			cmd |= PCI_COMMAND_MEMORY;
>  	}
>  
> +	dev_info(&dev->dev, "%s: cmd %#x\n", __func__, cmd);
>  	if (cmd != old_cmd) {
>  		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
>  			 old_cmd, cmd);
> 
You can see complete bootlog with above at
http://pastebin.ubuntu.com/15416575/

Let me know what you find.

Murali

-- 
Murali Karicheri
Linux Kernel, Keystone
