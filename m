Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754357AbdA3UyB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 15:54:01 -0500
Date: Mon, 30 Jan 2017 14:53:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: improve the training polling code
Message-ID: <20170130205346.GU20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1484728155-72502-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484728155-72502-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2017 at 04:29:15PM +0800, Shawn Lin wrote:
> Use the readl_poll_timeout instead of open coding them.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockship for v4.11, thanks!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 52 +++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0d6e8ee..17374a9 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -188,8 +188,11 @@
>  	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
>  	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
>  #define PCIE_LINK_IS_L2(x) \
> -		(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == \
> -		 PCIE_CLIENT_DEBUG_LTSSM_L2)
> +	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
> +#define PCIE_LINK_UP(x) \
> +	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
> +#define PCIE_LINK_IS_GEN2(x) \
> +	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)
>  
>  #define RC_REGION_0_ADDR_TRANS_H		0x00000000
>  #define RC_REGION_0_ADDR_TRANS_L		0x00000000
> @@ -463,7 +466,6 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	struct device *dev = rockchip->dev;
>  	int err;
>  	u32 status;
> -	unsigned long timeout;
>  
>  	gpiod_set_value(rockchip->ep_gpio, 0);
>  
> @@ -604,23 +606,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	gpiod_set_value(rockchip->ep_gpio, 1);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
> -	timeout = jiffies + msecs_to_jiffies(500);
> -
> -	for (;;) {
> -		status = rockchip_pcie_read(rockchip,
> -					    PCIE_CLIENT_BASIC_STATUS1);
> -		if ((status & PCIE_CLIENT_LINK_STATUS_MASK) ==
> -		    PCIE_CLIENT_LINK_STATUS_UP) {
> -			dev_dbg(dev, "PCIe link training gen1 pass!\n");
> -			break;
> -		}
> -
> -		if (time_after(jiffies, timeout)) {
> -			dev_err(dev, "PCIe link training gen1 timeout!\n");
> -			return -ETIMEDOUT;
> -		}
> -
> -		msleep(20);
> +	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> +				 status, PCIE_LINK_UP(status), 20,
> +				 500 * USEC_PER_MSEC);
> +	if (err) {
> +		dev_err(dev, "PCIe link training gen1 timeout!\n");
> +		return -ETIMEDOUT;
>  	}
>  
>  	if (rockchip->link_gen == 2) {
> @@ -632,22 +623,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		status |= PCI_EXP_LNKCTL_RL;
>  		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  
> -		timeout = jiffies + msecs_to_jiffies(500);
> -		for (;;) {
> -			status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> -			if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
> -			    PCIE_CORE_PL_CONF_SPEED_5G) {
> -				dev_dbg(dev, "PCIe link training gen2 pass!\n");
> -				break;
> -			}
> -
> -			if (time_after(jiffies, timeout)) {
> -				dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
> -				break;
> -			}
> -
> -			msleep(20);
> -		}
> +		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
> +					 status, PCIE_LINK_IS_GEN2(status), 20,
> +					 500 * USEC_PER_MSEC);
> +		if (err)
> +			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
>  	}
>  
>  	/* Check the final link width from negotiated lane counter from MGMT */
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
