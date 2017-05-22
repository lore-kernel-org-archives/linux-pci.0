Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:54229 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdEVUPy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 16:15:54 -0400
Date: Mon, 22 May 2017 23:15:52 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme: pci: Fix NULL dereference when resetting NVMe SSD
Message-ID: <20170522201551.GA19022@dhcp-216.srv.tuxera.com>
References: <20170520175952.GA11258@dhcp-216.srv.tuxera.com>
 <20170521061736.GA12287@lst.de>
 <20170522153829.GA17980@dhcp-216.srv.tuxera.com>
 <20170522160217.GA26104@lst.de>
 <20170522160420.GA26356@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170522160420.GA26356@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 06:04:20PM +0200, Christoph Hellwig wrote:
> On Mon, May 22, 2017 at 06:02:17PM +0200, Christoph Hellwig wrote:
> > On Mon, May 22, 2017 at 06:38:29PM +0300, Rakesh Pandit wrote:
> > > Just got to use the using the test box again and you are right that
> > > nvme_remove_dead_ctrl_work is getting called just before the NULL
> > > pointer dereference.
> > > 
> > > Here call trace to nvme_timeout which results in eventually call to
> > > nvme_reset when it wants to reset the controller (which races with
> > > ->reset_notify from PCI layer):
> > 
> > Does the patch below fix the issue for you?
> 
> Actually, it probably should be this one, but for you the effects
> are probably the same:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5bba8e6..b61ad77dc322 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4275,11 +4275,13 @@ int pci_reset_function(struct pci_dev *dev)
>  	if (rc)
>  		return rc;
>  
> +	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
>  
> -	rc = pci_dev_reset(dev, 0);
> +	rc = __pci_dev_reset(dev, 0);
>  
>  	pci_dev_restore(dev);
> +	pci_dev_unlock(dev);
>  
>  	return rc;
>  }

Thanks, this patch fixes the reported issue for me.
