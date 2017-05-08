Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34401 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdEHRqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2017 13:46:15 -0400
Date: Mon, 8 May 2017 12:46:13 -0500
From: Rob Herring <robh@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for IPQ4019 PCIe controller
Message-ID: <20170508174613.37vss73bsuo5ouqk@rob-hp-laptop>
References: <20170505152524.29337-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170505152524.29337-1-john@phrozen.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 05, 2017 at 05:25:24PM +0200, John Crispin wrote:
> Add support for the IPQ4019 PCIe controller. IPQ4019 supports Gen
> 1/2, one lane, one PCIe root complex with support for MSI and legacy
> interrupts, and it conforms to PCI Express Base 2.1 specification.
> 
> The core init is the sames as for the MSM8996, however the clocks and
> reset lines differ.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  20 +-

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pci/host/pcie-qcom.c                       | 304 +++++++++++++++++++++
>  2 files changed, 323 insertions(+), 1 deletion(-)


> +static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v3 *res = &pcie->res.v3;
> +	struct device *dev = pcie->pp.dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = reset_control_assert(res->axi_m_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert axi master reset\n");

These all seem kind of verbose. Perhaps the error message should be in 
reset_control_assert function.

> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(res->axi_s_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot asser axi slave reset\n");
> +		return ret;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	ret = reset_control_assert(res->pipe_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert pipe reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(res->pipe_sticky_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert pipe sticky reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(res->phy_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert phy reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(res->phy_ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert phy ahb reset\n");
> +		return ret;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	ret = reset_control_assert(res->axi_m_sticky_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert axi master sticky reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(res->pwr_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert power reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(res->ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert ahb reset\n");
> +		return ret;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	ret = reset_control_deassert(res->phy_ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert phy ahb reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(res->phy_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert phy reset\n");
> +		goto err_rst_phy;
> +	}
> +
> +	ret = reset_control_deassert(res->pipe_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert pipe reset\n");
> +		goto err_rst_pipe;
> +	}
> +
> +	ret = reset_control_deassert(res->pipe_sticky_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert pipe sticky reset\n");
> +		goto err_rst_pipe_sticky;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	ret = reset_control_deassert(res->axi_m_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert axi master reset\n");
> +		goto err_rst_axi_m;
> +	}
> +
> +	ret = reset_control_deassert(res->axi_m_sticky_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert axi master sticky reset\n");
> +		goto err_rst_axi_m_sticky;
> +	}
> +
> +	ret = reset_control_deassert(res->axi_s_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert axi slave reset\n");
> +		goto err_rst_axi_s;
> +	}
> +
> +	ret = reset_control_deassert(res->pwr_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert power reset\n");
> +		goto err_rst_pwr;
> +	}
> +
> +	ret = reset_control_deassert(res->ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert ahb reset\n");
> +		goto err_rst_ahb;
> +	}
> +
> +	usleep_range(10000, 12000);
> +
> +	ret = clk_prepare_enable(res->aux_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable iface clock\n");
> +		goto err_clk_aux;
> +	}
> +
> +	ret = clk_prepare_enable(res->master_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		goto err_clk_axi_m;
> +	}
> +
> +	ret = clk_prepare_enable(res->slave_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable phy clock\n");
> +		goto err_clk_axi_s;
> +	}
> +
> +	/* enable PCIe clocks and resets */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= !BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	/* change DBI base address */
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	/* MAC PHY_POWERDOWN MUX DISABLE  */
> +	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> +	val &= ~BIT(29);
> +	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	val |= BIT(4);
> +	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +	val |= BIT(31);
> +	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +
> +	return 0;
> +
> +err_clk_axi_s:
> +	clk_disable_unprepare(res->master_clk);
> +err_clk_axi_m:
> +	clk_disable_unprepare(res->aux_clk);


In deinit you turn off the clocks last.


> +err_clk_aux:
> +	reset_control_assert(res->ahb_reset);
> +err_rst_ahb:
> +	reset_control_assert(res->pwr_reset);
> +err_rst_pwr:
> +	reset_control_assert(res->axi_s_reset);
> +err_rst_axi_s:
> +	reset_control_assert(res->axi_m_sticky_reset);
> +err_rst_axi_m_sticky:
> +	reset_control_assert(res->axi_m_reset);
> +err_rst_axi_m:
> +	reset_control_assert(res->pipe_sticky_reset);
> +err_rst_pipe_sticky:
> +	reset_control_assert(res->pipe_reset);
> +err_rst_pipe:
> +	reset_control_assert(res->phy_reset);
> +err_rst_phy:
> +	reset_control_assert(res->phy_ahb_reset);
> +	return ret;
> +}
> +
>  static int qcom_pcie_link_up(struct pcie_port *pp)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> @@ -661,6 +957,13 @@ static const struct qcom_pcie_ops ops_v2 = {
>  	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
>  };
>  
> +static const struct qcom_pcie_ops ops_v3 = {
> +	.get_resources = qcom_pcie_get_resources_v3,
> +	.init = qcom_pcie_init_v3,
> +	.deinit = qcom_pcie_deinit_v3,
> +	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
> +};
> +
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -739,6 +1042,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
> +	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_v3 },
>  	{ }
>  };
>  
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
