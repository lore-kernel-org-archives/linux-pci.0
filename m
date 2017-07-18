Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36764 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdGRUcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 16:32:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id o88so10202051pfk.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 13:31:59 -0700 (PDT)
Date: Tue, 18 Jul 2017 13:31:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/7] PCI: rockchip: split out
 rockchip_pcie_get_phys
Message-ID: <20170718203156.GB116895@google.com>
References: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
 <1500364623-97041-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500364623-97041-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

Some nitpicks :)

On Tue, Jul 18, 2017 at 03:56:57PM +0800, Shawn Lin wrote:
> We plan to introduce per-lanes PHY, so split out new
> function to make it easy in the future. No functional
> change intended.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/host/pcie-rockchip.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 5acf869..6632a51 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -853,6 +853,19 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->dev;
> +
> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(rockchip->phy)) {
> +		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
> +			dev_err(dev, "missing phy\n");
> +		return PTR_ERR(rockchip->phy);
> +	}
> +
> +	return 0;
> +}

You promptly relocate this entire function in the next patch. Would be
nice if you picked one place and kept it there. (I believe this is
partly because of how the previous revision had some more complicated
functions added nearby that were related. But you've killed that now.)

>  
>  /**
>   * rockchip_pcie_parse_dt - Parse Device Tree
> @@ -883,12 +896,8 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	if (IS_ERR(rockchip->apb_base))
>  		return PTR_ERR(rockchip->apb_base);
>  
> -	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> -	if (IS_ERR(rockchip->phy)) {
> -		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
> -			dev_err(dev, "missing phy\n");
> +	if (rockchip_pcie_get_phys(rockchip))
>  		return PTR_ERR(rockchip->phy);

In the next patch you (correctly) change this to actually capture the
return code from rockchip_pcie_get_phys(). Seems like you should just do
that in this patch.

Brian

> -	}
>  
>  	rockchip->lanes = 1;
>  	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
> -- 
> 1.9.1
> 
> 
