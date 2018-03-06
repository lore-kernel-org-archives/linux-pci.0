Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41982 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFIX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 03:23:59 -0500
Received: by mail-pl0-f66.google.com with SMTP id d9-v6so3973452plo.8
        for <linux-pci@vger.kernel.org>; Tue, 06 Mar 2018 00:23:59 -0800 (PST)
Date: Tue, 6 Mar 2018 16:23:19 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH v9 0/3] PCI: dwc: Enables MSI-X driver support
Message-ID: <20180306082316.GH28619@dragon>
References: <cover.1519834018.git.gustavo.pimentel@synopsys.com>
 <20180302180320.GA5404@red-moon>
 <23de1d16-ee47-9e53-c1c4-4437f37cc358@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23de1d16-ee47-9e53-c1c4-4437f37cc358@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 05, 2018 at 06:22:53PM +0000, Gustavo Pimentel wrote:
> On 02/03/2018 18:03, Lorenzo Pieralisi wrote:
> > [+cc Shawn, Vignesh, Pratyush]
...
> > Is it correct to leave pcie-histb.c as-is ? I do not think it is.
> 
> At the time the first series of this patch came out there wasn't such driver and
> I just start working on this topic on December... Nevertheless, you are right it
> should follow the same procedure that others.
> 
> diff --git a/drivers/pci/dwc/pcie-histb.c b/drivers/pci/dwc/pcie-histb.c
> index 70b5c0b..5d47b90 100644
> --- a/drivers/pci/dwc/pcie-histb.c
> +++ b/drivers/pci/dwc/pcie-histb.c
> @@ -207,13 +207,6 @@ static struct dw_pcie_host_ops histb_pcie_host_ops = {
>  	.host_init = histb_pcie_host_init,
>  };
> 
> -static irqreturn_t histb_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct pcie_port *pp = arg;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
>  static void histb_pcie_host_disable(struct histb_pcie *hipcie)
>  {
>  	reset_control_assert(hipcie->soft_reset);
> @@ -393,14 +386,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to get MSI IRQ\n");
>  			return pp->msi_irq;
>  		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       histb_pcie_msi_irq_handler,
> -				       IRQF_SHARED, "histb-pcie-msi", pp);
> -		if (ret) {
> -			dev_err(dev, "cannot request MSI IRQ\n");
> -			return ret;
> -		}
>  	}
> 
>  	hipcie->phy = devm_phy_get(dev, "phy");

I manually applied the changes on top of Lorenzo's pci/dwc-msi branch,
and pcie-histb driver still works fine.

Tested-by: Shawn Guo <shawn.guo@linaro.org>
