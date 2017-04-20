Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946859AbdDTSw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2017 14:52:57 -0400
Subject: Re: [PATCH v2] PCI: disable SERR for kdump kernel
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20170419003130.5302-1-yinghai@kernel.org>
 <584359f9-5851-08c8-4b80-ae73abc4fe59@codeaurora.org>
 <CAErSpo7paKmVjvGhedCdbSNbARqDmE6jfLikp4SO75fob3pMzw@mail.gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6f07625e-c22e-6ed9-efe3-a56bcc1c86cd@codeaurora.org>
Date: Thu, 20 Apr 2017 14:52:54 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo7paKmVjvGhedCdbSNbARqDmE6jfLikp4SO75fob3pMzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/20/2017 2:38 PM, Bjorn Helgaas wrote:
> On Thu, Apr 20, 2017 at 12:14 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 4/18/2017 8:31 PM, Yinghai Lu wrote:
>>> * pci_setup_device - fill in class and map information of a device
>>>   * @dev: the device structure to fill
>>> @@ -1572,6 +1592,9 @@ int pci_setup_device(struct pci_dev *dev
>>>       /* device class may be changed after fixup */
>>>       class = dev->class >> 8;
>>>
>>> +     if (is_kdump_kernel())
>>> +             pci_disable_serr(dev);
>>> +
>>
>> This sounds like something that needs to be done while shutting down
>> the first kernel as part of the kdump procedure rather than boot of
>> the kdump kernel in pci setup.
> 
> In general, I would rather make the new kernel more tolerant than make
> assumptions about how the old kernel shut down.  I don't know if
> there's an explicit statement of kexec philosophy on this (it'd be
> nice if there were), but it seems like a more robust strategy, e.g.,
> less prone to revlock issues between the old/new kernels.
> 

What if the secondary kernel never gets a chance to boot due to excessive
errors? Code might not even make to the point where PCI driver is executed.

If I remember this right, kexec is already doing PCI cleanup operation during
shutdown and it is also calling the shutdown hook of device drivers. 

(I recently added a shutdown hook to my own HIDMA driver for the very same reason)

The requirement for the second kernel boot is not to have any pending DMA
and IRQs so that secondary kernel can boot safely.

Maybe, the right thing is to look for a way to put PCI into some safe mode.
There should be some code there disabling the COMMAND enable bits if not already.

This code could be added to the same place.

http://lxr.free-electrons.com/ident?i=pci_device_shutdown

469         /*
470          * If this is a kexec reboot, turn off Bus Master bit on the
471          * device to tell it to not continue to do DMA. Don't touch
472          * devices in D3cold or unknown states.
473          * If it is not a kexec reboot, firmware will hit the PCI
474          * devices with big hammer and stop their DMA any way.
475          */
476         if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
477                 pci_clear_master(pci_dev);

> Bjorn
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
