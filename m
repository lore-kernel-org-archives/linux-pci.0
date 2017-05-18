Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33742 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbdERSuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2017 14:50:16 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so7238691qkh.0
        for <linux-pci@vger.kernel.org>; Thu, 18 May 2017 11:50:16 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <marc.zyngier@arm.com>
Cc: <m-karicheri2@ti.com>, <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <linux-pci@vger.kernel.org>
References: <cover.1494867112.git.jpinto@synopsys.com> <f395077bae8e34b2929bccb886952322ad5526fc.1494867112.git.jpinto@synopsys.com>
In-Reply-To: <f395077bae8e34b2929bccb886952322ad5526fc.1494867112.git.jpinto@synopsys.com>
Subject: Re: [RFC v2 2/8] pci: exynos SoC driver adapted to new irq API
Date: Thu, 18 May 2017 14:50:13 -0400
Message-ID: <002a01d2d007$9651afd0$c2f50f70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 15, 2017 1:04 PM, Joao Pinto wrote:

> 
> This patch adapts Exynos SoC specific driver to use the new interrupt api
> available in pcie-designware.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> changes v1->v2:
> - just to keep up patch set version
> 
>  drivers/pci/dwc/pci-exynos.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 546082a..e49c39a 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -490,15 +490,6 @@ static irqreturn_t exynos_pcie_irq_handler(int irq,
> void *arg)
>  	return IRQ_HANDLED;
>  }
> 
> -static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct exynos_pcie *ep = arg;
> -	struct dw_pcie *pci = ep->pci;
> -	struct pcie_port *pp = &pci->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static void exynos_pcie_msi_init(struct exynos_pcie *ep)
>  {
>  	struct dw_pcie *pci = ep->pci;
> @@ -622,15 +613,6 @@ static int __init exynos_add_pcie_port(struct
> exynos_pcie *ep,
>  			dev_err(dev, "failed to get msi irq\n");
>  			return -ENODEV;
>  		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -					exynos_pcie_msi_irq_handler,
> -					IRQF_SHARED | IRQF_NO_THREAD,
> -					"exynos-pcie", ep);
> -		if (ret) {
> -			dev_err(dev, "failed to request msi irq\n");
> -			return ret;
> -		}
>  	}
> 
>  	pp->root_bus_nr = -1;
> --
> 2.9.3
