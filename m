Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751635AbdDCXPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Apr 2017 19:15:30 -0400
Date: Mon, 3 Apr 2017 18:15:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        kishon@ti.com, linux-arm-kernel@axis.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] PCI: dwc: fix crash seen due to missing ops
Message-ID: <20170403231525.GF13232@bhelgaas-glaptop.roam.corp.google.com>
References: <20170321144354.15452-1-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170321144354.15452-1-niklass@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 03:43:54PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> Fix the following crash, seen in dwc/pcie-artpec6.
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00000004
>   pgd = c0204000
>   [00000004] *pgd=00000000
>   Internal error: Oops: 5 [#1] SMP ARM
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc3-next-20170321 #1
>   Hardware name: Axis ARTPEC-6 Platform
>   task: db098000 task.stack: db096000
>   PC is at dw_pcie_writel_dbi+0x2c/0xd0
>   ...
> 
> While at it, fix the same problem for pcie-designware-plat.
> 
> Fixes: 442ec4c04d12 ("PCI: dwc: all: Split struct pcie_port into host-only and core structures")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

For artpec6, I think this has already been fixed by Kishon's "PCI: dwc:
artpec6: Populate cpu_addr_fixup ops".

Since both the artpec6 and designware-plat issues were introduced by
442ec4c04d12, which we merged in the v4.11 merge window, I moved Kishon's
fix and the designware-plat part of this patch to for-linus for v4.11.

Please double-check my for-linus branch to make sure it has what we need.

> ---
>  drivers/pci/dwc/pcie-artpec6.c         | 4 ++++
>  drivers/pci/dwc/pcie-designware-plat.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> index fcd3ef845883..6d23683c0892 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -234,6 +234,9 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>  	return 0;
>  }
>  
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +};
> +
>  static int artpec6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -252,6 +255,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
>  
>  	artpec6_pcie->pci = pci;
>  
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> index b6c832ba39dd..f20d494922ab 100644
> --- a/drivers/pci/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -86,6 +86,9 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>  	return 0;
>  }
>  
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +};
> +
>  static int dw_plat_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -103,6 +106,7 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
>  
>  	dw_plat_pcie->pci = pci;
>  
> -- 
> 2.11.0
> 
