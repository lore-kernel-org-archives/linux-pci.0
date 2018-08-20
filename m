Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeHTVAA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Aug 2018 17:00:00 -0400
Subject: Re: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if
 hotplug is enabled
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180818065126.77912-2-okaya@kernel.org>
 <20180820082150.r4q47ppqqclaschd@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <38fd0d0a-6d60-c8db-f155-e6078260513b@kernel.org>
Date: Mon, 20 Aug 2018 13:43:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180820082150.r4q47ppqqclaschd@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/20/2018 4:21 AM, Lukas Wunner wrote:
> On Fri, Aug 17, 2018 at 11:51:10PM -0700, Sinan Kaya wrote:
>> +static int pciehp_control_surprise_error(struct controller *ctrl, bool enable)
> 
> The return value isn't checked, so this could return void.
> 

Sure, I can do that.

> 
>> @@ -280,6 +303,9 @@ static int pciehp_probe(struct pcie_device *dev)
>>   
>>   	pciehp_check_presence(ctrl);
>>   
>> +	/* We want exclusive control of link down events in hotplug driver */
>> +	pciehp_control_surprise_error(ctrl, false);
>> +
>>   	return 0;
> 
> Hm, if the platform firmware hasn't granted native hotplug control to OSPM,
> or if some other hotplug driver than pciehp is used, shouldn't surprise down
> be ignored by error recovery as well?  If yes, the mask would have to be set
> in generic code somewhere in drivers/pci/probe.c I guess, based on the
> is_hotplug_bridge bit in struct pci_dev.

I could move this code if we know that is_hotplug_bridge flag is set
regardless of OS hotplug driver control or not.


> 
> (Interestingly, PCI_ERR_UNCOR_MASK is already changed in probe.c by
> program_hpp_type2().  That seems to be ACPI-specific code, which kind
> of begs the question why it's not in pci-acpi.c?)

Yes, you can tell the OS what AER mask to set following hotplug
insertion via ACPI HPP table especially if you remove a hotplug bridge.
This is used during ACPI hotplug.

> 
> Thanks,
> 
> Lukas
> 
