Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 18 Jul 2017 14:24:47 +0530
From: Varadarajan Narayanan <varada@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        svarbanov@mm-sol.com, kishon@ti.com, sboyd@codeaurora.org,
        vivek.gautam@codeaurora.org, fengguang.wu@intel.com,
        weiyongjun1@huawei.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/7] phy: qcom-qmp: Fix phy pipe clock name
Message-ID: <20170718085440.GD32439@codeaurora.org>
References: <1500293043-1887-1-git-send-email-varada@codeaurora.org>
 <1500293043-1887-4-git-send-email-varada@codeaurora.org>
 <20170717223047.GA20973@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170717223047.GA20973@minitux>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Mon, Jul 17, 2017 at 03:30:47PM -0700, Bjorn Andersson wrote:
> On Mon 17 Jul 05:03 PDT 2017, Varadarajan Narayanan wrote:
>
> > Presently, the phy pipe clock's name is assumed to be either
> > usb3_phy_pipe_clk_src or pcie_XX_pipe_clk_src (where XX is the
> > phy lane's number). However, this will not work if an SoC has
> > more than one instance of the phy. Hence, instead of assuming
> > the name of the clock, fetch it from the DT.
> >
>
> Adding the support to fetch this from DT looks reasonable, but you
> should make sure to fall back to the old logic in case you don't find a
> "clock-output-names" property.

If more than one instance of the IP block is instantiated in the
SoC, it will try to register the same clock (i.e.
pcie_0_pipe_clk_src or usb3_phy_pipe_clk_src) more than once and
devm_clk_hw_register() will fail for the second and subsequent
instances of the IP, resulting in the pipe_clk not being able to
find its parent.

Additionally, the clock name itself differs between SoCs. For
example, in MSM8996 it is usb3_phy_pipe_clk_src for USB and
pcie_X_pipe_clk_src (where X is lane number 0, 1 or 2). In
IPQ8074 it is usb3phy_X_cc_pipe_clk or pcie20_phyX_pipe_clk
(where X is IP instance number 0 or 1).

MSM8996, has one instance of the IP with 3 different lanes,
whereas IPQ8074 has two instances with one lane in each instance.
A future SoC might have multiple instances with each instance
having different number of lanes and the clock's name might have
X & Y to indicate instance number and lane numbers.

Hence, if the "clock-output-names" property is not available
there is no logic that can correctly "guess" the clock's name.
The old logic incorrectly assumes the format of the clock name,
resulting in devm_clk_hw_register() failures and pipe_clk not
being linked to its proper parent.

> [..]
> > @@ -1110,6 +1103,8 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
> >
> >  	id = 0;
> >  	for_each_available_child_of_node(dev->of_node, child) {
> > +		const char *clk_name;
> > +
> >  		/* Create per-lane phy */
> >  		ret = qcom_qmp_phy_create(dev, child, id);
> >  		if (ret) {
> > @@ -1118,11 +1113,20 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
> >  			return ret;
> >  		}
> >
> > +		ret = of_property_read_string(child, "clock-output-names",
> > +							&clk_name);
> > +		if (ret) {
>
> This would be the case for any existing dts files, so you're not allowed
> to treat this as an error.

Since, there are no dts files that presently enable this driver,
wouldn't it be better to flag this as an error now itself instead
of having to fall back to old handling (which as mentioned above
is incomplete). Please let me know.

Thanks
Varada

> > +			dev_err(dev,
> > +				"failed to get clock-output-names for lane%d phy, %d\n",
> > +				id, ret);
> > +			return ret;
> > +		}
> > +
>
> Regards,
> Bjorn

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
