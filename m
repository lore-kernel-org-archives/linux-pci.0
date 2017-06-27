Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbdF0X20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 19:28:26 -0400
Date: Tue, 27 Jun 2017 18:28:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: versatile: Add local struct device pointers
Message-ID: <20170627232823.GM17844@bhelgaas-glaptop.roam.corp.google.com>
References: <20170627224823.16802.89569.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170627224823.16802.89569.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 27, 2017 at 05:48:23PM -0500, Bjorn Helgaas wrote:
> Use a local "struct device *dev" for brevity and consistency with other
> drivers.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this on the pci/versatile branch for v4.13.

> ---
>  drivers/pci/host/pci-versatile.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> index f572c921cdd4..3de1e0a726db 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -120,6 +120,7 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
>  
>  static int versatile_pci_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct resource *res;
>  	int ret, i, myslot = -1;
>  	u32 val;
> @@ -128,27 +129,26 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *bridge;
>  	LIST_HEAD(pci_res);
>  
> -	bridge = devm_pci_alloc_host_bridge(&pdev->dev, 0);
> +	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	versatile_pci_base = devm_ioremap_resource(&pdev->dev, res);
> +	versatile_pci_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(versatile_pci_base))
>  		return PTR_ERR(versatile_pci_base);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	versatile_cfg_base[0] = devm_ioremap_resource(&pdev->dev, res);
> +	versatile_cfg_base[0] = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(versatile_cfg_base[0]))
>  		return PTR_ERR(versatile_cfg_base[0]);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	versatile_cfg_base[1] = devm_pci_remap_cfg_resource(&pdev->dev,
> -							    res);
> +	versatile_cfg_base[1] = devm_pci_remap_cfg_resource(dev, res);
>  	if (IS_ERR(versatile_cfg_base[1]))
>  		return PTR_ERR(versatile_cfg_base[1]);
>  
> -	ret = versatile_pci_parse_request_of_pci_ranges(&pdev->dev, &pci_res);
> +	ret = versatile_pci_parse_request_of_pci_ranges(dev, &pci_res);
>  	if (ret)
>  		return ret;
>  
> @@ -164,7 +164,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  		}
>  	}
>  	if (myslot == -1) {
> -		dev_err(&pdev->dev, "Cannot find PCI core!\n");
> +		dev_err(dev, "Cannot find PCI core!\n");
>  		return -EIO;
>  	}
>  	/*
> @@ -172,7 +172,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  	 */
>  	pci_slot_ignore |= (1 << myslot);
>  
> -	dev_info(&pdev->dev, "PCI core found (slot %d)\n", myslot);
> +	dev_info(dev, "PCI core found (slot %d)\n", myslot);
>  
>  	writel(myslot, PCI_SELFID);
>  	local_pci_cfg_base = versatile_cfg_base[1] + (myslot << 11);
> @@ -205,7 +205,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
>  
>  	list_splice_init(&pci_res, &bridge->windows);
> -	bridge->dev.parent = &pdev->dev;
> +	bridge->dev.parent = dev;
>  	bridge->sysdata = NULL;
>  	bridge->busnr = 0;
>  	bridge->ops = &pci_versatile_ops;
> 
