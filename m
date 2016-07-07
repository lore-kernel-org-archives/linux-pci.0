Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34870 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbcGGANA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 20:13:00 -0400
Received: by mail-pf0-f171.google.com with SMTP id c2so717161pfa.2
        for <linux-pci@vger.kernel.org>; Wed, 06 Jul 2016 17:12:59 -0700 (PDT)
Date: Wed, 6 Jul 2016 17:12:55 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160707001254.GA100467@google.com>
References: <1467789398-13501-1-git-send-email-shawn.lin@rock-chips.com>
 <1467789398-13501-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467789398-13501-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Wed, Jul 06, 2016 at 03:16:38PM +0800, Shawn Lin wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v6:
> - use "depends on PCI_MSI_IRQ_DOMAIN" suggested by Arnd
> 
> Changes in v5:
> - handle multiple pending INTx at the same time
>   suggested by Marc
> 
> Changes in v4:
> - address the comments from Brain
> 
> Changes in v3:
> - remove header file
> - remove struct msi_controller and move most of variables
>   of rockchip_pcie_port to become the local ones.
> - allow legacy int even if enabling MSI
> - drop regulator set voltage operation suggested by Doug
> 
> Changes in v2:
> - remove phy related stuff and call phy API
> - add new head file and define lots of macro to make
>   the code more readable
> - remove lots msi related code suggested by Marc
> - add IO window address translation
> - init_port and parse_dt reconstruction suggested by Bharat
> - improve wr_own_conf suggested by Arnd
> - make pcie as an interrupt controller and fix wrong int handler
>   suggested by Marc
> - remove PCI_PROBE_ONLY suggested by Lorenzo
> 
>  drivers/pci/host/Kconfig         |   11 +
>  drivers/pci/host/Makefile        |    1 +
>  drivers/pci/host/pcie-rockchip.c | 1213 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1225 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-rockchip.c
> 

[...]

> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> new file mode 100644
> index 0000000..7996556
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -0,0 +1,1213 @@

[...]

> +/**
> + * rockchip_pcie_init_port - Initialize hardware
> + * @port: PCIe port information
> + */
> +static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
> +{
> +	int err;
> +	u32 status;
> +	unsigned long timeout;
> +
> +	gpiod_set_value(port->ep_gpio, 0);
> +
> +	err = phy_init(port->phy);
> +	if (err < 0) {
> +		dev_err(port->dev, "fail to init phy, err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->core_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert core_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->mgmt_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert mgmt_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->mgmt_sticky_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert mgmt_sticky_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->pipe_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert pipe_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	pcie_write(port,
> +		   HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
> +				 PCIE_CLIENT_CONF_ENABLE_MASK,
> +				 PCIE_CLIENT_CONF_ENABLE_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(port->lanes),
> +				 PCIE_CLIENT_CONF_LANE_NUM_MASK,
> +				 PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
> +				 PCIE_CLIENT_MODE_MASK,
> +				 PCIE_CLIENT_MODE_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_ARI_ENABLE,
> +				 PCIE_CLIENT_ARI_ENABLE_MASK,
> +				 PCIE_CLIENT_ARI_ENABLE_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_GEN_SEL_2,
> +				 PCIE_CLIENT_GEN_SEL_MASK,
> +				 PCIE_CLIENT_GEN_SEL_SHIFT),
> +		   PCIE_CLIENT_BASE);
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_err(port->dev, "fail to power on phy, err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->core_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert core_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->mgmt_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert mgmt_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->mgmt_sticky_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert mgmt_sticky_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->pipe_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert pipe_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	/* Enable Gen1 training */
> +	pcie_write(port,
> +		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
> +				 PCIE_CLIENT_LINK_TRAIN_MASK,
> +				 PCIE_CLIENT_LINK_TRAIN_SHIFT),
> +		   PCIE_CLIENT_BASE);
> +
> +	gpiod_set_value(port->ep_gpio, 1);
> +
> +	/* 500ms timeout value should be enough for gen1/2 taining */
> +	timeout = jiffies + msecs_to_jiffies(500);
> +
> +	for (;;) {
> +		status = pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
> +		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
> +		      PCIE_CLIENT_LINK_STATUS_MASK) ==
> +		      PCIE_CLIENT_LINK_STATUS_UP) {
> +			dev_dbg(port->dev, "pcie link training gen1 pass!\n");
> +			break;
> +		}
> +
> +		msleep(20);
> +
> +		if (!time_before(jiffies, timeout))
> +			break;
> +
> +	}
> +	status = pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
> +	err = (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
> +		 PCIE_CLIENT_LINK_STATUS_MASK) ==
> +		 PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
> +	if (err) {
> +		dev_err(port->dev, "pcie link training gen1 timeout!\n");
> +		return err;
> +	}

You're doing an extra PCIe read, even in the "success" case (you only
really need to double-check the timeout case, to be sure you're not
declaring timeout prematurely). That's probably fine, but you could
maybe avoid this more easily if you factored your timeout loop into a
separate function, and just 'return 0' from the loop on success, and
only 'break' to double-check for timeouts.

> +
> +	/*
> +	 * Enable retrain for gen2. This should be configured only after
> +	 * gen1 finished.
> +	 */
> +	status = pcie_read(port,
> +			   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
> +	status |= PCIE_CORE_LCSR_RETRAIN_LINK;
> +	pcie_write(port, status,
> +		   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
> +
> +	timeout = jiffies + msecs_to_jiffies(500);
> +	for (;;) {
> +		status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> +		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
> +		      PCIE_CORE_PL_CONF_SPEED_MASK) ==
> +		      PCIE_CORE_PL_CONF_SPEED_5G) {
> +			dev_dbg(port->dev, "pcie link training gen2 pass!\n");
> +			break;
> +		}
> +
> +		msleep(20);
> +
> +		if (!time_before(jiffies, timeout))
> +			break;
> +	}
> +	status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> +	err = (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
> +		PCIE_CORE_PL_CONF_SPEED_MASK) ==
> +		PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
> +	if (err)
> +		dev_dbg(port->dev, "pcie link training gen2 timeout, fall back to gen1!\n");

Same here.

> +
> +	/* Check the final link with from negotiated lane counter from MGMT */
> +	status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> +	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
> +			   PCIE_CORE_PL_CONF_LANE_MASK);
> +	dev_dbg(port->dev, "current link width is x%d\n", status);
> +
> +	pcie_write(port, ROCKCHIP_VENDOR_ID, PCIE_RC_CONFIG_BASE);
> +	pcie_write(port, PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
> +		   PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_RID_CCR);
> +	pcie_write(port, 0x0, PCIE_CORE_CTRL_MGMT_BASE + PCIE_RC_BAR_CONF);
> +
> +	pcie_write(port, (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
> +		   PCIE_CORE_AXI_CONF_BASE);
> +	pcie_write(port, RC_REGION_0_ADDR_TRANS_H,
> +		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_ADDR1);
> +	pcie_write(port, 0x0080000a,
> +		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC0);
> +	pcie_write(port, 0x0,
> +		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC1);
> +
> +	return 0;
> +}
> +
> +/**
> + * rockchip_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *node = dev->of_node;
> +	struct resource *regs;
> +	int irq;
> +	int err = -ENODEV;
> +
> +	regs = platform_get_resource_byname(pdev,
> +					    IORESOURCE_MEM,
> +					    "axi-base");
> +	if (!regs) {
> +		dev_err(dev, "missing axi-base property\n");
> +		return err;
> +	}
> +
> +	port->reg_base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(port->reg_base))
> +		return PTR_ERR(port->reg_base);
> +
> +	regs = platform_get_resource_byname(pdev,
> +					    IORESOURCE_MEM,
> +					    "apb-base");
> +	if (!regs) {
> +		dev_err(dev, "missing apb-base property\n");
> +		return err;
> +	}
> +
> +	port->apb_base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(port->apb_base))
> +		return PTR_ERR(port->apb_base);
> +
> +	port->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(port->phy)) {
> +		if (PTR_ERR(port->phy) != -EPROBE_DEFER)
> +			dev_err(dev, "Missing phy\n");
> +		return PTR_ERR(port->phy);
> +	}
> +
> +	port->lanes = 1;
> +	err = of_property_read_u32(node, "num-lanes", &port->lanes);
> +	if (!err && ((port->lanes == 0) ||
> +		     (port->lanes == 3) ||
> +		     (port->lanes > 4))) {
> +		dev_warn(dev, "invalid num-lanes, default use one lane\n");
> +		port->lanes = 1;
> +	}
> +
> +	port->core_rst = devm_reset_control_get(dev, "core");
> +	if (IS_ERR(port->core_rst)) {
> +		if (PTR_ERR(port->core_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing core rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->core_rst);
> +	}
> +
> +	port->mgmt_rst = devm_reset_control_get(dev, "mgmt");
> +	if (IS_ERR(port->mgmt_rst)) {
> +		if (PTR_ERR(port->mgmt_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing mgmt rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->mgmt_rst);
> +	}
> +
> +	port->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
> +	if (IS_ERR(port->mgmt_sticky_rst)) {
> +		if (PTR_ERR(port->mgmt_sticky_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing mgmt-sticky rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->mgmt_sticky_rst);
> +	}
> +
> +	port->pipe_rst = devm_reset_control_get(dev, "pipe");
> +	if (IS_ERR(port->pipe_rst)) {
> +		if (PTR_ERR(port->pipe_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pipe rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->pipe_rst);
> +	}
> +
> +	port->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +	if (IS_ERR(port->ep_gpio)) {
> +		dev_err(dev, "missing ep-gpios property in node %s\n",
> +			node->name);
> +		return PTR_ERR(port->ep_gpio);
> +	}
> +
> +	port->aclk_pcie = devm_clk_get(dev, "aclk");
> +	if (IS_ERR(port->aclk_pcie)) {
> +		dev_err(dev, "aclk clock not found.\n");
> +		return PTR_ERR(port->aclk_pcie);
> +	}
> +
> +	port->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> +	if (IS_ERR(port->aclk_perf_pcie)) {
> +		dev_err(dev, "aclk_perf clock not found.\n");
> +		return PTR_ERR(port->aclk_perf_pcie);
> +	}
> +
> +	port->hclk_pcie = devm_clk_get(dev, "hclk");
> +	if (IS_ERR(port->hclk_pcie)) {
> +		dev_err(dev, "hclk clock not found.\n");
> +		return PTR_ERR(port->hclk_pcie);
> +	}
> +
> +	port->clk_pcie_pm = devm_clk_get(dev, "pm");
> +	if (IS_ERR(port->clk_pcie_pm)) {
> +		dev_err(dev, "pm clock not found.\n");
> +		return PTR_ERR(port->clk_pcie_pm);
> +	}
> +
> +	irq = platform_get_irq_byname(pdev, "sys");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie_sys IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
> +			       IRQF_SHARED, "pcie-sys", port);
> +	if (err) {
> +		dev_err(dev, "failed to request pcie subsystem irq\n");
> +		return err;
> +	}
> +
> +	irq = platform_get_irq_byname(pdev, "legacy");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie_legacy IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	irq_set_chained_handler_and_data(irq,
> +					 rockchip_pcie_legacy_int_handler,
> +					 port);
> +
> +	irq = platform_get_irq_byname(pdev, "client");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie-client IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
> +			       IRQF_SHARED, "pcie-client", port);
> +	if (err) {
> +		dev_err(dev, "failed to request pcie client irq\n");
> +		return err;
> +	}
> +
> +	port->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(port->vpcie3v3)) {
> +		if (PTR_ERR(port->vpcie3v3) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "No vpcie3v3 regulator found.\n");
> +	}
> +
> +	port->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
> +	if (IS_ERR(port->vpcie1v8)) {
> +		if (PTR_ERR(port->vpcie1v8) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "No vpcie1v8 regulator found.\n");
> +	}
> +
> +	port->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
> +	if (IS_ERR(port->vpcie0v9)) {
> +		if (PTR_ERR(port->vpcie0v9) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "No vpcie0v9 regulator found.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *port)
> +{
> +	int err;
> +
> +	if (!IS_ERR(port->vpcie3v3)) {
> +		err = regulator_enable(port->vpcie3v3);
> +		if (err) {
> +			dev_err(port->dev, "Fail to enable vpcie3v3 regulator.\n");
> +			goto err_out;
> +		}
> +	}
> +
> +	if (!IS_ERR(port->vpcie1v8)) {
> +		err = regulator_enable(port->vpcie1v8);
> +		if (err) {
> +			dev_err(port->dev, "Fail to enable vpcie1v8 regulator.\n");
> +			goto err_disable_3v3;
> +		}
> +	}
> +
> +	if (!IS_ERR(port->vpcie0v9)) {
> +		err = regulator_enable(port->vpcie0v9);
> +		if (err) {
> +			dev_err(port->dev, "Fail to enable vpcie0v9 regulator.\n");
> +			goto err_disable_1v8;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_disable_1v8:
> +	if (!IS_ERR(port->vpcie1v8))
> +		regulator_disable(port->vpcie1v8);
> +err_disable_3v3:
> +	if (!IS_ERR(port->vpcie3v3))
> +		regulator_disable(port->vpcie3v3);
> +err_out:
> +	return err;
> +}
> +
> +static void rockchip_pcie_enable_interrupts(struct rockchip_pcie_port *port)
> +{
> +	pcie_write(port, (PCIE_CLIENT_INT_CLI << 16) &
> +		   (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
> +	pcie_write(port, PCIE_CORE_INT, PCIE_CORE_INT_MASK);
> +}
> +
> +static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = rockchip_pcie_intx_map,
> +};
> +
> +static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
> +{
> +	struct device *dev = pp->dev;
> +
> +	pp->irq_domain = irq_domain_add_linear(dev->of_node, 4,
> +					       &intx_domain_ops, pp);
> +	if (!pp->irq_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return PTR_ERR(pp->irq_domain);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +	u32 sub_reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	if (reg & PCIE_CLIENT_INT_LOCAL) {
> +		dev_dbg(pp->dev, "local interrupt recived\n");
> +		sub_reg = pcie_read(pp, PCIE_CORE_INT_STATUS);
> +		if (sub_reg & PCIE_CORE_INT_PRFPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from the PNP Receive FIFO RAM\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_CRFPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from the Completion Receive FIFO RAM\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_RRPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from Replay Buffer RAM\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_PRFO)
> +			dev_dbg(pp->dev, "Overflow occurred in the PNP Receive FIFO\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_CRFO)
> +			dev_dbg(pp->dev, "Overflow occurred in the Completion Receive FIFO\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_RT)
> +			dev_dbg(pp->dev, "Replay timer timed out\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_RTR)
> +			dev_dbg(pp->dev, "Replay timer rolled over after 4 transmissions of the same TLP\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_PE)
> +			dev_dbg(pp->dev, "Phy error detected on receive side\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_MTR)
> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_UCR)
> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_FCE)
> +			dev_dbg(pp->dev, "An error was observed in the flow control advertisements from the other side\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_CT)
> +			dev_dbg(pp->dev, "A request timed out waiting for completion\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_UTC)
> +			dev_dbg(pp->dev, "Unmapped TC error\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_MMVC)
> +			dev_dbg(pp->dev, "MSI mask register changes\n");
> +
> +		pcie_write(pp, sub_reg, PCIE_CORE_INT_STATUS);
> +	}
> +
> +	pcie_write(pp, PCIE_CLIENT_INT_SUBSYSTEM | PCIE_CLIENT_INT_LOCAL,
> +		   PCIE_CLIENT_INT_STATUS);

Is this IRQ handler just for debugging? Seems kinda excessive. Similar
comment below.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
> +		dev_dbg(pp->dev, "legacy done interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_MSG)
> +		dev_dbg(pp->dev, "message done interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_HOT_RST)
> +		dev_dbg(pp->dev, "hot reset interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_DPA)
> +		dev_dbg(pp->dev, "dpa interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_FATAL_ERR)
> +		dev_dbg(pp->dev, "fatal error interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
> +		dev_dbg(pp->dev, "no fatal error interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_CORR_ERR)
> +		dev_dbg(pp->dev, "correctable error interrupt recived\n");

I thought somebody may have asked about this previously, but are you
really just installing this interrupt handler just to dump debug
messages? Seems like it'b be better just to avoid requesting this IRQ
completely, IMO. But maybe that's debatable.

> +
> +	pcie_write(pp, reg, PCIE_CLIENT_INT_STATUS);

Is it safe to just overwrite the entire status register? I see it is
made up of both Read Only and Write-1-to-Clear bits, and not all of
those bits are owned by this IRQ handler; some of them are for
rockchip_pcie_subsys_irq_handler(). So shouldn't you only write the bits
you know you handle? Like:

	pcie_write(pp, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
			PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
			PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
			PCIE_CLIENT_INT_NFATAL_ERR | PCIE_CLIENT_INT_CORR_ERR),
			PCIE_CLIENT_INT_STATUS);

Or, if you just kill this entire IRQ handler, you can avoid this
potential source of errors.

(FWIW, it's possible this handler is causing me some problems with
legacy interrupts. Once I remove the "request_irq()" for this and the
other handler, I can get things kinda working again.)

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct rockchip_pcie_port *port;
> +	u32 reg;
> +	u32 hwirq;
> +	u32 virq;
> +
> +	chained_irq_enter(chip, desc);
> +	port = irq_desc_get_handler_data(desc);
> +
> +	reg = pcie_read(port, PCIE_CLIENT_INT_STATUS);
> +	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
> +	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
> +
> +	while (reg) {
> +		hwirq = ffs(reg);
> +		reg &= ~BIT(hwirq);

Per Marc's suggestion, you have created an infinite loop :)

This should be:

	hwirq = ffs(reg);
	reg &= ~BIT(hwirq - 1);

...which brings me to this question: are you ever testing non-MSI (i.e.,
"legacy") interrupts on this driver? There seems to be quite a bit of
discussion about the structuring of the interrupt-map and
interrupt-controller handling, but it appears this mostly/only gets
actually *used* for the legacy interrupt case, and on my tests, legacy
interrupts aren't really working, at least not with the new binding
examples that you proposed. But then, you didn't send a rk3399.dtsi
update, so perhaps I constructed my DTS wrong...

If you haven't been testing legacy interrupts, I'd recommend booting
with "pci=nomsi" and see what happens.

> +
> +		virq = irq_find_mapping(port->irq_domain, hwirq);
> +		if (virq)
> +			generic_handle_irq(virq);
> +		else
> +			dev_err(port->dev, "unexpected IRQ, INT%d\n", hwirq);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +

[...]

Brian
