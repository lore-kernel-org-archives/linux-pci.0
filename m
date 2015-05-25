Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:48764 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbEYRK4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2015 13:10:56 -0400
Message-ID: <5563579E.80608@broadcom.com>
Date: Mon, 25 May 2015 10:10:54 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>, <zajec5@gmail.com>
Subject: Re: [PATCH 1/2] PCI: iproc: directly add pci resources
References: <1432499823-27369-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1432499823-27369-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hauke,

On 5/24/2015 1:37 PM, Hauke Mehrtens wrote:
> The resources member in the struct was pointing to a stack variable and
> is invalid after the the registration function returned. Remove this
> pointer and add it a a parameter to the function.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
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

This means we do not want to keep a copy of the resources. In the
future, if we need to add support to explicitly set up the
inbound/outbound mapping window, we need to do it in iproc_pcie_setup.
Is that the intention?

Thanks,

Ray

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
> 
