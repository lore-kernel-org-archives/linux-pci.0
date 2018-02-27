Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbeB0L3n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 06:29:43 -0500
Date: Tue, 27 Feb 2018 11:29:35 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/6] PCI: rockchip: Spilt out common function to init
 controller
Message-ID: <20180227112935.GA7184@e107981-ln.cambridge.arm.com>
References: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
 <1519348606-243485-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519348606-243485-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 09:16:46AM +0800, Shawn Lin wrote:
> Most of the operations are used for both of host and EP driver,
> so this patch spilt them out to a new function, rockchip_pcie_init_port

Here and in the $SUBJECT

s/spilt/split

I will update it myself if there is no v3 required (but I have some
minor comments on patch 5 so I suspect it will be required).

Lorenzo

> in pcie-rockchip.c and rename the original function to
> rockchip_pcie_host_init_port to avoid confusion. No functional
> changed intended.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/pci/rockchip/pcie-rockchip-host.c | 131 ++-------------------------
>  drivers/pci/rockchip/pcie-rockchip.c      | 141 ++++++++++++++++++++++++++++++
>  drivers/pci/rockchip/pcie-rockchip.h      |   3 +
>  3 files changed, 151 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/pci/rockchip/pcie-rockchip-host.c b/drivers/pci/rockchip/pcie-rockchip-host.c
> index 079949c..f5b0492 100644
> --- a/drivers/pci/rockchip/pcie-rockchip-host.c
> +++ b/drivers/pci/rockchip/pcie-rockchip-host.c
> @@ -294,134 +294,17 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
>   * rockchip_pcie_init_port - Initialize hardware
>   * @rockchip: PCIe port information
>   */
> -static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> +static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
> -	int err, i;
> +	int err, i = MAX_LANE_NUM;
>  	u32 status;
>  
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
>  
> -	err = reset_control_assert(rockchip->aclk_rst);
> -	if (err) {
> -		dev_err(dev, "assert aclk_rst err %d\n", err);
> -		return err;
> -	}
> -
> -	err = reset_control_assert(rockchip->pclk_rst);
> -	if (err) {
> -		dev_err(dev, "assert pclk_rst err %d\n", err);
> -		return err;
> -	}
> -
> -	err = reset_control_assert(rockchip->pm_rst);
> -	if (err) {
> -		dev_err(dev, "assert pm_rst err %d\n", err);
> +	err = rockchip_pcie_init_port(rockchip);
> +	if (err)
>  		return err;
> -	}
> -
> -	for (i = 0; i < MAX_LANE_NUM; i++) {
> -		err = phy_init(rockchip->phys[i]);
> -		if (err) {
> -			dev_err(dev, "init phy%d err %d\n", i, err);
> -			goto err_exit_phy;
> -		}
> -	}
> -
> -	err = reset_control_assert(rockchip->core_rst);
> -	if (err) {
> -		dev_err(dev, "assert core_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_assert(rockchip->mgmt_rst);
> -	if (err) {
> -		dev_err(dev, "assert mgmt_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_assert(rockchip->mgmt_sticky_rst);
> -	if (err) {
> -		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_assert(rockchip->pipe_rst);
> -	if (err) {
> -		dev_err(dev, "assert pipe_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	udelay(10);
> -
> -	err = reset_control_deassert(rockchip->pm_rst);
> -	if (err) {
> -		dev_err(dev, "deassert pm_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->aclk_rst);
> -	if (err) {
> -		dev_err(dev, "deassert aclk_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->pclk_rst);
> -	if (err) {
> -		dev_err(dev, "deassert pclk_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	if (rockchip->link_gen == 2)
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> -				    PCIE_CLIENT_CONFIG);
> -	else
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> -				    PCIE_CLIENT_CONFIG);
> -
> -	rockchip_pcie_write(rockchip,
> -			    PCIE_CLIENT_CONF_ENABLE |
> -			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
> -			    PCIE_CLIENT_ARI_ENABLE |
> -			    PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes) |
> -			    PCIE_CLIENT_MODE_RC,
> -			    PCIE_CLIENT_CONFIG);
> -
> -	for (i = 0; i < MAX_LANE_NUM; i++) {
> -		err = phy_power_on(rockchip->phys[i]);
> -		if (err) {
> -			dev_err(dev, "power on phy%d err %d\n", i, err);
> -			goto err_power_off_phy;
> -		}
> -	}
> -
> -	/*
> -	 * Please don't reorder the deassert sequence of the following
> -	 * four reset pins.
> -	 */
> -	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->core_rst);
> -	if (err) {
> -		dev_err(dev, "deassert core_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->mgmt_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->pipe_rst);
> -	if (err) {
> -		dev_err(dev, "deassert pipe_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
>  
>  	/* Fix the transmitted FTS count desired to exit from L0s. */
>  	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_PLC1);
> @@ -514,8 +397,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  err_power_off_phy:
>  	while (i--)
>  		phy_power_off(rockchip->phys[i]);
> +
>  	i = MAX_LANE_NUM;
> -err_exit_phy:
>  	while (i--)
>  		phy_exit(rockchip->phys[i]);
>  	return err;
> @@ -1034,7 +917,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  	if (err)
>  		goto err_disable_0v9;
>  
> -	err = rockchip_pcie_init_port(rockchip);
> +	err = rockchip_pcie_host_init_port(rockchip);
>  	if (err)
>  		goto err_pcie_resume;
>  
> @@ -1099,7 +982,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		goto err_set_vpcie;
>  	}
>  
> -	err = rockchip_pcie_init_port(rockchip);
> +	err = rockchip_pcie_host_init_port(rockchip);
>  	if (err)
>  		goto err_vpcie;
>  
> diff --git a/drivers/pci/rockchip/pcie-rockchip.c b/drivers/pci/rockchip/pcie-rockchip.c
> index 6c0063d..d03508c 100644
> --- a/drivers/pci/rockchip/pcie-rockchip.c
> +++ b/drivers/pci/rockchip/pcie-rockchip.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
> @@ -144,6 +145,146 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	return 0;
>  }
>  
> +int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->dev;
> +	int err, i;
> +	u32 regs;
> +
> +	err = reset_control_assert(rockchip->aclk_rst);
> +	if (err) {
> +		dev_err(dev, "assert aclk_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(rockchip->pclk_rst);
> +	if (err) {
> +		dev_err(dev, "assert pclk_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(rockchip->pm_rst);
> +	if (err) {
> +		dev_err(dev, "assert pm_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	for (i = 0; i < MAX_LANE_NUM; i++) {
> +		err = phy_init(rockchip->phys[i]);
> +		if (err) {
> +			dev_err(dev, "init phy%d err %d\n", i, err);
> +			goto err_exit_phy;
> +		}
> +	}
> +
> +	err = reset_control_assert(rockchip->core_rst);
> +	if (err) {
> +		dev_err(dev, "assert core_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	err = reset_control_assert(rockchip->mgmt_rst);
> +	if (err) {
> +		dev_err(dev, "assert mgmt_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	err = reset_control_assert(rockchip->mgmt_sticky_rst);
> +	if (err) {
> +		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	err = reset_control_assert(rockchip->pipe_rst);
> +	if (err) {
> +		dev_err(dev, "assert pipe_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	udelay(10);
> +
> +	err = reset_control_deassert(rockchip->pm_rst);
> +	if (err) {
> +		dev_err(dev, "deassert pm_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	err = reset_control_deassert(rockchip->aclk_rst);
> +	if (err) {
> +		dev_err(dev, "deassert aclk_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	err = reset_control_deassert(rockchip->pclk_rst);
> +	if (err) {
> +		dev_err(dev, "deassert pclk_rst err %d\n", err);
> +		goto err_exit_phy;
> +	}
> +
> +	if (rockchip->link_gen == 2)
> +		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> +				    PCIE_CLIENT_CONFIG);
> +	else
> +		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> +				    PCIE_CLIENT_CONFIG);
> +
> +	regs = PCIE_CLIENT_LINK_TRAIN_ENABLE | PCIE_CLIENT_ARI_ENABLE |
> +		   PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
> +
> +	if (rockchip->is_rc)
> +		regs |= PCIE_CLIENT_CONF_ENABLE | PCIE_CLIENT_MODE_RC;
> +	else
> +		regs |= PCIE_CLIENT_CONF_DISABLE | PCIE_CLIENT_MODE_EP;
> +
> +	rockchip_pcie_write(rockchip, regs, PCIE_CLIENT_CONFIG);
> +
> +	for (i = 0; i < MAX_LANE_NUM; i++) {
> +		err = phy_power_on(rockchip->phys[i]);
> +		if (err) {
> +			dev_err(dev, "power on phy%d err %d\n", i, err);
> +			goto err_power_off_phy;
> +		}
> +	}
> +
> +	/*
> +	 * Please don't reorder the deassert sequence of the following
> +	 * four reset pins.
> +	 */
> +	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> +	if (err) {
> +		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> +		goto err_power_off_phy;
> +	}
> +
> +	err = reset_control_deassert(rockchip->core_rst);
> +	if (err) {
> +		dev_err(dev, "deassert core_rst err %d\n", err);
> +		goto err_power_off_phy;
> +	}
> +
> +	err = reset_control_deassert(rockchip->mgmt_rst);
> +	if (err) {
> +		dev_err(dev, "deassert mgmt_rst err %d\n", err);
> +		goto err_power_off_phy;
> +	}
> +
> +	err = reset_control_deassert(rockchip->pipe_rst);
> +	if (err) {
> +		dev_err(dev, "deassert pipe_rst err %d\n", err);
> +		goto err_power_off_phy;
> +	}
> +
> +	return 0;
> +err_power_off_phy:
> +	while (i--)
> +		phy_power_off(rockchip->phys[i]);
> +	i = MAX_LANE_NUM;
> +err_exit_phy:
> +	while (i--)
> +		phy_exit(rockchip->phys[i]);
> +	return err;
> +}
> +
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
> diff --git a/drivers/pci/rockchip/pcie-rockchip.h b/drivers/pci/rockchip/pcie-rockchip.h
> index c0f84d9..af3e74f 100644
> --- a/drivers/pci/rockchip/pcie-rockchip.h
> +++ b/drivers/pci/rockchip/pcie-rockchip.h
> @@ -27,10 +27,12 @@
>  #define PCIE_CLIENT_BASE		0x0
>  #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
>  #define   PCIE_CLIENT_CONF_ENABLE	  HIWORD_UPDATE_BIT(0x0001)
> +#define   PCIE_CLIENT_CONF_DISABLE	  HIWORD_UPDATE(0x0001, 0)
>  #define   PCIE_CLIENT_LINK_TRAIN_ENABLE	  HIWORD_UPDATE_BIT(0x0002)
>  #define   PCIE_CLIENT_ARI_ENABLE	  HIWORD_UPDATE_BIT(0x0008)
>  #define   PCIE_CLIENT_CONF_LANE_NUM(x)	  HIWORD_UPDATE(0x0030, ENCODE_LANES(x))
>  #define   PCIE_CLIENT_MODE_RC		  HIWORD_UPDATE_BIT(0x0040)
> +#define   PCIE_CLIENT_MODE_EP		  HIWORD_UPDATE(0x0040, 0)
>  #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
>  #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
>  #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
> @@ -238,6 +240,7 @@ static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val,
>  }
>  
>  int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip);
> +int rockchip_pcie_init_port(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
> -- 
> 1.9.1
> 
> 
