Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:55302 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbdHQLyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 07:54:15 -0400
Subject: Re: [PATCH v8 3/3] PCI: dwc: qcom: Add support for IPQ8074 PCIe
 controller
To: Varadarajan Narayanan <varada@codeaurora.org>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com,
        sboyd@codeaurora.org, vivek.gautam@codeaurora.org,
        fengguang.wu@intel.com, weiyongjun1@huawei.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: smuthayy <smuthayy@codeaurora.org>
References: <1502968858-28090-1-git-send-email-varada@codeaurora.org>
 <1502968858-28090-4-git-send-email-varada@codeaurora.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <9a3e4ab0-8253-6df3-a2da-c0219eb5e927@mm-sol.com>
Date: Thu, 17 Aug 2017 14:54:12 +0300
MIME-Version: 1.0
In-Reply-To: <1502968858-28090-4-git-send-email-varada@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Varada,

On 08/17/2017 02:20 PM, Varadarajan Narayanan wrote:
> Add support for the IPQ8074 PCIe controller.  IPQ8074 supports
> Gen 1/2, one lane, two PCIe root complex with support for MSI and
> legacy interrupts, and it conforms to PCI Express Base 2.1
> specification.
> 
> The core init is the similar to the existing SoC, however the
> clocks and reset lines differ.
> 
> Signed-off-by: smuthayy <smuthayy@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 208 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 208 insertions(+)

This patch will need re-basing too.

With both comments below addressed:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index c4cd039..1cb03dd 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -37,6 +37,20 @@
>  #include "pcie-designware.h"
>  
>  #define PCIE20_PARF_SYS_CTRL			0x00
> +#define MST_WAKEUP_EN				BIT(13)
> +#define SLV_WAKEUP_EN				BIT(12)
> +#define MSTR_ACLK_CGC_DIS			BIT(10)
> +#define SLV_ACLK_CGC_DIS			BIT(9)
> +#define CORE_CLK_CGC_DIS			BIT(6)
> +#define AUX_PWR_DET				BIT(4)
> +#define L23_CLK_RMV_DIS				BIT(2)
> +#define L1_CLK_RMV_DIS				BIT(1)
> +
> +#define PCIE20_COMMAND_STATUS			0x04
> +#define CMD_BME_VAL				0x4
> +#define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
> +#define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
> +
>  #define PCIE20_PARF_PHY_CTRL			0x40
>  #define PCIE20_PARF_PHY_REFCLK			0x4C
>  #define PCIE20_PARF_DBI_BASE_ADDR		0x168
> @@ -58,9 +72,21 @@
>  #define CFG_BRIDGE_SB_INIT			BIT(0)
>  
>  #define PCIE20_CAP				0x70
> +#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + 0xc)
> +#define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT	(BIT(10) | BIT(11))
> +#define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
> +#define PCIE_CAP_LINK1_VAL			0x2fd7f
> +
> +#define PCIE20_PARF_Q2A_FLUSH			0x1ac
> +
> +#define PCIE20_MISC_CONTROL_1_REG		0x8bc
> +#define DBI_RO_WR_EN				1
>  
>  #define PERST_DELAY_US				1000
>  
> +#define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> +#define SLV_ADDR_SPACE_SZ                       0x10000000

Please use tabs instead of spaces.

> +
>  struct qcom_pcie_resources_2_1_0 {
>  	struct clk *iface_clk;
>  	struct clk *core_clk;
> @@ -110,10 +136,20 @@ struct qcom_pcie_resources_2_4_0 {
>  	struct reset_control *phy_ahb_reset;
>  };
>  
> +struct qcom_pcie_resources_2_3_3 {
> +	struct clk *iface;
> +	struct clk *axi_m_clk;
> +	struct clk *axi_s_clk;
> +	struct clk *ahb_clk;
> +	struct clk *aux_clk;
> +	struct reset_control *rst[7];
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
>  	struct qcom_pcie_resources_2_3_2 v2_3_2;
> +	struct qcom_pcie_resources_2_3_3 v2_3_3;
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
>  };
>  
> @@ -884,6 +920,169 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int i;
> +	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
> +				    "axi_m_sticky", "sticky",
> +				    "ahb", "sleep", };
> +
> +	res->iface = devm_clk_get(dev, "iface");
> +	if (IS_ERR(res->iface))
> +		return PTR_ERR(res->iface);
> +
> +	res->axi_m_clk = devm_clk_get(dev, "axi_m");
> +	if (IS_ERR(res->axi_m_clk))
> +		return PTR_ERR(res->axi_m_clk);
> +
> +	res->axi_s_clk = devm_clk_get(dev, "axi_s");
> +	if (IS_ERR(res->axi_s_clk))
> +		return PTR_ERR(res->axi_s_clk);
> +
> +	res->ahb_clk = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(res->ahb_clk))
> +		return PTR_ERR(res->ahb_clk);
> +
> +	res->aux_clk = devm_clk_get(dev, "aux");
> +	if (IS_ERR(res->aux_clk))
> +		return PTR_ERR(res->aux_clk);
> +
> +	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
> +		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
> +		if (IS_ERR(res->rst[i]))
> +			return PTR_ERR(res->rst[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> +
> +	clk_disable_unprepare(res->iface);
> +	clk_disable_unprepare(res->axi_m_clk);
> +	clk_disable_unprepare(res->axi_s_clk);
> +	clk_disable_unprepare(res->ahb_clk);
> +	clk_disable_unprepare(res->aux_clk);
> +}
> +
> +static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int i, ret;
> +	u32 val;
> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> +		ret = reset_control_assert(res->rst[i]);
> +		if (ret) {
> +			dev_err(pcie->pci->dev,
> +				"%s: reset assert failed for %d\n",
> +				__func__, i);
> +			return ret;
> +		}
> +	}
> +
> +	usleep_range(2000, 2500);
> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> +		ret = reset_control_deassert(res->rst[i]);
> +		if (ret) {
> +			dev_err(pcie->pci->dev,
> +				"%s: reset deassert failed for %d\n",
> +				__func__, i);
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Don't have a way to see if the reset has completed.
> +	 * Wait for some time.
> +	 */
> +	usleep_range(2000, 2500);
> +
> +	ret = clk_prepare_enable(res->iface);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		goto err_clk_iface;
> +	}
> +
> +	ret = clk_prepare_enable(res->axi_m_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		goto err_clk_axi_m;
> +	}
> +
> +	ret = clk_prepare_enable(res->axi_s_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable axi slave clock\n");
> +		goto err_clk_axi_s;
> +	}
> +
> +	ret = clk_prepare_enable(res->ahb_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable ahb clock\n");
> +		goto err_clk_ahb;
> +	}
> +
> +	ret = clk_prepare_enable(res->aux_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable aux clock\n");
> +		goto err_clk_aux;
> +	}
> +
> +	writel(SLV_ADDR_SPACE_SZ,
> +		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
> +		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
> +		AUX_PWR_DET | L23_CLK_RMV_DIS | L1_CLK_RMV_DIS,
> +		pcie->parf + PCIE20_PARF_SYS_CTRL);
> +	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
> +
> +	writel(CMD_BME_VAL, pci->dbi_base + PCIE20_COMMAND_STATUS);
> +	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
> +	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
> +
> +	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
> +	val &= ~PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT;
> +	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
> +
> +	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
> +		PCIE20_DEVICE_CONTROL2_STATUS2);
> +
> +	return 0;
> +
> +err_clk_aux:
> +	clk_disable_unprepare(res->ahb_clk);
> +err_clk_ahb:
> +	clk_disable_unprepare(res->axi_s_clk);
> +err_clk_axi_s:
> +	clk_disable_unprepare(res->axi_m_clk);
> +err_clk_axi_m:
> +	clk_disable_unprepare(res->iface);
> +err_clk_iface:
> +	/*
> +	 * Not checking for failure, will anyway return
> +	 * the original failure in 'ret'.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> +		reset_control_assert(res->rst[i]);
> +
> +	return ret;
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
>  	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
> @@ -985,6 +1184,14 @@ static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 2.3.3	Synopsys IP rev.: 4.30a */
> +static const struct qcom_pcie_ops ops_2_3_3 = {
> +	.get_resources = qcom_pcie_get_resources_2_3_3,
> +	.init = qcom_pcie_init_2_3_3,
> +	.deinit = qcom_pcie_deinit_2_3_3,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  };
> @@ -1080,6 +1287,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
> +	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },

Sorry forgot to mention that in the previous review, please exchange
ops_2_4_0 and ops_2_3_3 to keep the list sorted.

-- 
regards,
Stan
