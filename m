Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752741AbdA3XEM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 18:04:12 -0500
Date: Mon, 30 Jan 2017 17:03:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>, Duc Dang <dhdang@apm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: xgene: double free on init error
Message-ID: <20170130230322.GA20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170121044949.GB15269@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170121044949.GB15269@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 21, 2017 at 07:49:49AM +0300, Dan Carpenter wrote:
> The "port" variable was allocated with devm_kzalloc() so if we free it
> with kfree() it will be freed twice.  Also I changed it to propogate the
> error from devm_ioremap_resource() instead of returning -ENOMEM.
> 
> Fixes: c5d460396100 ("PCI: Add MCFG quirks for X-Gene host controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Waiting for Tanmay's ack, ping :)

> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 7c3b54b..142a166 100644
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
> -		return -ENOMEM;
> -	}
> +	if (IS_ERR(port->csr_base))
> +		return PTR_ERR(port->csr_base);
>  
>  	port->cfg_base = cfg->win;
>  	port->version = ipversion;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
