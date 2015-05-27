Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34803 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbE0XfX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 19:35:23 -0400
Received: by igbhj9 with SMTP id hj9so100763175igb.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2015 16:35:22 -0700 (PDT)
Date: Wed, 27 May 2015 18:35:19 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: rjui@broadcom.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, zajec5@gmail.com
Subject: Re: [PATCH 1/2] PCI: iproc: directly add pci resources
Message-ID: <20150527233519.GH10210@google.com>
References: <1432499823-27369-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432499823-27369-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 24, 2015 at 10:37:02PM +0200, Hauke Mehrtens wrote:
> The resources member in the struct was pointing to a stack variable and
> is invalid after the the registration function returned. Remove this
> pointer and add it a a parameter to the function.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied both patches with Ray's Reviewed-by to pci/host-iproc for v4.2,
thanks!

> ---
>  drivers/pci/host/pcie-iproc-bcma.c     | 4 +---
>  drivers/pci/host/pcie-iproc-platform.c | 4 +---
>  drivers/pci/host/pcie-iproc.c          | 4 ++--
>  drivers/pci/host/pcie-iproc.h          | 3 +--
>  4 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
> index c318f19..f96b39e 100644
> --- a/drivers/pci/host/pcie-iproc-bcma.c
> +++ b/drivers/pci/host/pcie-iproc-bcma.c
> @@ -62,11 +62,9 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>  	res_mem.flags = IORESOURCE_MEM;
>  	pci_add_resource(&res, &res_mem);
>  
> -	pcie->resources = &res;
> -
>  	pcie->map_irq = iproc_pcie_bcma_map_irq;
>  
> -	ret = iproc_pcie_setup(pcie);
> +	ret = iproc_pcie_setup(pcie, &res);
>  	if (ret) {
>  		dev_err(pcie->dev, "PCIe controller setup failed\n");
>  		return ret;
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index c8aa06f..c5fe4c1 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -69,11 +69,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pcie->resources = &res;
> -
>  	pcie->map_irq = of_irq_parse_and_map_pci;
>  
> -	ret = iproc_pcie_setup(pcie);
> +	ret = iproc_pcie_setup(pcie, &res);
>  	if (ret) {
>  		dev_err(pcie->dev, "PCIe controller setup failed\n");
>  		return ret;
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index cef31f6..d77481e 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -183,7 +183,7 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
>  	writel(SYS_RC_INTX_MASK, pcie->base + SYS_RC_INTX_EN);
>  }
>  
> -int iproc_pcie_setup(struct iproc_pcie *pcie)
> +int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>  	int ret;
>  	struct pci_bus *bus;
> @@ -211,7 +211,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>  	pcie->sysdata.private_data = pcie;
>  
>  	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
> -				  &pcie->sysdata, pcie->resources);
> +				  &pcie->sysdata, res);
>  	if (!bus) {
>  		dev_err(pcie->dev, "unable to create PCI root bus\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index a333d4b..ba0a108 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -29,7 +29,6 @@
>  struct iproc_pcie {
>  	struct device *dev;
>  	void __iomem *base;
> -	struct list_head *resources;
>  	struct pci_sys_data sysdata;
>  	struct pci_bus *root_bus;
>  	struct phy *phy;
> @@ -37,7 +36,7 @@ struct iproc_pcie {
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  };
>  
> -int iproc_pcie_setup(struct iproc_pcie *pcie);
> +int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
>  int iproc_pcie_remove(struct iproc_pcie *pcie);
>  
>  #endif /* _PCIE_IPROC_H */
> -- 
> 2.1.4
> 
