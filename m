Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A8C10F05
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D896A2133F
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDAPNb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:13:31 -0400
Received: from foss.arm.com ([217.140.101.70]:36350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPNb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 11:13:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3653BA78;
        Mon,  1 Apr 2019 08:13:30 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB813F690;
        Mon,  1 Apr 2019 08:13:27 -0700 (PDT)
Date:   Mon, 1 Apr 2019 16:13:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 6/7] PCI: qcom: Add QCS404 PCIe controller support
Message-ID: <20190401151324.GB6234@e107981-ln.cambridge.arm.com>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
 <20190219060407.15263-7-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219060407.15263-7-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 18, 2019 at 10:04:06PM -0800, Bjorn Andersson wrote:
> The QCS404 platform contains a PCIe controller of version 2.4.0 and a
> Qualcomm PCIe2 PHY. The driver already supports version 2.4.0, for the
> IPQ4019, but this support touches clocks and resets related to the PHY
> as well, and there's no upstream driver for the PHY.
> 
> On QCS404 we must initialize the PHY, so a separate PHY driver is
> implemented to take care of this and the controller driver is updated to
> not require the PHY related resources. This is done by relying on the
> fact that operations in both the clock and reset framework are nops when
> passed NULL, so we can isolate this change to only the get_resource
> function.
> 
> For QCS404 we also need to enable the AHB (iface) clock, in order to
> access the register space of the controller, but as this is not part of
> the IPQ4019 DT binding this is only added for new users of the 2.4.0
> controller.
> 
> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 64 +++++++++++++++-----------
>  1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b4d8bcf6eb77..3724ab5de956 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -113,7 +113,7 @@ struct qcom_pcie_resources_2_3_2 {
>  };
>  
>  struct qcom_pcie_resources_2_4_0 {
> -	struct clk_bulk_data clks[3];
> +	struct clk_bulk_data clks[4];
>  	int num_clks;
>  	struct reset_control *axi_m_reset;
>  	struct reset_control *axi_s_reset;
> @@ -637,13 +637,16 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");

Just a question: other host controller drivers resorted to .data
structures (ie struct of_device_id.data) to sort out per-SOC
parameters I was wondering if you want to do the same, maybe
not just yet but I noticed so I am asking.

Lorenzo

>  	int ret;
>  
>  	res->clks[0].id = "aux";
>  	res->clks[1].id = "master_bus";
>  	res->clks[2].id = "slave_bus";
> +	res->clks[3].id = "iface";
>  
> -	res->num_clks = 3;
> +	/* qcom,pcie-ipq4019 is defined without "iface" */
> +	res->num_clks = is_ipq ? 3 : 4;
>  
>  	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
>  	if (ret < 0)
> @@ -657,27 +660,33 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->axi_s_reset))
>  		return PTR_ERR(res->axi_s_reset);
>  
> -	res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
> -	if (IS_ERR(res->pipe_reset))
> -		return PTR_ERR(res->pipe_reset);
> -
> -	res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
> -								 "axi_m_vmid");
> -	if (IS_ERR(res->axi_m_vmid_reset))
> -		return PTR_ERR(res->axi_m_vmid_reset);
> -
> -	res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
> -								"axi_s_xpu");
> -	if (IS_ERR(res->axi_s_xpu_reset))
> -		return PTR_ERR(res->axi_s_xpu_reset);
> -
> -	res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
> -	if (IS_ERR(res->parf_reset))
> -		return PTR_ERR(res->parf_reset);
> -
> -	res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
> -	if (IS_ERR(res->phy_reset))
> -		return PTR_ERR(res->phy_reset);
> +	if (is_ipq) {
> +		/*
> +		 * These resources relates to the PHY or are secure clocks, but
> +		 * are controlled here for IPQ4019
> +		 */
> +		res->pipe_reset = devm_reset_control_get_exclusive(dev, "pipe");
> +		if (IS_ERR(res->pipe_reset))
> +			return PTR_ERR(res->pipe_reset);
> +
> +		res->axi_m_vmid_reset = devm_reset_control_get_exclusive(dev,
> +									 "axi_m_vmid");
> +		if (IS_ERR(res->axi_m_vmid_reset))
> +			return PTR_ERR(res->axi_m_vmid_reset);
> +
> +		res->axi_s_xpu_reset = devm_reset_control_get_exclusive(dev,
> +									"axi_s_xpu");
> +		if (IS_ERR(res->axi_s_xpu_reset))
> +			return PTR_ERR(res->axi_s_xpu_reset);
> +
> +		res->parf_reset = devm_reset_control_get_exclusive(dev, "parf");
> +		if (IS_ERR(res->parf_reset))
> +			return PTR_ERR(res->parf_reset);
> +
> +		res->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
> +		if (IS_ERR(res->phy_reset))
> +			return PTR_ERR(res->phy_reset);
> +	}
>  
>  	res->axi_m_sticky_reset = devm_reset_control_get_exclusive(dev,
>  								   "axi_m_sticky");
> @@ -697,9 +706,11 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>  	if (IS_ERR(res->ahb_reset))
>  		return PTR_ERR(res->ahb_reset);
>  
> -	res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
> -	if (IS_ERR(res->phy_ahb_reset))
> -		return PTR_ERR(res->phy_ahb_reset);
> +	if (is_ipq) {
> +		res->phy_ahb_reset = devm_reset_control_get_exclusive(dev, "phy_ahb");
> +		if (IS_ERR(res->phy_ahb_reset))
> +			return PTR_ERR(res->phy_ahb_reset);
> +	}
>  
>  	return 0;
>  }
> @@ -1284,6 +1295,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-msm8996", .data = &ops_2_3_2 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &ops_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &ops_2_4_0 },
> +	{ .compatible = "qcom,pcie-qcs404", .data = &ops_2_4_0 },
>  	{ }
>  };
>  
> -- 
> 2.18.0
> 
