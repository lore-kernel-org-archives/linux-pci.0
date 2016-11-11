Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935747AbcKKWDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 17:03:47 -0500
Date: Fri, 11 Nov 2016 16:03:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 1/4] PCI: rockchip: Provide captured slot power limit
 and scale
Message-ID: <20161111220342.GP9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476754889-21804-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476754889-21804-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 18, 2016 at 09:41:26AM +0800, Shawn Lin wrote:
> If vpcie3v3 is available, we could provide these information
> via RC's configure register to make EP able to know the power
> limit.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I applied all four of these to pci/host-rockchip for v4.10, thanks!

> ---
> 
> Changes in v4:
> - rebase on next branch
> 
> Changes in v3:
> - rebase the code since it isn't cleanly applied again.
> 
> Changes in v2:
> - rebase the code since it isn't cleanly applied after Bjorn's cleanup
> 
>  drivers/pci/host/pcie-rockchip.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22da..3ede865 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -135,6 +135,10 @@
>  #define PCIE_RC_CONFIG_VENDOR		(PCIE_RC_CONFIG_BASE + 0x00)
>  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
>  #define   PCIE_RC_CONFIG_SCC_SHIFT		16
> +#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
> +#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> +#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> +#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
>  #define   PCIE_RC_CONFIG_LCS_RETRAIN_LINK	BIT(5)
>  #define   PCIE_RC_CONFIG_LCS_LBMIE		BIT(10)
> @@ -395,6 +399,40 @@ static struct pci_ops rockchip_pcie_ops = {
>  	.write = rockchip_pcie_wr_conf,
>  };
>  
> +static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
> +{
> +	u32 status, curr, scale, power;
> +
> +	if (IS_ERR(rockchip->vpcie3v3))
> +		return;
> +
> +	/*
> +	 * Set RC's captured slot power limit and scale if
> +	 * vpcie3v3 available. The default values are both zero
> +	 * which means the software should set these two according
> +	 * to the actual power supply.
> +	 */
> +	curr = regulator_get_current_limit(rockchip->vpcie3v3);
> +	if (curr > 0) {
> +		scale = 3; /* 0.001x */
> +		curr = curr / 1000; /* convert to mA */
> +		power = (curr * 3300) / 1000; /* milliwatt */
> +		while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
> +			if (!scale) {
> +				dev_warn(rockchip->dev, "invalid power supply\n");
> +				return;
> +			}
> +			scale--;
> +			power = power / 10;
> +		}
> +
> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
> +		status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
> +			  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> +	}
> +}
> +
>  /**
>   * rockchip_pcie_init_port - Initialize hardware
>   * @rockchip: PCIe port information
> @@ -496,6 +534,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
>  	rockchip_pcie_write(rockchip, status, PCIE_CORE_CTRL_PLC1);
>  
> +	rockchip_pcie_set_power_limit(rockchip);
> +
>  	/* Enable Gen1 training */
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
> -- 
> 2.3.7
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
