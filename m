Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33987 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdGRUjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 16:39:17 -0400
Received: by mail-pg0-f46.google.com with SMTP id 123so18733742pgj.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 13:39:17 -0700 (PDT)
Date: Tue, 18 Jul 2017 13:39:14 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/7] PCI: rockchip: idle the inactive PHY(s)
Message-ID: <20170718203913.GD116895@google.com>
References: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
 <1500364623-97041-5-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500364623-97041-5-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, Jul 18, 2017 at 03:57:00PM +0800, Shawn Lin wrote:
> Check the status of all lanes and idle the inactive one(s).
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> - use cached lanes_map to avoid powering off inactive
>   lanes twice
> 
> Changes in v2: None
> 
>  drivers/pci/host/pcie-rockchip.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 4cc6aec..d73223f 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -15,6 +15,7 @@
>   * (at your option) any later version.
>   */
>  
> +#include <linux/bitrev.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> @@ -112,6 +113,9 @@
>  #define   PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT	16
>  #define   PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(x) \
>  		(((x) >> 3) << PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT)
> +#define PCIE_CORE_LANE_MAP             (PCIE_CORE_CTRL_MGMT_BASE + 0x200)
> +#define   PCIE_CORE_LANE_MAP_MASK              0x0000000f
> +#define   PCIE_CORE_LANE_MAP_REVERSE           BIT(16)
>  #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
>  #define   PCIE_CORE_INT_PRFPE			BIT(0)
>  #define   PCIE_CORE_INT_CRFPE			BIT(1)
> @@ -229,6 +233,7 @@ struct rockchip_pcie {
>  	struct	regulator *vpcie0v9; /* 0.9V power supply */
>  	struct	gpio_desc *ep_gpio;
>  	u32	lanes;
> +	u8      lanes_map;
>  	u8	root_bus_nr;
>  	int	link_gen;
>  	struct	device *dev;
> @@ -301,6 +306,17 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  	return 1;
>  }
>  
> +static void rockchip_pcie_lane_map(struct rockchip_pcie *rockchip)
> +{
> +	u32 val = rockchip_pcie_read(rockchip, PCIE_CORE_LANE_MAP);
> +
> +	rockchip->lanes_map = val & PCIE_CORE_LANE_MAP_MASK;
> +
> +	/* The link may be using a reverse-indexed mapping. */
> +	if (val & PCIE_CORE_LANE_MAP_REVERSE)
> +		rockchip->lanes_map = bitrev8(rockchip->lanes_map) >> 4;

This might just be a matter of taste, but it seems to make more sense
for this function to just return a u8, and the caller can assign it to
'rockchip->lane_map'.

> +}
> +
>  static int rockchip_pcie_rd_own_conf(struct rockchip_pcie *rockchip,
>  				     int where, int size, u32 *val)
>  {
> @@ -737,6 +753,18 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  			  PCIE_CORE_PL_CONF_LANE_SHIFT);
>  	dev_dbg(dev, "current link width is x%d\n", status);
>  
> +	if (!rockchip->legacy_phy) {
> +		/*  power off unused lane(s) */
> +		rockchip_pcie_lane_map(rockchip);

My above comment would make it a lot clearer that the above line...

> +		for (i = 0; i < MAX_LANE_NUM; i++) {
> +			if (rockchip->lanes_map & BIT(i))

...is determining the behavior here.

> +				continue;
> +
> +			dev_dbg(dev, "idling lane %d\n", i);
> +			phy_power_off(rockchip->phys[i]);
> +		}
> +	}
> +
>  	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
>  			    PCIE_CORE_CONFIG_VENDOR);
>  	rockchip_pcie_write(rockchip,

...

Brian
