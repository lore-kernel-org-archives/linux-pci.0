Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57026 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab2EHQe3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 12:34:29 -0400
Received: by dady13 with SMTP id y13so2856670dad.19
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2012 09:34:29 -0700 (PDT)
Message-ID: <4FA94B10.1050503@gmail.com>
Date: Wed, 09 May 2012 00:34:24 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered
 by the shpchp driver
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com> <1335539820-11232-11-git-send-email-jiang.liu@huawei.com> <4FA4F3E5.5040600@fold.natur.cuni.cz> <4FA5EF97.8010306@gmail.com> <20120506152036.GA31551@kroah.com> <4FA8623C.4010400@gmail.com> <20120508001848.GA20753@kroah.com> <4FA929F3.9000503@gmail.com> <20120508144820.GA7874@kroah.com>
In-Reply-To: <20120508144820.GA7874@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/08/2012 10:48 PM, Greg Kroah-Hartman wrote:
>> There's already a global rw_semaphore named pci_bus_sem in the PCI core, which
>> is mainly used to protect "children" and "devices" lists in struct pci_bus.
>> pci_bus_sem will be used in many hot paths, such as pci_get_slot() etc.
> 
> That's not a "hot patch" at all.
I mean it's much more hot than the hotplug path:)

>>>> 						4) worker thread wake up and try to
>>>> 						   handle the hotplug event
>>>> 						5) try to acquire the global lock
>>>> 6) try to destroy the PCIe device for the 
>>>>    PCIe native hotplug service
>>>> 7) unbind the pciehp driver and flush the
>>>>    workqueue
>>>> 8) wait for all queued work items to be finished
>>>
>>> Why would you want to do these last 2 options?
>>>
>>> hotplug events should be "simple" in that they happen anytime, and as
>>> you have pointed out, from different places, so just make them block
>>> waiting for other events to complete.
>> The step 7 and 8 are done by the pciehp driver, which is to avoid invalid memory
>> access after unloading pciehp driver.
> 
> Huh?  Unloading it from what?
> 
>> The real story is that, the wq must be flushed when unbinding the
>> pciehp driver, otherwise pending work item may cause invalid memory
>> access after the pciehp driver has been unloaded.
> 
> That's fine, just don't do operations on devices that are now gone.
pciehp driver's remove() method will flush the work queue to wait until all queued
task items to be finished. And remove() method may be called under several conditions:
1) hot-remove PCIe root ports/downstream ports with PCIe native hotplug capability
2) echo pci_device_path > /sys/bus/pci_express/drivers/pciehp/unbind 
3) rmmod pciehp

Step 7 and 8 is optional for case 1 and 2, but it's must for case 3 above.
And the remove() can't tell it's called for unbinding or unloading, so remove()
will always flush the work queue. 

>>> Use a single lock, in the pci hotplug core, for this type of thing.
>>> And, I'm pretty sure we have a lock already for this, in the pci core,
>>> as part of the driver core, so you should be fine.
>> Please refer to the comments above, I fell that the existing pci_bus_sem is not
>> suitable for the task here. And we can't rely on lock mechanisms in the device
>> model framework too, that may interfere with bind/unbind process.
> 
> No, you should also be locking on that, as it can cause events to
> happen.
> 
> Just try using the one lock, if that doesn't work for some reason,
> please show us why.

I will try to explain why I think a single lock solution maybe is not the best. 

Actually this patch set is mainly a preparation for PCI host bridge hotplug.
For PCI/PCIe device hotplug operations, it may last for several seconds.
For host bridge hotplug, it may last for much more longer or even indeterminable
for the worst case. Why indeterminable? It's due to a design limitation in the
DMAEngine subsystem, so it may take a very long time to reclaim an Intel IOAT device
(we are working on this issue too).

For the global pci_bus_sem, it's mainly used by:
drivers/pci/{bus.c, probe.c, remove.c, search.c, slot.c}
drivers/pci/pcie/{aspm.c, pme.c}
It's reasonable to use the same lock for PCI hotplug operations with bus.c, probe.c,
remove.c, and may be acceptable for search.c, slot.c too. But I think it may cause
trouble if hotplug share the same lock with aspm.c and pme.c, given the long period
the lock may be held by a PCI hotplug operation.

And currently there are calling paths as below:
1) user triggers hotplug event
2) acquire the down_write(&pci_hotplug_sem)
3) unbind aspm or pme driver
4) aspm/pme driver's remove() method invokes down_read(&pci_bus_sem)
If we use the global lock pci_bus_sem for PCI hotplug operations, we can't use 
down_read(&pci_bus_sem) in any code which may be called by PCI hotplug logic.
That actually changes the pci_bus_sem from a rw_semaphore into a mutex. I think
that penalty is too heavy here.

Thanks!
--gerry
