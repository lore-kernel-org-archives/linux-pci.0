Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Jul 2017 15:07:18 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Varadarajan Narayanan <varada@codeaurora.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, smuthayy <smuthayy@codeaurora.org>
Subject: Re: [PATCH 7/7] PCI: dwc: qcom: Add support for IPQ8074 PCIe
 controller
Message-ID: <20170717220718.GZ20973@minitux>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-8-git-send-email-varada@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500293043-1887-8-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon 17 Jul 05:04 PDT 2017, Varadarajan Narayanan wrote:

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
>  drivers/pci/dwc/pcie-qcom.c | 259 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 259 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index d15657d..c1fa356 100644
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
> @@ -58,9 +72,22 @@
>  #define CFG_BRIDGE_SB_INIT			BIT(0)
>  
>  #define PCIE20_CAP				0x70
> +#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + 0xC)
> +#define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
> +#define PCIE_CAP_LINK1_VAL			0x2fd7f
> +
> +#define PCIE20_PARF_Q2A_FLUSH			0x1AC
> +
> +#define PCIE20_MISC_CONTROL_1_REG		0x8BC
> +#define DBI_RO_WR_EN				1
>  
>  #define PERST_DELAY_US				1000
>  
> +#define AXI_CLK_RATE				200000000
> +
> +#define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> +#define SLV_ADDR_SPACE_SZ                       0x10000000
> +
>  struct qcom_pcie_resources_v0 {
>  	struct clk *iface_clk;
>  	struct clk *core_clk;
> @@ -110,11 +137,26 @@ struct qcom_pcie_resources_v3 {
>  	struct reset_control *phy_ahb_reset;
>  };
>  
> +struct qphy_reset {
> +	struct reset_control	*rst;
> +	char			*name;
> +};
> +
> +struct qcom_pcie_resources_v4 {
> +	struct clk *sys_noc_clk;
> +	struct clk *axi_m_clk;
> +	struct clk *axi_s_clk;
> +	struct clk *ahb_clk;
> +	struct clk *aux_clk;
> +	struct qphy_reset rst[7];

Just store the struct reset_control here directly, carrying the name
doesn't serve much of a purpose - and it clutters the code.

> +};

Can you confirm that this is actually version 4 of this block? Or are we
just incrementing an arbitrary number here?

> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_v0 v0;
>  	struct qcom_pcie_resources_v1 v1;
>  	struct qcom_pcie_resources_v2 v2;
>  	struct qcom_pcie_resources_v3 v3;
> +	struct qcom_pcie_resources_v4 v4;
>  };
>  
>  struct qcom_pcie;
> @@ -139,6 +181,16 @@ struct qcom_pcie {
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static inline void
> +writel_masked(void __iomem *addr, u32 clear_mask, u32 set_mask)

This function name is very generic and in the two places you call it
set_mask is 0. So please just inline this.

> +{
> +	u32 val = readl(addr);
> +
> +	val &= ~clear_mask;
> +	val |= set_mask;
> +	writel(val, addr);
> +}
> +
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value(pcie->reset, 1);
> @@ -884,6 +936,205 @@ static int qcom_pcie_init_v3(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_get_resources_v4(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int i;
> +
> +	res->sys_noc_clk = devm_clk_get(dev, "sys_noc");
> +	if (IS_ERR(res->sys_noc_clk))
> +		return PTR_ERR(res->sys_noc_clk);
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
> +	res->rst[0].name = "axi_m";
> +	res->rst[1].name = "axi_s";
> +	res->rst[2].name = "pipe";
> +	res->rst[3].name = "axi_m_sticky";
> +	res->rst[4].name = "sticky";
> +	res->rst[5].name = "ahb";
> +	res->rst[6].name = "sleep";
> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> +		res->rst[i].rst = devm_reset_control_get(dev, res->rst[i].name);
> +		if (IS_ERR(res->rst[i].rst))
> +			return PTR_ERR(res->rst[i].rst);
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_v4(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
> +
> +	clk_disable_unprepare(res->sys_noc_clk);
> +	clk_disable_unprepare(res->axi_m_clk);
> +	clk_disable_unprepare(res->axi_s_clk);
> +	clk_disable_unprepare(res->ahb_clk);
> +	clk_disable_unprepare(res->aux_clk);
> +}
> +
> +static int qcom_pcie_enable_resources_v4(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(res->sys_noc_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		return ret;
> +	}

Should these clocks really be handled explicitly in the driver? Are
these not the bus clocks, to be handled by "msm_bus"?

> +
> +	ret = clk_prepare_enable(res->axi_m_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		goto err_clk_axi_m;
> +	}
> +
> +	ret = clk_set_rate(res->axi_m_clk, AXI_CLK_RATE);
> +	if (ret) {
> +		dev_err(dev, "MClk rate set failed (%d)\n", ret);
> +		goto err_clk_axi_m;
> +	}
> +
> +	ret = clk_prepare_enable(res->axi_s_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable axi slave clock\n");
> +		goto err_clk_axi_s;
> +	}
> +
> +	ret = clk_set_rate(res->axi_s_clk, AXI_CLK_RATE);
> +	if (ret) {
> +		dev_err(dev, "MClk rate set failed (%d)\n", ret);
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
> +	udelay(1);
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
> +	clk_disable_unprepare(res->sys_noc_clk);
> +
> +	return ret;
> +}
> +
> +static inline int qphy_reset_control(struct qcom_pcie *pcie,
> +				     struct qphy_reset *r,
> +				     bool assert)
> +{
> +	int ret;
> +
> +	if (assert)
> +		ret = reset_control_assert(r->rst);
> +	else
> +		ret = reset_control_deassert(r->rst);
> +
> +	if (ret)
> +		dev_err(pcie->pci->dev, "%s: reset %s failed for %s\n",
> +			__func__, assert ? "assert" : "deassert", r->name);
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_v4_reset(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v4 *res = &pcie->res.v4;
> +	struct qphy_reset *qphy_rst = &res->rst[0];

&res->rst[0] is supposed to be written as res->rst, but that's exactly
the same number of characters to type as your local variable. So just
skip the variable.

> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> +		if (qphy_reset_control(pcie, &qphy_rst[i], true))

This is a complicated way of saying:
	if (reset_control_assert(qphy_rst[i].rst))

> +			return;

You should most definitely propagate this error.

> +
> +	usleep_range(10000, 12000); /* wait 12ms */

This is not 12ms, this is 10-12ms. This is a _long_ time to usleep, how
about just msleep(20) instead?

> +
> +	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> +		if (qphy_reset_control(pcie, &qphy_rst[i], false))

Same as above, this just write:
if (reset_control_deassert(qphy_rst[i].rst))

> +			return;
> +
> +	usleep_range(10000, 12000); /* wait 12ms */
> +	wmb(); /* ensure data is written to hw register */

wmb() ensures ordering of writes, it does not wait for data to reach the
hardware registers.

> +}
> +
> +static int qcom_pcie_init_v4(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	int ret;
> +
> +	qcom_pcie_v4_reset(pcie);
> +	qcom_ep_reset_assert(pcie);
> +
> +	ret = qcom_pcie_enable_resources_v4(pcie);
> +	if (ret)
> +		return ret;
> +
> +	writel(SLV_ADDR_SPACE_SZ, pcie->parf +
> +					PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> +
> +	ret = phy_power_on(pcie->phy);
> +	if (ret)

This will leave all the resources enabled, you should issue a deinit
here..

> +		return ret;
> +
> +	writel_masked(pcie->parf + PCIE20_PARF_PHY_CTRL, BIT(0), 0);
> +

Regards,
Bjorn
