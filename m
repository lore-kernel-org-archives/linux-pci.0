Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:34414 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbcIWA1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 20:27:44 -0400
Subject: Re: [PATCH] PCI: rockchip: Support quirk to disable 5 GT/s (PCIe 2.x)
 link rate
To: Brian Norris <briannorris@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1474565478-27242-1-git-send-email-briannorris@chromium.org>
Cc: shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b9527acf-e3cf-19d2-b8fc-0a59637e9598@rock-chips.com>
Date: Fri, 23 Sep 2016 08:27:35 +0800
MIME-Version: 1.0
In-Reply-To: <1474565478-27242-1-git-send-email-briannorris@chromium.org>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brain,

ÔÚ 2016/9/23 1:31, Brian Norris Ð´µÀ:
> rk3399 supports PCIe 2.x link speeds marginally at best, and on some
> boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
> ms waiting for training that will never happen, let's support a device
> tree quirk flag to disable generation 2 speeds entirely.

I was thinking about could we get target link speed [TLS] from the
end-point when finishing Gen1 training, but it seems that the location
of ep's TLS is not fixed.

Anyway, your patch looks sane to me as we leave gen2 as default and
people could drop that feature by adding rockchip,disable-gen2 to
their dts if they are sure the board would never supoort Gen2 devices.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>


>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  .../devicetree/bindings/pci/rockchip-pcie.txt      |  2 +
>  drivers/pci/host/pcie-rockchip.c                   | 57 +++++++++++++---------
>  2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> index ba67b39939c1..e769726fd093 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -42,6 +42,8 @@ Required properties:
>  Optional Property:
>  - ep-gpios: contain the entry for pre-reset gpio
>  - num-lanes: number of lanes to use
> +- rockchip,disable-gen2: present if PCIe generation 2.x (i.e., 5 GT/s link
> +	speeds) is not supported.
>  - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
>  - vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
>  - vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c3593e633ccd..f047c4a73f69 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -53,6 +53,7 @@
>  #define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
>  #define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
>  #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
> +#define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>  #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
>  #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
>  #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
> @@ -191,6 +192,7 @@ struct rockchip_pcie {
>  	struct	gpio_desc *ep_gpio;
>  	u32	lanes;
>  	u8	root_bus_nr;
> +	bool	enable_gen2;
>  	struct	device *dev;
>  	struct	irq_domain *irq_domain;
>  };
> @@ -418,13 +420,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>
> +	if (rockchip->enable_gen2)
> +		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> +				    PCIE_CLIENT_CONFIG);
> +	else
> +		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> +				    PCIE_CLIENT_CONFIG);
> +
>  	rockchip_pcie_write(rockchip,
>  			    PCIE_CLIENT_CONF_ENABLE |
>  			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
>  			    PCIE_CLIENT_ARI_ENABLE |
>  			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
> -			    PCIE_CLIENT_MODE_RC |
> -			    PCIE_CLIENT_GEN_SEL_2,
> +			    PCIE_CLIENT_MODE_RC,
>  				PCIE_CLIENT_CONFIG);
>
>  	err = phy_power_on(rockchip->phy);
> @@ -492,29 +500,31 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		msleep(20);
>  	}
>
> -	/*
> -	 * Enable retrain for gen2. This should be configured only after
> -	 * gen1 finished.
> -	 */
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	if (rockchip->enable_gen2) {
> +		/*
> +		 * Enable retrain for gen2. This should be configured only after
> +		 * gen1 finished.
> +		 */
> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +		status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +
> +		timeout = jiffies + msecs_to_jiffies(500);
> +		for (;;) {
> +			status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> +			if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
> +					PCIE_CORE_PL_CONF_SPEED_5G) {
> +				dev_dbg(dev, "PCIe link training gen2 pass!\n");
> +				break;
> +			}
>
> -	timeout = jiffies + msecs_to_jiffies(500);
> -	for (;;) {
> -		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> -		if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
> -		    PCIE_CORE_PL_CONF_SPEED_5G) {
> -			dev_dbg(dev, "PCIe link training gen2 pass!\n");
> -			break;
> -		}
> +			if (time_after(jiffies, timeout)) {
> +				dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
> +				break;
> +			}
>
> -		if (time_after(jiffies, timeout)) {
> -			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
> -			break;
> +			msleep(20);
>  		}
> -
> -		msleep(20);
>  	}
>
>  	/* Check the final link width from negotiated lane counter from MGMT */
> @@ -722,6 +732,9 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		rockchip->lanes = 1;
>  	}
>
> +	rockchip->enable_gen2 = !of_property_read_bool(node,
> +						       "rockchip,disable-gen2");
> +
>  	rockchip->core_rst = devm_reset_control_get(dev, "core");
>  	if (IS_ERR(rockchip->core_rst)) {
>  		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
>


-- 
Best Regards
Shawn Lin

