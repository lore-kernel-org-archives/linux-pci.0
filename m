Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BBBC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE412086C
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 16:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gt9gcavd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBHQjU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:39:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35289 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfBHQjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 11:39:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id j13-v6so3556288ljc.2
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJvNPv0iYV1ss/wTWzX21hkUtCucJaHNNAaHN6/iqTo=;
        b=Gt9gcavdyZ7eD1kl00TIVkYfWXkNUsTl7WeiLPnfIkcXCjsU9llwXdKpqGSpA+bRiE
         W2pYwEd74BsK6TjjzqjaQg8uUPTnLqpoL1pHg3kfS88rNzRORh/Ek+Dh/EXDXOL2BBtE
         rCqbXzenpuORZgFA4oAB5C0Eo36gUibZ5HFYOzMLHDVzPbb4PlJQqdw0FLjBfWrb2rRq
         /wmE7Po53JF48uSbOLGdXnGrCA9zy86//al2UFvizepHJi4gX+f3X3RwU7dZx15QBHc2
         5Sf9a8Oo/lAA8tfucGZkPa+Ti3GYnAViUXnVXTLmrmtJ6vRcMV2QsPqnnCcQbx9Fn0mz
         /+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJvNPv0iYV1ss/wTWzX21hkUtCucJaHNNAaHN6/iqTo=;
        b=makj0l3dXY9akm9Oo+zhcY8hLoO6A7Gf+v485txyxA7SArOufPLC5ASObf7dn6LJki
         pApX4I6iZpXNMZsE+nTUKAFePLcIxVGWW906wGzLLzVEotRkrnnmtsYodZWayEFpUNHL
         YEThkxxENy5s/VS6yEVK1+/zo55wZ8bZJ1KeTzx44LSunI3ndP+DelmqqVDuhEwMIVC1
         R8ICQWC5QEVa0WGYyhGF+bNLyiz7jbWCYd8KM/VAYTbGsXxjCULvdnFx4FerM48b/gjM
         XyKbE/WC6WSR2F/bvNNN3uYkyOki7HINAJ5Yk2wdCqecM1dnUifAWIoPfQv03KrbojEa
         2PkQ==
X-Gm-Message-State: AHQUAuZLYISGx7hjooZzxHo9HmzvvdCIdg1/C6pb3hnwktIFF+fnegz9
        RPmqXOfJ0URFlsr4VSRuGbLvbg==
X-Google-Smtp-Source: AHgI3Ia0ZO0l3o8m3eXp9J5skOxTlbXcF5SBSHlTj8+zpkNdl/0AtsFTr6wE07psL2vpKPE8LrIh6Q==
X-Received: by 2002:a2e:9209:: with SMTP id k9-v6mr2172546ljg.12.1549643957260;
        Fri, 08 Feb 2019 08:39:17 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id y1-v6sm466880ljh.39.2019.02.08.08.39.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 08:39:16 -0800 (PST)
Date:   Fri, 8 Feb 2019 17:39:13 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: qcom: Add QCS404 PCIe controller support
Message-ID: <20190208163913.GE773@centauri.lan>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
 <20190125234509.26419-7-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125234509.26419-7-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 03:45:08PM -0800, Bjorn Andersson wrote:
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
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 64 +++++++++++++++-----------
>  1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 9d366fad2b7f..6d4215ddcb42 100644
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
> +		 * These resources relates to the PHY, but are controlled here
> +		 * for IPQ4019
> +		 */

This comment makes be believe that all these resouces are related to the
PHY.

"pipe" and "phy" are related to the PHY, but I doubt that the rest of them
relates to the PHY.

If QCS404 lacks these other reset signals, which is very possible, since
it's a completely different SoC, perhaps the comment should also mention
that.

With that:
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>

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
