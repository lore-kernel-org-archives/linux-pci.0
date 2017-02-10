Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbdBJRiv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 12:38:51 -0500
Date: Fri, 10 Feb 2017 11:38:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: clean up the unnecessary memory free
Message-ID: <20170210173837.GC29169@bhelgaas-glaptop.roam.corp.google.com>
References: <1484104755-242853-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484104755-242853-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 11, 2017 at 11:19:15AM +0800, Shawn Lin wrote:
> No need to free port as it is allocated by devm method.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sorry, I didn't notice that this is almost identical to Dan
Carpenter's patch [1], which I had already applied.  You posted it
first, but Tanmay acked Dan's, so that's what I applied.  I added a
line to the changelog to at least give you some credit for it.

[1] https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-xgene&id=1ded56df3247d358390ae6dc09ccee620262ac5f

> ---
> 
>  drivers/pci/host/pci-xgene.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 7c3b54b..790b6cb 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -246,14 +246,11 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
>  	ret = xgene_get_csr_resource(adev, &csr);
>  	if (ret) {
>  		dev_err(dev, "can't get CSR resource\n");
> -		kfree(port);
>  		return ret;
>  	}
>  	port->csr_base = devm_ioremap_resource(dev, &csr);
> -	if (IS_ERR(port->csr_base)) {
> -		kfree(port);
> +	if (IS_ERR(port->csr_base))
>  		return -ENOMEM;
> -	}
>  
>  	port->cfg_base = cfg->win;
>  	port->version = ipversion;
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
