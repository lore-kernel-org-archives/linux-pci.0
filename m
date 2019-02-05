Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24164C282D7
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63482146F
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 05:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549346067;
	bh=d0aZ3auWf+/3eovxxc6ZRJMGHjE4CaV7tW/bUNyKqHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OAgis6+SeoSQVaWBZDxd7LBQKJ58wIN0MGCszdWoIDd/ngcUr0BwpEzdDxjy6XPlG
	 msiuuI8h/aATmcQ+qkJjrQmxSnDp3B7Igl8q2lpUQROK5M1rB9Mmyi8UAROq2eUIm5
	 Gu+q93e7x14CwAKiJMq9Nb+eGp33yYIIy7zyPCuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfBEFy0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfBEFy0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Feb 2019 00:54:26 -0500
Received: from localhost (unknown [171.61.84.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903ED2081B;
        Tue,  5 Feb 2019 05:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549346065;
        bh=d0aZ3auWf+/3eovxxc6ZRJMGHjE4CaV7tW/bUNyKqHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuizQqlIhp+4ctVdK65LOSWsTiP/vT+xAZ/TpuLE1GIq0qEQFrSWdVpWqF9NlUvNc
         KiJuKjOdqF14CAOibUoGcsR8+jYwKF+3Am6PqOofh2W9WF+e/I9ODUgRpFdXLyJj3/
         v5i2Xv6uxb3M/7hwzNxr3unoimwRcKaPb6Q275Cg=
Date:   Tue, 5 Feb 2019 11:24:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
Message-ID: <20190205055416.GX4296@vkoul-mobl>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
 <20190125234509.26419-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234509.26419-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25-01-19, 15:45, Bjorn Andersson wrote:
> The Qualcomm PCIe2 PHY is a Synopsys based PCIe PHY found in a number of
> Qualcomm platforms, add a binding to describe this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/phy/qcom-pcie2-phy.txt           | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> new file mode 100644
> index 000000000000..7da02f9d78c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> @@ -0,0 +1,40 @@
> +Qualcomm PCIe2 PHY controller
> +=============================
> +
> +The Qualcomm PCIe2 PHY is a Synopsys based phy found in a number of Qualcomm
> +platforms.
> +
> +Required properties:
> + - compatible: compatible list, should be:
> +	       "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy"
> +
> + - reg: offset and length of the PHY register set.
> + - #phy-cells: must be 0.
> +
> + - clocks: a clock-specifier pair for the "pipe" clock
> +
> + - vdda-vp-supply: phandle to low voltage regulator
> + - vdda-vph-supply: phandle to high voltage regulator
> +
> + - resets: reset-specifier pairs for the "phy" and "pipe" resets
> + - reset-names: list of resets, should contain:
> +		"phy" and "pipe"
> +
> + - clock-output-names: name of the outgoing clock signal from the PHY PLL

Should we specify the clk name here?

> +
> +Example:
> + phy@7786000 {
> +	compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
> +	reg = <0x07786000 0xb8>;
> +
> +	clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +	resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
> +	         <&gcc GCC_PCIE_0_PIPE_ARES>;
> +	reset-names = "phy", "pipe";
> +
> +	vdda-vp-supply = <&vreg_l3_1p05>;
> +	vdda-vph-supply = <&vreg_l5_1p8>;
> +
> +	clock-output-names = "pcie_0_pipe_clk";
> +	#phy-cells = <0>;
> + };
> -- 
> 2.18.0

-- 
~Vinod
