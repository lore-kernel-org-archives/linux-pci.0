Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35973 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab2EHAB7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 20:01:59 -0400
Received: by pbbrp8 with SMTP id rp8so7306994pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 07 May 2012 17:01:59 -0700 (PDT)
Message-ID: <4FA8623C.4010400@gmail.com>
Date: Tue, 08 May 2012 08:01:00 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered
 by the shpchp driver
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com> <1335539820-11232-11-git-send-email-jiang.liu@huawei.com> <4FA4F3E5.5040600@fold.natur.cuni.cz> <4FA5EF97.8010306@gmail.com> <20120506152036.GA31551@kroah.com>
In-Reply-To: <20120506152036.GA31551@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

resend and cc linux-pci list.

On 05/06/2012 11:20 PM, Greg Kroah-Hartman wrote:
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
Thanks for your kindly reminder, Greg!
I'm a newbie to Linux community and there are still many things for me to learn.

>> 	I'm afraid that we can't get the patch set merged in to v3.4. 
> The merge window for 3.4 was months ago, of course this can't be fixed
> there with your large patchset, sorry.
Actually the patch set is still in RFC stage, I forgot to mark it as RFC
last time, will pay attention to this in future.

>> Greg doesn't like the implementation to solve this issue, and asked me
>> to redo it in other ways, but I haven't found other way yet until now.
>> Still keeping punching my header for better solution now.
> I gave you hints on how to implement this properly if you want to, did
> they not work?
I think your have raised three main concerns.
1) Avoid busy wait.
2) Do not introduce a new style lock.
3) Enhance the PCI core instead of changing each PCI hotplug driver.

We could improve or avoid the first issue by replacing msleep() with wait queue.

For the second issue, we may have two candidate solutions: 
a) introduce a global lock for all PCI devices
b) introduce pci_branch_lock()/unlock() to lock/unlock a PCI subtree for hotplug
operations. 
According to my experience with other OS, the second solution is complex and
deadlock prune. It may become more complex on linux due to the device tree abstraction,
and pci_dev/pci_bus splitting. So I took the first solution for trade off. It
may cost more time for hotplug operations, but the implementation will be simpler
and won't cause regression to the PCI core.

If we adopt a global lock for all PCI devices solution, we do need the 
pci_hotplug_try_lock() interface to break deadlock cases. For example,
	Thread A				Thread B
1) try to remove a downstream PCIe port with
   PCIe native hotplug support
2) acquire the global lock
						3) PCIe hotplug event happens, a work
						   item is queued into the workqueue
						4) worker thread wake up and try to
						   handle the hotplug event
						5) try to acquire the global lock
6) try to destroy the PCIe device for the 
   PCIe native hotplug service
7) unbind the pciehp driver and flush the
   workqueue
8) wait for all queued work items to be finished

Then deadlock happens. Interface pci_hotplug_try_lock() is used to break the
deadlock in the worker thread. There are similar deadlock scenario in other
drivers.

For the third issue, it depends on the solution for the second issue.

Some patches in the v2 patch set doesn't depend on the solution for issue two.
So to make things simpler, I will try to split out those patches.

Thanks, Greg! Really appreciate your comments and suggestions! 

-- gerry
