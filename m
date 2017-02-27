Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:9724 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdB0FYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2017 00:24:38 -0500
Subject: Re: [PATCH] PCI: dwc: Fix crashes seen due to missing assignments
To: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1488017292-24158-1-git-send-email-linux@roeck-us.net>
CC: Jingoo Han <jingoohan1@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58B3B35A.4040501@ti.com>
Date: Mon, 27 Feb 2017 10:34:26 +0530
MIME-Version: 1.0
In-Reply-To: <1488017292-24158-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Guenter,

On Saturday 25 February 2017 03:38 PM, Guenter Roeck wrote:
> Fix the following crash, seen in dwc/pci-imx6.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000070
> pgd = c0004000
> [00000070] *pgd=00000000
> Internal error: Oops: 805 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-09686-g9e31489 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> task: cb850000 task.stack: cb84e000
> PC is at imx6_pcie_probe+0x2f4/0x414
> ...
> 
> While at it, fix the same problem in various drivers instead of waiting
> for individual crash reports.
> 
> The change in the imx6 driver was tested with qemu. The changes in other
> drivers are based on code inspection and have been compile tested only.
> 
> Fixes: 442ec4c04d12 ("PCI: dwc: all: Split struct pcie_port into ...")
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

looks like I missed the assignment which rebasing. Thanks for fixing it.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

-Kishon
> ---
>  drivers/pci/dwc/pci-exynos.c     | 1 +
>  drivers/pci/dwc/pci-imx6.c       | 1 +
>  drivers/pci/dwc/pci-keystone.c   | 2 ++
>  drivers/pci/dwc/pci-layerscape.c | 2 ++
>  drivers/pci/dwc/pcie-armada8k.c  | 2 ++
>  drivers/pci/dwc/pcie-artpec6.c   | 2 ++
>  drivers/pci/dwc/pcie-hisi.c      | 2 ++
>  drivers/pci/dwc/pcie-qcom.c      | 2 ++
>  drivers/pci/dwc/pcie-spear13xx.c | 2 ++
>  9 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 001c91a945aa..993b650ef275 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -668,6 +668,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	ep->pci = pci;
>  	ep->ops = (const struct exynos_pcie_ops *)
>  		of_device_get_match_data(dev);
>  
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index 3ab6761db9e8..801e46cd266d 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -605,6 +605,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	imx6_pcie->pci = pci;
>  	imx6_pcie->variant =
>  		(enum imx6_pcie_variants)of_device_get_match_data(dev);
>  
> diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
> index 8dc66409182d..fcc9723bad6e 100644
> --- a/drivers/pci/dwc/pci-keystone.c
> +++ b/drivers/pci/dwc/pci-keystone.c
> @@ -401,6 +401,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	ks_pcie->pci = pci;
> +
>  	/* initialize SerDes Phy if present */
>  	phy = devm_phy_get(dev, "pcie-phy");
>  	if (PTR_ERR_OR_ZERO(phy) == -EPROBE_DEFER)
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index 175c09e3a932..c32e392a0ae6 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -280,6 +280,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
> +	pcie->pci = pci;
> +
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
>  	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
>  	if (IS_ERR(pci->dbi_base))
> diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
> index 66bac6fbfa9f..f110e3b24a26 100644
> --- a/drivers/pci/dwc/pcie-armada8k.c
> +++ b/drivers/pci/dwc/pcie-armada8k.c
> @@ -220,6 +220,8 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	pcie->pci = pci;
> +
>  	pcie->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(pcie->clk))
>  		return PTR_ERR(pcie->clk);
> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> index 59ecc9e66436..fcd3ef845883 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -253,6 +253,8 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  
>  	pci->dev = dev;
>  
> +	artpec6_pcie->pci = pci;
> +
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>  	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
>  	if (IS_ERR(pci->dbi_base))
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index e3e4fedd9f68..fd66a3199db7 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -284,6 +284,8 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  
>  	driver = dev->driver;
>  
> +	hisi_pcie->pci = pci;
> +
>  	hisi_pcie->soc_ops = of_device_get_match_data(dev);
>  
>  	hisi_pcie->subctrl =
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index e36abe0d9d6f..67eb7f5926dd 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -686,6 +686,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
>  
> +	pcie->pci = pci;
> +
>  	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
>  
>  	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
> index 348f9c5e0433..eaa4ea8e2ea4 100644
> --- a/drivers/pci/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/dwc/pcie-spear13xx.c
> @@ -247,6 +247,8 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	spear13xx_pcie->pci = pci;
> +
>  	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
>  	if (IS_ERR(spear13xx_pcie->phy)) {
>  		ret = PTR_ERR(spear13xx_pcie->phy);
> 
