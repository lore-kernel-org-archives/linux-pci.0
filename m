Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdE3W2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 18:28:46 -0400
Date: Tue, 30 May 2017 17:28:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: ensure the PCI device is locked over ->reset_notify
 calls
Message-ID: <20170530222844.GE14896@bhelgaas-glaptop.roam.corp.google.com>
References: <20170523054202.7985-1-hch@lst.de>
 <20170523054202.7985-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523054202.7985-2-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex]

On Tue, May 23, 2017 at 07:42:02AM +0200, Christoph Hellwig wrote:
> Without this ->notify_reset instance may race with ->remove calls,

Do you mean the .reset_notify() method in struct pci_error_handlers?
I don't see a "notify_reset" symbol.

Can you elaborate on exactly how this race happens?  I'm trying to
figure out whether this is also a problem or potential problem with
other reset paths like pci_try_reset_function(), pci_reset_bus(),
pci_try_reset_bus(), pci_reset_slot(), and pci_try_reset_slot().

What does the race look like when it happens?  Oops, panic, etc?

Can this also be triggered via the sysfs "reset" file?

> which can be easily triggered in NVMe.
> 
> Reported-by: Rakesh Pandit <rakesh@tuxera.com>
> Tested-by: Rakesh Pandit <rakesh@tuxera.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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
> -- 
> 2.11.0
> 
