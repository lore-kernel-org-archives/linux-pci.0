Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E8BC10F05
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9349520857
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 14:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfDAO7C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:59:02 -0400
Received: from foss.arm.com ([217.140.101.70]:36150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAO7C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 10:59:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE77EA78;
        Mon,  1 Apr 2019 07:59:01 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9153F690;
        Mon,  1 Apr 2019 07:58:59 -0700 (PDT)
Date:   Mon, 1 Apr 2019 15:58:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: Add binding for Qualcomm PCIe2
 PHY
Message-ID: <20190401145854.GA6234@e107981-ln.cambridge.arm.com>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
 <20190219060407.15263-3-bjorn.andersson@linaro.org>
 <20190222195758.GA26984@bogus>
 <20190227042545.GE5511@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227042545.GE5511@minitux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 26, 2019 at 08:25:45PM -0800, Bjorn Andersson wrote:
> On Fri 22 Feb 11:57 PST 2019, Rob Herring wrote:
> 
> > On Mon, Feb 18, 2019 at 10:04:02PM -0800, Bjorn Andersson wrote:
> > > The Qualcomm PCIe2 PHY is a Synopsys based PCIe PHY found in a number of
> > > Qualcomm platforms, add a binding to describe this.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  .../bindings/phy/qcom-pcie2-phy.txt           | 40 +++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> > > new file mode 100644
> > > index 000000000000..7da02f9d78c7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
> > > @@ -0,0 +1,40 @@
> > > +Qualcomm PCIe2 PHY controller
> > > +=============================
> > > +
> > > +The Qualcomm PCIe2 PHY is a Synopsys based phy found in a number of Qualcomm
> > > +platforms.
> > > +
> > > +Required properties:
> > > + - compatible: compatible list, should be:
> > > +	       "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy"
> > > +
> > > + - reg: offset and length of the PHY register set.
> > > + - #phy-cells: must be 0.
> > > +
> > > + - clocks: a clock-specifier pair for the "pipe" clock
> > > +
> > > + - vdda-vp-supply: phandle to low voltage regulator
> > > + - vdda-vph-supply: phandle to high voltage regulator
> > > +
> > > + - resets: reset-specifier pairs for the "phy" and "pipe" resets
> > > + - reset-names: list of resets, should contain:
> > > +		"phy" and "pipe"
> > > +
> > > + - clock-output-names: name of the outgoing clock signal from the PHY PLL
> > 
> > Not valid to have this without '#clock-cells'.
> > 
> 
> This happens to work today as we don't describe &gcc's dependency on
> this, but just rely on the global clock namespace. But it should be
> there, so I'll respin this.

Should I drop this series from the PCI queue waiting for v3 then ?

Thanks,
Lorenzo

> > Though I'm confused how this and the input clock name seem to match.
> > 
> 
> The PHY generates the clock we call "pcie_0_pipe_clk" which is fed into
> the global clock controller (gcc), where it can be gated (and divided)
> and then fed back to both the PHY and the controller as
> "gcc_pcie_0_pipe_clk".
> 
> 
> Thanks for the review Rob.
> 
> Regards,
> Bjorn
> 
> > > +
> > > +Example:
> > > + phy@7786000 {
> > > +	compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
> > > +	reg = <0x07786000 0xb8>;
> > > +
> > > +	clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> > > +	resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
> > > +	         <&gcc GCC_PCIE_0_PIPE_ARES>;
> > > +	reset-names = "phy", "pipe";
> > > +
> > > +	vdda-vp-supply = <&vreg_l3_1p05>;
> > > +	vdda-vph-supply = <&vreg_l5_1p8>;
> > > +
> > > +	clock-output-names = "pcie_0_pipe_clk";
> > > +	#phy-cells = <0>;
> > > + };
> > > -- 
> > > 2.18.0
> > > 
