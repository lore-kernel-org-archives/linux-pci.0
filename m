Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933483AbcKWXIw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 18:08:52 -0500
Date: Wed, 23 Nov 2016 17:08:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7] PCI: qcom: add support to msm8996 PCIe controller
Message-ID: <20161123230834.GK16033@bhelgaas-glaptop.roam.corp.google.com>
References: <1479811409-22375-1-git-send-email-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479811409-22375-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 22, 2016 at 10:43:29AM +0000, Srinivas Kandagatla wrote:
> This patch adds support to msm8996/apq8096 PCIe, MSM8996 supports
> Gen 1/2, One lane, 3 PCIe root-complex with support to MSI and
> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
> 
> This patch adds post_init callback to qcom_pcie_ops, as this is PCIe
> pipe clocks are only setup after the phy is powered on.
> It also adds ltssm_enable callback as it is very much different to other
> supported SOCs in the driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Applied to pci/host-qcom for v4.10, thanks!

> ---
>  Changes since v5/v6:
>  	- No code changes.
> 	- s/pcie/PCIe in change log based on Rob's comments.
> 	- Removed DT example for 8996 as requested by Rob.
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  14 +-
>  drivers/pci/host/pcie-qcom.c                       | 175 ++++++++++++++++++++-
>  2 files changed, 183 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 4059a6f..15ced03 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -7,6 +7,7 @@
>  			- "qcom,pcie-ipq8064" for ipq8064
>  			- "qcom,pcie-apq8064" for apq8064
>  			- "qcom,pcie-apq8084" for apq8084
> +			- "qcom,pcie-msm8996" for msm8996 or apq8096
>  
>  - reg:
>  	Usage: required
> @@ -92,6 +93,17 @@
>  			- "aux"		Auxiliary (AUX) clock
>  			- "bus_master"	Master AXI clock
>  			- "bus_slave"	Slave AXI clock
> +
> +- clock-names:
> +	Usage: required for msm8996/apq8096
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "pipe"	Pipe Clock driving internal logic.
> +			- "aux"		Auxiliary (AUX) clock.
> +			- "cfg"		Configuration clk.
> +			- "bus_master"	Master AXI clock.
> +			- "bus_slave"	Slave AXI clock.
> +
>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -115,7 +127,7 @@
>  			- "core" Core reset
>  
>  - power-domains:
> -	Usage: required for apq8084
> +	Usage: required for apq8084 and msm8996/apq8096
>  	Value type: <prop-encoded-array>
>  	Definition: A phandle and power domain specifier pair to the
>  		    power domain which is responsible for collapsing
> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
> index 3593640..25c5556 100644
> --- a/drivers/pci/host/pcie-qcom.c
> +++ b/drivers/pci/host/pcie-qcom.c
> @@ -36,11 +36,17 @@
>  
>  #include "pcie-designware.h"
>  
> +#define PCIE20_PARF_SYS_CTRL			0x00
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
>  #define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16c
> +#define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
>  #define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
> +#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
> +#define PCIE20_PARF_LTSSM			0x1B0
> +#define PCIE20_PARF_SID_OFFSET			0x234
> +#define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> @@ -72,9 +78,18 @@ struct qcom_pcie_resources_v1 {
>  	struct regulator *vdda;
>  };
>  
> +struct qcom_pcie_resources_v2 {
> +	struct clk *aux_clk;
> +	struct clk *master_clk;
> +	struct clk *slave_clk;
> +	struct clk *cfg_clk;
> +	struct clk *pipe_clk;
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_v0 v0;
>  	struct qcom_pcie_resources_v1 v1;
> +	struct qcom_pcie_resources_v2 v2;
>  };
>  
>  struct qcom_pcie;
> @@ -82,7 +97,9 @@ struct qcom_pcie;
>  struct qcom_pcie_ops {
>  	int (*get_resources)(struct qcom_pcie *pcie);
>  	int (*init)(struct qcom_pcie *pcie);
> +	int (*post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
> +	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  };
>  
>  struct qcom_pcie {
> @@ -116,17 +133,33 @@ static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
>  	return dw_handle_msi_irq(pp);
>  }
>  
> -static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
> +static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> -
> -	if (dw_pcie_link_up(&pcie->pp))
> -		return 0;
> -
>  	/* enable link training */
>  	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
>  	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
>  	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +}
> +
> +static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +	/* enable link training */
> +	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
> +	val |= BIT(8);
> +	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
> +}
> +
> +static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
> +{
> +
> +	if (dw_pcie_link_up(&pcie->pp))
> +		return 0;
> +
> +	/* Enable Link Training state machine */
> +	if (pcie->ops->ltssm_enable)
> +		pcie->ops->ltssm_enable(pcie);
>  
>  	return dw_pcie_wait_for_link(&pcie->pp);
>  }
> @@ -421,6 +454,113 @@ static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +	struct device *dev = pcie->pp.dev;
> +
> +	res->aux_clk = devm_clk_get(dev, "aux");
> +	if (IS_ERR(res->aux_clk))
> +		return PTR_ERR(res->aux_clk);
> +
> +	res->cfg_clk = devm_clk_get(dev, "cfg");
> +	if (IS_ERR(res->cfg_clk))
> +		return PTR_ERR(res->cfg_clk);
> +
> +	res->master_clk = devm_clk_get(dev, "bus_master");
> +	if (IS_ERR(res->master_clk))
> +		return PTR_ERR(res->master_clk);
> +
> +	res->slave_clk = devm_clk_get(dev, "bus_slave");
> +	if (IS_ERR(res->slave_clk))
> +		return PTR_ERR(res->slave_clk);
> +
> +	res->pipe_clk = devm_clk_get(dev, "pipe");
> +	if (IS_ERR(res->pipe_clk))
> +		return PTR_ERR(res->pipe_clk);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +	struct device *dev = pcie->pp.dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(res->aux_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable aux clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(res->cfg_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable cfg clock\n");
> +		goto err_cfg_clk;
> +	}
> +
> +	ret = clk_prepare_enable(res->master_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable master clock\n");
> +		goto err_master_clk;
> +	}
> +
> +	ret = clk_prepare_enable(res->slave_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable slave clock\n");
> +		goto err_slave_clk;
> +	}
> +
> +	/* enable PCIe clocks and resets */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
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
> +err_slave_clk:
> +	clk_disable_unprepare(res->master_clk);
> +err_master_clk:
> +	clk_disable_unprepare(res->cfg_clk);
> +err_cfg_clk:
> +	clk_disable_unprepare(res->aux_clk);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +	struct device *dev = pcie->pp.dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(res->pipe_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable pipe clock\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qcom_pcie_link_up(struct pcie_port *pp)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> @@ -429,6 +569,17 @@ static int qcom_pcie_link_up(struct pcie_port *pp)
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> +static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +
> +	clk_disable_unprepare(res->pipe_clk);
> +	clk_disable_unprepare(res->slave_clk);
> +	clk_disable_unprepare(res->master_clk);
> +	clk_disable_unprepare(res->cfg_clk);
> +	clk_disable_unprepare(res->aux_clk);
> +}
> +
>  static void qcom_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> @@ -444,6 +595,9 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err_deinit;
>  
> +	if (pcie->ops->post_init)
> +		pcie->ops->post_init(pcie);
> +
>  	dw_pcie_setup_rc(pp);
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
> @@ -487,12 +641,22 @@ static const struct qcom_pcie_ops ops_v0 = {
>  	.get_resources = qcom_pcie_get_resources_v0,
>  	.init = qcom_pcie_init_v0,
>  	.deinit = qcom_pcie_deinit_v0,
> +	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
>  };
>  
>  static const struct qcom_pcie_ops ops_v1 = {
>  	.get_resources = qcom_pcie_get_resources_v1,
>  	.init = qcom_pcie_init_v1,
>  	.deinit = qcom_pcie_deinit_v1,
> +	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
> +};
> +
> +static const struct qcom_pcie_ops ops_v2 = {
> +	.get_resources = qcom_pcie_get_resources_v2,
> +	.init = qcom_pcie_init_v2,
> +	.post_init = qcom_pcie_post_init_v2,
> +	.deinit = qcom_pcie_deinit_v2,
> +	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
>  };
>  
>  static int qcom_pcie_probe(struct platform_device *pdev)
> @@ -572,6 +736,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_v0 },
>  	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
> +	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
>  	{ }
>  };
>  
> -- 
> 2.10.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
