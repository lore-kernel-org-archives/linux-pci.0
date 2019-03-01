Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B6C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 12:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24DE20851
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 12:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="S513nS07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfCAMxj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:53:39 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:52191 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfCAMxj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 07:53:39 -0500
Received: from [192.168.28.130] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 26D5CCE1D;
        Fri,  1 Mar 2019 14:53:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1551444816; bh=R32D6LGCGFmPSsrG/2tsoqkk71GjPiXbOMWUthLC258=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S513nS07R84mD1m3InnGeZy5lKiXLetFMcHdpXVyszO8yM1iI0VEmBglpXzskYyRQ
         0R1wNqNGZ3bq+xlvzbJ/adpbMXCzaO1b3Bnr0LhfRKFrnenbNKmNwsb+5p2ElaHuhw
         wgU3P+oIDaOzFnWHzrb4HvscFluCgiytQQAClYh7SPQF2n/VgDtnplgF0ooR5lDz4A
         YNNK9ZJDYftZ0rgKw7g2jBMkj0vn5a7AEPE3KyYQdzuZek6Ds4XrGKy9RU9u99Ms8H
         QWfIRMkbk8B0M4v8y5bYZWG0J5MNZwCddszOOHKP86lolAU8GgSddByZ5FpVMg3M/m
         PdIbIVu/SDPDA==
Subject: Re: [PATCH] pcie: qcom: Add support for sdm845 PCIe controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190226070125.22318-1-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <e8a05fdd-2ca5-9f1c-6137-40df491ab310@mm-sol.com>
Date:   Fri, 1 Mar 2019 14:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226070125.22318-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the patch!

On 2/26/19 9:01 AM, Bjorn Andersson wrote:
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> 
> Due to lack of hardware only the Gen2 controller has been verified.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  19 +++
>  drivers/pci/controller/dwc/pcie-qcom.c        | 146 ++++++++++++++++++
>  2 files changed, 165 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 1fd703bd73e0..2cf92ed39499 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -10,6 +10,7 @@
>  			- "qcom,pcie-msm8996" for msm8996 or apq8096
>  			- "qcom,pcie-ipq4019" for ipq4019
>  			- "qcom,pcie-ipq8074" for ipq8074
> +			- "qcom,pcie-sdm845" for sdm845
>  
>  - reg:
>  	Usage: required
> @@ -116,6 +117,18 @@
>  			- "ahb"		AHB clock
>  			- "aux"		Auxiliary clock
>  
> +- clock-names:
> +	Usage: required for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "aux"		Auxiliary clock
> +			- "cfg"		Configuration clock
> +			- "bus_master"	Master AXI clock
> +			- "bus_slave"	Slave AXI clock
> +			- "slave_q2a"	Slave Q2A clock

What means Q2A? It'd be nice to describe it.

> +			- "tbu"		PCIe TBU clock

Is TBU related to SMMU or to something else?

> +			- "pipe"	PIPE clock
> +
>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -167,6 +180,12 @@
>  			- "ahb"			AHB Reset
>  			- "axi_m_sticky"	AXI Master Sticky reset
>  
> +- reset-names:
> +	Usage: required for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "pci"			PCIe core reset
> +
>  - power-domains:
>  	Usage: required for apq8084 and msm8996/apq8096
>  	Value type: <prop-encoded-array>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d185ea5fe996..5147454a6ae5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -54,6 +54,7 @@
>  #define PCIE20_PARF_LTSSM			0x1B0
>  #define PCIE20_PARF_SID_OFFSET			0x234
>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
> +#define PCIE20_PARF_DEVICE_TYPE			0x1000
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> @@ -80,6 +81,8 @@
>  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
>  #define SLV_ADDR_SPACE_SZ			0x10000000
>  
> +#define DEVICE_TYPE_RC				0x4
> +
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
>  struct qcom_pcie_resources_2_1_0 {
>  	struct clk *iface_clk;
> @@ -139,12 +142,21 @@ struct qcom_pcie_resources_2_3_3 {
>  	struct reset_control *rst[7];
>  };
>  
> +struct qcom_pcie_resources_2_7_0 {
> +	struct clk_bulk_data clks[6];
> +	struct regulator_bulk_data supplies[2];
> +

please drop the blank line.

> +	struct reset_control *pci_reset;
> +	struct clk *pipe_clk;
> +};
> +
>  union qcom_pcie_resources {
>  	struct qcom_pcie_resources_1_0_0 v1_0_0;
>  	struct qcom_pcie_resources_2_1_0 v2_1_0;
>  	struct qcom_pcie_resources_2_3_2 v2_3_2;
>  	struct qcom_pcie_resources_2_3_3 v2_3_3;
>  	struct qcom_pcie_resources_2_4_0 v2_4_0;
> +	struct qcom_pcie_resources_2_7_0 v2_7_0;
>  };
>  
>  struct qcom_pcie;
> @@ -1076,6 +1088,129 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
>  	return ret;
>  }
>  
> +static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	int ret;
> +
> +	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> +	if (IS_ERR(res->pci_reset))
> +		return PTR_ERR(res->pci_reset);
> +
> +	res->supplies[0].supply = "vdda";
> +	res->supplies[1].supply = "vddpe-3v3";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> +				      res->supplies);
> +	if (ret)
> +		return ret;
> +
> +	res->clks[0].id = "aux";
> +	res->clks[1].id = "cfg";
> +	res->clks[2].id = "bus_master";
> +	res->clks[3].id = "bus_slave";
> +	res->clks[4].id = "slave_q2a";
> +	res->clks[5].id = "tbu";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	res->pipe_clk = devm_clk_get(dev, "pipe");
> +	return PTR_ERR_OR_ZERO(res->pipe_clk);
> +}
> +
> +static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable regulators\n");
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +	if (ret < 0)

you could add dev_err() as well (to be aligned with
regulator_bulk_enable and reset_control_assert).

> +		goto err_disable_regulators;
> +
> +	ret = reset_control_assert(res->pci_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		return ret;
> +	}
> +
> +	msleep(10);

for sleeping interval 10us - 20ms you should use usleep_range, please
fix it.

> +
> +	ret = reset_control_deassert(res->pci_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		return ret;
> +	}
> +
> +	clk_prepare_enable(res->pipe_clk);

check for errors, please.

> +
> +	/* configure PCIe to RC mode */
> +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
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
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +		val |= BIT(31);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +	}
> +
> +	return 0;
> +
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> +
> +	return ret;
> +}
> +

<cut>

-- 
regards,
Stan
