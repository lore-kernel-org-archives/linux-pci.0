Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754284AbdGJUjl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 16:39:41 -0400
Date: Mon, 10 Jul 2017 15:39:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] phy-rockchip-pcie: add set_mode callback
Message-ID: <20170710203937.GA5610@bhelgaas-glaptop.roam.corp.google.com>
References: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497601068-181656-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 04:17:47PM +0800, Shawn Lin wrote:
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

s/coressponding/corresponding/
s/specificed/specified/
s/in consistent/consistent/

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

phy_mode is defined as:

  enum phy_mode {
	  PHY_MODE_INVALID,
	  PHY_MODE_USB_HOST,
	  PHY_MODE_USB_DEVICE,
	  PHY_MODE_USB_OTG,
  };

You're using phy_mode as something entirely different -- a bitmap of
which lanes you want to keep active.  I understand you're trying to
avoid extending phy_mode again, but I just want to point out that
there are no other places that subvert phy_mode as you're doing.

It's probably worth a comment here about why we're not using the
standard enum values.  I see you already have one at the caller.

I'm not the PHY guy, so I'd like Kishon's ack before going down this
road.

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
> -- 
> 1.9.1
> 
> 
