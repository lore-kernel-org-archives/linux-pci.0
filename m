Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 2 Sep 2016 14:38:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 07/15] Simplify the confusing HIWORD_UPDATE scheme.
Message-ID: <20160902213806.GA31011@roeck-us.net>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160902155453.8650.29613.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902155453.8650.29613.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 02, 2016 at 10:54:53AM -0500, Bjorn Helgaas wrote:
> 
> ---
>  drivers/pci/host/pcie-rockchip.c |   70 +++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c0c3ad5..b204567 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -115,36 +115,26 @@
>  	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
>  	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
>  
> -/*
> -  * The higher 16-bit of this register is used for write protection
> -  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> -  */
> -#define HIWORD_UPDATE(val, mask, shift) \
> -	((val) << (shift) | (mask) << ((shift) + 16))
> -
>  #define RC_REGION_0_ADDR_TRANS_H		0x00000000
>  #define RC_REGION_0_ADDR_TRANS_L		0x00000000
>  #define RC_REGION_0_PASS_BITS			(25 - 1)
>  #define MAX_AXI_WRAPPER_REGION_NUM		33
>  #define PCIE_CORE_LCSR_RETRAIN_LINK		BIT(5)
> -#define PCIE_CLIENT_CONF_ENABLE			BIT(0)
> -#define PCIE_CLIENT_CONF_ENABLE_SHIFT		0
> -#define PCIE_CLIENT_CONF_ENABLE_MASK		0x1
> -#define PCIE_CLIENT_LINK_TRAIN_ENABLE		1
> -#define PCIE_CLIENT_LINK_TRAIN_SHIFT		1
> -#define PCIE_CLIENT_LINK_TRAIN_MASK		0x1
> -#define PCIE_CLIENT_ARI_ENABLE			BIT(0)
> -#define PCIE_CLIENT_ARI_ENABLE_SHIFT		3
> -#define PCIE_CLIENT_ARI_ENABLE_MASK		0x1
> -#define PCIE_CLIENT_CONF_LANE_NUM(x)		(x / 2)
> -#define PCIE_CLIENT_CONF_LANE_NUM_SHIFT		4
> -#define PCIE_CLIENT_CONF_LANE_NUM_MASK		0x3
> -#define PCIE_CLIENT_MODE_RC			BIT(0)
> -#define PCIE_CLIENT_MODE_SHIFT			6
> -#define PCIE_CLIENT_MODE_MASK			0x1
> -#define PCIE_CLIENT_GEN_SEL_2			1
> -#define PCIE_CLIENT_GEN_SEL_SHIFT		7
> -#define PCIE_CLIENT_GEN_SEL_MASK		0x1
> +
> +/*
> + * The upper 16 bits of the PCIE_CLIENT registers are a write mask for the
> + * lower 16 bits.  This allows atomic updates of the register without
> + * locking.
> + */
> +#define HIWORD_UPDATE(mask, val)	((mask << 16) | val)
> +
> +#define ENCODE_LANES(x)			(((x >> 1) & 3) << 4)

(x) ?

> +
> +#define PCIE_CLIENT_CONF_ENABLE		HIWORD_UPDATE(0x0001, 0x0001)
> +#define PCIE_CLIENT_LINK_TRAIN_ENABLE	HIWORD_UPDATE(0x0002, 0x0002)
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)	HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
> +#define PCIE_CLIENT_GEN_SEL_2		HIWORD_UPDATE(0x0040, 0x0040)
> +
>  #define PCIE_CLIENT_LINK_STATUS_UP		0x3
>  #define PCIE_CLIENT_LINK_STATUS_SHIFT		20
>  #define PCIE_CLIENT_LINK_STATUS_MASK		0x3
> @@ -423,22 +413,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	}
>  
>  	rockchip_pcie_write(rockchip,
> -		   HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
> -				 PCIE_CLIENT_CONF_ENABLE_MASK,
> -				 PCIE_CLIENT_CONF_ENABLE_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes),
> -				 PCIE_CLIENT_CONF_LANE_NUM_MASK,
> -				 PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
> -				 PCIE_CLIENT_MODE_MASK,
> -				 PCIE_CLIENT_MODE_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_ARI_ENABLE,
> -				 PCIE_CLIENT_ARI_ENABLE_MASK,
> -				 PCIE_CLIENT_ARI_ENABLE_SHIFT) |
> -		   HIWORD_UPDATE(PCIE_CLIENT_GEN_SEL_2,
> -				 PCIE_CLIENT_GEN_SEL_MASK,
> -				 PCIE_CLIENT_GEN_SEL_SHIFT),
> -		   PCIE_CLIENT_BASE);
> +			    PCIE_CLIENT_CONF_ENABLE |
> +			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
> +			    PCIE_CLIENT_ARI_ENABLE |
> +			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
> +			    PCIE_CLIENT_MODE_RC |
> +			    PCIE_CLIENT_GEN_SEL_2,
> +				PCIE_CLIENT_BASE);
>  

This is soooo much better ...

Guenter

>  	err = phy_power_on(rockchip->phy);
>  	if (err) {
> @@ -482,11 +463,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  				 PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
>  
>  	/* Enable Gen1 training */
> -	rockchip_pcie_write(rockchip,
> -		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
> -				 PCIE_CLIENT_LINK_TRAIN_MASK,
> -				 PCIE_CLIENT_LINK_TRAIN_SHIFT),
> -		   PCIE_CLIENT_BASE);
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> +			    PCIE_CLIENT_BASE);
>  
>  	gpiod_set_value(rockchip->ep_gpio, 1);
>  
> 
