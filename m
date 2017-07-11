Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:53432 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdGKEqr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2017 00:46:47 -0400
Subject: Re: [PATCH 1/2] phy-rockchip-pcie: add set_mode callback
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
CC: Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cea27b15-2c2d-a4a9-76f8-f4798c152101@ti.com>
Date: Tue, 11 Jul 2017 10:15:58 +0530
MIME-Version: 1.0
In-Reply-To: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 16 June 2017 01:47 PM, Shawn Lin wrote:
> phy_mode was added for switching USB mode purposely as
> well as phy_set_mode API. However other types of PHY could
> also have some miscellaneous setting/modes need to be
> handled. This patch is gonna support this callback for
> phy-rockchip-pcie and do some power-saving work there.
> Note that we just stuff in some other values other that the
> existing phy_mode and convert it in the coressponding driver
> instead, otherwise we should extend the phy_mode again which
> it doesn't make sense to add in new driver's specificed value.
> Overall it looks fine to me as the controller's driver and the
> phy's driver are paired so that the caller and the consumer should
> be able to keep the value(mode) in consistent.

I really don't prefer using an API other that what it is intended for. We have
to come up with a better way for handling this.

IIUC this patch sets unused lanes in idle mode? If yes, then can't we model
each lane as a separate phy, so that we can power-on/power-off each lane
independently.

Thanks
Kishon
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/phy/rockchip/phy-rockchip-pcie.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index 6904633..9ffad15 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -255,11 +255,33 @@ static int rockchip_pcie_phy_exit(struct phy *phy)
>  	return 0;
>  }
>  
> +static int rockchip_pcie_phy_set_mode(struct phy *phy, enum phy_mode mode)
> +{
> +	struct rockchip_pcie_phy *rk_phy = phy_get_drvdata(phy);
> +	u8 map = (u8)mode;
> +	int i;
> +
> +	for (i = 0; i < PHY_MAX_LANE_NUM; i++) {
> +		if (map & BIT(i))
> +			continue;
> +
> +		dev_dbg(&phy->dev, "idling lane %d\n", i);
> +		regmap_write(rk_phy->reg_base,
> +			     rk_phy->phy_data->pcie_laneoff,
> +			     HIWORD_UPDATE(PHY_LANE_IDLE_OFF,
> +			     PHY_LANE_IDLE_MASK,
> +			     PHY_LANE_IDLE_A_SHIFT + i));
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct phy_ops ops = {
>  	.init		= rockchip_pcie_phy_init,
>  	.exit		= rockchip_pcie_phy_exit,
>  	.power_on	= rockchip_pcie_phy_power_on,
>  	.power_off	= rockchip_pcie_phy_power_off,
> +	.set_mode	= rockchip_pcie_phy_set_mode,
>  	.owner		= THIS_MODULE,
>  };
>  
> 
