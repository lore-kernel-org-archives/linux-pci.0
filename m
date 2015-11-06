Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:14889 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757624AbbKFUup (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2015 15:50:45 -0500
Date: Fri, 6 Nov 2015 12:50:33 -0800
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
CC: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, <linux-arm-msm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 4/5] PCI: qcom: Add Qualcomm PCIe controller driver
Message-ID: <20151106205033.GH24668@usrtlx11787.corpusers.net>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
 <1430743338-10441-5-git-send-email-svarbanov@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1430743338-10441-5-git-send-email-svarbanov@mm-sol.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon 04 May 05:42 PDT 2015, Stanimir Varbanov wrote:

> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 

I want to get the ethernet on the ifc6410 running and this seems like
the last patchset for the PCIe.

> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
[..]
> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
> new file mode 100644
> index 0000000..4f083c6
> --- /dev/null
> +++ b/drivers/pci/host/pcie-qcom.c
> @@ -0,0 +1,677 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.

Bump the year, it's the future now :)

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
[..]
> +
> +struct qcom_pcie {
> +	struct pcie_port pp;
> +	struct device *dev;

You already have this device pointer in pp->dev.

> +	union pcie_resources res;
> +	void __iomem *parf;
> +	void __iomem *dbi;
> +	void __iomem *elbi;
> +	struct phy *phy;
> +	struct gpio_desc *reset;
> +	unsigned int version;
> +};
> +
> +#define to_qcom_pcie(x)		container_of(x, struct qcom_pcie, pp)
> +
> +static inline void
> +writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)
> +{
> +	u32 val = readl(addr);
> +
> +	val &= ~clear_mask;
> +	val |= set_mask;
> +	writel(val, addr);
> +}

There are no case where you do clear and set, so I would like that you
just inline this function where you need it. It adds 2 extra lines at a
few places, but a lot of clarity.

> +
> +static void qcom_ep_reset_assert_deassert(struct qcom_pcie *pcie, int assert)
> +{
> +	int val, active_low;
> +
> +	if (IS_ERR_OR_NULL(pcie->reset))
> +		return;

This will be NULL or valid here, never ERR. So it's fine to call
gpiod_set_value() with this pointer without the check.

> +
> +	active_low = gpiod_is_active_low(pcie->reset);
> +

gpiod_set_value() checks for FLAG_ACTIVE_LOW and will invert the value
first thing. So you do not need to do this manually.

> +	if (assert)
> +		val = !!active_low;
> +	else
> +		val = !active_low;
> +
> +	gpiod_set_value(pcie->reset, val);
> +
> +	usleep_range(PERST_DELAY_MIN_US, PERST_DELAY_MAX_US);

This doesn't seem to be called in a hot path, so you should be able to
simply msleep(1) here.

> +}
> +
> +static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> +{
> +	qcom_ep_reset_assert_deassert(pcie, 1);

If we're down to this function just being a gpiod_set_value() and a
sleep we can inline it here instead of having this proxy function.

> +}
> +
> +static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> +{
> +	qcom_ep_reset_assert_deassert(pcie, 0);

Same here.

> +}
> +
> +static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static int qcom_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> +	u32 val = readl(pcie->dbi + PCIE20_CAP_LINKCTRLSTATUS);
> +
> +	return val & BIT(29) ? 1 : 0;

return !!(val & BIT(29));

Do we know what this bit 29 is?

> +}
> +
[..]
> +
> +static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> +	struct device *dev = pcie->dev;
> +
> +	res->vdda = devm_regulator_get(dev, "vdda");
> +	if (IS_ERR(res->vdda))
> +		return PTR_ERR(res->vdda);
> +
> +	res->iface = devm_clk_get(dev, "iface");
> +	if (IS_ERR(res->iface))
> +		return PTR_ERR(res->iface);
> +
> +	res->aux = devm_clk_get(dev, "aux");
> +	if (IS_ERR(res->aux) && PTR_ERR(res->aux) == -EPROBE_DEFER)

PTR_ERR() == x implies IS_ERR(), so you don't need both.

> +		return -EPROBE_DEFER;
> +	else if (IS_ERR(res->aux))
> +		res->aux = NULL;
> +
> +	res->master_bus = devm_clk_get(dev, "master_bus");
> +	if (IS_ERR(res->master_bus))
> +		return PTR_ERR(res->master_bus);
> +
> +	res->slave_bus = devm_clk_get(dev, "slave_bus");
> +	if (IS_ERR(res->slave_bus))
> +		return PTR_ERR(res->slave_bus);
> +
> +	res->core = devm_reset_control_get(dev, "core");
> +	if (IS_ERR(res->core))
> +		return PTR_ERR(res->core);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_enable_link_training(struct pcie_port *pp)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> +	struct device *dev = pp->dev;
> +	int retries;
> +	u32 val;
> +
> +	/* enable link training */
> +	writel_masked(pcie->elbi + PCIE20_ELBI_SYS_CTRL, 0, BIT(0));
> +
> +	/* wait for up to 100ms for the link to come up */
> +	retries = LINKUP_RETRIES_COUNT;
> +	do {
> +		val = readl(pcie->elbi + PCIE20_ELBI_SYS_STTS);
> +		if (val & XMLH_LINK_UP)
> +			break;
> +		usleep_range(LINKUP_DELAY_MIN_US, LINKUP_DELAY_MAX_US);
> +	} while (retries--);
> +
> +	if (retries < 0 || !dw_pcie_link_up(pp)) {
> +		dev_err(dev, "link initialization failed\n");
> +		return -ENXIO;
> +	}

Rather than implementing this based on a number of retries, I think it
would be cleaner to set a goal for jiffies + HZ / 10, then in the loop
you check your conditions, then check for time_after(jiffies, timeout)
and finally msleep() for a while.

> +
> +	return 0;
> +}
> +
[..]
> +static void qcom_pcie_host_init_v0(struct pcie_port *pp)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> +	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> +	struct device *dev = pcie->dev;
> +	int ret;
> +
> +	qcom_ep_reset_assert(pcie);
> +
> +	ret = qcom_pcie_enable_resources_v0(pcie);
> +	if (ret)
> +		return;
> +
> +	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);

Do we have a name for this bit?

> +
> +	/* enable external reference clock */
> +	writel_masked(pcie->parf + PCIE20_PARF_PHY_REFCLK, 0, BIT(16));

Do we have a name for this bit?

> +
> +	ret = reset_control_deassert(res->phy_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert phy reset\n");
> +		return;
> +	}
> +
> +	ret = reset_control_deassert(res->pci_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		return;
> +	}
> +
> +	ret = reset_control_deassert(res->por_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert por reset\n");
> +		return;
> +	}
> +
> +	ret = reset_control_deassert(res->axi_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert axi reset\n");
> +		return;
> +	}
> +
> +	/* wait 150ms for clock acquisition */
> +	usleep_range(10000, 15000);

Either the comment or the sleep is wrong. Also, I think you should just
use msleep() here, the precision doesn't look important.

> +
> +	dw_pcie_setup_rc(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
> +	qcom_ep_reset_deassert(pcie);
> +
> +	ret = qcom_pcie_enable_link_training(pp);
> +	if (ret)
> +		goto err;
> +
> +	return;
> +err:
> +	qcom_ep_reset_assert(pcie);
> +	qcom_pcie_disable_resources_v0(pcie);
> +}
> +
[..]
> +static int
> +qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size, u32 *val)
> +{
> +	/* the device class is not reported correctly from the register */
> +	if (where == PCI_CLASS_REVISION && size == 4) {
> +		*val = readl(pp->dbi_base + PCI_CLASS_REVISION);
> +		*val &= ~(0xffff << 16);

Isn't this the same as *val &= 0xffff; ?

> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;

Feels like it would be cleaner to just to:

u32 rev;

rev = readl(pp->dbi_base + PCI_CLASS_REVISION);
*val = PCI_CLASS_BRIDGE_PCI << 16 | rev & 0xffff;

> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
> +				size, val);

This api has been simplified, the new version should be:

  dw_pcie_cfg_read(pp->dbi_base + where, size, val);

> +}
> +
[..]
> +static const struct of_device_id qcom_pcie_match[] = {
> +	{ .compatible = "qcom,pcie-v0", .data = (void *)PCIE_V0 },
> +	{ .compatible = "qcom,pcie-v1", .data = (void *)PCIE_V1 },
> +	{ }
> +};

MODULE_DEVICE_TABLE() and move this below remove()

> +
> +static int qcom_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	struct resource *res;
> +	struct qcom_pcie *pcie;
> +	struct pcie_port *pp;
> +	int ret;
> +
> +	match = of_match_node(qcom_pcie_match, dev->of_node);
> +	if (!match)
> +		return -ENXIO;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->version = (unsigned int)match->data;

Use of_device_get_match_data() here instead.

> +
> +	pcie->reset = devm_gpiod_get_optional(dev, "perst");
> +	if (IS_ERR(pcie->reset) && PTR_ERR(pcie->reset) == -EPROBE_DEFER)
> +		return PTR_ERR(pcie->reset);

devm_gpiod_get_optional() will either return an IS_ERR() or NULL in the
case of it not being found. So I think you should always return
PTR_ERR() if IS_ERR() is set.


Also, the devm_gpiod_get_optional() api has gotten a third parameter,
set it to GPIOD_OUT_LOW.

> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
> +	pcie->parf = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->parf))
> +		return PTR_ERR(pcie->parf);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pcie->dbi = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->dbi))
> +		return PTR_ERR(pcie->dbi);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +	pcie->elbi = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->elbi))
> +		return PTR_ERR(pcie->elbi);
> +
> +	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> +	if (IS_ERR(pcie->phy))
> +		return PTR_ERR(pcie->phy);
> +
> +	pcie->dev = dev;

nit, move this lonely assignment up to the version assignment to make it
happier. Or you could just use pcie->pp->dev throughout the driver...

> +
> +	if (pcie->version == PCIE_V0)
> +		ret = qcom_pcie_get_resources_v0(pcie);
> +	else
> +		ret = qcom_pcie_get_resources_v1(pcie);
> +
> +	if (ret)
> +		return ret;
> +
> +	pp = &pcie->pp;
> +	pp->dev = dev;
> +	pp->dbi_base = pcie->dbi;
> +	pp->root_bus_nr = -1;
> +	pp->ops = &qcom_pcie_ops;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0) {
> +			dev_err(dev, "cannot get msi irq\n");
> +			return pp->msi_irq;
> +		}
> +

Feeding an error value of msi_irq into request_irq will fails
gracefully, so you could just skip the error handling above.

> +		ret = devm_request_irq(dev, pp->msi_irq,
> +				       qcom_pcie_msi_irq_handler,
> +				       IRQF_SHARED, "qcom-pcie-msi", pp);
> +		if (ret) {
> +			dev_err(dev, "cannot request msi irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "cannot initialize host\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	return 0;
> +}
> +
[..]
> +
> +MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
> +MODULE_DESCRIPTION("Qualcomm PCIe root complex driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-pcie");

There's little point in the MODULE_ALIAS(), please drop it.

Regards,
Bjorn
