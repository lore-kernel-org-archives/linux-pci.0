Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9233CC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1EE20857
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfwEkBDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCASoV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:44:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43769 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfCASoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 13:44:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so11803126pfh.10
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2019 10:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAz2HOqge7g+FSOpc9hPR7gbFZONSU8QrjNcM9LzkvQ=;
        b=jfwEkBDX4lrBTUdOA9aptVqExZjWglP8pDWu8x/Ix2q0QnR9u1ZAgjWvhocJLOvPCm
         g+g0dD1MJ3p3qUV0FPLNwzTVLrRLTyImUdu5tjq/7YeQhGq4/fsvLqHMlRVmcfZ59a+Z
         h4+B8CPOaF2nSuaavzqCP2a0tiIsAO1IRlt1Guq6Sp9BLClrodSlxKEfcJf/aW+/m9EV
         yo1NO62GxSH+O8bTSQpUCvJPY/wBFdb/xVMuOEf+z8TuW2FoyokCIdoWt55uFThQFjMU
         lLk0tWP1RC5oevz8kKuMQK1bPuP2tVdYkC4thma2rfOyuigA8tz4CSRmV8OUixcRxdZ7
         UTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAz2HOqge7g+FSOpc9hPR7gbFZONSU8QrjNcM9LzkvQ=;
        b=e1UgKkxKgfPWUz910lYh6kbJXrfPl1WXga6O+cfAQWWKnVJoV72VwVCXiw5V9U07ce
         GX254ozBMbMJMHhn5B4ie610LcwWOgZ91oy6HW8uXMG0YmyI4dD3tC3KrfxWXSb2EXsq
         008D7fp7VM2rxAkuGGBRIpG9FKOdPzEAy6DYtFrmgjdD8bWaB8D6XTXy/Tl04+hNkGnz
         y/b39tz+H8xUl/EbdXXiY9hlDGU7R6WyMLy8izkHQSI95dCjDILEGxy+BAIZFIoYqH9U
         Hr5GehNox+qjkoDkRTGxn8YU50VpZCrxCwqq2bZ+p6YYTVc6IPjF4Z5oaX+ZVqb2Svuh
         n7Hw==
X-Gm-Message-State: APjAAAXCH3jeif1XyorXb2fPdvOuajpY3UW7liC1gdlwiERNolrgrEc5
        qX3buiePGCTUc7jRr89OeCNYZg==
X-Google-Smtp-Source: AHgI3IbxxVnl3LhpFIMRoIgfybIcKSXAa8Te5HqHwKH6M3h699Mc4fDJWmcBy3mlLTzxHLK0JU2Bvw==
X-Received: by 2002:a62:1706:: with SMTP id 6mr6902532pfx.28.1551465857744;
        Fri, 01 Mar 2019 10:44:17 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 71sm6064749pgc.23.2019.03.01.10.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 10:44:16 -0800 (PST)
Date:   Fri, 1 Mar 2019 10:44:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie: qcom: Add support for sdm845 PCIe controller
Message-ID: <20190301184414.GG5511@minitux>
References: <20190226070125.22318-1-bjorn.andersson@linaro.org>
 <e8a05fdd-2ca5-9f1c-6137-40df491ab310@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a05fdd-2ca5-9f1c-6137-40df491ab310@mm-sol.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 01 Mar 04:53 PST 2019, Stanimir Varbanov wrote:

> Hi Bjorn,
> 
> Thanks for the patch!
> 
> On 2/26/19 9:01 AM, Bjorn Andersson wrote:
> > The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> > 
> > Due to lack of hardware only the Gen2 controller has been verified.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.txt     |  19 +++
> >  drivers/pci/controller/dwc/pcie-qcom.c        | 146 ++++++++++++++++++
> >  2 files changed, 165 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > index 1fd703bd73e0..2cf92ed39499 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > @@ -10,6 +10,7 @@
> >  			- "qcom,pcie-msm8996" for msm8996 or apq8096
> >  			- "qcom,pcie-ipq4019" for ipq4019
> >  			- "qcom,pcie-ipq8074" for ipq8074
> > +			- "qcom,pcie-sdm845" for sdm845
> >  
> >  - reg:
> >  	Usage: required
> > @@ -116,6 +117,18 @@
> >  			- "ahb"		AHB clock
> >  			- "aux"		Auxiliary clock
> >  
> > +- clock-names:
> > +	Usage: required for sdm845
> > +	Value type: <stringlist>
> > +	Definition: Should contain the following entries
> > +			- "aux"		Auxiliary clock
> > +			- "cfg"		Configuration clock
> > +			- "bus_master"	Master AXI clock
> > +			- "bus_slave"	Slave AXI clock
> > +			- "slave_q2a"	Slave Q2A clock
> 
> What means Q2A? It'd be nice to describe it.
> 

I'll see what I can do.

> > +			- "tbu"		PCIe TBU clock
> 
> Is TBU related to SMMU or to something else?
> 

Yes, the ARM SMMU is split in a centralized controller (TCU) and
translation blocks (TBU) for each hardware peripheral. So this is the
clock for the translation block sitting between the two PCIe controllers
and the system NOC.

The clock is described here, rather than in the SMMU node in the
upstream way of representing client-related resources - although we
don't use the device_link to toggle it in the implementation below.

> > +			- "pipe"	PIPE clock
> > +
> >  - resets:
> >  	Usage: required
> >  	Value type: <prop-encoded-array>
> > @@ -167,6 +180,12 @@
> >  			- "ahb"			AHB Reset
> >  			- "axi_m_sticky"	AXI Master Sticky reset
> >  
> > +- reset-names:
> > +	Usage: required for sdm845
> > +	Value type: <stringlist>
> > +	Definition: Should contain the following entries
> > +			- "pci"			PCIe core reset
> > +
> >  - power-domains:
> >  	Usage: required for apq8084 and msm8996/apq8096
> >  	Value type: <prop-encoded-array>
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index d185ea5fe996..5147454a6ae5 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -54,6 +54,7 @@
> >  #define PCIE20_PARF_LTSSM			0x1B0
> >  #define PCIE20_PARF_SID_OFFSET			0x234
> >  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
> > +#define PCIE20_PARF_DEVICE_TYPE			0x1000
> >  
> >  #define PCIE20_ELBI_SYS_CTRL			0x04
> >  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> > @@ -80,6 +81,8 @@
> >  #define PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE	0x358
> >  #define SLV_ADDR_SPACE_SZ			0x10000000
> >  
> > +#define DEVICE_TYPE_RC				0x4
> > +
> >  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> >  struct qcom_pcie_resources_2_1_0 {
> >  	struct clk *iface_clk;
> > @@ -139,12 +142,21 @@ struct qcom_pcie_resources_2_3_3 {
> >  	struct reset_control *rst[7];
> >  };
> >  
> > +struct qcom_pcie_resources_2_7_0 {
> > +	struct clk_bulk_data clks[6];
> > +	struct regulator_bulk_data supplies[2];
> > +
> 
> please drop the blank line.
> 

Sure thing, and I'll throw in some defines for the two 2s, per your
feedback on the pending QCS404 patch.

> > +	struct reset_control *pci_reset;
> > +	struct clk *pipe_clk;
> > +};
> > +
> >  union qcom_pcie_resources {
> >  	struct qcom_pcie_resources_1_0_0 v1_0_0;
> >  	struct qcom_pcie_resources_2_1_0 v2_1_0;
> >  	struct qcom_pcie_resources_2_3_2 v2_3_2;
> >  	struct qcom_pcie_resources_2_3_3 v2_3_3;
> >  	struct qcom_pcie_resources_2_4_0 v2_4_0;
> > +	struct qcom_pcie_resources_2_7_0 v2_7_0;
> >  };
> >  
> >  struct qcom_pcie;
> > @@ -1076,6 +1088,129 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >  	return ret;
> >  }
> >  
> > +static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > +{
> > +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > +	struct dw_pcie *pci = pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	int ret;
> > +
> > +	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > +	if (IS_ERR(res->pci_reset))
> > +		return PTR_ERR(res->pci_reset);
> > +
> > +	res->supplies[0].supply = "vdda";
> > +	res->supplies[1].supply = "vddpe-3v3";
> > +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> > +				      res->supplies);
> > +	if (ret)
> > +		return ret;
> > +
> > +	res->clks[0].id = "aux";
> > +	res->clks[1].id = "cfg";
> > +	res->clks[2].id = "bus_master";
> > +	res->clks[3].id = "bus_slave";
> > +	res->clks[4].id = "slave_q2a";
> > +	res->clks[5].id = "tbu";
> > +
> > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	res->pipe_clk = devm_clk_get(dev, "pipe");
> > +	return PTR_ERR_OR_ZERO(res->pipe_clk);
> > +}
> > +
> > +static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > +{
> > +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > +	struct dw_pcie *pci = pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> > +	if (ret < 0) {
> > +		dev_err(dev, "cannot enable regulators\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> > +	if (ret < 0)
> 
> you could add dev_err() as well (to be aligned with
> regulator_bulk_enable and reset_control_assert).
> 

clk_bulk_prepare_enable() will print an error indicating which of the
multiple clocks that failed to turn on, so I don't think adding another
- more generic - error line will add value.


Looking again shows that I missed that regulator_bulk_enable() does the
same thing, so I will align the two by removing above error print.

> > +		goto err_disable_regulators;
> > +
> > +	ret = reset_control_assert(res->pci_reset);
> > +	if (ret) {
> > +		dev_err(dev, "cannot deassert pci reset\n");
> > +		return ret;
> > +	}
> > +
> > +	msleep(10);
> 
> for sleeping interval 10us - 20ms you should use usleep_range, please
> fix it.
> 

10ms looks arbitrary as well, I'll review this.

> > +
> > +	ret = reset_control_deassert(res->pci_reset);
> > +	if (ret) {
> > +		dev_err(dev, "cannot deassert pci reset\n");
> > +		return ret;
> > +	}
> > +
> > +	clk_prepare_enable(res->pipe_clk);
> 
> check for errors, please.
> 

Of course.

> > +
> > +	/* configure PCIe to RC mode */
> > +	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
> > +
> > +	/* enable PCIe clocks and resets */
> > +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +	val &= ~BIT(0);
> > +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > +
> > +	/* change DBI base address */
> > +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> > +
> > +	/* MAC PHY_POWERDOWN MUX DISABLE  */
> > +	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> > +	val &= ~BIT(29);
> > +	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> > +
> > +	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > +	val |= BIT(4);
> > +	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > +		val |= BIT(31);
> > +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> > +	}
> > +
> > +	return 0;
> > +
> > +err_disable_regulators:
> > +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> > +
> > +	return ret;
> > +}
> > +
> 

Thanks for your review!

Regards,
Bjorn
