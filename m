Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57520 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab2EHASx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 20:18:53 -0400
Received: by pbbrp8 with SMTP id rp8so7319055pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 07 May 2012 17:18:52 -0700 (PDT)
Date: Mon, 7 May 2012 17:18:48 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered by
 the shpchp driver
Message-ID: <20120508001848.GA20753@kroah.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
 <1335539820-11232-11-git-send-email-jiang.liu@huawei.com>
 <4FA4F3E5.5040600@fold.natur.cuni.cz>
 <4FA5EF97.8010306@gmail.com>
 <20120506152036.GA31551@kroah.com>
 <4FA8623C.4010400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FA8623C.4010400@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 08, 2012 at 08:01:00AM +0800, Jiang Liu wrote:
> >> Greg doesn't like the implementation to solve this issue, and asked me
> >> to redo it in other ways, but I haven't found other way yet until now.
> >> Still keeping punching my header for better solution now.
> > I gave you hints on how to implement this properly if you want to, did
> > they not work?
> I think your have raised three main concerns.
> 1) Avoid busy wait.
> 2) Do not introduce a new style lock.
> 3) Enhance the PCI core instead of changing each PCI hotplug driver.
> 
> We could improve or avoid the first issue by replacing msleep() with wait queue.

No, wait, you should never have done #1 or #2 in the first place.  Don't
try to "solve" #1 any other way than just flat out not doing that at
all.

> For the second issue, we may have two candidate solutions: 
> a) introduce a global lock for all PCI devices

The driver core already has one, so why create another one?

> b) introduce pci_branch_lock()/unlock() to lock/unlock a PCI subtree for hotplug
> operations. 
> According to my experience with other OS, the second solution is complex and
> deadlock prune. It may become more complex on linux due to the device tree abstraction,
> and pci_dev/pci_bus splitting. So I took the first solution for trade off.

I agree, we don't want to lock branches, that is wrong as you have found
out as well.

> It may cost more time for hotplug operations, but the implementation
> will be simpler and won't cause regression to the PCI core.

There are no speed issues with hotplug pci operations, the spec itself
has wait times required in _seconds_, so we are fine here.

> If we adopt a global lock for all PCI devices solution, we do need the 
> pci_hotplug_try_lock() interface to break deadlock cases. For example,
> 	Thread A				Thread B
> 1) try to remove a downstream PCIe port with
>    PCIe native hotplug support
> 2) acquire the global lock
> 						3) PCIe hotplug event happens, a work
> 						   item is queued into the workqueue

Wait right here, how did a "pcie hotplug event happen"?

> 						4) worker thread wake up and try to
> 						   handle the hotplug event
> 						5) try to acquire the global lock
> 6) try to destroy the PCIe device for the 
>    PCIe native hotplug service
> 7) unbind the pciehp driver and flush the
>    workqueue
> 8) wait for all queued work items to be finished

Why would you want to do these last 2 options?

hotplug events should be "simple" in that they happen anytime, and as
you have pointed out, from different places, so just make them block
waiting for other events to complete.

> Then deadlock happens. Interface pci_hotplug_try_lock() is used to break the
> deadlock in the worker thread. There are similar deadlock scenario in other
> drivers.
> 
> For the third issue, it depends on the solution for the second issue.
> 
> Some patches in the v2 patch set doesn't depend on the solution for issue two.
> So to make things simpler, I will try to split out those patches.
> 
> Thanks, Greg! Really appreciate your comments and suggestions! 

Use a single lock, in the pci hotplug core, for this type of thing.
And, I'm pretty sure we have a lock already for this, in the pci core,
as part of the driver core, so you should be fine.

Don't try to make this more complex than it is.  Yes, it's going to take
some refactoring of the messy pci hotplug drivers (sorry, they are a
mess in places), but that will make this all be much simpler in the end,
hopefully.

good luck,

greg k-h
