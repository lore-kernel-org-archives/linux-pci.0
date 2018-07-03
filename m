Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeGCPna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 11:43:30 -0400
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703143434.GA4086@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
Date: Tue, 3 Jul 2018 11:43:26 -0400
MIME-Version: 1.0
In-Reply-To: <20180703143434.GA4086@wunner.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/3/2018 10:34 AM, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> @@ -308,8 +310,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>>  		pci_dev_put(pdev);
>>  	}
>>  
>> +	hpsvc = pcie_port_find_service(udev, PCIE_PORT_SERVICE_HP);
>> +	hpdev = pcie_port_find_device(udev, PCIE_PORT_SERVICE_HP);
>> +
>> +	if (hpdev && hpsvc)
>> +		hpsvc->mask_irq(to_pcie_device(hpdev));
>> +
>>  	result = reset_link(udev, service);
>>  
>> +	if (hpdev && hpsvc)
>> +		hpsvc->unmask_irq(to_pcie_device(hpdev));
>> +
> 
> We've already got the ->reset_slot callback in struct hotplug_slot_ops,
> I'm wondering if we really need additional ones for this use case.
> 
> If you just do...
> 
> 	if (!pci_probe_reset_slot(dev->slot))
> 		pci_reset_slot(dev->slot)
> 	else {
> 		/* regular code path */
> 	}
> 
> would that not be equivalent?

As I have informed you before on my previous reply, the pdev->slot is
only valid for children objects such as endpoints not for a bridge when
using pciehp.

The pointer is NULL for the host bridge itself.

I reached out to reset_slot() callback in v4 of this implementation.

https://patchwork.kernel.org/patch/10494971/

However, as Oza explained FATAL error handling gets called from two different
paths as AER and DPC.

If the link goes down due to DPC, calling pci_reset_slot() would be a mistake
as DPC has its own recovery mechanism by programming the DPC capabilities.
pci_reset_slot() performs a secondary bus reset following hotplug interrupt
mask.

Issuing a secondary bus reset to a DPC event would be a mistake for recovery.

That's why, I extracted the hotplug mask and unmask IRQ calls into service
layer so that I can mask hotplug interrupts regardless of the source of the
FATAL error whether it is DPC or AER.

If error source is DPC, it still goes to DPC driver's reset_link() callback
for DPC specific clean up.

If error source is AER, it still goes to AER driver's reset_link() callback
for secondary bus reset.

Remember that AER driver completely bypasses pci_reset_slot() today. The lock
mechanism you are putting will not be useful for FATAL error case where
pci_secondary_bus_reset() is called directly.

pci_reset_slot() only gets called from external drivers such as VFIO to initiate
a reset to the slot if hotplug is supported.

> 
> (It's worth noting though that pciehp is the only hotplug driver
> implementing the ->reset_slot callback.  If hotplug is handled by
> a different driver or by the platform firmware, devices may still
> be removed and re-enumerated twice.)
> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
