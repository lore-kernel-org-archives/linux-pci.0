Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:55030 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbcJHCvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 22:51:22 -0400
Subject: Re: [PATCH 1/3] PCI: rockchip: Rename accessors
To: Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20161007162706.23835.10081.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-pci@vger.kernel.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <4417d4f0-312e-11eb-55b6-8265b948ed4c@rock-chips.com>
Date: Sat, 8 Oct 2016 10:51:06 +0800
MIME-Version: 1.0
In-Reply-To: <20161007162706.23835.10081.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/10/8 0:27, Bjorn Helgaas 写道:
> Rename rockchip_pcie_read() to rockchip_readl() and rockchip_pcie_write()
> to rockchip_writel() for consistency with other drivers.  No functional
> change intended.
>

It looks okay to me if this modification make pcie-rockchip looks more
consisten with other drivers.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-rockchip.c |   85 +++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index b8c82fc..0ef2f9f 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -204,12 +204,12 @@ struct rockchip_pcie {
>  	struct	irq_domain *irq_domain;
>  };
>
> -static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
> +static u32 rockchip_readl(struct rockchip_pcie *rockchip, u32 reg)
>  {
>  	return readl(rockchip->apb_base + reg);
>  }
>
> -static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val,
> +static void rockchip_writel(struct rockchip_pcie *rockchip, u32 val,
>  				u32 reg)
>  {
>  	writel(val, rockchip->apb_base + reg);
> @@ -219,18 +219,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>  {
>  	u32 status;
>
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
>  	status |= (PCIE_RC_CONFIG_LCS_LBMIE | PCIE_RC_CONFIG_LCS_LABIE);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_LCS);
>  }
>
>  static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
>  {
>  	u32 status;
>
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
>  	status |= (PCIE_RC_CONFIG_LCS_LBMS | PCIE_RC_CONFIG_LCS_LAMS);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_LCS);
>  }
>
>  static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
> @@ -238,10 +238,10 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>  	u32 val;
>
>  	/* Update Tx credit maximum update interval */
> -	val = rockchip_pcie_read(rockchip, PCIE_CORE_TXCREDIT_CFG1);
> +	val = rockchip_readl(rockchip, PCIE_CORE_TXCREDIT_CFG1);
>  	val &= ~PCIE_CORE_TXCREDIT_CFG1_MUI_MASK;
>  	val |= PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(24000);	/* ns */
> -	rockchip_pcie_write(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
> +	rockchip_writel(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
>  }
>
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
> @@ -438,7 +438,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>
> -	rockchip_pcie_write(rockchip,
> +	rockchip_writel(rockchip,
>  			    PCIE_CLIENT_CONF_ENABLE |
>  			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
>  			    PCIE_CLIENT_ARI_ENABLE |
> @@ -487,17 +487,17 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	 * reliable and enabling ASPM doesn't work.  This is a controller
>  	 * bug we need to work around.
>  	 */
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
> +	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
> +	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
>
>  	/* Fix the transmitted FTS count desired to exit from L0s. */
> -	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_PLC1);
> +	status = rockchip_readl(rockchip, PCIE_CORE_CTRL_PLC1);
>  	status = (status & PCIE_CORE_CTRL_PLC1_FTS_MASK) |
>  		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
> -	rockchip_pcie_write(rockchip, status, PCIE_CORE_CTRL_PLC1);
> +	rockchip_writel(rockchip, status, PCIE_CORE_CTRL_PLC1);
>
>  	/* Enable Gen1 training */
> -	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> +	rockchip_writel(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>
>  	gpiod_set_value(rockchip->ep_gpio, 1);
> @@ -506,8 +506,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	timeout = jiffies + msecs_to_jiffies(500);
>
>  	for (;;) {
> -		status = rockchip_pcie_read(rockchip,
> -					    PCIE_CLIENT_BASIC_STATUS1);
> +		status = rockchip_readl(rockchip, PCIE_CLIENT_BASIC_STATUS1);
>  		if ((status & PCIE_CLIENT_LINK_STATUS_MASK) ==
>  		    PCIE_CLIENT_LINK_STATUS_UP) {
>  			dev_dbg(dev, "PCIe link training gen1 pass!\n");
> @@ -526,13 +525,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	 * Enable retrain for gen2. This should be configured only after
>  	 * gen1 finished.
>  	 */
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_readl(rockchip, PCIE_RC_CONFIG_LCS);
>  	status |= PCIE_RC_CONFIG_LCS_RETRAIN_LINK;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_writel(rockchip, status, PCIE_RC_CONFIG_LCS);
>
>  	timeout = jiffies + msecs_to_jiffies(500);
>  	for (;;) {
> -		status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> +		status = rockchip_readl(rockchip, PCIE_CORE_CTRL);
>  		if ((status & PCIE_CORE_PL_CONF_SPEED_MASK) ==
>  		    PCIE_CORE_PL_CONF_SPEED_5G) {
>  			dev_dbg(dev, "PCIe link training gen2 pass!\n");
> @@ -548,25 +547,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	}
>
>  	/* Check the final link width from negotiated lane counter from MGMT */
> -	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> +	status = rockchip_readl(rockchip, PCIE_CORE_CTRL);
>  	status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
>  			  PCIE_CORE_PL_CONF_LANE_MASK);
>  	dev_dbg(dev, "current link width is x%d\n", status);
>
> -	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
> +	rockchip_writel(rockchip, ROCKCHIP_VENDOR_ID,
>  			    PCIE_RC_CONFIG_VENDOR);
> -	rockchip_pcie_write(rockchip,
> +	rockchip_writel(rockchip,
>  			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
>  			    PCIE_RC_CONFIG_RID_CCR);
> -	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
> +	rockchip_writel(rockchip, 0x0, PCIE_RC_BAR_CONF);
>
> -	rockchip_pcie_write(rockchip,
> +	rockchip_writel(rockchip,
>  			    (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
>  			    PCIE_CORE_OB_REGION_ADDR0);
> -	rockchip_pcie_write(rockchip, RC_REGION_0_ADDR_TRANS_H,
> +	rockchip_writel(rockchip, RC_REGION_0_ADDR_TRANS_H,
>  			    PCIE_CORE_OB_REGION_ADDR1);
> -	rockchip_pcie_write(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
> -	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
> +	rockchip_writel(rockchip, 0x0080000a, PCIE_CORE_OB_REGION_DESC0);
> +	rockchip_writel(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
>
>  	return 0;
>  }
> @@ -578,10 +577,10 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>  	u32 reg;
>  	u32 sub_reg;
>
> -	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
> +	reg = rockchip_readl(rockchip, PCIE_CLIENT_INT_STATUS);
>  	if (reg & PCIE_CLIENT_INT_LOCAL) {
>  		dev_dbg(dev, "local interrupt received\n");
> -		sub_reg = rockchip_pcie_read(rockchip, PCIE_CORE_INT_STATUS);
> +		sub_reg = rockchip_readl(rockchip, PCIE_CORE_INT_STATUS);
>  		if (sub_reg & PCIE_CORE_INT_PRFPE)
>  			dev_dbg(dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
>
> @@ -624,15 +623,15 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>  		if (sub_reg & PCIE_CORE_INT_MMVC)
>  			dev_dbg(dev, "MSI mask register changes\n");
>
> -		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
> +		rockchip_writel(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
>  	} else if (reg & PCIE_CLIENT_INT_PHY) {
>  		dev_dbg(dev, "phy link changes\n");
>  		rockchip_pcie_update_txcredit_mui(rockchip);
>  		rockchip_pcie_clr_bw_int(rockchip);
>  	}
>
> -	rockchip_pcie_write(rockchip, reg & PCIE_CLIENT_INT_LOCAL,
> -			    PCIE_CLIENT_INT_STATUS);
> +	rockchip_writel(rockchip, reg & PCIE_CLIENT_INT_LOCAL,
> +			PCIE_CLIENT_INT_STATUS);
>
>  	return IRQ_HANDLED;
>  }
> @@ -643,7 +642,7 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
>  	struct device *dev = rockchip->dev;
>  	u32 reg;
>
> -	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
> +	reg = rockchip_readl(rockchip, PCIE_CLIENT_INT_STATUS);
>  	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
>  		dev_dbg(dev, "legacy done interrupt received\n");
>
> @@ -668,7 +667,7 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
>  	if (reg & PCIE_CLIENT_INT_PHY)
>  		dev_dbg(dev, "phy interrupt received\n");
>
> -	rockchip_pcie_write(rockchip, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
> +	rockchip_writel(rockchip, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
>  			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
>  			      PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
>  			      PCIE_CLIENT_INT_NFATAL_ERR |
> @@ -690,7 +689,7 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
>
>  	chained_irq_enter(chip, desc);
>
> -	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
> +	reg = rockchip_readl(rockchip, PCIE_CLIENT_INT_STATUS);
>  	reg = (reg & PCIE_CLIENT_INTR_MASK) >> PCIE_CLIENT_INTR_SHIFT;
>
>  	while (reg) {
> @@ -914,9 +913,9 @@ err_out:
>
>  static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
>  {
> -	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
> +	rockchip_writel(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
>  			    (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
> -	rockchip_pcie_write(rockchip, (u32)(~PCIE_CORE_INT),
> +	rockchip_writel(rockchip, (u32)(~PCIE_CORE_INT),
>  			    PCIE_CORE_INT_MASK);
>
>  	rockchip_pcie_enable_bw_int(rockchip);
> @@ -986,13 +985,13 @@ static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
>  	ob_addr_1 = upper_addr;
>  	ob_desc_0 = (1 << 23 | type);
>
> -	rockchip_pcie_write(rockchip, ob_addr_0,
> +	rockchip_writel(rockchip, ob_addr_0,
>  			    PCIE_CORE_OB_REGION_ADDR0 + aw_offset);
> -	rockchip_pcie_write(rockchip, ob_addr_1,
> +	rockchip_writel(rockchip, ob_addr_1,
>  			    PCIE_CORE_OB_REGION_ADDR1 + aw_offset);
> -	rockchip_pcie_write(rockchip, ob_desc_0,
> +	rockchip_writel(rockchip, ob_desc_0,
>  			    PCIE_CORE_OB_REGION_DESC0 + aw_offset);
> -	rockchip_pcie_write(rockchip, 0,
> +	rockchip_writel(rockchip, 0,
>  			    PCIE_CORE_OB_REGION_DESC1 + aw_offset);
>
>  	return 0;
> @@ -1019,8 +1018,8 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
>  	ib_addr_0 |= (lower_addr << 8) & PCIE_CORE_IB_REGION_ADDR0_LO_ADDR;
>  	ib_addr_1 = upper_addr;
>
> -	rockchip_pcie_write(rockchip, ib_addr_0, PCIE_RP_IB_ADDR0 + aw_offset);
> -	rockchip_pcie_write(rockchip, ib_addr_1, PCIE_RP_IB_ADDR1 + aw_offset);
> +	rockchip_writel(rockchip, ib_addr_0, PCIE_RP_IB_ADDR0 + aw_offset);
> +	rockchip_writel(rockchip, ib_addr_1, PCIE_RP_IB_ADDR1 + aw_offset);
>
>  	return 0;
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

