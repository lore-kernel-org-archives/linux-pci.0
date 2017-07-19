Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:9948 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdGSHt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 03:49:56 -0400
Subject: Re: [RFC PATCH v4 1/7] PCI: rockchip: split out
 rockchip_pcie_get_phys
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1500448979-93067-1-git-send-email-shawn.lin@rock-chips.com>
 <1500448979-93067-2-git-send-email-shawn.lin@rock-chips.com>
CC: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        <linux-pci@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4e11d727-47cb-9b89-5081-387b550902b4@ti.com>
Date: Wed, 19 Jul 2017 13:17:58 +0530
MIME-Version: 1.0
In-Reply-To: <1500448979-93067-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 19 July 2017 12:52 PM, Shawn Lin wrote:
> We plan to introduce per-lanes PHY, so split out new
> function to make it easy in the future. No functional
> change intended.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> 
> Changes in v4:
> - use err variable to check return value of
>   rockchip_pcie_get_phys
> - add Brian's tag
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/host/pcie-rockchip.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 5acf869..c42feab 100644
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
>  
>  /**
>   * rockchip_pcie_parse_dt - Parse Device Tree
> @@ -883,12 +896,9 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	if (IS_ERR(rockchip->apb_base))
>  		return PTR_ERR(rockchip->apb_base);
>  
> -	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> -	if (IS_ERR(rockchip->phy)) {
> -		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
> -			dev_err(dev, "missing phy\n");
> -		return PTR_ERR(rockchip->phy);
> -	}
> +	err = rockchip_pcie_get_phys(rockchip);
> +	if (err)
> +		return err;
>  
>  	rockchip->lanes = 1;
>  	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
> 
