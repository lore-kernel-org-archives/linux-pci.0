Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:64451 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbdE2JTM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 May 2017 05:19:12 -0400
Date: Mon, 29 May 2017 12:19:09 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: <linux-pci@vger.kernel.org>
CC: <helgaas@kernel.org>, <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI: ensure the PCI device is locked over ->reset_notify
 calls
Message-ID: <20170529091909.GA33654@dhcp-216.srv.tuxera.com>
References: <20170523054202.7985-1-hch@lst.de>
 <20170523054202.7985-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170523054202.7985-2-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, May 23, 2017 at 07:42:02AM +0200, Christoph Hellwig wrote:
> Without this ->notify_reset instance may race with ->remove calls,
> which can be easily triggered in NVMe.
>

Any input on this sometime before next -rc release would be great ?

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
