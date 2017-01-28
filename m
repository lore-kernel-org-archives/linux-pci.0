Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbdA1Vcf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jan 2017 16:32:35 -0500
Date: Sat, 28 Jan 2017 15:31:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] PCI: xgene: clean up the unnecessary memory free
Message-ID: <20170128213115.GL20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1484104755-242853-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484104755-242853-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tanmay]

On Wed, Jan 11, 2017 at 11:19:15AM +0800, Shawn Lin wrote:
> No need to free port as it is allocated by devm method.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Please cc the maintainer so he knows to look at this.  I added Tanmay
for you, and I'll wait for his ack before applying this.

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
