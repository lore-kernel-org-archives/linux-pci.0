Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36884 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934021AbeAXQDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jan 2018 11:03:22 -0500
Received: by mail-qt0-f193.google.com with SMTP id d54so11561288qtd.4
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2018 08:03:22 -0800 (PST)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        <marc.zyngier@arm.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <kishon@ti.com>
Cc: <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <nsekhar@ti.com>
References: <cover.1516701516.git.gustavo.pimentel@synopsys.com> <5526d39226e948d3be46297725522badfe63d024.1516701516.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <5526d39226e948d3be46297725522badfe63d024.1516701516.git.gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v5 2/9] PCI: dwc: exynos: Switch to use the IRQ chained API
Date: Wed, 24 Jan 2018 11:03:19 -0500
Message-ID: <000001d3952c$daf2a0f0$90d7e2d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 23, 2018 7:25 AM, Gustavo Pimentel wrote:
> 
> Changes Exynos SoC specific driver to use the IRQ chained API available in
> pcie-designware.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

It looks good.

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> Change v1->v2:
> - Nothing changed, just to follow the patch set version.
> Change v2->v3:
> - Nothing changed, just to follow the patch set version.
> Change v3->v4:
> - Changed summary line to match the drivers/PCI convention and changelog
> to
> maintain the consistency (thanks Bjorn).
> Change v4->v5:
> - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pci-exynos.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index 56f32ae..0a6b283d 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -297,15 +297,6 @@ static irqreturn_t exynos_pcie_irq_handler(int irq,
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
> @@ -431,15 +422,6 @@ static int __init exynos_add_pcie_port(struct
> exynos_pcie *ep,
>  			dev_err(dev, "failed to get msi irq\n");
>  			return pp->msi_irq;
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
> 2.7.4
> 
