Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:14087 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeECVD2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 17:03:28 -0400
Date: Thu, 3 May 2018 15:05:02 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <tom.leiming@gmail.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme/pci: Use async_schedule for initial reset work
Message-ID: <20180503210502.GP5938@localhost.localdomain>
References: <20180427211708.5604-1-keith.busch@intel.com>
 <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com>
 <20180430194533.GC5938@localhost.localdomain>
 <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>
 <20180502152953.GH5938@localhost.localdomain>
 <alpine.LRH.2.02.1805021717430.2705@file01.intranet.prod.int.rdu2.redhat.com>
 <20180503201507.GO5938@localhost.localdomain>
 <alpine.LRH.2.02.1805031614210.5215@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.02.1805031614210.5215@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 04:45:22PM -0400, Mikulas Patocka wrote:
> Suppose this:
> task 1: nvme_probe
> task 1: calls async_schedule(nvme_async_probe), that queues the work for 
> 	task 2
> task 1: exits (so the device is active from pci subsystem's point of view)
> task 3: the pci subsystem calls nvme_remove
> task 3: calls nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> task 3: cancel_work_sync(&dev->ctrl.reset_work); (does nothing because the 
> 	work item hasn't started yet)
> task 3: nvme_remove does all the remaining work
> task 3: frees the device
> task 3: exists nvme_remove
> task 2: (in the async domain) runs nvme_async_probe
> task 2: calls nvme_reset_ctrl_sync
> task 2: nvme_reset_ctrl
> task 2: calls nvme_change_ctrl_state and queue_work - on a structure that 
> 	was already freed by nvme_remove
> 
> This bug is rare - but it may happen if the user too quickly activates and 
> deactivates the device by writing to sysfs.

Okay, I think I see your point. Pairing a nvme_get_ctrl with a
nvme_put_ctrl should fix that.
