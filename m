Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34037 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab2EHONO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 10:13:14 -0400
Received: by pbbrp8 with SMTP id rp8so8090465pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 08 May 2012 07:13:14 -0700 (PDT)
Message-ID: <4FA929F3.9000503@gmail.com>
Date: Tue, 08 May 2012 22:13:07 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered
 by the shpchp driver
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com> <1335539820-11232-11-git-send-email-jiang.liu@huawei.com> <4FA4F3E5.5040600@fold.natur.cuni.cz> <4FA5EF97.8010306@gmail.com> <20120506152036.GA31551@kroah.com> <4FA8623C.4010400@gmail.com> <20120508001848.GA20753@kroah.com>
In-Reply-To: <20120508001848.GA20753@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/08/2012 08:18 AM, Greg Kroah-Hartman wrote:
> On Tue, May 08, 2012 at 08:01:00AM +0800, Jiang Liu wrote:
>>>> Greg doesn't like the implementation to solve this issue, and asked me
>>>> to redo it in other ways, but I haven't found other way yet until now.
>>>> Still keeping punching my header for better solution now.
>>> I gave you hints on how to implement this properly if you want to, did
>>> they not work?
>> I think your have raised three main concerns.
>> 1) Avoid busy wait.
>> 2) Do not introduce a new style lock.
>> 3) Enhance the PCI core instead of changing each PCI hotplug driver.
>>
>> We could improve or avoid the first issue by replacing msleep() with wait queue.
> 
> No, wait, you should never have done #1 or #2 in the first place.  Don't
> try to "solve" #1 any other way than just flat out not doing that at
> all.
Sure, I won't change the code until we have reached some agreements.

> 
>> For the second issue, we may have two candidate solutions: 
>> a) introduce a global lock for all PCI devices
> 
> The driver core already has one, so why create another one?
It's for performance and simplicity.

There's already a global rw_semaphore named pci_bus_sem in the PCI core, which
is mainly used to protect "children" and "devices" lists in struct pci_bus.
pci_bus_sem will be used in many hot paths, such as pci_get_slot() etc.
On the other handle, a PCI hotplug operation may last for several seconds,
or even minutes when removing PCI host bridge for the worst case. The new
global lock is introduced to avoid blocking the hot paths for seconds or minutes,

The pci_bus_sem is used as a fine grain lock to protect "children" and "devices"
lists. If we extend it to serialize whole PCI hotplug operations, we must carefully
tune the PCI core to avoid deadlock. The change may not be trivial too.

Actually we are just extending the existing pci_remove_rescan_mutex to 
serialize all PCI hotplug operations. Currently it's only used to serialize
PCI hotplug operations triggered by sysfs interfaces created by PCI core,
such as /sys/devices/pci/xxxxx/{remove,rescan}.

> 
>> It may cost more time for hotplug operations, but the implementation
>> will be simpler and won't cause regression to the PCI core.
> 
> There are no speed issues with hotplug pci operations, the spec itself
> has wait times required in _seconds_, so we are fine here.
Yes. So I follow the rule: optimize for hot paths. It's not a big issue
for hotplug operations to wait for a bit longer.
 
>> If we adopt a global lock for all PCI devices solution, we do need the 
>> pci_hotplug_try_lock() interface to break deadlock cases. For example,
>> 	Thread A				Thread B
>> 1) try to remove a downstream PCIe port with
>>    PCIe native hotplug support
>> 2) acquire the global lock
>> 						3) PCIe hotplug event happens, a work
>> 						   item is queued into the workqueue
> 
> Wait right here, how did a "pcie hotplug event happen"?
We have a system with one PCIe root port connected to an IO expansion box by PCIe cable.
The IO expansion box is essentially an MR-IOV switch, which supports multiple virtual
switches and can dynamically migrate downstream ports among virtual switches. Both the
root port on motherboard and downstream ports on IOBOX support PCIe hotplug.
The entirely system supports:
1) IOH hotplug
2) IOBOX hotplug
3) PCIe hotplug on the IOBOX downstream port
4) IOBOX downstream port migration among virtual switches.

So PCIe hotplug event may be triggered by physical button or port migration operations 
when hot-removing the IOH or IOBOX.

> 
>> 						4) worker thread wake up and try to
>> 						   handle the hotplug event
>> 						5) try to acquire the global lock
>> 6) try to destroy the PCIe device for the 
>>    PCIe native hotplug service
>> 7) unbind the pciehp driver and flush the
>>    workqueue
>> 8) wait for all queued work items to be finished
> 
> Why would you want to do these last 2 options?
> 
> hotplug events should be "simple" in that they happen anytime, and as
> you have pointed out, from different places, so just make them block
> waiting for other events to complete.
The step 7 and 8 are done by the pciehp driver, which is to avoid invalid memory
access after unloading pciehp driver. The real story is that, the wq must be
flushed when unbinding the pciehp driver, otherwise pending work item may cause
invalid memory access after the pciehp driver has been unloaded.

>> Then deadlock happens. Interface pci_hotplug_try_lock() is used to break the
>> deadlock in the worker thread. There are similar deadlock scenario in other
>> drivers.
>>
>> For the third issue, it depends on the solution for the second issue.
>>
>> Some patches in the v2 patch set doesn't depend on the solution for issue two.
>> So to make things simpler, I will try to split out those patches.
>>
>> Thanks, Greg! Really appreciate your comments and suggestions! 
> 
> Use a single lock, in the pci hotplug core, for this type of thing.
> And, I'm pretty sure we have a lock already for this, in the pci core,
> as part of the driver core, so you should be fine.
Please refer to the comments above, I fell that the existing pci_bus_sem is not
suitable for the task here. And we can't rely on lock mechanisms in the device
model framework too, that may interfere with bind/unbind process.

> 
> Don't try to make this more complex than it is.  Yes, it's going to take
> some refactoring of the messy pci hotplug drivers (sorry, they are a
> mess in places), but that will make this all be much simpler in the end,
> hopefully.
Actually I was just trying to find a simple way to fix the issue. I feel it's
more complex to solve this by enhancing the PCI core. But I will keep on thinking
to find other simpler ways for the task.

Thanks, Greg!
--gerry
