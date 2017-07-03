Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752479AbdGCNBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jul 2017 09:01:01 -0400
Date: Mon, 3 Jul 2017 08:00:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: fix pci_try_reset_function()
Message-ID: <20170703130058.GB13824@bhelgaas-glaptop.roam.corp.google.com>
References: <20170701135323.x5vaj4e2wcs2mcro@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170701135323.x5vaj4e2wcs2mcro@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 02:09:19PM +0300, Dan Carpenter wrote:
> There is a reversed if condition so the function doesn't work.
> 
> Fixes: e94fae7aeef4 ("PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Folded into pci/virtualization, thanks!

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5b49d662f996..3bf28bf04c3d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4269,7 +4269,7 @@ int pci_try_reset_function(struct pci_dev *dev)
>  	if (rc)
>  		return rc;
>  
> -	if (pci_dev_trylock(dev))
> +	if (!pci_dev_trylock(dev))
>  		return -EAGAIN;
>  
>  	pci_dev_save_and_disable(dev);
