Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 19 Dec 2015 21:38:37 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rogerq@ti.com, nsekhar@ti.com,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	tony@atomide.com, t-kristo@ti.com
Subject: Re: [PATCH v3 6/9] phy: ti-pipe3: use *syscon* framework API to
 power on/off the PHY
Message-ID: <20151220033836.GG9883@rob-hp-laptop>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <1450170968-11282-7-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450170968-11282-7-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 15, 2015 at 02:46:05PM +0530, Kishon Vijay Abraham I wrote:
> Deprecate using phy-omap-control driver to power on/off the PHY and
> use *syscon* framework to do the same.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |   10 ++-
>  drivers/phy/phy-ti-pipe3.c                       |   90 ++++++++++++++++++----
>  2 files changed, 85 insertions(+), 15 deletions(-)

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

One comment on the driver though.

[...]

> --- a/drivers/phy/phy-ti-pipe3.c
> +++ b/drivers/phy/phy-ti-pipe3.c

[...]

> @@ -144,18 +155,53 @@ static void ti_pipe3_disable_clocks(struct ti_pipe3 *phy);
>  
>  static int ti_pipe3_power_off(struct phy *x)
>  {
> +	u32 val;
> +	int ret;
>  	struct ti_pipe3 *phy = phy_get_drvdata(x);
>  
> -	omap_control_phy_power(phy->control_dev, 0);
> +	if (phy->phy_power_syscon) {

Writing this as:

if (!phy->phy_power_syscon) {
	...
	return 0;
}

//regmap code


will make it simpler to remove the deprecated code later.


> +		val = PIPE3_PHY_TX_RX_POWEROFF <<
> +			PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
> +
> +		ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
> +					 PIPE3_PHY_PWRCTL_CLK_CMD_MASK, val);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		omap_control_phy_power(phy->control_dev, 0);
> +	}
>  
>  	return 0;
