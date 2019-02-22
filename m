Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBAAC10F00
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4622070D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550865481;
	bh=zTmqd7SbtkkQBqJbqfKKiX2ePTb0M8TQ4174Q7GveOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z26RyGkcbXwbSt0/6ZLwOJBJ3K9v8qrmX3HLztCWdHe0n5gOqhNO4ey1kGVFSBlG2
	 eCycSnxotILaf0xhY3pQjjGf9SNXv2TbpdEwy54vlF9ruqj4i+eejtLbnqF8tYTr2v
	 JSux57jbR6RXnf3ij8hDomO34fkn2T+6OAs7Xqkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfBVT6A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:58:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42790 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVT6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 14:58:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id s16so2650967oih.9;
        Fri, 22 Feb 2019 11:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pv/6sBaFhmoUMN8QVUmDG8SzGwfsmkT4EQdjCr0U0FM=;
        b=qvp176iTBZ0zB3taPbxC779KEGC860qew4jKfQQBrJTdsnQ59EhKwIU1PRGa2yg6Sf
         vWN8f1sk7x+KJ4vz1J85n9aHuqONLAgb0ljYG9HFDLvP06YNXq/RSj7LYVeKn9/F7sIx
         XEW6gMQft5om20eY7We3hGTAT/U+/fiqmtoUv6jTx9YQ2ueHu6shCOzYgQYpIV1X+cIg
         mc2h/esHSTfLjyBOVwfM8J3G7Dfn6jMqV6e7nSfXkYUN/Q5zIkpWXtlntR8ROm8B7oOo
         +V1Qmds8/8L3M2G69FCiliXUFCpw0ydNeC3zcWnGt5HoT/A0M2AGgYq3HghbY8VcvzyS
         CRMg==
X-Gm-Message-State: AHQUAua4JBQTn3k1eXbda1lZTPsN6+c0Dup4Hbu1fvtOpAOeWfOoO6Vv
        HYr0BD7qq5SbbKW4GLjPMA==
X-Google-Smtp-Source: AHgI3IYuehi4rvMq4o9ihSApQ6/AHHwGFWlPNMBoLORRyrF9XLhVT/ms0vRXNrkQDJB4YHPtV7pPYw==
X-Received: by 2002:aca:5284:: with SMTP id g126mr3404834oib.31.1550865479430;
        Fri, 22 Feb 2019 11:57:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n126sm970310oif.19.2019.02.22.11.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:57:58 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:57:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: Add binding for Qualcomm PCIe2
 PHY
Message-ID: <20190222195758.GA26984@bogus>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
 <20190219060407.15263-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219060407.15263-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 18, 2019 at 10:04:02PM -0800, Bjorn Andersson wrote:
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

Not valid to have this without '#clock-cells'.

Though I'm confused how this and the input clock name seem to match.

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
> 
