Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:43711 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759675AbdCVPtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2017 11:49:49 -0400
Subject: Re: [PATCH] PCI: dwc: fix crash seen due to missing ops
To: Niklas Cassel <niklas.cassel@axis.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>, <kishon@ti.com>
References: <20170321144354.15452-1-niklass@axis.com>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Niklas Cassel <niklass@axis.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ffb1d92b-a637-2ed9-51d3-6b9fbb790635@synopsys.com>
Date: Wed, 22 Mar 2017 15:47:06 +0000
MIME-Version: 1.0
In-Reply-To: <20170321144354.15452-1-niklass@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Niklas,

Às 2:43 PM de 3/21/2017, Niklas Cassel escreveu:
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
> 

In the case of pcie-designware-plat you have the declaration of pci->ops:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/dwc/pcie-designware-plat.c#n78

and in artpec6 in here:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/dwc/pcie-artpec6.c#n226

Both declarations are made previously of calling dw_pcie_host_init(), so why do
you need this dummy ops in the probe function? I never had that necessity.

Thanks,
Joao

Thanks,
