Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751081AbeECUpY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 16:45:24 -0400
Date: Thu, 3 May 2018 16:45:22 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
cc: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <tom.leiming@gmail.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme/pci: Use async_schedule for initial reset work
In-Reply-To: <20180503201507.GO5938@localhost.localdomain>
Message-ID: <alpine.LRH.2.02.1805031614210.5215@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180427211708.5604-1-keith.busch@intel.com> <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com> <20180430194533.GC5938@localhost.localdomain> <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>
 <20180502152953.GH5938@localhost.localdomain> <alpine.LRH.2.02.1805021717430.2705@file01.intranet.prod.int.rdu2.redhat.com> <20180503201507.GO5938@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thu, 3 May 2018, Keith Busch wrote:

> On Thu, May 03, 2018 at 10:55:09AM -0400, Mikulas Patocka wrote:
> > I think there is still one more bug:
> > 
> > If nvme_probe is called, it schedules the asynchronous work using 
> > async_schedule - now suppose that the pci system calls the "remove", 
> > "shutdown" or "suspend" method - this method will race with 
> > nvme_async_probe running in the async domain - that will cause 
> > misbehavior.
> > 
> > Or - does the PCI subsystem flush the async queues before calling these 
> > methods? I'm not sure, but it doesn't seem so.
> > 
> > I think, you need to save the cookie returned by async_schedule and wait 
> > for this cookie with async_synchronize_cookie in the other methods.
> 
> I think we're fine as-is without syncing the cookie. 
> 
> The remove path should be fine since we already sync with the necessary
> work queues.
> 
> The shutdown, suspend and reset paths will just cause the initial reset
> work to end early, the same result as what previously would happen.

Suppose this:
task 1: nvme_probe
task 1: calls async_schedule(nvme_async_probe), that queues the work for 
	task 2
task 1: exits (so the device is active from pci subsystem's point of view)
task 3: the pci subsystem calls nvme_remove
task 3: calls nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
task 3: cancel_work_sync(&dev->ctrl.reset_work); (does nothing because the 
	work item hasn't started yet)
task 3: nvme_remove does all the remaining work
task 3: frees the device
task 3: exists nvme_remove
task 2: (in the async domain) runs nvme_async_probe
task 2: calls nvme_reset_ctrl_sync
task 2: nvme_reset_ctrl
task 2: calls nvme_change_ctrl_state and queue_work - on a structure that 
	was already freed by nvme_remove

This bug is rare - but it may happen if the user too quickly activates and 
deactivates the device by writing to sysfs.

Mikulas
